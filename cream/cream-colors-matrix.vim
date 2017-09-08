" vim:set ts=8 sts=2 sw=2 tw=0:
"
" matrix.vim - MATRIX like colorscheme.
"
" Maintainer:	MURAOKA Taro <koron@tka.att.ne.jp>
" Last Change:  10-Jun-2003.

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
"let g:colors_name = 'matrix'

" the character under the cursor
hi Cursor	guifg=#226622 guibg=#55ff55
hi lCursor	guifg=#226622 guibg=#55ff55
" like Cursor, but used when in IME mode |CursorIM|
hi CursorIM	guifg=#226622 guibg=#55ff55
" directory names (and other special names in listings)
hi Directory	guifg=#55ff55 guibg=#000000
" diff mode: Added line |diff.txt|
hi DiffAdd	guifg=#55ff55 guibg=#226622 gui=none
" diff mode: Changed line |diff.txt|
hi DiffChange	guifg=#55ff55 guibg=#226622 gui=none
" diff mode: Deleted line |diff.txt|
hi DiffDelete	guifg=#113311 guibg=#113311 gui=none
" diff mode: Changed text within a changed line |diff.txt|
hi DiffText	guifg=#55ff55 guibg=#339933 gui=bold
" error messages on the command line
hi ErrorMsg	guifg=#55ff55 guibg=#339933
" the column separating vertically split windows
hi VertSplit	guifg=#339933 guibg=#339933
" line used for closed folds
hi Folded	guifg=#44cc44 guibg=#113311
" 'foldcolumn'
hi FoldColumn	guifg=#44cc44 guibg=#226622
" 'incsearch' highlighting; also used for the text replaced with
hi IncSearch	guifg=#226622 guibg=#55ff55 gui=none
" line number for ":number" and ":#" commands, and when 'number'
hi LineNr	guifg=#44cc44 guibg=#002200
" 'showmode' message (e.g., "-- INSERT --")
hi ModeMsg	guifg=#44cc44 guibg=#000000
" |more-prompt|
hi MoreMsg	guifg=#44cc44 guibg=#000000
" '~' and '@' at the end of the window, characters from
hi NonText	guifg=#00cc00 guibg=#001100
" normal text
hi Normal	guifg=#44cc44 guibg=#000000
" |hit-enter| prompt and yes/no questions
hi Question	guifg=#44cc44 guibg=#000000
" Last search pattern highlighting (see 'hlsearch').
hi Search	guifg=#113311 guibg=#44cc44 gui=none
"+++ Cream:
hi SignColumn   guifg=#44cc44 guibg=#003300
"+++
hi SpecialKey	guifg=#44cc44 guibg=#000000
" Meta and special keys listed with ":map", also for text used
hi SpecialKey	guifg=#44cc44 guibg=#000000
" status line of current window
hi StatusLine	guifg=#55ff55 guibg=#339933 gui=none
" status lines of not-current windows
hi StatusLineNC	guifg=#113311 guibg=#339933 gui=none
" titles for output from ":set all", ":autocmd" etc.
hi Title	guifg=#55ff55 guibg=#113311 gui=bold
" Visual mode selection
hi Visual	guifg=#55ff55 guibg=#339933 gui=none
" Visual mode selection when vim is "Not Owning the Selection".
hi VisualNOS	guifg=#44cc44 guibg=#000000
" warning messages
hi WarningMsg	guifg=#55ff55 guibg=#000000
" current match in 'wildmenu' completion
hi WildMenu	guifg=#226622 guibg=#55ff55

hi Comment	guifg=#116611 guibg=#000000
hi Constant	guifg=#55ff55 guibg=#226622
hi Special	guifg=#44cc44 guibg=#226622
hi Identifier	guifg=#55ff55 guibg=#000000
hi Statement	guifg=#55ff55 guibg=#000000 gui=bold
hi PreProc	guifg=#339933 guibg=#000000
hi Type		guifg=#55ff55 guibg=#000000 gui=bold
hi Underlined	guifg=#55ff55 guibg=#000000 gui=underline
hi Error	guifg=#55ff55 guibg=#339933
hi Todo		guifg=#113311 guibg=#44cc44 gui=none

"+++ Cream:

" statusline
highlight User1  gui=BOLD guifg=#116611 guibg=#002200
highlight User2  gui=bold guifg=#66aa66 guibg=#002200
highlight User3  gui=bold guifg=#00cc00 guibg=#002200
highlight User4  gui=bold guifg=#ffff00 guibg=#002200

" bookmarks
highlight Cream_ShowMarksHL gui=BOLD guifg=#99ff33 guibg=#006600

" spell check
highlight SpellBad   gui=undercurl guisp=#00ff00
highlight SpellRare  gui=undercurl guisp=#779900
highlight SpellLocal gui=undercurl guisp=#009900
highlight SpellCap   gui=undercurl guisp=#66cc00

" current line
highlight CurrentLine term=reverse ctermbg=0 ctermfg=14 gui=none guibg=#406070

" email
highlight EQuote1 guifg=#00aa00
highlight EQuote2 guifg=#009900
highlight EQuote3 guifg=#007700
highlight Sig guifg=#005500

"+++

