return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdwinEnter", "CmdlineEnter", "BufReadPre" },
	dependencies = {
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-emoji" },
		{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
		-- { "yelog/i18n.nvim" },
		{
			"hrsh7th/cmp-vsnip",
			-- dependencies = { "vim-vsnip", "cmp-nvim-lsp-document-symbol" },
		},
		{
			"SmiteshP/nvim-navic",
			config = function()
				require("plugconfig/nvim_navic")
			end,
		},
		{
			"onsails/lspkind.nvim",
			config = function()
				require("plugconfig/lspkind")
			end,
		}, -- {
		-- 	"tzachar/cmp-tabnine",
		-- 	config = function()
		-- 		require("plugconfig/cmp-tabnine")
		-- 	end,
		-- 	build = "./install.sh",
		-- },
		{
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup({})
			end,
		},
		{ "williamboman/mason.nvim" },
		{
			"mason-org/mason-lspconfig.nvim",
		},
		{ "neovim/nvim-lspconfig" },
		{
			"hrsh7th/vim-vsnip",
			config = function()
				require("plugconfig/vsnip")
			end,
			dependencies = { { "hrsh7th/vim-vsnip-integ" } },
		},
		{
			"ray-x/lsp_signature.nvim",
			opts = {},
			config = function(_, opts)
				require("lsp_signature").setup()
			end,
		},

		{
			"zbirenbaum/copilot-cmp",
			config = function()
				require("copilot_cmp").setup()
			end,
		},
		{
			"lvimuser/lsp-inlayhints.nvim",
		},
		{ "simrat39/rust-tools.nvim" },
	},
	-- event = { "InsertEnter", "CmdwinEnter", "CmdlineEnter" },
	config = function()
		local lspkind = require("lspkind")
		local lsp_inlinehint = require("lsp-inlayhints")
		lsp_inlinehint.setup()
		local navic = require("nvim-navic")

		-- vim.lsp.clangd.setup({
		-- 	on_attach = function(client, bufnr) end,
		-- })

		vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
		vim.api.nvim_create_autocmd("LspAttach", {
			group = "LspAttach_inlayhints",
			callback = function(args)
				if not (args.data and args.data.client_id) then
					return
				end

				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				lsp_inlinehint.on_attach(client, bufnr)
			end,
		})

		local rt = require("rust-tools")

		rt.setup({
			server = {
				on_attach = function(_, bufnr)
					-- Hover actions
					vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
					-- Code action groups
					vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
				end,
			},
			tools = {
				inlay_hints = {
					auto = true,
				},
			},
		})

		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		local feedkey = function(key, mode)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
		end

		function formatForTailwindCSS(entry, vim_item)
			if vim_item.kind == "Color" and entry.completion_item.documentation then
				local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
				if r then
					local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
					local group = "Tw_" .. color
					if vim.fn.hlID(group) < 1 then
						vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
					end
					vim_item.kind = "●"
					vim_item.kind_hl_group = group
					return vim_item
				end
			end
			vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
			return vim_item
		end

		-- local lspconfig = require("mason-lspconfig")
		local cmp = require("cmp")

		local has_words_before = function()
			if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
				return false
			end
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
		end
		local function border(hl_name)
			return {
				{ "╭", hl_name },
				{ "─", hl_name },
				{ "╮", hl_name },
				{ "│", hl_name },
				{ "╯", hl_name },
				{ "─", hl_name },
				{ "╰", hl_name },
				{ "│", hl_name },
			}
		end

		-- cmp.register_source("i18n", require("i18n.integration.cmp_source").new())
		cmp.setup({
			snippet = {

				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				end,
			},
			window = {
				completion = {
					border = border("CmpBorder"),
					winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
				},
				documentation = { border = border("CmpDocBorder") },

				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			formatting = {
				-- fields = {'abbr', 'kind', 'menu'},
				format = require("lspkind").cmp_format({
					with_text = true,
					menu = {
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						cmp_tabnine = "[TabNine]",
						copilot = "[Copilot]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[NeovimLua]",
						latex_symbols = "[LaTeX]",
						path = "[Path]",
						omni = "[Omni]",
						spell = "[Spell]",
						emoji = "[Emoji]",
						calc = "[Calc]",
						rg = "[Rg]",
						treesitter = "[TS]",
						dictionary = "[Dictionary]",
						mocword = "[mocword]",
						cmdline_history = "[History]",
					},
					before = function(entry, vim_item) -- for tailwind css autocomplete
						vim_item = formatForTailwindCSS(entry, vim_item)
						return vim_item
					end,
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() and has_words_before() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					elseif cmp.visible() then
						cmp.select_next_item()
					elseif vim.fn["vsnip#available"](1) == 1 then
						feedkey("<Plug>(vsnip-expand-or-jump)", "")
					elseif has_words_before() then
						cmp.complete()
					else
						fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item()
					elseif vim.fn["vsnip#jumpable"](-1) == 1 then
						feedkey("<Plug>(vsnip-jump-prev)", "")
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				-- {
				-- 	name = "copilot",
				-- 	group_index = 2,
				-- 	max_item_count = 3,
				-- 	trigger_characters = {
				-- 		{
				-- 			".",
				-- 			":",
				-- 			"(",
				-- 			"'",
				-- 			'"',
				-- 			"[",
				-- 			",",
				-- 			"#",
				-- 			"*",
				-- 			"@",
				-- 			"|",
				-- 			"=",
				-- 			"-",
				-- 			"{",
				-- 			"/",
				-- 			"\\",
				-- 			"+",
				-- 			"?",
				-- 			" ",
				-- 			"\t",
				-- 			"\n",
				-- 		},
				-- 	},
				-- },

				{ name = "nvim_lsp", group_index = 2 },
				{ name = "vsnip", group_index = 3 }, -- For vsnip users.
				{ name = "nvim_lsp_signature_help" },
				{ name = "emoji", group_index = 4 },
				-- { name = "nvim_lsp_document_symbol" },
				{ name = "nvim_lua" },
				{ name = "cmp_tabnine", group_index = 2 },
				---{ name = "skkeleton", group_index = 2 },

				{ name = "copilot", group_index = 2 },
				{ name = "crates" },
				-- { name = "i18n" },

				-- { name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
			}, { { name = "buffer" }, { name = "cmp_tabnine" } }),
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				{ name = "nvim_lsp_signature_help" },
			}, { { name = "buffer" } }),
		})

		-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
		})

		-- Setup lspconfig.
		-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
		--
		-- -- if you want to set up formatting on save, you can use this as a callback
		-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- require("copilot").setup({
		-- 	panel = {
		-- 		enabled = false,
		-- 	},
		-- })

		local opts = { noremap = true, silent = true }
		-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
		-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

		local on_attach = function(client, bufnr)
			navic.attach(client, bufnr)
			local function buf_set_keymap(...)
				vim.api.nvim_buf_set_keymap(bufnr, ...)
			end

			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

			-- LSPサーバーのフォーマット機能を無効にする
			--
			-- client.resolved_capabilities.document_formatting = false

			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			local function opts(desc)
				return { desc = "nvim lsp: " .. desc, noremap = true, silent = true, buffer = bufnr }
			end

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("declaration"))
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("definition"))
			-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("hover"))
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
			-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
			-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts("remove workspace folder"))
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts("list workspace folders"))
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts("type_definition"))
			-- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts("rename"))
			-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts("code action"))
			-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("references"))
			vim.keymap.set("n", "<space>f", vim.lsp.buf.format, opts("format"))

			-- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
			-- buf_set_keymap("n", "<space>f", {
			-- 	group = augroup,
			-- 	buffer = bufnr,
			-- 	callback = function()
			-- 		lsp_formatting(bufnr)
			-- 	end,
			-- }, opts)
		end

		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local ensure_installed = { "ts_ls", "lua_ls", "clangd" }
		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = ensure_installed, -- 自動でインストールしたいlanguage server
		})

		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			on_attach = on_attach,
		})
		vim.lsp.enable(ensure_installed)
	end,
}
