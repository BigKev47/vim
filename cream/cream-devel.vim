"
" Filename: cream-devel.vim
"
" Description: Development related tools.
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

if !exists("g:cream_dev")
	finish
endif

" TestCow() {{{1
function! TestCow(...)
" Displays the values of any number of arguments passed. (Useful for
" dumping an unknown list of variables without regard!)

	if a:0 > 0
		let x = ""
		let i = 0
		while exists("a:{i}")
			let x = x . "\n a:" . i . " = " . a:{i}
			let i = i+1
		endwhile
		call confirm(
			\ x . "\n" .
			\ "\n", "&Ok", 1, "Info")
	endif

endfunction

" mappings {{{1
" minimize Vim

" * Remember: we map Ctrl+Shift+V to start Vim in the window manager
" * Note: <M-v> destroys the German ö so we double it
imap <silent> <M-v>v     <C-b>:suspend<CR>
imap <silent> <M-V>V     <C-b>:suspend<CR>
imap <silent> <M-v><M-v> <C-b>:suspend<CR>
imap <silent> <M-V><M-V> <C-b>:suspend<CR>

" Cream_source_self() {{{1
if !exists("*Cream_source_self")
" Source the current file. (Function check wrapper ensures this works
" even in the same file as this function definition.)

	function! Cream_source_self(mode)
	" source the current file as a Vim script

		if &filetype != "vim"
			call confirm(
				\ "Can only source Vim files.\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif

		silent! update

		let n = Cream_source(expand("%"))
		if n == 1
			echo "Source successful."
		else
			call confirm(
				\ "Source errored.\n" .
				\ "\n", "&Ok", 1, "Info")
		endif

		if a:mode == "v"
			normal gv
		endif

	endfunction
	imap <silent> <M-F12> <C-b>:call Cream_source_self("i")<CR>
	vmap <silent> <M-F12> :<C-u>call Cream_source_self("v")<CR>

endif

" 1}}}
" vim:foldmethod=marker
