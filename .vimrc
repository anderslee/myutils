" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.

  call pathogen#runtime_append_all_bundles()

  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis


set textwidth=72
set cindent
set shiftwidth=8
set nobackup
set nowritebackup
"set noswapfile


set tabstop=8	"缩排8列，有大神建议折衷4，比8小，比2大"
set expandtab   "将所有制表符转变成空格"
set shiftwidth=8 "内/外缩排为8列"
set shiftround   "总是内/外缩排至最近的移位点"

set fo-=cro

set paste

set fo-=r
set noai

set tag+=/home/hume/.tags
"set tags+=/home/hume/linux/mysql/source/mariadb-5.2.5/.tags
"set tags+=/pool/git/cc/linux-source-2.6.38/tags

set autochdir


map <F2> i#!/usr/bin/env perl <CR><CR><ESC>

map <F3> i#    Filename: <CR>#    Author: anders lee (jianghumanbu@gmail.com)<CR>#    Date: <CR>#    Copyright: anders lee (jianghumanbu@gmail.com)<CR><ESC>

map <F4> i<CR>use strict;<CR>use warnings;<CR>use diagnostics;<CR>use Modern::Perl;<CR><CR><ESC>

"map <F5> i<CR>use utf8;<CR>binmode(STDOUT, ':encoding(utf8)');<CR>binmode(STDIN, ':encoding(utf8)');<CR>binmode(STDERR, ':encoding(utf8)');<CR><CR><ESC>

map <F5> i<CR>use utf8;<CR>binmode(STDIN, ':encoding(utf8)');<CR><CR><ESC>


map <F6> i<CR>#use constant DEBUG=>0;<CR><CR>#use lib '/home/manbu/perl5/lib';<CR><CR>#use vars qw//;<CR><CR><ESC>


" always show status line
set laststatus=2
set statusline=%F%*\ %y[%{&ff}][%{&fenc}]\ %2*%r%m%*\ %l,%c\ %=%l/%L\ (%p%%)%*\%{strftime('%Y-%m-%d-%H:%M')}


set nocp
filetype plugin on


"iab papp ^[:r ~/.templates/perl.pl^M

set iskeyword+=:
set iskeyword+=$
set iskeyword+=@
set iskeyword+=%


set complete+=k~/.vim_extras/file_that_lists_every_installed_perl_modules
