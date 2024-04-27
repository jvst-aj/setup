-- Plugin to comment visual regions/lines
return {
	"numToStr/Comment.nvim",
	opts = {},
	lazy = false,
	config = function()
		require("Comment").setup()
	end,
}
