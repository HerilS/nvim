" NEOVIM PLUGINS
call plug#begin("~/.vim/plugged")

Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'

call plug#end()

" BASIC SETTINGS
let mapleader =","

" Use System Clipboard
set clipboard=unnamedplus

" Go to center on insert
autocmd InsertEnter * norm zz

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Shortcutting split opening
nnoremap <leader>h :split<CR>
nnoremap <leader>v :vsplit<CR>

" Change & Delete JSX tags
map <leader>c cstt
map <leader>d dst

" Alias replace all to S
nnoremap S :%s//gI<Left><Left><Left>

" Standard
set mouse=a
syntax on
set ignorecase
set smartcase
set number
set noshowmode
hi link jsxCloseString htmlTag

" Theming
set t_Co=256
set t_ut=
set termguicolors
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_invert_tabline = 1
let g:gruvbox_transparent_bg = 1
colorscheme gruvbox
set background=dark
let g:rehash256 = 1
highlight clear SignColumn

" Transparent Background
hi Normal ctermbg=NONE guibg=NONE

" Indenting
:set shiftwidth=2
:set autoindent
:set smartindent

" Shortcutting split Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tab Navigation
nnoremap <nowait> <leader>t <Esc>:tabnew<CR>
nnoremap <S-Tab> :tabprevious<CR>
nnoremap <Tab> :tabnext<CR>

" MTA
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'javascript': 1,
    \}

let g:mta_set_default_matchtag_color = 1

" COC
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ 'coc-pairs',
  \ 'coc-git',
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-css'
  \ ]

" CLOSE TAG
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*ts,*tsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.jsx,*ts,*tsx'
let g:closetag_filetypes = 'html,xhtml,phtml,js,ts,jsx,tsx'
let g:closetag_xhtml_filetypes = 'xhtml,js,jsx,ts,tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" TELESCOPE
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,

    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {
      i = {
	    ["<C-x>"] = false,
	    ["<C-q>"] = actions.send_to_qflist
	}
    }
},
extensions = {
    fzy_native = {
	override_generic_sorter = false,
	override_file_sorter = true,
      }
   }
}

require('telescope').load_extension('fzy_native')
EOF

" TELESCOPE HOTKEYS
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

" AIRLINE
let g:airline_theme='transparent'

" FLOATTERM
nnoremap t <Esc>:FloatermNew<CR>
