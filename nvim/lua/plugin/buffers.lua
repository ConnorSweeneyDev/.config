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
local ignore_patterns = general_util.get_patterns_from_gitignore()
map("n", "<A-o>", function()
	buffer_util.manual_open(folders, file_extensions, ignore_patterns)
end)
map("n", "<A-c>", function()
	buffer_util.manual_close()
end)
buffer_util.open_on_startup(folders, file_extensions, ignore_patterns)
