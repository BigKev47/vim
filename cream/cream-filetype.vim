"
" cream-filetype.vim
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
" Filetypes and filetype dependent behavior (comments)
"

"______________________________________________________________________
" File Type Support

function! Cream_filetype(...)
" detect and set conditions based on filetype
" o {argument} (optional) is filetype to set, otherwise detected

	" for some reason, position is lost during this routine, remember
	let mypos = Cream_pos()

	" detection
	if a:0 > 0
		execute "set filetype=" . a:1
	" Not sure why this was being tested, ignore and re-detect
	"elseif &filetype == ""
	else
		filetype detect
		" catch undetected
		if &filetype == ""
			set filetype=txt
		endif
	endif

	" verify indention initialization (won't do it twice)
	call Cream_autoindent_init()

	" remove filebrowser filters
	let b:browsefilter="All Files\t*.*;*.*\n"

	" cream filetype
	if  &filetype == "txt"
	\|| &filetype == "mail"
		call Cream_source($CREAM . "filetypes/txt.vim")
	else
		if hlexists("Sig")
			silent! syntax clear Sig
		endif
		if hlexists("EQuote1")
			silent! syntax clear EQuote1
		endif
		if hlexists("EQuote2")
			silent! syntax clear EQuote2
		endif
		if hlexists("EQuote3")
			silent! syntax clear EQuote3
		endif
		if hlexists("Cream_txt_bullets")
			silent! syntax clear Cream_txt_bullets
		endif
		if hlexists("Cream_txt_charlines_half")
			silent! syntax clear Cream_txt_charlines_half
		endif
		if hlexists("Cream_txt_charlines_full")
			silent! syntax clear Cream_txt_charlines_full
		endif
		if hlexists("Cream_txt_stamp")
			silent! syntax clear Cream_txt_stamp
		endif
		if hlexists("Cream_txt_stamp_value")
			silent! syntax clear Cream_txt_stamp_value
		endif
		if hlexists("Cream_txt_foldtitles")
			silent! syntax clear Cream_txt_foldtitles
		endif
	endif

	if &filetype == "c"
		call Cream_source($CREAM . "filetypes/c.vim")
	endif

	if &filetype == "html"
	\|| &filetype == "php"
		call Cream_source($CREAM . "filetypes/html.vim")
	endif

	if &filetype == "lisp"
		call Cream_source($CREAM . "filetypes/lisp.vim")
	endif

	if &filetype == "vim"
		call Cream_source($CREAM . "filetypes/vim.vim")
	endif

	" restore position
	execute mypos

endfunction

