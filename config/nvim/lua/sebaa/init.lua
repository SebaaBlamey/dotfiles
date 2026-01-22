vim.g.mapleader = " "
require("sebaa.lazy_init")
require("sebaa.set")
require("sebaa.remap")

local settings_path = vim.fn.stdpath("config") .. "/lua/sebaa/settings"
local settings_files = vim.fn.glob(settings_path .. "/*.lua", false, true)
for _, file in ipairs(settings_files) do
	local module_name = file:match("([^/]+)%.lua$")
	if module_name then
		require("sebaa.settings." .. module_name)
	end
end
