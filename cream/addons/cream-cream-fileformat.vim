"=
" cream-cream-fileformat.vim
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
" Highlight characters with decimal values between 128-255. These
" characters may not appear the same on all systems when Vim uses an
" encoding other than latin1. (If used in Vim script, these characters
" could potentially cause script to fail.)
"

" register as a Cream add-on
if exists("$CREAM")
	" don't list unless Cream developer
	if !exists("g:cream_dev")
		finish
	endif

	call Cream_addon_register(
	\ 'Cream Fileformat', 
	\ 'Set Cream *.vim files to fileformat=unix', 
	\ 'Ensure fileformat=unix for all Cream *.vim files (except spell check dictionaries).', 
	\ 'Cream Devel.Fileformat Fixer',
	\ 'call Cream_format_cream_unix()', 
	\ '<C-u>call Cream_format_cream_unix()'
	\ )
endif

" Create function to verify all Cream files are filetype=unix.
function! Cream_format_cream_unix()

	let n = confirm(
		\ "Preparing to ensure all Cream *.vim files except spell check dictionaries \n" .
		\ "have fileformat=unix. \n" .
		\ " \n" .
		\ "Continue? \n" .
		\ "\n", "&Ok\n&Cancel", 1, "Info")
	if n != 1
		return
	endif

	let mylazyredraw = &lazyredraw
	set lazyredraw

	let cmd = "call Cream_fileformat('unix')"
	call Cream_cmd_on_files($CREAM . "*.vim", cmd)
	call Cream_cmd_on_files($CREAM . "addons/*.vim", cmd)
	call Cream_cmd_on_files($VIM . "/_*vimrc", cmd)

	let &lazyredraw = mylazyredraw

endfunction

