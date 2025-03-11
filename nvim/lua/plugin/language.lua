Map("n", "<LEADER>kf", function()
	Language_util.format({
		[{ "c", "h", "cpp", "hpp", "inl" }] = "clang-format -i %",
		[{ "py" }] = "black %",
		[{ "js", "jsx", "css", "html", "json" }] = "npx prettier % --write",
		[{ "lua" }] = "stylua %",
		[{ "rs" }] = "rustfmt %",
	})
end)
Map("n", "<LEADER><LEADER>", function()
	Lua_util.source()
end)
Map("n", "UC", function()
	C_util.switch_file_in_compilation_unit("source")
end)
Map("n", "UH", function()
	C_util.switch_file_in_compilation_unit("header")
end)
Map("n", "UI", function()
	C_util.switch_file_in_compilation_unit("inline")
end)
Api.nvim_create_autocmd({ "BufEnter", "WinEnter", "ModeChanged" }, {
	callback = function()
		Language_util.handle_text({ "txt", "md", "gitcommit" })
	end,
})
