"
" cream-menu-mru.vim -- Most Recent Used (MRU) file list menu
"   as modified for the Cream project (http://cream.sourceforge.net)
"
" Cream -- An easy-to-use configuration of the famous Vim text editor
" [ http://cream.sourceforge.net ] Copyright (C) 2001-2011 Steve Hall
"
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
" Origin: http://vim.sourceforge.net/scripts/script.php?script_id=207
" Notes:
" * Cream modifications are bracketed by '+++' comments
" * Menu renamed and prioritized to accommodate loading at the bottom
"   of the File menu rather than in a separate menu. (Requires
"   that the remainder of the menu is able to be loaded by a function
"   call.)
" * Made all menu loads and unloads silent.
" * Renamed "Options" menu to "Recent Files, Options" and made it
"   precede the file list rather than follow it. (Makes a more
"   intuitive looking and informative header.)
" * Changed item numbering from 0-9 to 1-10
" * Commented options to rename the menu or to edit it directly from
"   the Options menu.
" * Ampersand doubling restricted to Microsoft platforms.
" * Menu items aligned.
"
" ChangeLog:
"
" 2003-05-16
" o Synced with 6.0.3.
"
" 2003-02-07
" o Abstracted separator character so we can test various encodings
"   quickly.
"
" 2002-03-27
" o Got help file exclusions working. Depends both on correct
"   filtering statement AND removal of redundant autocmd events which
"   errantly checked filetypes without subject buffer being current.
" o Fixed handling of files containing tildes. This was a problem
"   when matching against the entire buffer list in MRURefreshMenu().
"
"......................................................................


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Purpose: Create a menu with most recently used files
" Author: Rajesh Kallingal <RajeshKallingal@yahoo.com>
" Original Author: ???
" Version: 6.0.3
" Last Modified: Thu May 15 16:29:52 2003
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Description:
" 	This plugin will create a MRU menu to keep track of most recently visited
" 	buffers. You can customize Menu Label, menu size and whether to show
" 	numbered or non-numbered menu
"
"	Global Variables Used:
" 	Make sure you have added '!' in 'viminfo' option to save global valiables
"		MRU_BUFFERS - keeps the lsit of recent buffers, usedto build the menu
"		MRU_MENUSIZE - maximum entries to keep in the list
"		MRU_HOTKEYS - whether to have a hot key of 0-9, A-Z in the menu
"		MRU_LABEL - menu name to use, default is 'M&RU'
"
"	Excludes:
"		help files (not working)
"
" Installation:
" 	Just drop it this file in your plugin folder/directory.
"
" TODO:
" 	- handle buffers to exclude (unlisted buffers, help files)
" 	- handle menu size of more than 35
" 	- help document
"
" vim ts=4 : sw=4 : tw=0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do not load, if already been loaded
if exists("g:loaded_mrumenu")
	finish
endif

let g:loaded_mrumenu = 1

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

"+++ Cream: abstract separator character (from "\377")
let s:sep = "]"
"let s:sep = "\377"
"+++

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Variables
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" following are the default values for the script variables used to control
" the script behaviour. The value will be remembered for the future sessions

" store file name to use in the menu
let s:script_file = expand ('<sfile>:p')
"+++ Cream
" The menu label to be used, default value
"let s:mru_label = 'M&RU'
let s:file_prio = "10"
let s:mru_prio = "900"
let s:mru_label = '&File'
"+++
" default value
let s:mru_menusize = 10
" set this to 1 if you want to have 0-9, A-Z as the hotkeys in the mru list, set to 0 for the default file name
"+++ Cream: default to 1 rather than 0
let s:mru_hotkeys = 1
"+++


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MRUInitialize()

	call MRUInitializeGlobals ()
	call MRURefreshMenu ()

endfunction

function! MRUInitializeGlobals()
" Initialize the global variables with defaults if they are not stored in
" viminfo.

	" Do not intialize, if already been intialized
	if exists("s:initialized_globals")
		return
	endif
	let s:initialized_globals=1

	if exists('g:MRU_LABEL')
		"name of the menu
		"+++ Cream: do not assign to global value
		"let s:mru_label = g:MRU_LABEL
		let s:file_prio = "10"
		let s:mru_prio = "900"
		let s:mru_label = "&File"
		"+++
		unlet g:MRU_LABEL
	endif

	if exists('g:MRU_MENUSIZE')
		" maximum number of entries to remember
		let s:mru_menusize = g:MRU_MENUSIZE
		unlet g:MRU_MENUSIZE
	endif

	if exists('g:MRU_HOTKEYS')
		" whether or not to use hot keys 0-9, A-Z for menu items
		let s:mru_hotkeys = g:MRU_HOTKEYS
		unlet g:MRU_HOTKEYS
	endif

	if exists('g:MRU_BUFFERS')
		" list of recent buffers
		let s:mru_buffers = g:MRU_BUFFERS
"		echo strlen (s:mru_buffers)
		unlet g:MRU_BUFFERS
	else
		let s:mru_buffers = ""
	endif

"	This is not required as vim handles really long global variables
"	if !exists('g:MRU_BUFFERS')
"		call MRUJoinBufList ()
"	endif
"
	let s:mru_count = 0
	
endfunction

function! MRURefreshMenu()
" This function will recreate the menu entries from s:mru_buffers variable

	" remove the MRU Menu
	execute 'anoremenu <silent> ' . s:file_prio . "." . s:mru_prio . " " . s:mru_label . '.x x'
	execute 'silent! aunmenu '    . s:file_prio . "." . s:mru_prio . " " . s:mru_label

	" use this variable to keep the list of entries in the menu so far
	let menu_list = ''

	"+++ Cream:
	" recall rest of File menu first
	call Cream_menu_load_file()
	" put options at the top
	call MRUAddOptionMenu ()
	"+++

	let list = s:mru_buffers
	let s:mru_count = 0
	while list != "" && s:mru_count < s:mru_menusize
		" put a separator after every 10 entries
		if s:mru_count % 10 == 0 && s:mru_count / 10 > 0
			"+++ Cream: no need to be single digit, conflicts with others above
			"execute 'anoremenu <silent> ' . s:mru_prio . " " . s:mru_label . '.-sep' . s:mru_count / 10 . '- <NUL>'
			let myprio = s:mru_prio + s:mru_count
			execute 'anoremenu <silent> ' . s:file_prio . "." . myprio . " " . s:mru_label . '.-sep' . s:mru_count . '- <NUL>'
			"+++
		endif
		let entry_length = match(list, s:sep)
		if entry_length >= 0
			let fullpath = strpart(list, 0, entry_length)
			let list = strpart(list, entry_length + 1, strlen(list))
		else
			let fullpath = list
			let list = ""
		endif

		if fullpath != ""
			let filename = fnamemodify(fullpath, ':t')

			"+++ Cream: handle file names with tilde characters in matching through list
			let filename = escape(filename, "~")
			"+++

			" append a space to the filename to enable multiple entries in menu
			" which has the same filename but different path
			while (match(menu_list, '\<' . filename . "\/") >= 0)
				let filename = filename . ' '
			endwhile

			let menu_list = menu_list . filename . "\/"

			"+++ Cream: un-escape tilde characters back so menu shows correctly
			let filename = substitute(filename, '\\\~', '\~', 'g')
			"+++

			let s:mru_count = s:mru_count + 1
			call MRUAddToMenu (fullpath, filename)
		endif

	endwhile
	"+++ Cream: put options at the top
	"call MRUAddOptionMenu ()
	"+++
endfunction

function! MRUAddToMenu (fullpath, filename)
" Add the entry to the menu

	let menu_entry = a:filename . "\t" . fnamemodify(a:fullpath,':h')
	let menu_entry = escape(menu_entry, '\\. 	|\~')
	"let editfilename = escape(a:fullpath, '\\. 	|\~')
	"incase there is an & in the filename
	if OnMS()
		let menu_entry = substitute (menu_entry, '&', '&&', 'g')
		let menu_entry = substitute (menu_entry, '/', '\\\\', 'g')
		"let editfilename = substitute (editfilename, '&', '&&', 'g')
	endif

	"+++ Cream:
	" o escape spaces, backslashes, apostrophes
	" o use Cream_file_open() rather than simple :edit

	"let menu_command = ' :call MRUEditFile("' . editfilename . '")<cr>'
	"let tmenu_text = 'Edit File ' . a:fullpath

	"let myfile = escape(a:fullpath, " \'")
	let myfile = Cream_path_fullsystem(a:fullpath)
	"if bufloaded (a:fullpath)
	"    "let menu_command = ' :buffer ' . myfile . '<CR>'
	"    let menu_command_i = ' <C-b>:buffer ' . myfile . '<CR>'
	"    let menu_command_v = ' :<C-u>buffer ' . myfile . '<CR>'
	"    let tmenu_text = 'Goto Buffer ' . myfile
	"else
		"let menu_command = " :call Cream_file_open(\"" . myfile . "\")<CR>"
		"let menu_command = " :call Cream_file_open('" . myfile . "')<CR>"

		" don't specify mode, it's not necessary
		"let menu_command_i = " \<C-b>:call Cream_file_open_mru('" . myfile . "')<CR>"
		"let menu_command_v = " :\<C-u>call Cream_file_open_mru('" . myfile . "')<CR>"
		let menu_command = " :call Cream_file_open_mru('" . myfile . "')<CR>"

		let tmenu_text = 'Edit File ' . myfile
	"endif
	"+++
	"if exists("s:mru_hotkeys") && s:mru_hotkeys == 1
		 " use hot keys 0-9
		 if s:mru_count <= 10
			"+++ Cream: count from 1-10, not from 0-9
			"let alt_key = s:mru_count - 1
			let alt_key = s:mru_count
			"+++
			"+++ Cream:
			" o underline the first 10 (numbered) entries, no letters
			"   so as not to conflict with other menu items
			" o precede single digits with two spaces for beauty ;)
			if s:mru_count < 10
				" single digits
					let alt_key = "\\ \\ &" . alt_key
			elseif s:mru_count == 10
				" 10 is special (alt_key should equal "10")
				let alt_key = "1&0"
			endif
			"+++
		" use hot keys A-Z
		else
			let alt_key = nr2char(s:mru_count + 54) " start with A at 65
			"+++ Cream: append spaces before letters to justify with numbers
			let alt_key = "\\ \\ " . alt_key
			"+++
		endif
		" menu priority
		" Trick: We're doubling the count so we can add space between
		" for visual mode menu items.
		let myprio = s:mru_prio + s:mru_count

		"execute 'anoremenu <silent> ' . myprio . " " . s:mru_label . '.' . alt_key . '\.\ ' . menu_entry . menu_command
	
		" don't specify mode, it's not necessary
		"execute 'imenu <silent> ' . s:file_prio . "." . myprio . " " . s:mru_label . '.' . alt_key . '\.\ ' . menu_entry . menu_command_i
		"execute 'vmenu <silent> ' . s:file_prio . "." . myprio . " " . s:mru_label . '.' . alt_key . '\.\ ' . menu_entry . menu_command_v
		execute 'anoremenu <silent> ' . s:file_prio . "." . myprio . " " . s:mru_label . '.' . alt_key . '\.\ ' . menu_entry . menu_command

		"execute 'tmenu <silent> ' . myprio . "." . s:mru_count . " "   . s:mru_label . '.' . alt_key . '\.\ ' . substitute (escape (a:filename, '\\. 	|\~'), '&', '&&', 'g') . ' ' . tmenu_text
	"else
	"    "execute 'anoremenu <silent> ' . s:mru_prio . " " . s:mru_label . '.' . menu_entry . menu_command
	"    execute 'imenu <silent> ' . s:mru_prio . "." . s:mru_count . " "   . s:mru_label . '.' . menu_entry . menu_command_i
	"    execute 'vmenu <silent> ' . s:mru_prio . "." . s:mru_count . ".1 " . s:mru_label . '.' . menu_entry . menu_command_v
	"    "execute 'tmenu <silent> ' . s:mru_prio . "." . s:mru_count . " "   . s:mru_label . '.' . substitute (escape (a:filename, '\\. 	|\~'), '&', '&&', 'g') . ' ' . tmenu_text
	"endif
endfunction

"function! MRUEditFile(filename)
"    " edit or go to the buffer
"
"    if bufloaded (a:filename)
"        silent execute 'buffer ' . a:filename
"    else
"        silent execute 'edit ' . a:filename
"    endif
"endfunction

function! MRUAddOptionMenu()
" Add the Option menu entries
	
	execute 'anoremenu <silent> ' . s:file_prio . "." . s:mru_prio . " " . s:mru_label . '.-sep0- <NUL>'
	"+++ Cream: do not allow list numbers to be removed
	"if exists ("s:mru_hotkeys") && s:mru_hotkeys == 1
	"    execute 'anoremenu <silent> ' . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.Non\ Numbered\ Menu :call MRUToggleHotKey()<CR>'
	"    execute 'tmenu <silent> ' . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.Non\ Numbered\ Menu Remove sequential number/alphabet from the menu entry'
	"else
	"    execute 'anoremenu <silent> ' . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.Numbered\ Menu :call MRUToggleHotKey()<CR>'
	"    execute 'tmenu <silent> ' . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.Numbered\ Menu Add a sequential number/alphabet to the menu entry (0-9/A-Z)'
	"endif
	"+++

	execute 'anoremenu <silent> ' . s:file_prio . "." . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.Set\ Menu\ Size :call MRUSetMenuSize()<CR>'
	execute 'tmenu <silent> '     . s:file_prio . "." . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.Set\ Menu\ Size Allows you to change the number of entries in menu.'
	"+++ Cream: do not allow renaming of the menu
	"execute 'anoremenu <silent> ' . s:mru_label . '.&Recent\ Files,\ Options.Rename\ Menu :call MRUSetMenuLabel()<CR>'
	"execute 'tmenu <silent> ' . s:mru_label . '.&Recent\ Files,\ Options.Rename\ Menu Allows you to rename the Top Menu Name'
	"+++

	execute 'anoremenu <silent> ' . s:file_prio . "." . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.-sep0- <NUL>'
	execute 'anoremenu <silent> ' . s:file_prio . "." . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.Remove\ Invalid :call MRURemoveInvalid()<CR>'
	execute 'tmenu <silent> '     . s:file_prio . "." . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.Remove\ Invalid Removes files no longer exists from the list'
	execute 'anoremenu <silent> ' . s:file_prio . "." . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.Clear\ List :call MRUClearList()<CR>'
	execute 'tmenu <silent> '     . s:file_prio . "." . s:mru_prio . " " . s:mru_label . '.&Recent\ Files,\ Options.Clear\ List Removes all the entries from this menu.'

endfunction

function! MRUAddToList()
" add current buffer to list of recent travellers.  Remove oldest if
" bigger than MRU_MENUSIZE

	" incase vim is started with drag & drop
	call MRUInitializeGlobals()

	"let filename = expand("<afile>:p")
	let filename = fnamemodify(expand("%"), ":p")

	"+++ Cream: fix exclusion of help files
	" Exclude following files/types/folders
	if getbufvar(filename, "&filetype") == "help"
		return	
	endif
	"+++

"	if exists("g:spooldir") && filename =~ g:spooldir
"		" do not add spooled files to the list
"		return	
"	endif

	"if filename != '' && filereadable (expand ("<afile>"))
	"if filename != '' && filereadable(filename)
	if filereadable(filename)
		" Remove the current file entry from MRU_BUFFERS
		let s:mru_buffers = substitute(s:mru_buffers, escape(filename,'\\~'). s:sep, '', 'g')
		" Add current file as the first in MRU_BUFFERS list
		let s:mru_buffers = filename . s:sep . s:mru_buffers

		" Remove oldest entry if > MRU_MENUSIZE
		if s:mru_count > s:mru_menusize
			let trash = substitute(s:mru_buffers, s:sep, "^^", "g")
			let trash = matchstr(trash, '\([^^^]*^^\)\{'.s:mru_menusize.'\}')
			let s:mru_buffers = substitute(trash, "^^", s:sep, "g")
		endif
		call MRURefreshMenu()
	endif

endfunction


" Customizing Options

function! MRUClearList()
	" Clear the MRU List
	let choice = confirm("Are you sure you want to clear the list?", "&Yes\n&No", 2, "Question")

	if choice != 1
		return
	endif
	let s:mru_buffers = ''
	let s:mru_count = 0
	call MRURefreshMenu ()

endfunction

"function! MRUToggleHotKey()
"    if s:mru_hotkeys == 1
"        let s:mru_hotkeys = 0
"    else
"        let s:mru_hotkeys = 1
"    endif
"    call MRURefreshMenu ()
""	call MRUDisplayMenu ()
"endfunction

"function! MRUSetMenuLabel()
"    execute 'let menu_label = input ("Enter Menu Label [' . s:mru_label . ']: ")'
"
"    if menu_label != ""
"        " remove current MRU Menu
"        execute 'anoremenu <silent> ' . s:mru_label . '.x x'
"        execute 'silent! aunmenu ' . s:mru_label
"
"        let s:mru_label = menu_label
"        call MRURefreshMenu ()
"    endif
"endfunction

function! MRUSetMenuSize()

	execute 'let menu_size = inputdialog("Enter number of recently used\n files to list (maximum 30):", ' . s:mru_menusize . ')'

	if menu_size != ""
		if menu_size > 30
			let menu_size = 30
		endif
		let s:mru_menusize = menu_size
		call MRURefreshMenu ()
	endif

"	call MRUDisplayMenu ()
endfunction

function! MRURemoveInvalid(...)
" Remove non existing files from the menu (not automatic, an option)
" o Optional argument "silent" prevents display of count removed.

	let i = 0
	let list = s:mru_buffers
	let buf_list = ""
	let buf_count = 0
	while list != ""
		let entry_length = match(list, s:sep)
		if entry_length >= 0
			let fullpath = strpart(list, 0, entry_length)
			let list = strpart(list, entry_length+1, strlen(list))
		else
			let fullpath = list
			let list = ""
		endif
		if filereadable(fullpath)
			if buf_count == 0
				let buf_list = fullpath
			else
				let buf_list = buf_list . s:sep . fullpath
			endif
			let buf_count = buf_count + 1
		else
			let i = i + 1
		endif
	endwhile

	let s:mru_buffers = buf_list
	let s:mru_count = buf_count
	call MRURefreshMenu()

	if a:0 == 0 || a:1 != "silent"
		call confirm(
			\ "Non-existing files removed:  " . i . "\n" .
			\ "\n", "&Ok", 1, "Info")
	endif

endfunction


function! MRUVimLeavePre()
	"+++ Cream: do not save global variable for name
	"let g:MRU_LABEL = s:mru_label
	"+++
	let g:MRU_MENUSIZE = s:mru_menusize
	"+++ Cream: do not save global variable for hot keys
	"let g:MRU_HOTKEYS = s:mru_hotkeys
	"+++
	"+++ Cream: handle remote server errors
	"let g:MRU_BUFFERS = s:mru_buffers
	if exists("s:mru_buffers")
		let g:MRU_BUFFERS = s:mru_buffers
	endif
	"+++
endfunction

"+++ Cream
function! Cream_file_open_mru(filename)
" wrapper for the File.MostRecentlyUsed menu items

	" if file doesn't exist, refresh MRU, abort
	if !filereadable(a:filename)
		call confirm(
			\ "File no longer exists!\n" .
			\ "\n", "&Ok", 1, "Info")
		call MRURemoveInvalid("silent")
		return
	endif

	" open, buffer
	if bufexists(a:filename)
		if exists("g:CREAM_TABPAGES") && g:CREAM_TABPAGES == 1
			let cnt = tabpagenr("$")
			let i = 1
			while i <= cnt
				" quit if current
				if bufnr("%") == bufnr(a:filename)
					continue
				endif
				if i == bufnr(a:filename)
					continue
				endif
				tabnext
				let i = i + 1
			endwhile
		else
			execute "buffer " . bufnr(a:filename)
		endif
		return
	" open, file
	else
		call Cream_file_open(a:filename)
	endif

endfunction
"+++

"+++ Cream: moved to autocmds
"augroup MRU
"    autocmd!
"    autocmd VimEnter * call MRUInitialize()
"    "autocmd GUIEnter * call MRUInitialize()
"    "+++ Cream: remove redundant events (When buffer not current,
"    "           filetype is not able to be determined and excluded
"    "           based on type.)
"    "autocmd BufDelete,BufEnter,BufWritePost,FileWritePost * call MRUAddToList ()
"    autocmd BufEnter * call MRUAddToList()
"    "+++
"    "+++ Cream: call relocated to Cream_exit()
"    "autocmd VimLeavePre * nested call MRUVimLeavePre()
"    "+++
"augroup END
"+++

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save
