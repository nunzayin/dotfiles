vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.schedule(function() 
    vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.list = true
vim.opt.listchars = {
	eol = '¶',
	tab = '| ',
	trail = '·',
	nbsp = '␣'
}
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.keymap.set("n", "fzf", ":cd<Enter>:Files<Enter>")
vim.keymap.set("n", "fzb", ":Buffers<Enter>")
vim.keymap.set("n", "fzl", ":Lines<Enter>")
vim.keymap.set("n", "fzc", ":Files<Enter>")
vim.keymap.set("n", "cd",
":cd<Enter>:call fzf#run(fzf#wrap({'source': 'fd --no-ignore-vcs -Ht d', 'sink': 'cd'}))<Enter>")
vim.keymap.set("n", "cs", ":cd %:h<Enter>")
vim.keymap.set("n", "T", ":te<Enter>a")

vim.keymap.set("n", "L", ":te lazygit<Enter>a")
vim.api.nvim_create_autocmd('TermClose',{
    pattern = { "term://*lazygit" },
    callback = function(ev)
        vim.api.nvim_input("<Enter>")
    end
})

vim.keymap.set("n", "q", ":bd<Enter>")

local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('folke/which-key.nvim')
Plug('windwp/nvim-autopairs')
Plug('junegunn/fzf')
Plug('junegunn/fzf.vim')
Plug('blazkowolf/gruber-darker.nvim')

vim.call('plug#end')

require("nvim-autopairs").setup {}

require("gruber-darker").setup {
    italic = {
        strings = false,
    },
}
vim.cmd.colorscheme("gruber-darker")
