set number
set exrc 
set relativenumber 
set hidden 
set tabstop=4 softtabstop=4 
set shiftwidth=4 
set expandtab 
set smartindent 
set nu 
set nowrap 
set smartcase 
set noerrorbells 
set nohlsearch 
set scrolloff=8 
syntax on 
set autoindent 
set showmatch 
let python_highlight_all=1 
syntax on 
set laststatus=2 
 
set nocompatible 
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'windwp/nvim-autopairs'
Plug 'morhetz/gruvbox'
" Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' } 
Plug 'vim-airline/vim-airline'  
Plug 'folke/lsp-colors.nvim'
Plug 'numToStr/Comment.nvim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
call plug#end()


let g:gruvbox_italic=1
let g:gruvbox_termcolors=256
let g:gruvbox_italic=1
let g:gruvbox_underline=0
set bg=dark
let g:gruvbox_transparent_bg=1
set encoding=utf-8
colorscheme gruvbox
hi Normal ctermbg=none

lua <<EOF
require'lspconfig'.clangd.setup{}
require'lspconfig'.java_language_server.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.pyre.setup{}
require'lspconfig'.tsserver.setup{}
require("nvim-autopairs").setup {}
require('Comment').setup()
require("toggleterm").setup{}
local cmp = require "cmp"

cmp.setup {
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping {
      i = cmp.mapping.confirm { select = true },
    },
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }, { "i" }),
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, { "i" }),
  },
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    -- 'crates' is lazy loaded
    { name = "nvim_lsp" },
    { name = "path" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "spell" },
  },
  formatting = {
    fields = {
      cmp.ItemField.Abbr,
      cmp.ItemField.Kind,
      cmp.ItemField.Menu,
    },
}

}
-- insert `(` after select function or method item
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

EOF
