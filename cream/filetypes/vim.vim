"
" cream-filetype-vim.vim
"
" Cream -- An easy-to-use configuration of the famous Vim text editor
" [ http://cream.sourceforge.net ] Copyright (C) 2001-2011 Steve Hall
" 
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 3 of the License, or
" (at your option) any later version.
" [ http://www.gnu.org/licenses/gpl.html ]
" 
" This program is distributed in the hope that it will be useful, but
" WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
" General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software
" Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
" 02111-1307, USA.

"autocmd BufRead,BufNewFile *.vim		setfiletype vim

" vim
"set comments+=:\"

" clear comments
setlocal comments=

" bullets within comments
" +
setlocal comments+=sr:\"\ \ \ \ \ \ \ +\ ,mb:\"\ \ \ \ \ \ \ \ ,eb:\"\ \ \ \ \ \ \ \ 
" -
setlocal comments+=sr:\"\ \ \ \ \ -\ ,mb:\"\ \ \ \ \ \ ,eb:\"\ \ \ \ \ \ 
" *
setlocal comments+=sr:\"\ \ \ *\ ,mb:\"\ \ \ \ ,eb:\"\ \ \ \ 
" o
setlocal comments+=sr:\"\ o\ ,mb:\"\ \ ,eb:\"\ \ 
" @
setlocal comments+=sr:\"\ @\ ,mb:\"\ \ ,eb:\"\ \ 

" bullet parts
setlocal comments+=fb:*,fb:-,fb:+,fb:o
" commets
setlocal comments+=:\"


"----------------------------------------------------------------------
" leaving...
"autocmd BufWinLeave * call Cream_filetype_vim_un()

"function! Cream_filetype_vim_un()
"    if &filetype == "vim"
"        set comments-=:\"
"    endif
"endfunction

