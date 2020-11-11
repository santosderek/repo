" Install vim-plug plugin manager 
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Begin plugins
call plug#begin('~/.vim/plugged')

Plug 'adrian5/oceanic-next-vim'

call plug#end()

let g:oceanic_italic_comments= 1
let g:oceanic_transparent_bg = 1
colorscheme oceanicnext

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

set number

" Set tabs to spaces 4
set tabstop=4 shiftwidth=4 expandtab
