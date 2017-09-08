" Vim color file
" Maintainer:   Mike Williams <mrw@eandem.co.uk>
" Last Change:	2nd June 2003
" Version:	1.1

" Remove all existing highlighting.
set background=light

hi clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "blackwhite"

highlight Normal	    cterm=NONE ctermfg=black ctermbg=white gui=NONE guifg=black guibg=white
highlight NonText	    ctermfg=black ctermbg=white guifg=black guibg=white
highlight LineNr        cterm=italic ctermfg=black ctermbg=white gui=italic guifg=black guibg=white

" Syntax highlighting scheme
highlight Comment	    cterm=italic ctermfg=black ctermbg=white gui=italic guifg=black guibg=white

highlight Constant	    ctermfg=black ctermbg=white guifg=black guibg=white
highlight String	    ctermfg=black ctermbg=white guifg=black guibg=white
highlight Character	    ctermfg=black ctermbg=white guifg=black guibg=white
highlight Number	    ctermfg=black ctermbg=white guifg=black guibg=white
" Boolean defaults to Constant
highlight Float		    ctermfg=black ctermbg=white guifg=black guibg=white

highlight Identifier	ctermfg=black ctermbg=white guifg=black guibg=white
highlight Function	    ctermfg=black ctermbg=white guifg=black guibg=white

highlight Statement	    ctermfg=black ctermbg=white guifg=black guibg=white
highlight Conditional	ctermfg=black ctermbg=white guifg=black guibg=white
highlight Repeat	    ctermfg=black ctermbg=white guifg=black guibg=white
highlight Label		    ctermfg=black ctermbg=white guifg=black guibg=white
highlight Operator	    ctermfg=black ctermbg=white guifg=black guibg=white
" Keyword defaults to Statement
" Exception defaults to Statement

highlight PreProc	    cterm=bold ctermfg=black ctermbg=white gui=bold guifg=black guibg=white
" Include defaults to PreProc
" Define defaults to PreProc
" Macro defaults to PreProc
" PreCondit defaults to PreProc

highlight Type		    cterm=bold ctermfg=black ctermbg=white gui=bold guifg=black guibg=white
" StorageClass defaults to Type
" Structure defaults to Type
" Typedef defaults to Type

highlight Special	    cterm=italic ctermfg=black ctermbg=white gui=bold guifg=black guibg=white
" SpecialChar defaults to Special
" Tag defaults to Special
" Delimiter defaults to Special
highlight SpecialComment cterm=italic ctermfg=black ctermbg=white gui=italic guifg=black guibg=white
" Debug defaults to Special

highlight Todo		    cterm=italic,bold ctermfg=black ctermbg=white gui=italic,bold guifg=black guibg=white
" Ideally, the bg color would be white but VIM cannot print white on black!
highlight Error		    cterm=bold,reverse ctermfg=black ctermbg=grey gui=bold,reverse guifg=black guibg=grey

"+++ Cream: missing
highlight WarningMsg	cterm=bold ctermfg=black ctermbg=grey gui=italic guifg=black guibg=white
highlight Underlined	cterm=bold ctermfg=black ctermbg=white gui=underline guifg=black guibg=white
highlight ModeMsg		cterm=bold ctermfg=black ctermbg=white gui=bold guifg=black guibg=white
"+++


"+++ Cream:

" invisible characters
highlight NonText         guifg=#bbbbbb gui=none
highlight SpecialKey      guifg=#bbbbbb gui=none

" statusline
highlight User1  gui=bold guifg=#bbbbbb guibg=#f3f3f3
highlight User2  gui=bold guifg=#555555 guibg=#f3f3f3
highlight User3  gui=bold guifg=#000000 guibg=#f3f3f3
highlight User4  gui=bold guifg=#000000 guibg=#f3f3f3

" bookmarks
highlight Cream_ShowMarksHL gui=bold guifg=black guibg=white ctermfg=black ctermbg=white cterm=bold

" spell check
highlight BadWord gui=bold guifg=foreground guibg=LightGray ctermfg=black ctermbg=grey

" current line
highlight CurrentLine term=reverse ctermbg=0 ctermfg=14 gui=none guibg=#dddddd

" email
highlight EQuote1 guifg=#000000
highlight EQuote2 guifg=#444444
highlight EQuote3 guifg=#888888
highlight Sig guifg=#999999

"+++

" EOF print_bw.vim
