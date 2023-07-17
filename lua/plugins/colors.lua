return {
	'drewtempelmeyer/palenight.vim',
	lazy = false,
	priority = 1000,
	config = function() 
		vim.o.background = "dark"
		vim.cmd([[colorscheme palenight]])

	end


}
