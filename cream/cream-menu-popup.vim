"
" cream-menu-popup.vim
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

" Note: This is functionalized so we can re-set it with a call.

function! Cream_menu_popup()

	" destroy existing popup menu
	silent! unmenu PopUp
	silent! unmenu! PopUp

	" add blank line only prior to version 6.1.433
	if version < 601 || version == 601 && !exists("patch433")
		anoremenu <silent> 100 PopUp.\                 <Nul>
		anoremenu <silent> 101 PopUp.-Sep101-     <Nul>
	endif
	anoremenu <silent> 111 PopUp.&Undo             :call Cream_undo("i")<CR>

	    vmenu <silent> 113 PopUp.Cu&t         :<C-u>call Cream_cut("v")<CR>
	    vmenu <silent> 114 PopUp.&Copy        :<C-u>call Cream_copy("v")<CR>

	    vmenu <silent> 115 PopUp.&Paste	      :<C-u>call Cream_paste("v")<CR>
	    imenu <silent> 116 PopUp.&Paste  <C-b>:call Cream_paste("i")<CR>

	    vmenu <silent> 117 PopUp.&Delete      :<C-u>call Cream_delete()<CR>

	"anoremenu <silent> 118 PopUp.-Sep108-          <Nul>
	anoremenu <silent> 119 PopUp.Select\ &All      :call Cream_select_all()<CR>

endfunction
call Cream_menu_popup()

