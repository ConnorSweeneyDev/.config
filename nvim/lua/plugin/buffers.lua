local folders = { "/program", "/src", "/lua" }
local file_extensions = {
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
}
local ignore_patterns = General_util.get_patterns_from_gitignore()
Map("n", "<A-o>", function()
	Buffer_util.manual_open(folders, file_extensions, ignore_patterns)
end)
Map("n", "<A-c>", function()
	Buffer_util.manual_close()
end)
Buffer_util.open_on_startup(folders, file_extensions, ignore_patterns)
