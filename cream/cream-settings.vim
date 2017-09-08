"
" cream-settings.vim
"
" Cream -- An easy-to-use configuration of the famous Vim text  editor
" [ http://cream.sourceforge.net ] Copyright (C) 2001-2011 Steve Hall
"
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 2 of  the  License,  or
" (at your option) any later version.
" [ http://www.gnu.org/licenses/gpl.html ]
"
" This program is distributed in the hope that it will be useful,  but
" WITHOUT  ANY  WARRANTY;  without  even  the  implied   warranty   of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR  PURPOSE.  See  the  GNU
" General Public License for more details.
"
" You should have received a copy of the GNU  General  Public  License
" along with  this  program;  if  not,  write  to  the  Free  Software
" Foundation,  Inc.,  59  Temple  Place  -  Suite  330,   Boston,   MA
" 02111-1307, USA.
"
" Description:
" * basic environmental settings required by most of Cream
" * no global variables set here
"

" General {{{1

" makes Vim "modeless"
set insertmode

"*** Do NOT use! (Individual options set elsewhere)
"behave mswin
"***

" write ("nowrite" is a read-only/file viewer)
set write

" file to use for keyword completion (not spelling!)
"set dictionary=/usr/dict/words

" hold screen updating while executing macros
" * nolazyredraw is slower
" * nolazyredraw ensures better accuracy ;)
" *   lazyredraw still allows "redraw!" to override within a function
set nolazyredraw

" Just use default
"" GTK2 hack: <S-Space> is broken otherwise
"if has("gui_gtk2")
"    set imdisable
"endif

" Vim plugins {{{1

" the loading of Vim plugins can be controled by the
" g:CREAM_NOVIMPLUGINS variable
if exists("g:CREAM_NOVIMPLUGINS")
	if g:CREAM_NOVIMPLUGINS == 1
		set noloadplugins
	endif
endif

" Paths (misc, critical are set in vimrc) {{{1

" set default search paths for files
"set path=.,,

"" set current directory equal to location of current buffer
"" Source: http://vim.sourceforge.net/tips/tip.php?tip_id=64
"" Author: William Lee, modified by ict@eh.org
"function! Cream_cwd()
"    let mydir = expand("%:p:h")
"    if mydir !~ '^/tmp'
"      exec "cd " . mydir
"    endif
"    unlet mydir
"endfunction

" set browse location
" TODO: We use getcwd() and g:CREAM_CWD elsewhere to effectively
"       accomplish the same thing. While this is automatic, Cream uses
"       a more selective strategy to avoid setting a high latency
"       directory active.
set browsedir=buffer
" can't use this, depends on too restrictive features (:help feature-list)
"set autochdir

" Windows and Buffers {{{1

" confirm certain (verbose) operations to unsaved buffers
set noconfirm
" * Allow hidden buffers! When a new buffer is opened and then
"   modified, we do not want to force the user to write it before they
"   switch to another file/buffer. (We just want it to show up in the
"   buffer list as modified.) So it should not be abandoned if
"   unsaved, which is what ":set nohidden" does.
set hidden
" used to set buffers no longer displayed in a window (empty means
" follow global 'set hidden')
set bufhidden=
" automatically save modifications to files when you use buffer/window
" commands.
set noautowrite
" automatically save modifications to files when you use critical
" (rxternal) commands.
set noautowriteall

" keep window sizes mostly equal
set equalalways

" height of help window -- zero disables (50%) (default=20)
set helpheight=0
" Create new windows below current one
set splitbelow

" turn off alternate file
set cpoptions-=a

" Window titling {{{1

" window icon text--use defaults
function! Cream_titletext()

	" verify b:cream_nr
	call Cream_buffer_nr()
	" verify buffer name
	call Cream_buffer_pathfile()

	" modified
	if getbufvar(b:cream_nr, "&modified") == 1
		let mymod = "*"
	else
		let mymod = ""
	endif

	" filename
	let myfile = fnamemodify(b:cream_pathfilename, ":t")

	if     myfile == ""
		let myfile = "[untitled]"
	elseif Cream_buffer_isspecial() == 1
		if Cream_buffer_ishelp() == 1
			let myfile = "Help"
		elseif myfile == "_opsplorer"
			let myfile = "File Tree"
		elseif isdirectory(bufname(b:cream_nr))
			let myfile = "File Explorer"
		elseif myfile == "__Calendar"
			let myfile = "Calendar"
		elseif myfile == "__Tag_List__"
			let myfile = "Tag List"
		elseif myfile == "-- EasyHtml --"
			let myfile = "Item List"
		endif
	endif
	let myfile = myfile . " "

	" path
	if     Cream_buffer_ishelp() == 1
		let mypath = "(" . fnamemodify(b:cream_pathfilename, ":h") . ")"
		" add trailing slash if doesn't exist
		let mypath = Cream_path_addtrailingslash(mypath)
	elseif b:cream_pathfilename == ""
		let mypath = ""
	elseif Cream_buffer_isspecial() == 1
		let mypath = ""
	else
		" add trailing slash if doesn't exist
		let mypath = Cream_path_addtrailingslash(fnamemodify(b:cream_pathfilename, ":h"))
		let mypath = "(" . mypath . ")"
	endif

	"" limit total length (until titlelen gets fixed)
	"if strlen(mypath . myfile . mymod) > 50
	"    let mypath = "..." . strpart(mypath, strlen(mypath . myfile . mymod) - 47)
	"endif

	return mymod . myfile . mypath

endfunction
function! Cream_titletext_init()
	set titlestring=%.999{Cream_titletext()}
endfunction
" broken
set titlelen=0
set title

" Editing and Keyboard {{{1

" place two spaces after a period
set nojoinspaces

" allow cursor positioning where there is no character. (Useful in Visual block
" mode.) (Options are 'block', 'insert', 'all'.)
set virtualedit=block


" use a faster timeout setting
set timeout
set timeoutlen=300
"set ttimeout
"set ttimeoutlen=200

" Menus  {{{1

if has("gui_running")
" GUI menus
	" general Vim menu Settings

	" menubar (initially off to improve loading speed, turned back on
	" via autocmd after startup)
	set guioptions-=m
	" grey menu items when not active (rather than hide them)
	set guioptions+=g

	" hide toolbar for faster startup (init will turn on on VimEnter)
	set guioptions-=T

	" toolbar (Cream_toolbar_toggle() toggle function in cream-lib.vim)
	function! Cream_toolbar_init()
		" initialize
		if !exists("g:CREAM_TOOLBAR")
			let g:CREAM_TOOLBAR = 1
		endif
		" set
		if g:CREAM_TOOLBAR == 1
			" toolbar
			set guioptions+=T
		else
			" no toolbar
			set guioptions-=T
		endif
	endfunction

	" allow tearoff menus
	set guioptions-=t

	" allows use of [ALT] key, in combination with others, to access GUI menus.
	"*** Need to find a way to de-conflict these from language mappings ***
	set winaltkeys=menu

endif

" M -- means "Don't source default menu"
set guioptions+=M


" Console menus

set wildmenu
set cpoptions-=<
set wildcharm=<C-z>

" Selection {{{1

" allow "special" keys to begin select mode. (This option is useful
" for enabling "windows-like" text selection.
set keymodel=startsel,stopsel

" end of line selection behavior
set selection=exclusive

" starts Select mode instead of Visual mode in the prescribed
" conditions. (Options: mouse,cmd,key)
"***       Use 'key' to replace selected text with a character! (non-mouse) ***
"*** Don't use 'cmd' because we need visual mode for column editing! ***
"***       Use 'cmd' because... ***
"*** Don't use 'mouse' so that double-click selects can be pasted upon. (Bogus) ***
set selectmode=key,mouse


" Motion {{{1

" allows backspacing" over indentation, end-of-line, and
" start-of-line.
set backspace=indent,eol,start

" Allow jump commands for left/right motion to wrap to previous/next
" line when cursor is on first/last character in the line.
set whichwrap+=<,>,h,l,[,]


" jump to first character with page commands ('no' keeps the cursor in the current column)

"*** doesn't work for me
set startofline
" append <Home>/<End> to fix
"***

" Terminal {{{1

"*** Now dynamically set in lib function Cream_errorbells()
"	t_vb:  terminal's visual bell (See also 'visualbell')
"set t_vb=
"***

" Wrap {{{1

" do not indicate lines that have been wrapped. (Should show on last
" column, not on first!)
set cpoptions-=n

" line break at spaces
set linebreak
" determine which characters cause a line break (default: set breakat=" ^I!@*-+;:,./?")
set breakat=\ -


" substitute spaces for a tab character
" * Typically off. User can choose AutoWrap and QuickFormat to change.
set noexpandtab
" Inserts blanks if at the beginning of a line.
set nosmarttab

" see :help fo-table (notice that we're resetting, not adding!)
" * DO NOT ADD "w" option... it completely hoses auto-wrap!
"set formatoptions=tcrqn2m
set formatoptions=tcrqm

" Completion, Incrementing {{{1

set showfulltag

set nrformats=alpha

" Case sensitivity {{{1

set ignorecase

" convert to case of current start
set infercase


" Mouse {{{1

" window focus follows mouse (when multiple windows present). (Nice if you're an
" expert, too confusing otherwise.)
set nomousefocus
set mousemodel=popup


" Scrolling {{{1

" minimum number of screen rows ('lines') to maintain context in
" vertical cursor movements.
set scrolloff=1
" *** I have found this to screw up 'linebreak' with 'wordwrap',
"     'breakat' and 'linebreak' ***
"set sidescrolloff=5

" show as much of a non-fitting line as possible
set display=lastline


" Command Line {{{1

" mode indication on command line
set noshowmode
" sure do wish I could make these go away to "pop" open when necessary.
set cmdheight=1
set cmdwinheight=1

" the char used for "expansion" on the command line. (Default value is <TAB>.)
" * <C-Space> is mapped elsewhere, but for insertmode in the doc (NOT the command line.)
set wildchar=<TAB>


" Errors {{{1

" Note: See library and autocommands for errorbell and visualbell
" settings

" default is "filnxtToO"
" * Add 'I' to disable splash screen
set shortmess=stOTI


" Clipboard {{{1

" use OS clipboard for general register
"set clipboard+=unnamed

if has("gui_running")
	" Vim selection to OS clipboard
	set guioptions-=a
	" Vim selection to OS clipboard, modeless
	set guioptions-=A
endif


" Folding {{{1

"set foldmethod=marker

" Filetype {{{1

" turn on
filetype plugin on

" Backups, swap files, viewoptions, history and mksessions {{{1
" * Move this section below path configuration if $CREAM is ever appended here.
" * Location to place backup files. Perhaps we could create a more sophisticated
"   approach here, such as automating the creation of a ./.bak ?

" create backup file on save
set backup
" create backup before overwriting (erased if successful)
set writebackup
" set backup file extension (Sometimes prefer ".bak" but tilde is easier to see)
set backupext=.~

" use a swapfile (turned off in Cream_singleserver_init() for
" single-server mode)
set swapfile

" * Hmmm... 'slash' is undocumented.
" * Don't use 'options', it overwrites Cream initializations
set viewoptions=folds,cursor,unix

set history=200

" mksession conditioning
" * Also available: localoptions,options,sesdir
" * Don't save 'options' -- we want auto re-detection of filetype and comment loading.
" * "set sessionoptions+=tabpages" done elsewhere
set sessionoptions=blank,buffers,curdir,folds,globals,help,resize,slash,unix,winpos,winsize

" Bracket matching {{{1

"set matchtime -- set at Cream_bracketmatch_init()
let g:loaded_matchparen = 1

" Search {{{1
set incsearch

" Diff {{{1

if has("win32")
	set diffexpr=MyDiff()
endif

" 1}}}
" vim:foldmethod=marker
