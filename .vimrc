set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-endwise', {'for': 'ruby'}
Plugin 'janko-m/vim-test'
Plugin 'mhinz/vim-startify'
Plugin 'scrooloose/nerdcommenter'
Plugin 'timakro/vim-searchant'
Plugin 'fatih/vim-go'
Plugin 'mileszs/ack.vim'
Plugin 'JGShaw/AnsibleVaultVim'
Plugin 'jonasbleyl/lunarflare.vim'
call vundle#end()

set re=1
set tabstop=2
set shiftwidth=2
set expandtab
set number
set scrolloff=4
set backupdir=/var/tmp,~/.tmp,.
set directory=/var/tmp,~/.tmp,.
set hidden
set nostartofline
set splitright

" filetype specific
au FileType go set tabstop=4 | set shiftwidth=4
au FileType make set tabstop=4

" theme
colorscheme lunarflare
let g:airline_theme='zenburn'
let g:airline_section_y=''
let g:airline_section_z="%l/%L ➤ %c"
set termguicolors
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

" change cursor for normal/insert mode
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" change leader key
let mapleader = ","

" NERDTree
let g:NERDTreeWinSize=38
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=1

" <Leader>m to toggle file tree
nnoremap <silent> <Leader>m :NERDTreeToggle<CR>

" <Leader>n to reveal file in file tree
nnoremap <silent> <Leader>n :NERDTreeFind<CR>

" update git gutter on file save
autocmd BufWritePost * GitGutter

" NERDCommenter
let g:NERDSpaceDelims=1
let g:NERDTrimTrailingWhitespace=1

" fix supertab/endwise incompatibility
let g:SuperTabCrMapping = 0

" vim-go :GoDiagnostics to see issues
let g:go_rename_command = 'gopls'
let g:go_echo_command_info = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" move between splits
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" ansible-vault
let g:AnsibleVaultVimPasswordFile = '.vault'
nmap <silent> <leader>ave :AnsibleVaultEdit<CR>

" <Leader>i to reindent the current file
noremap <silent> <leader>i  mzgg=G`z

" <leader>y yank to system clipboard
vnoremap <leader>y  "*y

" <Leader>t to run all tests in the current file if it is a test, otherwise run the last test file
noremap <silent> <leader>t :TestFile<CR>

" <Leader>t to run the tests in the scope nearest the cursor
noremap <silent> <leader>T :TestNearest<CR>

" <Leader>ts to run the tests in the scope nearest the cursor
noremap <silent> <leader>ts :TestSuite<CR>

" disable cache for go vim-test
let test#go#gotest#options = '-count=1'

" switch to previous buffer
noremap <silent> <Leader><Leader> :b#<CR>

" <Leader>sw to strip whitespace off the ends
nnoremap <silent> <Leader>sw :call StripTrailingWhitespace()<CR>

" strip trailing whitespace
function! StripTrailingWhitespace()
  normal mz
  normal Hmy
  exec '%s/\s*$//g'
  normal 'yz<cr>
  normal `z
endfunction

" jump to last cursor position
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if line("'\"") > 0 && line("'\"") <= line("$")
    exe "normal! g'\""
  endif
endfunction

" allow nerdtree to work in startify
autocmd User Startified setlocal buftype=

" setup vim-startify's start screen
let g:startify_change_to_vcs_root = 1
let g:startify_files_number = 6
let g:startify_custom_header = [
      \ '   __      __            ',
      \ '   \ \    / (_)          ',
      \ '    \ \  / / _ _ __ ___  ',
      \ '     \ \/ / | | `_ ` _ \ ',
      \ '      \  /  | | | | | | |',
      \ '       \/   |_|_| |_| |_|',
      \ '                         ',
      \ ]

let g:startify_list_order = [
      \ ['   Recent files in this directory:'],
      \ 'dir',
      \ ['   Bookmarks:'],
      \ 'bookmarks',
      \ ]

let g:startify_bookmarks = [
      \ { 'v': '~/.vimrc' },
      \ { 'z': '~/.zshrc' },
      \ { 't': '~/.tmux.conf' },
      \ { 's': '~/.ssh/config' },
      \ ]
