"
" cream-cream-release.vim -- developer release packager
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

" register as a Cream add-on
if exists("$CREAM")
	" don't list unless developer
	if !exists("g:cream_dev")
		finish
	endif

	call Cream_addon_register(
	\ 'Release', 
	\ 'Create Cream release package', 
	\ 'Create Cream release package', 
	\ 'Cream Devel.Release', 
	\ 'call Cream_release()',
	\ '<Nil>'
	\ )
endif

function! Cream_release()
" create a Cream release package from a checkout of CVS (g:cream_cvs)
" Note:  "mkdir" is multi-platform!

	" verify g:cream_cvs exists
	if !exists("g:cream_cvs")
		call confirm(
			\ "Error: g:cream_cvs not found. Quitting...\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" dialog which release to use
	let n = confirm(
		\ "Please select which release you wish to make.\n" .
		\ "\n", "&Unix\n&Windows\n&Both\n&Cancel", 1, "Info")
	if     n == 1
		let rformat = "unix"
	elseif n == 2
		let rformat = "windows"
	elseif n == 3
		let rformat = "both"
	else
		return
	endif

	" verify tool sets required to make the platform's release
	if rformat == "windows"
		if executable("zip") == 0
			call confirm(
				\ "Unable to create final package, utility \"zip\" doesn't exist on the path.\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
	else
		" must have both
		if executable("tar") == 0
			call confirm(
				\ "Unable to create final package, utility \"tar\" doesn't exist on the path.\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		if executable("gzip") == 0
			call confirm(
				\ "Unable to create final package, utility \"gzip\" doesn't exist on the path.\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
	endif

	" silent actions *related to copying* (optional)
	"   ""         -- shows prompts, shells
	"   "silent "  -- avoid prompts, shells
	"   "silent! " -- avoid prompts, shells and errors
	let mysilent = ""

	" platform-specifics vars
	if Cream_has("ms")
		let slash = '\'
		let quote = '"'
		" very important!
		let myshellslash = &shellslash
		set noshellslash
		let copycmd = 'xcopy'
	else
		let slash = '/'
		let quote = ''
		let copycmd = 'cp -p'
	endif

	" use periods, Debian requires it
	"" don't use periods in version indication for file names (we want
	"" to match CVS tag)
	"let ver = substitute(g:cream_version_str, '\.', '-', 'g')
	let ver = g:cream_version_str 

	" fix g:cream_cvs name (Windows only)
	if Cream_has("ms")
		let cream_cvs = substitute(g:cream_cvs, '/', '\', 'g')
	else
		let cream_cvs = g:cream_cvs
	endif
	" strip trailing slash
	let cream_cvs = substitute(cream_cvs, '[\\/]$', '', 'g')

	" make package directory 
	if rformat == "windows"
		" .\cream (two above module CVS hole)
		let releasedir = fnamemodify(cream_cvs, ":h:h") . slash . 'release-windows-' . strftime("%Y%m%dT%H%M%S")
	elseif rformat == "unix"
		" ./cream-X.XX (two above module CVS hole)
		let releasedir = fnamemodify(cream_cvs, ":h:h") . slash . 'release-unix-' . strftime("%Y%m%dT%H%M%S")
	else
		" ./cream-X.XX (two above module CVS hole)
		let releasedir = fnamemodify(cream_cvs, ":h:h") . slash . 'release-both-' . strftime("%Y%m%dT%H%M%S")
	endif
	execute ':' . mysilent . '!mkdir ' . quote . releasedir . quote

	" make package version directory
	if rformat == "windows"
		let releasedir = releasedir . slash . 'cream'
		execute ':' . mysilent . '!mkdir ' . quote . releasedir . quote
	else
		let releasedir = releasedir . slash . 'cream-' . ver
		execute ':' . mysilent . '!mkdir ' . quote . releasedir . quote
	endif

	" make subdirectories
	execute ':' . mysilent . '!mkdir ' . quote . releasedir . slash . 'addons'     . quote
	execute ':' . mysilent . '!mkdir ' . quote . releasedir . slash . 'bitmaps'    . quote
	execute ':' . mysilent . '!mkdir ' . quote . releasedir . slash . 'docs'       . quote
	execute ':' . mysilent . '!mkdir ' . quote . releasedir . slash . 'docs-html'  . quote
	execute ':' . mysilent . '!mkdir ' . quote . releasedir . slash . 'filetypes'  . quote
	execute ':' . mysilent . '!mkdir ' . quote . releasedir . slash . 'help'       . quote
	execute ':' . mysilent . '!mkdir ' . quote . releasedir . slash . 'lang'       . quote

	" copy files (don't just copy the structure, CVS interlaced)
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'creamrc'     . quote . ' ' . quote . releasedir . quote
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . '*.vim'       . quote . ' ' . quote . releasedir . quote
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'cream.svg'   . quote . ' ' . quote . releasedir . quote
	if rformat == "windows" || rformat == "both"
		execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'cream.ico'     . quote . ' ' . quote . releasedir . quote
		execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'INSTALL.bat'   . quote . ' ' . quote . releasedir . quote
		execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'cream.bat'   . quote . ' ' . quote . releasedir . quote
	endif
	if rformat == "unix" || rformat == "both"
		execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'cream.png'     . quote . ' ' . quote . releasedir . quote
		execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'INSTALL.sh'    . quote . ' ' . quote . releasedir . quote
		execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'cream'         . quote . ' ' . quote . releasedir . quote
		execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'cream.desktop' . quote . ' ' . quote . releasedir . quote
	endif

	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'addons'     . slash . '*.vim'  . quote . ' ' . quote . releasedir . slash . 'addons' . quote
	if     rformat == "windows"
		let bitmap = '*.bmp'
	elseif rformat == "unix"
		let bitmap = '*.xpm'
	else
		let bitmap = '*.*'
	endif
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'bitmaps'    . slash . bitmap                        . quote . ' ' . quote . releasedir . slash . 'bitmaps' . quote
	
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'docs'       . slash . '*.txt'                       . quote . ' ' . quote . releasedir . slash . 'docs'       . quote
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'docs-html'  . slash . '*.html'                      . quote . ' ' . quote . releasedir . slash . 'docs-html'  . quote
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'docs-html'  . slash . '*.php'                       . quote . ' ' . quote . releasedir . slash . 'docs-html'  . quote
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'docs-html'  . slash . '*.png'                       . quote . ' ' . quote . releasedir . slash . 'docs-html'  . quote
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'docs-html'  . slash . '*.gif'                       . quote . ' ' . quote . releasedir . slash . 'docs-html'  . quote
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'docs-html'  . slash . '*.ico'                       . quote . ' ' . quote . releasedir . slash . 'docs-html'  . quote
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'filetypes'  . slash . '*.vim'                       . quote . ' ' . quote . releasedir . slash . 'filetypes'  . quote
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'help'       . slash . '*.txt'                       . quote . ' ' . quote . releasedir . slash . 'help'       . quote
	execute ':' . mysilent . '!' . copycmd . ' ' . quote . cream_cvs . slash . 'lang'       . slash . '*.vim'                       . quote . ' ' . quote . releasedir . slash . 'lang'       . quote
	" don't copy cream/views

	" create package
	if rformat == "windows"
		execute 'cd ' . fnamemodify(releasedir, ":h")
		execute ':!zip -r -9 ' . quote . fnamemodify(releasedir, ":h") . slash . 'cream-' . ver . '.zip' . quote . ' ' . quote . 'cream' . quote
	else
		execute ':!cd ' . fnamemodify(releasedir, ":h") . '; tar -cvf cream-' . ver . '.tar ' . 'cream-' . ver
		execute ':!gzip ' . fnamemodify(releasedir, ":h") . slash . 'cream-' . ver . '.tar'
		" Warning
		call confirm(
			\ "VERIFY!\n" .
			\ " o Permissions on package files and directories\n" .
			\ " o Line endings on files\n" .
			\ "\n", "&Ok", 1, "Info")
	endif

	if exists("myshellslash")
		let &shellslash = myshellslash
	endif

endfunction

