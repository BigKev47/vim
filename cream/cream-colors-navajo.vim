"=
" cream-colors-navajo.vim
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
"
" ----------------------------------------------------------------------
" Vim color file
" Maintainer: R. Edward Ralston <eralston@techsan.org>
" Last Change: 2002-01-24 09:56:48
" URI: http://eralston.tripod.com/navajo.png
"
" This color scheme uses a "navajo-white" background
"

set background=light
highlight clear
if exists("syntax_on")
	syntax reset
endif

"let g:colors_name = "cream-navajo"

" looks good on Linux
"highlight Normal ctermfg=Black guifg=Black guibg=#b39674
"highlight Normal ctermfg=Black guifg=Black guibg=NavajoWhite3

" slightly brighter for w32
"+++ Cream: brighten still more
"highlight Normal ctermfg=Black guifg=Black guibg=#ba9c80
highlight Normal ctermfg=Black guifg=Black guibg=#caac90
"+++
"+++ Cream:
"highlight SpecialKey term=bold ctermfg=DarkBlue guifg=Blue
highlight SpecialKey term=bold ctermfg=darkblue guifg=#404010
"highlight NonText term=bold ctermfg=DarkBlue cterm=bold gui=bold guifg=#808080
highlight NonText term=bold ctermfg=darkblue cterm=bold gui=bold guifg=#404010
"+++
highlight Directory term=bold ctermfg=DarkBlue guifg=Blue
highlight ErrorMsg term=standout ctermfg=Gray ctermbg=DarkRed cterm=bold gui=bold guifg=White guibg=Red
highlight IncSearch term=reverse cterm=reverse gui=reverse
highlight Search term=reverse ctermbg=Black ctermfg=White cterm=reverse guibg=White
highlight MoreMsg term=bold ctermfg=DarkGreen gui=bold guifg=SeaGreen
highlight ModeMsg term=bold cterm=bold gui=bold
highlight LineNr term=underline ctermfg=DarkCyan ctermbg=Gray guibg=#808080 gui=bold guifg=black

"+++ Cream: defined as User1-4
"highlight StatusLineNC term=reverse cterm=reverse gui=bold guifg=LightRed guibg=#707070
"+++
highlight VertSplit term=reverse cterm=reverse gui=bold guifg=White guibg=#707070
highlight Title term=bold ctermfg=DarkMagenta gui=bold guifg=DarkMagenta
"+++ Cream:
"highlight Visual term=reverse cterm=reverse gui=reverse guifg=#c0c0c0 guibg=black
highlight Visual term=reverse cterm=reverse gui=bold    guifg=White guibg=#553388
"+++
highlight VisualNOS term=bold,underline cterm=bold,underline gui=reverse guifg=Grey guibg=white
highlight WarningMsg term=standout ctermfg=DarkRed gui=bold guifg=Red
highlight WildMenu term=standout ctermfg=Black ctermbg=DarkYellow guifg=Black guibg=Yellow
highlight Folded term=standout ctermfg=DarkBlue ctermbg=Gray guifg=Black guibg=NONE guifg=#907050
highlight FoldColumn term=standout ctermfg=DarkBlue ctermbg=Gray guifg=DarkBlue guibg=#c0c0c0
highlight DiffAdd term=bold ctermbg=DarkBlue guibg=White
highlight DiffChange term=bold ctermbg=DarkMagenta guibg=#edb5cd
highlight DiffDelete term=bold ctermfg=DarkBlue ctermbg=6 cterm=bold gui=bold guifg=LightBlue guibg=#f6e8d0
highlight DiffText term=reverse ctermbg=DarkRed cterm=bold gui=bold guibg=#ff8060
highlight Cursor gui=reverse guifg=#404010 guibg=white
highlight lCursor guifg=bg guibg=fg
highlight Match term=bold,reverse ctermbg=Yellow ctermfg=Blue cterm=bold,reverse gui=bold,reverse guifg=yellow guibg=blue


" Colors for syntax highlighting
highlight Comment term=bold ctermfg=DarkBlue guifg=#181880
highlight Constant term=underline ctermfg=DarkRed guifg=#c00058
highlight Special term=bold ctermfg=DarkMagenta guifg=#404010
highlight Identifier term=underline ctermfg=DarkCyan cterm=NONE guifg=#106060
highlight Statement term=bold ctermfg=DarkRed cterm=bold gui=bold guifg=Brown
highlight PreProc term=underline ctermfg=DarkMagenta guifg=DarkMagenta
highlight Type term=underline ctermfg=DarkGreen gui=bold guifg=SeaGreen
highlight Ignore ctermfg=Gray cterm=bold guifg=bg
highlight Error term=reverse ctermfg=Gray ctermbg=DarkRed cterm=bold gui=bold guifg=White guibg=Red
highlight Todo term=standout ctermfg=DarkBlue ctermbg=Yellow guifg=Blue guibg=Yellow

"+++ Cream

" statusline
highlight User1  gui=bold guifg=#6666cc guibg=#ba9c80
highlight User2  gui=bold guifg=#181880 guibg=#ba9c80
highlight User3  gui=bold guifg=#ffffff guibg=#ba9c80
highlight User4  gui=bold guifg=#cc3366 guibg=#ba9c80

" bookmarks
highlight Cream_ShowMarksHL ctermfg=blue ctermbg=lightblue cterm=bold guifg=White guibg=#553388 gui=bold

" spell check
highlight BadWord ctermfg=black ctermbg=lightblue gui=NONE guifg=black guibg=#ffcccc

" current line
highlight CurrentLine term=reverse ctermbg=0 ctermfg=14 gui=none guibg=#eaccb0

" email
highlight EQuote1 guifg=#0000cc
highlight EQuote2 guifg=#3333cc
highlight EQuote3 guifg=#6666cc
highlight Sig guifg=#666666

"+++

