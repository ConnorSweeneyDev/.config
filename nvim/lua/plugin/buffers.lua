Buffer_util.set_parameters({ "/program", "/src", "/lua" }, {
	"*.cpp",
	"*.hpp",
	"*.inl",
	"*.glsl",
	"*.c",
	"*.h",
	"*.py",
	"*.rs",
	"*.java",
	"*.cs",
	"*.js",
	"*.jsx",
	"*.css",
	"*.lua",
}, General_util.get_patterns_from_gitignore())
Map("n", "<A-o>", function()
	Buffer_util.manual_open()
end)
Map("n", "<A-c>", function()
	Buffer_util.manual_close()
end)
Buffer_util.open_on_startup()
