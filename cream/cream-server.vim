"
" cream-server.vim -- Manage multiple sessions
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
" Description:
" We like single sessions of Vim. If second Vim session opened, open
" the file in first session, close and move it to forefront

function! Cream_singleserver_init()
" initialize environment state (default is off)

	" don't use in terminal!
	if !has("gui_running")
		return
	elseif has("mac")
		return
	endif

	if exists("g:CREAM_SINGLESERVER")
		if g:CREAM_SINGLESERVER != 1
			let g:CREAM_SINGLESERVER = 0
			set swapfile
		else
			let g:CREAM_SINGLESERVER = 1
			"*** disable swapfiles until we resolve this
			set noswapfile
			"***
		endif
	else
		let g:CREAM_SINGLESERVER = 0
		set swapfile
	endif
endfunction


" Singleserver toggle (called by menu)
function! Cream_singleserver_toggle()

	" don't use in terminal!
	if !has("gui_running")
		return
	elseif has("mac")
		return
	endif

	" should already be initialized, but check anyway
	if exists("g:CREAM_SINGLESERVER")
		if g:CREAM_SINGLESERVER == 1
			call confirm(
				\ "\n" .
				\ "Single-Session Mode off -- multiple Vim sessions allowed.\n" .
				\ "\n", "&Ok", 1, "Info")
			let g:CREAM_SINGLESERVER = 0
			" save global in viminfo
		else
			call confirm(
				\ "\n" .
				\ "Single-Session Mode *on* -- multiple files will always\n" .
				\ "be opened within a single session of Vim.\n" .
				\ "\n", "&Ok", 1, "Info")
			let g:CREAM_SINGLESERVER = 1
			" save global in viminfo
		endif
		" init autocommand group
		call Cream_singleserver_init()
		" forget last buffer so future sessions have no memory
		let g:CREAM_LAST_BUFFER = ""
		wviminfo!
	else
		" error
		call Cream_error_warning("g:CREAM_SINGLESERVER not initialized in Cream_singleserver_toggle()")
	endif
	call Cream_menu_settings_preferences()
endfunction

function! Cream_singleserver()
" merge a second instance of Vim into the first one

	" don't use in terminal!
	if !has("gui_running")
		return
	elseif has("mac")
		return
	endif
    "" don't use if not initialized
    "if !exists("g:CREAM_SINGLESERVER")
    "    return
    "endif
    "" don't use if off
    "if g:CREAM_SINGLESERVER != 1
    "    return
    "endif
    "
    "" don't use if separate server over-ride on (see Cream_session_new() )
    "if exists("g:CREAM_SERVER_OVERRIDE")
    "    " reset
    "    unlet g:CREAM_SERVER_OVERRIDE
    "    return
    "endif

	"" option 1 (slow) {{{1
	"" collect servernames (separated by "\n", should be just one)
	"let myserverlist = serverlist()
	"" count
	"let servercount = MvNumberOfElements(myserverlist, "\n")
	"" get this server's name
	"let myserverid = v:servername

	"if servercount > 1
	"    " iterate through servernames until reaching one not equal to mine
	"    let i = 0
	"    while i < servercount
	"        let myserver = MvElementAt(myserverlist, "\n", i)
	"        if v:servername != myserver
	"            let myfile = expand("%:p")
	"            "*** no need to alter, Vim will re-handle
	"            "" windows slash to backslash (if exist, ie ":set shellslash")
	"            "if has("win32")
	"            "    let myfile = substitute(myfile,'/','\\','g')
	"            "endif
	"            "***
	"            if myfile != ""
	"                " escape
	"                let myfile = escape(myfile, " ")
	"                " solve buffer not found errors from second session startup
	"                let g:CREAM_LAST_BUFFER = ""
	"                let mycmd = "\<M-o>\<M-o>:edit " . "+" . line(".") . " " . myfile . "\<CR>"
	"            else
	"                let mycmd = "\<M-o>\<M-o>:call Cream_file_new()\<CR>"
	"            endif
	"            call remote_send(myserver, mycmd)
	"            "if has("win32")
	"            "\  has("
	"                call remote_expr(myserver, "foreground()")
	"            "else
	"            "    call foreground()
	"            "endif
	"            call Cream_exit()
	"            " we're toast at this point, but let's keep good form ;)
	"            break
	"        endif
	"        let i = i + 1
	"    endwhile
	"    ""*** DEBUG:
	"    "call confirm(
	"    "    \ "\n" .
	"    "    \ "  myserverlist = " . myserverlist . "\n" .
	"    "    \ "  servercount  = " . servercount . "\n" .
	"    "    \ "\n" .
	"    "    \ "  myserver     = " . myserver . "\n" .
	"    "    \ "  myfile       = " . myfile . "\n" .
	"    "    \ "  mycmd        = " . mycmd . "\n" .
	"    "    \ "\n", "&Ok", 1, "Info")
	"    ""***
	"endif 
	" 1}}}

	"" option 2 (do better guessing) {{{1
	"if v:servername !=? "GVIM"
	"
	"    " get opened file name
	"    let myfile = expand("%:p")
	"    " if have file, open it
	"    if myfile != ""
	"        " reverse backslashes
	"        let myfile = substitute(myfile, '\\', '/', 'g')
	"        " escape
	"        let myfile = escape(myfile, ' ')
	"        " solve buffer not found errors from second session startup
	"        let g:CREAM_LAST_BUFFER = ""
	"        " edit current file, maintain this position
	"        let mycmd = '<C-b>:edit ' . '+' . line('.') . ' ' . myfile . '<CR>'
	"    " open new buffer
	"    else
	"        let mycmd = '<C-b>:call Cream_file_new()<CR>'
	"    endif
	"    call remote_send('GVIM', mycmd)
	"    call remote_expr('GVIM', 'foreground()')
	"    call Cream_exit()
	"
	"end 
	" 1}}}

	" option 3 (just become the server) {{{1
	if v:servername !=? "CREAM"

		if !Cream_buffer_isnewunmod()

			" get opened file name
			let myfile = expand("%:p")
			" reverse backslashes
			let myfile = substitute(myfile, '\\', '/', 'g')
			" escape
			let myfile = escape(myfile, ' ')
			" solve buffer not found errors from second session startup
			let g:CREAM_LAST_BUFFER = ""
			""*** not needed, we're only concerned about variable space
			"" write the viminfo so it's remembered!
			"wviminfo!
			""***
			" edit current file, maintain this position
			let mycmd = "<C-\\><C-n>:edit +" . line('.') . ' ' . myfile . '<CR>'
		" open new buffer
		else
			let mycmd = "<C-\\><C-n>:call Cream_file_new()<CR>"
		endif
		call remote_send('CREAM', mycmd)
		" Fix tabs (last bit clears the line :)
		let mycmd = "<C-\\><C-n>:call Cream_tabpages_refresh()<CR><C-\\><C-n>:<CR>"
		call remote_send('CREAM', mycmd)

		call remote_foreground('CREAM')
		call Cream_exit()

		call Cream_menu_settings_preferences()

	end
	" 1}}}

endfunction

" vim:foldmethod=marker
