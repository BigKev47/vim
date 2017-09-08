"
" Filename: cream-cream-update.vim
" Updated:  2004-09-11 23:04:11-0400
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

" Documentation: {{{1
"
" Description:
"
" This is a Cream developer module to sychronize a CVS checkout of with CVS.
"
" Required: (set in cream-user.vim!)
" o g:cream_cvs: local path to Cream CVS root (above the modules)
"   * no trailing slash/backslash
" o $CVS_RSH (example: "ssh")
" o $CVSROOT (example: "[username]@cvs.sourceforge.net:/cvsroot/cream")
" o $CREAM
" o $VIM
" o $HOME (Unix) for creamrc location
"
" Notes:
" o cvs import -I ! -W "*.bmp -k 'b'" -W "*.png -k 'b'" cream [username] start
" o cvs update -P (prunes empty directories from working copy)
" o cvs update -d (bring down directories to working copy)
" o cvs checkout ...
"
" ToDo:
" o cvs add
" o cvs remove
"

" register as Cream add-on {{{1
if exists("$CREAM")
	" don't list unless developer
	if !exists("g:cream_dev")
		finish
	endif

	call Cream_addon_register(
	\ "Update",
	\ "Update Cream developer package",
	\ "Update Cream developer package Zip file, generally not for use for anyone but developers. Enables portable transmission of alpha technologies. ;)",
	\ "Cream Devel.Update",
	\ "call Cream_update_package()",
	\ '<Nil>'
	\ )
endif

" Cream_update_package() {{{1
function! Cream_update_package()
" main function (decide which action to perform)

	"*** DEBUG:
	let n = confirm(
		\ "WARNING!\n" .
		\ "  This routine is strictly developer-only! Do NOT use\n" .
		\ "  unless you've read the code and are prepared for its\n" .
		\ "  consequences!\n" .
		\ "\n", "&Ok\n&Cancel", 2, "Info")
	if n != 1
		return
	endif
	"***

	" validate required vars
	let error = ""
	" $CVS_RSH
	if !exists("$CVS_RSH")
		let error = error . "$CVS_RSH not found.\n"
	elseif !executable($CVS_RSH)
		let error = error . "Value of $CVS_RSH is not an executable.\n"
	endif
	" $CVSROOT
	if !exists("$CVSROOT")
		let error = error . "$CVSROOT not found.\n"
	endif
	" g:cream_cvs
	if has("win32") && !has("win32unix")
		let slash = '\'
	else
		let slash = '/'
	endif
	if !exists("g:cream_cvs")
		let error = error . "g:cream_cvs not found.\n"
	endif
	" cvs
	if !executable("cvs")
		let error = error . "cvs program not found.\n"
	endif
	" Errors
	if error != ''
		call confirm(
			\ "Error(s):\n\n" .
			\ error . "\nQuitting...\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	let g:cream_cvs = Cream_path_addtrailingslash(g:cream_cvs)

	" loop
	let myreturn = 1
	while myreturn == 1
		" stack buttons vertically
		let sav_go = &guioptions
		set guioptions+=v
		" decide what we want to do
		let n = confirm(
			\ "Please select an option:\n" .
			\ "\n",
			\ "CVS Co&mmit\nCVS &Update\n&Cancel", 1, "Info")
		" restore button stacking preference
		let &guioptions = sav_go
		if     n == 1
			call s:Cream_CVScommit(g:cream_cvs)
		elseif n == 2
			call s:Cream_CVSupdate(g:cream_cvs)
		else
			let myreturn = 0
		endif
	endwhile

endfunction

" Cream_CVScommit() {{{1
function! s:Cream_CVScommit(path)
" commit files in {path}

	" Note: cvs doesn't want trailing slash 
	" Tested: Win95, WinXP, GNU/Linux (RH9)

	" get commit message
	let message = s:Cream_CVSmessage()
	if message == -1
		return
	endif

	" establish quote and slash chars as required
	if has("win32") && !has("win32unix")
		let quote = '"'
		let slash = '\'
	else
		let quote = ''
		let slash = '/'
	endif

	" don't use silent, we need to enter a password in the shell
	" Notes: 
	" o Both platforms require a quoted message!
	" o Unix requires a trailing slash
	if has("win32") && !has("win32unix")
		" change directories (requires trailing slash for some reason)
		execute 'cd ' . quote . a:path . slash . quote
		execute '!cvs commit -m "' . message . '" ' . quote . a:path . quote
	else
		" can't pass absolute path on Unix
		execute 'cd ' . quote . a:path . quote
		execute '!cvs commit -m "' . message . '"'
	endif

endfunction

" Cream_CVSupdate() {{{1
function! s:Cream_CVSupdate(path)
" commit files in module {path}

	" establish quote and slash chars as required
	if has("win32") && !has("win32unix")
		let quote = '"'
	else
		let quote = ''
	endif
	
	" don't use silent
	if has("win32") && !has("win32unix")
		execute '!cvs update -Pd ' . quote . a:path . quote
	else
		" can't pass absolute path on Unix
		execute 'cd ' . quote . a:path . quote
		execute '!cvs update -Pd'
	endif

endfunction

" utility functions {{{1

function! s:Cream_CVSmessage()
" prompts and returns the CVS log message
" warns and returns -1 if empty

	let message = inputdialog("Please enter log message:", "")
	if message == ""
		call confirm(
			\ "Can not continue without a log message. Quitting...\n" .
			\ "\n", "&Ok", 1, "Info")
		return -1
	else
		return escape(message, '"<>|&')
	endif

endfunction

" 1}}}
" vim:foldmethod=marker
