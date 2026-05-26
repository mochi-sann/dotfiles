return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- JS/TS 用アダプタ（vitest / jest）
		"marilari88/neotest-vitest",
		"nvim-neotest/neotest-jest",
	},
	-- 最初にテスト系キーを押したときにロードする
	keys = {
		{
			"<leader>Tt",
			function()
				require("neotest").run.run()
			end,
			desc = "Neotest: 最寄りのテストを実行",
		},
		{
			"<leader>TT",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Neotest: ファイル全体を実行",
		},
		{
			"<leader>Td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Neotest: 最寄りをデバッグ実行",
		},
		{
			"<leader>Tx",
			function()
				require("neotest").run.stop()
			end,
			desc = "Neotest: 実行を停止",
		},
		{
			"<leader>Tw",
			function()
				require("neotest").watch.toggle(vim.fn.expand("%"))
			end,
			desc = "Neotest: ファイルのwatch切替",
		},
		{
			"<leader>Ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Neotest: サマリ切替",
		},
		{
			"<leader>To",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "Neotest: 出力を表示",
		},
		{
			"<leader>TO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Neotest: 出力パネル切替",
		},
		{
			"[t",
			function()
				require("neotest").jump.prev({ status = "failed" })
			end,
			desc = "Neotest: 前の失敗テストへ",
		},
		{
			"]t",
			function()
				require("neotest").jump.next({ status = "failed" })
			end,
			desc = "Neotest: 次の失敗テストへ",
		},
	},
	config = function()
		-- file が属するプロジェクト（最寄りの package.json を遡る）で
		-- 指定のテストランナーが使われているかを判定する
		local function detector(dep, config_pattern)
			return function(file)
				local dir = vim.fs.dirname(file)
				-- 設定ファイル（vitest.config.* / jest.config.*）があれば有効
				local cfg = vim.fs.find(function(name)
					return name:match(config_pattern) ~= nil
				end, { upward = true, path = dir, type = "file" })
				if cfg[1] then
					return true
				end
				-- package.json の dependencies / devDependencies に dep があれば有効
				local pkg = vim.fs.find("package.json", { upward = true, path = dir })[1]
				if not pkg then
					return false
				end
				local ok, json = pcall(vim.json.decode, table.concat(vim.fn.readfile(pkg), "\n"))
				if not ok or type(json) ~= "table" then
					return false
				end
				return (json.dependencies and json.dependencies[dep] ~= nil)
					or (json.devDependencies and json.devDependencies[dep] ~= nil)
			end
		end

		local uses_vitest = detector("vitest", "^vitest%.config%.")
		local uses_jest = detector("jest", "^jest%.config%.")

		local vitest = require("neotest-vitest")
		local jest = require("neotest-jest")({ env = { CI = true } })

		-- 各アダプタの is_test_file をラップし、対応ランナーのプロジェクトでだけ
		-- テストファイルと認識させる（vitest と jest が同じファイルを取り合わないように）
		local vitest_is_test = vitest.is_test_file
		vitest.is_test_file = function(file)
			return vitest_is_test(file) and uses_vitest(file)
		end

		local jest_is_test = jest.is_test_file
		jest.is_test_file = function(file)
			return jest_is_test(file) and uses_jest(file)
		end

		require("neotest").setup({
			adapters = { vitest, jest },
			-- 行内に成否を仮想テキストで表示
			status = { virtual_text = true },
			output = { open_on_run = true },
		})
	end,
}
