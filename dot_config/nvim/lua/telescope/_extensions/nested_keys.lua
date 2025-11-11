local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

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
					table.insert(results, {
						path = key_path,
						filename = file,
						lnum = lnum,
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

local function open_nested_key_picker(opts)
	opts = normalized_opts(opts or {})
	local entries = nested_key_entries(opts)
	if vim.tbl_isempty(entries) then
		vim.notify(opts.empty_message, vim.log.levels.INFO)
		return
	end
	pickers
		.new(opts.picker, {
			prompt_title = opts.prompt_title,
			finder = finders.new_table({
				results = entries,
				entry_maker = function(item)
					return {
						value = item,
						display = item.display,
						ordinal = item.ordinal,
						filename = item.filename,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			previewer = conf.file_previewer({}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection and selection.value then
						vim.cmd("edit " .. vim.fn.fnameescape(selection.value.filename))
						vim.api.nvim_win_set_cursor(0, { selection.value.lnum, 0 })
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
