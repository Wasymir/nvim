-- init inspired, and by that I mean I stole their code, by kickstart.nvim and ThePrimeagen's config.
require('rust')



vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'tpope/vim-sleuth',
    { 'numToStr/Comment.nvim',    config = true },
    { import = "plugins" }
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.o.wrap = false

vim.o.number = true
vim.o.relativenumber = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 10

vim.opt.swapfile = false

vim.opt.updatetime = 50

vim.keymap.set("n", "n", "nzzz")
vim.keymap.set("n", "N", "Nzzz")

vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = ":Ex" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]aste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })


vim.o.mouse = nil
vim.o.ttymouse = nil



