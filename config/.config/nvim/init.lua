vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.schedule(function() 
    vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
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
vim.cmd([[highlight Constant ctermbg=10 guifg=#98e3de]])

vim.keymap.set("n", "<A-j>", ":tabprevious<CR>")
vim.keymap.set("n", "<A-k>", ":tabnext<CR>")
vim.keymap.set("n", "<A-Left>", ":tabprevious<CR>")
vim.keymap.set("n", "<A-Right>", ":tabnext<CR>")

vim.keymap.set("n", "fzf", ":Files<Enter>")
vim.keymap.set("n", "fzb", ":Buffers<Enter>")
vim.keymap.set("n", "fzl", ":Lines<Enter>")
vim.keymap.set("n", "fzh", ":History<Enter>")
vim.keymap.set("n", "fzc", ":Commands<Enter>")

local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('folke/which-key.nvim')
Plug('windwp/nvim-autopairs')
Plug('neovim/nvim-lspconfig')
Plug('junegunn/fzf')
Plug('junegunn/fzf.vim')

vim.call('plug#end')

require("nvim-autopairs").setup {}
vim.diagnostic.config({ virtual_text = true })
local lspconfig = require("lspconfig")
lspconfig.gopls.setup {
    on_attach = on_attach,
    cmd = { "gopls", "serve" },
    filetypes = { "go", "go.mod" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true
            },
            staticcheck = true
        }
    }
}
lspconfig.rust_analyzer.setup {
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true;
            }
        }
    }
}
