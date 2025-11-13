local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")
local entry_display = require("telescope.pickers.entry_display")
local highlight_ns = vim.api.nvim_create_namespace("telescope_nested_keys")
local preview_highlight_ns = vim.api.nvim_create_namespace("telescope_nested_keys_preview")
vim.api.nvim_set_hl(0, "TelescopeNestedKeysPreviewLine", { link = "Search", default = true })
vim.api.nvim_set_hl(0, "TelescopeNestedKeysPreviewKey", { link = "IncSearch", default = true })
vim.api.nvim_set_hl(0, "TelescopeNestedKeysResultKey", { link = "TelescopeResultsIdentifier", default = true })
vim.api.nvim_set_hl(0, "TelescopeNestedKeysResultLocation", { link = "TelescopeResultsComment", default = true })

local function clamp_line(bufnr, lnum)
	if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
		return lnum or 1
	end
	local line_count = vim.api.nvim_buf_line_count(bufnr)
	if not lnum or lnum < 1 then
		return 1
	end
	if lnum > line_count then
		return line_count
	end
	return lnum
end

local extension_config = {
	patterns = { "*.json", "*.jsonc", "*.yaml", "*.yml" },
	search_dirs = {},
	rg_extra_args = {},
	prompt_title = "JSON/YAML Keys",
	empty_message = "JSON/YAML keys not found",
	picker = {},
	cwd = nil,
}

local function structured_key_files(opts)
	local cmd = { "rg", "--files" }
	for _, pattern in ipairs(opts.patterns) do
		table.insert(cmd, "-g")
		table.insert(cmd, pattern)
	end
	for _, arg in ipairs(opts.rg_extra_args or {}) do
		table.insert(cmd, arg)
	end
	local search_dirs = opts.search_dirs or {}
	if #search_dirs == 0 then
		local default_dir = opts.cwd or vim.loop.cwd() or vim.fn.getcwd()
		if default_dir and default_dir ~= "" then
			table.insert(search_dirs, default_dir)
		end
	end
	for _, dir in ipairs(search_dirs) do
		table.insert(cmd, dir)
	end
	local files = vim.fn.systemlist(cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("rg --files failed. Nested key search disabled", vim.log.levels.WARN)
		return {}
	end
	local filtered = {}
	for _, file in ipairs(files) do
		if file ~= "" then
			table.insert(filtered, file)
		end
	end
	return filtered
end

local function sanitize_key(raw)
	if not raw then
		return nil
	end
	raw = raw:gsub('^"', ""):gsub('"$', "")
	raw = raw:gsub("^'", ""):gsub("'$", "")
	return raw
end

local function extract_key(line)
	local key = line:match('^%s*%-?%s*"([^"]+)"%s*:')
	if key then
		return sanitize_key(key)
	end
	key = line:match("^%s*%-?%s*'([^']+)'%s*:")
	if key then
		return sanitize_key(key)
	end
	key = line:match("^%s*%-?%s*([%w_.%-]+)%s*:")
	return sanitize_key(key)
end

local function collect_keys_from_file(file)
	local ok, lines = pcall(vim.fn.readfile, file)
	if not ok or not lines then
		return {}
	end
	local stack = {}
	local results = {}
	local function pop_to_indent(indent)
		while #stack > 0 and stack[#stack].indent >= indent do
			table.remove(stack)
		end
	end

	for lnum, line in ipairs(lines) do
		local trimmed = vim.trim(line)
		if trimmed ~= "" then
			local indent = #(line:match("^%s*") or "")
			local is_comment = trimmed:match("^#") or trimmed:match("^//")
			if not is_comment then
				local key = extract_key(line)
				if key then
					pop_to_indent(indent)
					local parts = {}
					for _, node in ipairs(stack) do
						table.insert(parts, node.key)
					end
					table.insert(parts, key)
					local key_path = table.concat(parts, ".")
					local col = (line:find(key, 1, true) or (indent + 1)) - 1
					table.insert(results, {
						path = key_path,
						filename = file,
						lnum = lnum,
						col = math.max(col, 0),
						key = key,
					})
					table.insert(stack, { indent = indent, key = key })
				elseif trimmed:match("^[%}%]]") then
					pop_to_indent(indent)
				end
			end
		end
	end
	return results
end

local function nested_key_entries(opts)
	local files = structured_key_files(opts)
	local entries = {}
	local cwd = opts.cwd or vim.loop.cwd()
	for _, file in ipairs(files) do
		local rel = vim.fn.fnamemodify(file, ":.")
		if rel == file and cwd and file:sub(1, #cwd) == cwd then
			rel = file:sub(#cwd + 2)
		end
		for _, key_entry in ipairs(collect_keys_from_file(file)) do
			local display = string.format("%s  →  %s:%d", key_entry.path, rel, key_entry.lnum)
			table.insert(entries, {
				ordinal = key_entry.path .. " " .. rel,
				display = display,
				filename = key_entry.filename,
				lnum = key_entry.lnum,
				path = key_entry.path,
				key = key_entry.key,
				col = key_entry.col,
				relpath = rel,
			})
		end
	end
	return entries
end

local function normalized_opts(opts)
	local default_cwd = extension_config.cwd or vim.loop.cwd() or vim.fn.getcwd()
	return {
		patterns = opts.patterns or extension_config.patterns,
		search_dirs = opts.search_dirs or extension_config.search_dirs,
		rg_extra_args = opts.rg_extra_args or extension_config.rg_extra_args,
		prompt_title = opts.prompt_title or extension_config.prompt_title,
		empty_message = opts.empty_message or extension_config.empty_message,
		picker = opts.picker or extension_config.picker,
		cwd = opts.cwd or default_cwd,
	}
end

local function highlight_key_in_buffer(bufnr, lnum, col, key, opts)
	if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end
	opts = opts or {}
	local namespace = opts.namespace or highlight_ns
	local group = opts.group or "Search"
	local key_group = opts.key_group or group
	vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
	if not lnum or not key or key == "" then
		return
	end
	lnum = clamp_line(bufnr, lnum)
	local start_col = math.max(col or 0, 0)
	local end_col = start_col + #key
	vim.api.nvim_buf_add_highlight(bufnr, namespace, key_group, lnum - 1, start_col, end_col)
	if opts.highlight_line then
		local line_group = opts.line_group or group
		vim.api.nvim_buf_add_highlight(bufnr, namespace, line_group, lnum - 1, 0, -1)
		if opts.extra_line_group then
			vim.api.nvim_buf_add_highlight(bufnr, namespace, opts.extra_line_group, lnum - 1, 0, -1)
		end
	end
end

local function open_nested_key_picker(opts)
	opts = normalized_opts(opts or {})
	local entries = nested_key_entries(opts)
	if vim.tbl_isempty(entries) then
		vim.notify(opts.empty_message, vim.log.levels.INFO)
		return
	end

	local max_key_len = 0
	for _, entry in ipairs(entries) do
		if entry.path then
			max_key_len = math.max(max_key_len, #entry.path)
		end
	end
	local key_column_width = math.min(math.max(max_key_len + 2, 20), opts.key_column_width or 70)
	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = key_column_width },
			{ remaining = true },
		},
	})
	local function make_display(entry)
		local rel = entry.value.relpath or entry.value.filename
		local lnum = entry.value.lnum or 1
		return displayer({
			{ entry.value.path, "TelescopeNestedKeysResultKey" },
			{ string.format("%s:%d", rel, lnum), "TelescopeNestedKeysResultLocation" },
		})
	end

	pickers
		.new(opts.picker, {
			prompt_title = opts.prompt_title,
			finder = finders.new_table({
				results = entries,
				entry_maker = function(item)
					return {
						value = item,
						display = make_display,
						ordinal = item.ordinal,
						filename = item.filename,
						col = item.col,
						key = item.key,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry, status)
					local filename = entry.value.filename
					if not filename or filename == "" then
						return
					end
					conf.buffer_previewer_maker(filename, self.state.bufnr, {
						bufname = self.state.bufname,
					})
					local preview_buf = self.state.bufnr
					local target_lnum = clamp_line(preview_buf, entry.value.lnum)
					local target_col = math.max(entry.value.col or 0, 0)
					vim.schedule(function()
						if not vim.api.nvim_buf_is_valid(preview_buf) then
							return
						end
						highlight_key_in_buffer(preview_buf, target_lnum, target_col, entry.value.key, {
							namespace = preview_highlight_ns,
							group = "TelescopeNestedKeysPreviewKey",
							key_group = "TelescopeNestedKeysPreviewKey",
							highlight_line = true,
							line_group = "TelescopeNestedKeysPreviewLine",
						})
						if status.preview_win and vim.api.nvim_win_is_valid(status.preview_win) then
							vim.api.nvim_win_set_cursor(status.preview_win, { target_lnum, target_col })
						end
					end)
				end,
			}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection and selection.value then
						vim.cmd("edit " .. vim.fn.fnameescape(selection.value.filename))
						local bufnr = vim.api.nvim_get_current_buf()
						local lnum = clamp_line(bufnr, selection.value.lnum)
						local col = math.max(selection.value.col or 0, 0)
						vim.api.nvim_win_set_cursor(0, { lnum, col })
						highlight_key_in_buffer(bufnr, lnum, selection.value.col, selection.value.key)
					end
				end)
				return true
			end,
		})
		:find()
end

return telescope.register_extension({
	setup = function(ext_config)
		extension_config = vim.tbl_extend("force", extension_config, ext_config or {})
	end,
	exports = {
		nested_keys = function(opts)
			return open_nested_key_picker(opts)
		end,
	},
})
