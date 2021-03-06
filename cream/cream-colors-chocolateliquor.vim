" Vim color file
" Maintainer:   Gerald S. Williams
" Last Change:  2003 Apr 17

" This started as a dark version (perhaps opposite is a better term) of
" PapayaWhip, but took on a life of its own. Easy on the eyes, but still
" has good contrast. Not bad on a color terminal, either (of course, on
" my color terms, Black == #3f1f1f and White == PapayaWhip :-P ).
"
" Only values that differ from defaults are specified.

set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
"let g:colors_name = "ChocolateLiquor"

hi Normal guibg=#3f1f1f guifg=PapayaWhip ctermfg=White
"hi NonText guifg=Brown ctermfg=Brown
hi LineNr guibg=#1f0f0f guifg=Brown2
hi DiffDelete guibg=DarkRed guifg=White ctermbg=DarkRed ctermfg=White
hi DiffAdd guibg=DarkGreen guifg=White ctermbg=DarkGreen ctermfg=White
hi DiffText gui=NONE guibg=DarkCyan guifg=Yellow ctermbg=DarkCyan ctermfg=Yellow
hi DiffChange guibg=DarkCyan guifg=White ctermbg=DarkCyan ctermfg=White
hi Constant ctermfg=Red
hi Comment guifg=LightBlue3
hi PreProc guifg=Plum ctermfg=Magenta
hi StatusLine guibg=White guifg=Sienna4 cterm=NONE ctermfg=Gray ctermbg=Brown
hi StatusLineNC gui=NONE guifg=Black guibg=Gray ctermbg=Black ctermfg=Gray
hi VertSplit guifg=Gray
hi Search guibg=Gold3 ctermfg=White
hi Type gui=NONE guifg=DarkSeaGreen2
hi Statement gui=NONE guifg=Gold3

"+++ Cream:

" invisible characters
highlight NonText         guifg=#cc6666 guibg=#331313 gui=none
highlight SpecialKey      guifg=#cc6666 guibg=#3f1f1f gui=none
	
" statusline
highlight User1  gui=bold guifg=#998833 guibg=#0c0c0c
highlight User2  gui=bold guifg=#ccbb99 guibg=#0c0c0c
highlight User3  gui=bold guifg=#ffffaa guibg=#0c0c0c
highlight User4  gui=bold guifg=#00cccc guibg=#0c0c0c

" bookmarks
highlight Cream_ShowMarksHL gui=bold guifg=#ffffaa guibg=#000000 ctermfg=blue ctermbg=lightblue cterm=bold

" spell check
highlight BadWord gui=bold guifg=#000000 guibg=#665555 ctermfg=black ctermbg=lightblue

" current line
highlight CurrentLine term=reverse ctermbg=0 ctermfg=14 gui=none guibg=#6f3f3f

" email
highlight EQuote1 guifg=#ccaa99
highlight EQuote2 guifg=#bb7766
highlight EQuote3 guifg=#995544
highlight Sig guifg=#cc6666

"+++

