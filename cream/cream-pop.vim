"
" Filename: cream-pop.vim
"
" Cream -- An easy-to-use configuration of the famous Vim text editor
" [ http://cream.sourceforge.net ] Copyright (C) 2001-2011 Steve Hall
"
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 3 of the License, or
" (at your option) any later version.
" (http://www.gnu.org/licenses/gpl.html)
"
" This program is distributed in the hope that it will be useful, but
" WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
" General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software
" Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
" 02111-1307, USA.
"
" Description:
" Pops up a menu at the cursor upon "(" when the preceding word
" matches a previously initialized variable (function name). This
" variable is filetype specific, although general functions can be
" made global by inclusion .
"
" We use the :popup function to display it at the cursor (Win32 only
" support by Vim at the moment). If there's a match, the function is
" popped; otherwise it's ignored.
"
" Notes:
" * Default popup menu is restored via Cream_menu_popup() every
"   <LeftMouse>
"

function! Cream_pop(word)
" pop up a menu matching the global variable passed
" * Assumes a global menu variable (passed in the form "g:TestCow")
"   already exists (must verify before here!)

	" create popup menu item with same name as variable
	execute 'let mymenuname = a:word'
	" remove initial "g:"
	let mymenuname = strpart(mymenuname, 2)
	" remove initial encoding + "_"
	let mypos = match(mymenuname, "_") + 1
	let mymenuname = strpart(mymenuname, mypos)
	execute 'let mydescription = ' . a:word . '_menu'

	" display
	call Cream_pop_menu(mydescription)

	" TODO: now loop and enter every char exactly as entered
	" until user hits Esc, Enter, motion or end parenthesis

endfunction

function! Cream_pop_words(filetype, word, menu)
" create global based on the name and create the abbreviation
" * First argument is intended filetype
" * Second argument is function name (or, more generally, the object
"   to be completed on)
" * Third argument is the description, to be explained between the
"   parenthesis

	" validate function name
	" no spaces allowed
	if match(a:word, " ") != -1
		call confirm(
			\ "Invalid function name passed to Cream_pop_words():\n" .
			\ "   \"" . a:word . "\"\n" .
			\ "\n" .
			\ "Quitting..." .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" handle ampersands on Win32
	if has("win32")
		let menu_contents = substitute(a:menu, '&', '&&', 'g')
	else
		let menu_contents = a:menu
	endif

	" expose global for name *** CONTAINS MENU NAME, minus filename + "_"! ***
	execute "let g:pop_" . a:filetype . "_" . a:word . ' = a:word'
	" expose global for menu contents
	execute "let g:pop_" . a:filetype . "_" . a:word . "_menu = \"" . menu_contents . "\""

endfunction

function! Cream_pop_paren_map(...)
" use parenthesis to pop up function def info (if global by same name
" exists)
" special arguments:
" o (any)     -- avoids "not found" dialog
" o "autopop" -- avoids trying current function

	if a:0 > 0
		let myarg = a:1
	else
		let myarg = ""
	endif

	" back up behind parenthesis to check
	normal h

	" unless we are at the very end of the line, we need to go back in
	" order to find the last word typed.
	if virtcol('.') != virtcol('$')
		normal! h
		let myword = expand('<cword>')
		normal! l
	else
		let myword = expand('<cword>')
	endif


	"..........................................................
	" try our conditioned environment first
	let word = "g:pop_nil_" . myword
	if exists(word)
		" do Pop
		call Cream_pop(word)
		return
	endif

	"..........................................................
	" try filetype-specific next
	let word = "g:pop_" . &filetype . "_" . myword
	if exists(word)
		" do Pop
		call Cream_pop(word)
		return
	endif

	"..........................................................
	" try remote function prototype via ctag
	let mytag = expand("<cword>")
	" remember pos and file
	let myvcol = virtcol('.')
	let myline = line('.')
	let mybufnr = bufnr("%")
	let mypos = Cream_pos()
	" do jump
	execute "silent! tag " . mytag
	if  myvcol != virtcol('.')
	\|| myline != line('.')
	\|| mybufnr != bufnr("%")
		" get prototype
		let myprototype = Cream_Tlist_prototype()
		" jump back
		silent! pop
		" position
		execute mypos
		redraw
		" TODO: remove one from bottom of stack list (forget this jump)
		"...
		" display prototype
		call Cream_pop_menu(myprototype)

		return
	endif
	" don't jump back, we didn't move or add to stack

	"..........................................................
	" quit here if if called via AutoPop
	if myarg ==? "autopop"
		" fix position
		normal l
		return
	endif

	"..........................................................
	" try current function prototype
	let myprototype = Cream_Tlist_prototype()
	if myprototype != ""
		" popup
		call Cream_pop_menu("current:     " . myprototype)
		return
	endif

	if myarg ==? ""
		" Dialog: no info available
		let n = confirm(
			\ "No information available for this word.\n" .
			\ "\n", "&Ok", 1, "Info")
	endif

	" fix position
	normal l

endfunction

function! Cream_pop_menu(menuitem)
" pop up the prototype under the cursor

	if a:menuitem != ""

		silent! unmenu PopUp
		silent! unmenu! PopUp

		let menuitem_esc = escape(a:menuitem, ' \.')
		" handle ampersands on Win32
		if has("win32")
			let menuitem_esc = substitute(menuitem_esc, '&', '&&', 'g')
		endif

		" provide a more free-form description
		execute 'imenu <silent> PopUp.' . menuitem_esc. ' ' . a:menuitem

		" display
		" silent causes first usage to do nothing (Win95, 2003-04-04)
		" BUG HACK: first time through, fails, do twice
		if !exists("g:cream_popup")
			let g:cream_popup = 1
			silent! popup PopUp
		endif
		silent! popup PopUp

		" un-backup space check
		normal l
		return 1

	endif
	return 0

endfunction

function! Cream_pop_options()
" allow user to control pop preference
" * assumes global has been initialized prior to here

	" only windows has the :popup feature (for now)
	if !has("win32") && !has("gui_gtk")
		call confirm(
			\ "Sorry, Vim's \":popup\" feature is only supported on \n" .
			\ "the Windows and GTK platforms.\n" .
			\ "\n", "&Ok", 2, "Warning")
		return
	elseif has("gui_gtk") && v:version < 601
	\ ||   has("gui_gtk") && v:version == 601 && !has("patch433")
		call confirm(
			\ "Support for Vim's \":popup\" feature on GTK \n" .
			\ "was added in version 6.1.433. Please upgrade to use.\n" .
			\ "\n", "&Continue\n&Quit", 2, "Warning")
		return
	endif

	let n = confirm(
		\ "Use auto-popup information feature? (Prototype indicated\n" .
		\ "every time an open parenthesis is typed.)\n" .
		\ "\n", "&Yes\n&No\n&Cancel", 1, "Info")
	if     n == 1
		let g:CREAM_POP_AUTO = 1
		imap <silent> ( (<C-b>:call Cream_pop_paren_map("autopop")<CR>
	elseif n == 2
		let g:CREAM_POP_AUTO = 0
		silent! iunmap (
	endif

endfunction

function! Cream_pop_init()
" initializes global auto-pop variable

	"" only windows has the :popup feature (for now)
	"if !has("win32")
	"    return
	"endif

	" make pop automatic upon "("  (default: off)
	if !exists("g:CREAM_POP_AUTO")
		let g:CREAM_POP_AUTO = 0
	endif

	" auto pop (require two parenthesis if off--and single will delay!)
	if g:CREAM_POP_AUTO == 1
		imap <silent> ( (<C-b>:call Cream_pop_paren_map("autopop")<CR>
	endif

endfunction

"=
" List pop up items
"
" * Use "nil" for info boxes on words across any filetype.

"" create fake popup items
"call Cream_pop_words('nil', 'TestBob', ' NOPE!!!')
"call Cream_pop_words('vim', 'TestCow', 'size, color, horns')

" vim functions {{{1
"call Cream_pop_words('vim', 'append', 'append( {lnum}, {string} ) -- append {string} below line {lnum}')
"call Cream_pop_words('vim', 'argc', 'argc() -- number of files in the argument list')
"call Cream_pop_words('vim', 'argidx', 'argidx() -- current index in the argument list')
"call Cream_pop_words('vim', 'argv', 'argv( {nr} ) -- {nr} entry of the argument list')
"call Cream_pop_words('vim', 'browse', 'browse( {save}, {title}, {initdir}, {default} ) -- put up a file requester')
"call Cream_pop_words('vim', 'bufexists', 'bufexists( {expr} ) -- TRUE if buffer {expr} exists')
"call Cream_pop_words('vim', 'buflisted', 'buflisted( {expr} ) -- TRUE if buffer {expr} is listed')
"call Cream_pop_words('vim', 'bufloaded', 'bufloaded( {expr} ) -- TRUE if buffer {expr} is loaded')
"call Cream_pop_words('vim', 'bufname', 'bufname( {expr} ) -- Name of the buffer {expr}')
"call Cream_pop_words('vim', 'bufnr', 'bufnr( {expr} ) -- Number of the buffer {expr}')
"call Cream_pop_words('vim', 'bufwinnr', 'bufwinnr( {expr} ) -- window number of buffer {expr}')
"call Cream_pop_words('vim', 'byte2line', 'byte2line( {byte} ) -- line number at byte count {byte}')
"call Cream_pop_words('vim', 'char2nr', 'char2nr( {expr} ) -- ASCII value of first char in {expr}')
"call Cream_pop_words('vim', 'cindent', 'cindent( {lnum} ) -- C indent for line {lnum}')
"call Cream_pop_words('vim', 'col', 'col( {expr} ) -- column nr of cursor or mark')
"call Cream_pop_words('vim', 'confirm', 'confirm( {msg} [, {choices} [, {default} [, {type}]]] ) -- number of choice picked by user')
"call Cream_pop_words('vim', 'cscope_connection', 'cscope_connection( [{num} , {dbpath} [, {prepend}]] ) -- checks existence of cscope connection')
"call Cream_pop_words('vim', 'cursor', 'cursor( {lnum}, {col} ) -- position cursor at {lnum}, {col}')
"call Cream_pop_words('vim', 'delete', 'delete( {fname} ) -- delete file {fname}')
"call Cream_pop_words('vim', 'did_filetype', 'did_filetype() -- TRUE if FileType autocommand event used')
"call Cream_pop_words('vim', 'escape', 'escape( {string}, {chars} ) -- escape {chars} in {string} with \"\\\"')
"call Cream_pop_words('vim', 'eventhandler', 'eventhandler() -- TRUE if inside an event handler')
"call Cream_pop_words('vim', 'executable', 'executable( {expr} ) -- 1 if executable {expr} exists')
"call Cream_pop_words('vim', 'exists', 'exists( {var} ) -- TRUE if {var} exists')
"call Cream_pop_words('vim', 'expand', 'expand( {expr} ) -- expand special keywords in {expr}')
"call Cream_pop_words('vim', 'filereadable', 'filereadable( {file} ) -- TRUE if {file} is a readable file')
"call Cream_pop_words('vim', 'filewritable', 'filewritable( {file} ) -- TRUE if {file} is a writable file')
"call Cream_pop_words('vim', 'fnamemodify', 'fnamemodify( {fname}, {mods} ) -- modify file name')
"call Cream_pop_words('vim', 'foldclosed', 'foldclosed( {lnum} ) -- first line of fold at {lnum} if closed')
"call Cream_pop_words('vim', 'foldclosedend', 'foldclosedend( {lnum} ) -- last line of fold at {lnum} if closed')
"call Cream_pop_words('vim', 'foldlevel', 'foldlevel( {lnum} ) -- fold level at {lnum}')
"call Cream_pop_words('vim', 'foldtext', 'foldtext() -- line displayed for closed fold')
"call Cream_pop_words('vim', 'foreground', 'foreground() -- bring the Vim window to the foreground')
"call Cream_pop_words('vim', 'getchar', 'getchar( [expr] ) -- get one character from the user')
"call Cream_pop_words('vim', 'getcharmod', 'getcharmod() -- modifiers for the last typed character')
"call Cream_pop_words('vim', 'getbufvar', 'getbufvar( {expr}, {varname} ) -- variable {varname} in buffer {expr}')
"call Cream_pop_words('vim', 'getcwd', 'getcwd() -- the current working directory')
"call Cream_pop_words('vim', 'getftime', 'getftime( {fname} ) -- last modification time of file')
"call Cream_pop_words('vim', 'getfsize', 'getfsize( {fname} ) -- size in bytes of file')
"call Cream_pop_words('vim', 'getline', 'getline( {lnum} ) -- line {lnum} from current buffer')
"call Cream_pop_words('vim', 'getwinposx', 'getwinposx() -- X coord in pixels of GUI vim window')
"call Cream_pop_words('vim', 'getwinposy', 'getwinposy() -- Y coord in pixels of GUI vim window')
"call Cream_pop_words('vim', 'getwinvar', 'getwinvar( {nr}, {varname} ) -- variable {varname} in window {nr}')
"call Cream_pop_words('vim', 'glob', 'glob( {expr}] ) -- expand file wildcards in {expr}')
"call Cream_pop_words('vim', 'globpath', 'globpath( {path}, {expr} ) -- do glob({expr}) for all dirs in {path}')
"call Cream_pop_words('vim', 'has', 'has( {feature} ) -- TRUE if feature {feature} supported')
"call Cream_pop_words('vim', 'hasmapto', 'hasmapto( {what} [, {mode}] ) -- TRUE if mapping to {what} exists')
"call Cream_pop_words('vim', 'histadd', 'histadd( {history},{item} ) -- add an item to a history')
"call Cream_pop_words('vim', 'histdel', 'histdel( {history} [, {item}] ) -- remove an item from a history')
"call Cream_pop_words('vim', 'histget', 'histget( {history} [, {index}] ) -- get the item {index} from a history')
"call Cream_pop_words('vim', 'histnr', 'histnr( {history} ) -- highest index of a history')
"call Cream_pop_words('vim', 'hlexists', 'hlexists( {name} ) -- TRUE if highlight group {name} exists')
"call Cream_pop_words('vim', 'hlID', 'hlID( {name} ) -- syntax ID of highlight group {name}')
"call Cream_pop_words('vim', 'hostname', 'hostname() -- name of the machine vim is running on')
"call Cream_pop_words('vim', 'iconv', 'iconv( {expr}, {from}, {to} ) -- convert encoding of {expr}')
"call Cream_pop_words('vim', 'indent', 'indent( {lnum} ) -- indent of line {lnum}')
"call Cream_pop_words('vim', 'input', 'input( {prompt} [, {text}] ) -- get input from the user')
"call Cream_pop_words('vim', 'inputdialog', 'inputdialog( {prompt} [, {text}] ) -- like input() but in a GUI dialog')
"call Cream_pop_words('vim', 'inputsecret', 'inputsecret( {prompt} [, {text}] ) -- like input() but hiding the text')
"call Cream_pop_words('vim', 'isdirectory', 'isdirectory( {directory} ) -- TRUE if {directory} is a directory')
"call Cream_pop_words('vim', 'libcall', 'libcall( {lib}, {func}, {arg} ) -- call {func} in library {lib} with {arg}')
"call Cream_pop_words('vim', 'libcallnr', 'libcallnr( {lib}, {func}, {arg} ) -- idem, but return a Number')
"call Cream_pop_words('vim', 'line', 'line( {expr} ) -- line nr of cursor, last line or mark')
"call Cream_pop_words('vim', 'line2byte', 'line2byte( {lnum} ) -- byte count of line {lnum}')
"call Cream_pop_words('vim', 'lispindent', 'lispindent( {lnum} ) -- Lisp indent for line {lnum}')
"call Cream_pop_words('vim', 'localtime', 'localtime() -- current time')
"call Cream_pop_words('vim', 'maparg', 'maparg( {name}[, {mode}] ) -- rhs of mapping {name} in mode {mode}')
"call Cream_pop_words('vim', 'mapcheck', 'mapcheck( {name}[, {mode}] ) -- check for mappings matching {name}')
"call Cream_pop_words('vim', 'match', 'match( {expr}, {pat}[, {start}] ) -- position where {pat} matches in {expr}')
"call Cream_pop_words('vim', 'matchend', 'matchend( {expr}, {pat}[, {start} ) -- position where {pat} ends in {expr}')
"call Cream_pop_words('vim', 'matchstr', 'matchstr( {expr}, {pat}[, {start}] ) -- match of {pat} in {expr}')
"call Cream_pop_words('vim', 'mode', 'mode() -- String  current editing mode')
"call Cream_pop_words('vim', 'nextnonblank', 'nextnonblank( {lnum} ) -- line nr of non-blank line >= {lnum}')
"call Cream_pop_words('vim', 'nr2char', 'nr2char( {expr} ) -- single char with ASCII value {expr}')
"call Cream_pop_words('vim', 'prevnonblank', 'prevnonblank( {lnum} ) -- line nr of non-blank line <= {lnum}')
"call Cream_pop_words('vim', 'remote_expr', 'remote_expr( {server}, {string} [, {idvar}] ) -- send expression')
"call Cream_pop_words('vim', 'remote_foreground', 'remote_foreground( {server} ) -- bring Vim server to the foreground')
"call Cream_pop_words('vim', 'remote_peek', 'remote_peek( {serverid} [, {retvar}] ) -- check for reply string')
"call Cream_pop_words('vim', 'remote_read', 'remote_read( {serverid} ) -- read reply string')
"call Cream_pop_words('vim', 'remote_send', 'remote_send( {server}, {string} [, {idvar}] ) -- send key sequence')
"call Cream_pop_words('vim', 'rename', 'rename( {from}, {to} ) -- rename (move) file from {from} to {to}')
"call Cream_pop_words('vim', 'resolve', 'resolve( {filename} ) -- get filename a shortcut points to')
"call Cream_pop_words('vim', 'search', 'search( {pattern} [, {flags}] ) -- search for {pattern}')
"call Cream_pop_words('vim', 'searchpair', 'searchpair( {start}, {middle}, {end} [, {flags} [, {skip}]] ) -- search for other end of start/end pair')
"call Cream_pop_words('vim', 'server2client', 'server2client( {serverid}, {string} ) -- send reply string')
"call Cream_pop_words('vim', 'serverlist', 'serverlist() -- get a list of available servers')
"call Cream_pop_words('vim', 'setbufvar', 'setbufvar( {expr}, {varname}, {val} ) -- set {varname} in buffer {expr} to {val}')
"call Cream_pop_words('vim', 'setline', 'setline( {lnum}, {line} ) -- set line {lnum} to {line}')
"call Cream_pop_words('vim', 'setwinvar', 'setwinvar( {nr}, {varname}, {val} ) -- set {varname} in window {nr} to {val}')
"call Cream_pop_words('vim', 'strftime', 'strftime( {format}[, {time}] ) -- time in specified format')
"call Cream_pop_words('vim', 'stridx', 'stridx( {haystack}, {needle} ) -- first index of {needle} in {haystack}')
"call Cream_pop_words('vim', 'strlen', 'strlen( {expr} ) -- length of the String {expr}')
"call Cream_pop_words('vim', 'strpart', 'strpart( {src}, {start}[, {len}] ) -- {len} characters of {src} at {start}')
"call Cream_pop_words('vim', 'strridx', 'strridx( {haystack}, {needle} ) -- last index of {needle} in {haystack}')
"call Cream_pop_words('vim', 'strtrans', 'strtrans( {expr} ) -- translate string to make it printable')
"call Cream_pop_words('vim', 'submatch', 'submatch( {nr} ) -- specific match in \":substitute\"')
"call Cream_pop_words('vim', 'substitute', 'substitute( {expr}, {pat}, {sub}, {flags} ) -- all {pat} in {expr} replaced with {sub}')
"call Cream_pop_words('vim', 'synID', 'synID( {line}, {col}, {trans} ) -- syntax ID at {line} and {col}')
"call Cream_pop_words('vim', 'synIDattr', 'synIDattr( {synID}, {what} [, {mode}] ) -- attribute {what} of syntax ID {synID}')
"call Cream_pop_words('vim', 'synIDtrans', 'synIDtrans( {synID} ) -- translated syntax ID of {synID}')
"call Cream_pop_words('vim', 'system', 'system( {expr} ) -- output of shell command {expr}')
"call Cream_pop_words('vim', 'tempname', 'tempname() -- name for a temporary file')
"call Cream_pop_words('vim', 'tolower', 'tolower( {expr} ) -- the String {expr} switched to lowercase')
"call Cream_pop_words('vim', 'toupper', 'toupper( {expr} ) -- the String {expr} switched to uppercase')
"call Cream_pop_words('vim', 'type', 'type( {name} ) -- type of variable {name}')
"call Cream_pop_words('vim', 'virtcol', 'virtcol( {expr} ) -- screen column of cursor or mark')
"call Cream_pop_words('vim', 'visualmode', 'visualmode() -- last visual mode used')
"call Cream_pop_words('vim', 'winbufnr', 'winbufnr( {nr} ) -- buffer number of window {nr}')
"call Cream_pop_words('vim', 'wincol', 'wincol() -- window column of the cursor')
"call Cream_pop_words('vim', 'winheight', 'winheight( {nr} ) -- height of window {nr}')
"call Cream_pop_words('vim', 'winline', 'winline() -- window line of the cursor')
"call Cream_pop_words('vim', 'winnr', 'winnr() -- number of current window')
"call Cream_pop_words('vim', 'winwidth', 'winwidth( {nr} ) -- width of window {nr}')

" 1}}}
" vim:foldmethod=marker
