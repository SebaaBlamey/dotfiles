return {
	"echasnovski/mini.indentscope",
	config = function()
		require("mini.indentscope").setup({
			draw = {
				delay = 50,
			},
			symbol = "│",
		})
	end,
}
