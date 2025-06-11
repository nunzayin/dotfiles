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

vim.keymap.set("n", "fzf", ":cd<Enter>:Files<Enter>")
vim.keymap.set("n", "fzb", ":Buffers<Enter>")
vim.keymap.set("n", "fzl", ":Lines<Enter>")
vim.keymap.set("n", "fzc", ":Files<Enter>")
vim.keymap.set("n", "cd",
":cd<Enter>:call fzf#run(fzf#wrap({'source': 'fd --no-ignore-vcs -Ht d', 'sink': 'cd'}))<Enter>")
vim.keymap.set("n", "cs", ":cd %:h<Enter>")
vim.keymap.set("n", "T", ":te<Enter>a")
vim.keymap.set("n", "q", ":bd<Enter>")

local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('folke/which-key.nvim')
Plug('windwp/nvim-autopairs')
Plug('neovim/nvim-lspconfig')
Plug('junegunn/fzf')
Plug('junegunn/fzf.vim')
Plug('ms-jpq/coq_nvim', { branch = 'coq'} )
Plug('ms-jpq/coq.artifacts', { branch = 'artifacts'} )
Plug('ziglang/zig.vim')

vim.call('plug#end')

require("nvim-autopairs").setup {}

vim.diagnostic.config({ virtual_text = true })

local lspconfig = require("lspconfig")

vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0
vim.api.nvim_create_autocmd('BufWritePre',{
    pattern = {"*.zig", "*.zon"},
    callback = function(ev)
        vim.lsp.buf.format()
    end
})
lspconfig.zls.setup {
    settings = {
        zls = {
            semantic_tokens = "partial"
        }
    }
}

vim.g.coq_settings = {
    auto_start = 'shut-up',
    ["display.pum.source_context"] = {"[", "]"},
    ["keymap.recommended"] = false,
}
vim.api.nvim_set_keymap(
    'i', '<Up>', [[pumvisible() ? "<C-e><Up>" : "<Up>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap(
    'i', '<Down>', [[pumvisible() ? "<C-e><Down>" : "<Down>"]], { expr = true, noremap = true })
