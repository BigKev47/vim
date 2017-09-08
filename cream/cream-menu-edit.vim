"
" cream-menu-edit.vim
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

" undo/redo
	imenu <silent> 20.310 &Edit.&Undo<Tab>Ctrl+Z <C-b>:call Cream_undo("i")<CR>
	vmenu <silent> 20.310 &Edit.&Undo<Tab>Ctrl+Z      :<C-u>call Cream_undo("v")<CR>
	imenu <silent> 20.320 &Edit.&Redo<Tab>Ctrl+Y <C-b>:call Cream_redo("i")<CR>
	vmenu <silent> 20.320 &Edit.&Redo<Tab>Ctrl+Y      :<C-u>call Cream_redo("v")<CR>


anoremenu <silent> 20.335 &Edit.-Sep20335-         <Nul>
" cut
	imenu <silent> 20.340 &Edit.Cu&t<Tab>Ctrl+X        <Nop>
	vmenu <silent> 20.340 &Edit.Cu&t<Tab>Ctrl+X       :<C-u>call Cream_cut("v")<CR>
" copy
	imenu <silent> 20.350 &Edit.&Copy<Tab>Ctrl+C <C-b>:call Cream_copy("i")<CR>
	vmenu <silent> 20.350 &Edit.&Copy<Tab>Ctrl+C      :<C-u>call Cream_copy("v")<CR>
" paste
	imenu <silent> 20.360 &Edit.&Paste<Tab>Ctrl+V      <C-b>:call Cream_paste("i")<CR>
	vmenu <silent> 20.361 &Edit.&Paste<Tab>Ctrl+V      :<C-u>call Cream_paste("v")<CR>


anoremenu <silent> 20.395 &Edit.-SEP395-					<Nul>
anoremenu <silent> 20.400 &Edit.&Select\ All<Tab>Ctrl+A		:call Cream_select_all()<CR>

" goto
anoremenu <silent> 20.401 &Edit.-Sep20401-					<Nul>
anoremenu <silent> 20.402 &Edit.&Go\ To\.\.\.<Tab>Ctrl+G	:call Cream_goto()<CR>

" find/replace
anoremenu <silent> 20.405 &Edit.-Sep20405-					<Nul>
if has("gui_running")
	"anoremenu <silent> 20.410 &Edit.&Find\.\.\.<Tab>Ctrl+F		:call Cream_find()<CR>
	"anoremenu <silent> 20.420 &Edit.&Replace\.\.\.<Tab>Ctrl+H	:call Cream_replace()<CR>
	anoremenu <silent> 20.410 &Edit.&Find\.\.\.<Tab>Ctrl+F		:promptfind<CR>
	anoremenu <silent> 20.420 &Edit.&Replace\.\.\.<Tab>Ctrl+H	:promptrepl<CR>
	anoremenu <silent> 20.440 &Edit.Multi-file\ Replace\.\.\.	:call Cream_replacemulti()<CR>
else
	anoremenu <silent> 20.410 &Edit.&Find<Tab>/					/
	anoremenu <silent> 20.420 &Edit.Find\ and\ Rep&lace<Tab>:%s	:%s/
	vunmenu <silent> &Edit.Find\ and\ Rep&lace<Tab>:%s
	vmenu <silent> &Edit.Find\ and\ Rep&lace<Tab>:s				:s/
endif
anoremenu <silent> 20.450 &Edit.-Sep20450-						<Nul>
anoremenu <silent> 20.451 &Edit.Fi&nd\ Under\ Cursor.&Find\ Under\ Cursor<Tab>F3		:call Cream_findunder()<CR>
anoremenu <silent> 20.452 &Edit.Fi&nd\ Under\ Cursor.&Find\ Under\ Cursor\ (&Reverse)<Tab>Shift+F3		:call Cream_findunder_reverse()<CR>
anoremenu <silent> 20.453 &Edit.Fi&nd\ Under\ Cursor.&Find\ Under\ Cursor\ (&Case-sensitive)<Tab>Alt+F3		:call Cream_findunder_case()<CR>
anoremenu <silent> 20.454 &Edit.Fi&nd\ Under\ Cursor.&Find\ Under\ Cursor\ (Cas&e-sensitive,\ Reverse)<Tab>Alt+Shift+F3		:call Cream_findunder_case_reverse()<CR>

" Word Count
anoremenu <silent> 20.500 &Edit.-Sep20500-				<Nul>
	imenu <silent> 20.501 &Edit.Count\ &Word\.\.\.		<C-b>:call Cream_count_word("i")<CR>
	vmenu <silent> 20.502 &Edit.Count\ &Word\.\.\.		:<C-u>call Cream_count_word("v")<CR>
	imenu <silent> 20.503 &Edit.Cou&nt\ Total\ Words\.\.\.		<C-b>:call Cream_count_words("i")<CR>
	vmenu <silent> 20.504 &Edit.Cou&nt\ Total\ Words\.\.\.		:<C-u>call Cream_count_words("v")<CR>

" Columns
	imenu <silent> 20.600 &Edit.-Sep20600-						<Nul>
	imenu <silent> 20.601 &Edit.Column\ Select<Tab>Alt+Shift+(motion)	<C-b>:call Cream_columns()<CR>
"*** BROKEN:
"    imenu <silent> 20.603 &Edit.Set\ Column\ Font\.\.\.			<C-b>:call Cream_fontinit_columns()<CR>


