folders = {"/program", "/src", "/lua"}
file_extensions = {"*.cpp", "*.hpp", "*.inl", "*.glsl", "*.c", "*.h", "*.py", "*.lua", "*.java", "*.cs"}
ignore_files = {"resource.cpp", "resource.hpp"}
use_coc = true
map("n", "<A-o>", function() buffer_util.manual_open(folders, file_extensions, ignore_files, use_coc) end)
map("n", "<A-c>", function() buffer_util.manual_close(use_coc) end)
buffer_util.open_on_startup(folders, file_extensions, ignore_files)
