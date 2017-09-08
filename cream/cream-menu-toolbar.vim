"
" cream-menu-toolbar.vim -- GUI toolbar (for MS-Windows and GTK)
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

if !has("toolbar")
	finish
endif

"----------------------------------------------------------------------
"Add $CREAM to &runtimepath
"
" Description: The amenu icon= syntax is completely broken for
" Windows. Vince Negri wrote a patch 2002 Sep 20 to fix it, but it
" (obviously) isn't included in Vim6.1.
"
" Therefore, we do the workaround below, which adds cream\bitmaps to
" the runtime path so that the toolbars can find the icons on a
" "default" path. This path *cannot* be removed from the runtime after
" the toolbar has been loaded without problems, so it is retained.

" remove trailing slash from $CREAM
if  matchstr($CREAM, '.$') == '/'
\|| matchstr($CREAM, '.$') == '\'
	let myruntimepath = matchstr($CREAM, '^.*\(.$\)\@=') . "," . &runtimepath
else
	let myruntimepath = $CREAM . "," . &runtimepath
endif

" escape all spaces
let myruntimepath = substitute(myruntimepath, " ", "\\\\ ", "ge")
" add to &runtimepath
execute "set runtimepath=" . myruntimepath
"----------------------------------------------------------------------

"if !has("gui_gtk2")
"
"anoremenu <silent> 200.05 ToolBar.new		:call Cream_file_new()<CR>
"    tmenu <silent> ToolBar.new New File
"anoremenu <silent> 200.10 ToolBar.open		:call Cream_file_open()<CR>
"    tmenu <silent> ToolBar.open Open
"anoremenu <silent> 200.15 ToolBar.save		:call Cream_save()<CR>
"    tmenu <silent> ToolBar.save Save
"anoremenu <silent> 200.17 ToolBar.save_as	:call Cream_saveas()<CR>
"    tmenu <silent> ToolBar.save_as Save As
"anoremenu <silent> 200.20 ToolBar.save_all	:call Cream_saveall()<CR>
"    tmenu <silent> ToolBar.save_all Save All
"anoremenu <silent> 200.25 ToolBar.broken_image	:call Cream_close()<CR>
"    tmenu <silent> ToolBar.broken_image Close
"anoremenu <silent> 200.30 ToolBar.exit		:call Cream_exit()<CR>
"    tmenu <silent> ToolBar.exit Exit Vim
"
"anoremenu <silent> 200.40 ToolBar.-sep40-	<nul>
"if has("printer")
"    anoremenu <silent> 200.41 ToolBar.print	:call Cream_print("a")<CR>
"        tmenu <silent> ToolBar.print Print
"elseif has("unix")
"    anoremenu <silent> 200.41 ToolBar.print	:w !lpr<CR>
"        tmenu <silent> ToolBar.print Print
"elseif has("vms")
"    anoremenu <silent> 200.41 ToolBar.print	:call VMSPrint(":")<CR>
"        tmenu <silent> ToolBar.print Print
"endif
"
"anoremenu <silent> 200.45 ToolBar.-sep45-	<nul>
"anoremenu <silent> 200.50 ToolBar.undo		:call Cream_undo("i")<CR>
"    tmenu <silent> ToolBar.undo Undo
"anoremenu <silent> 200.60 ToolBar.redo		:call Cream_redo("i")<CR>
"    tmenu <silent> ToolBar.redo Redo
"
"anoremenu <silent> 200.65 ToolBar.-sep65-	<nul>
"    vmenu <silent> 200.70 ToolBar.cut_alt		    :<C-u>call Cream_cut("v")<CR>
"    tmenu <silent> ToolBar.cut_alt Cut (to Clipboard)
"    vmenu <silent> 200.80 ToolBar.copy_alt	        :<C-u>call Cream_copy("v")<CR>
"    tmenu <silent> ToolBar.copy_alt Copy (to Clipboard)
"    imenu <silent> 200.85.1 ToolBar.paste  <C-b>:call Cream_paste("i")<CR>
"    vmenu <silent> 200.85.2 ToolBar.paste       :<C-u>call Cream_paste("v")<CR>
"    tmenu <silent> ToolBar.paste Paste (to Clipboard)
"
"
"anoremenu <silent> 200.600 ToolBar.-sep600-	<nul>
"    imenu <silent> 200.601 ToolBar.text_align_left      <C-b>:call Cream_quickwrap_set("i", "left")<CR>
"    vmenu <silent> 200.602 ToolBar.text_align_left      :<C-u>call Cream_quickwrap_set("v", "left")<CR>
"    tmenu <silent> ToolBar.text_align_left Justify, Left
"    imenu <silent> 200.603 ToolBar.text_align_center    <C-b>:call Cream_quickwrap_set("i", "center")<CR>
"    vmenu <silent> 200.604 ToolBar.text_align_center    :<C-u>call Cream_quickwrap_set("v", "center")<CR>
"    tmenu <silent> ToolBar.text_align_center Justify, Center
"    imenu <silent> 200.605 ToolBar.text_align_right     <C-b>:call Cream_quickwrap_set("i", "right")<CR>
"    vmenu <silent> 200.606 ToolBar.text_align_right     :<C-u>call Cream_quickwrap_set("v", "right")<CR>
"    tmenu <silent> ToolBar.text_align_right Justify, Right
"    imenu <silent> 200.607 ToolBar.text_align_justify   <C-b>:call Cream_quickwrap_set("i", "full")<CR>
"    vmenu <silent> 200.608 ToolBar.text_align_justify   :<C-u>call Cream_quickwrap_set("v", "full")<CR>
"    tmenu <silent> ToolBar.text_align_justify Justify, Full
"
"if !has("gui_athena")
"    anoremenu <silent> 200.700 ToolBar.-sep700-		<nul>
"    anoremenu <silent> 200.701 ToolBar.search		:call Cream_find()<CR>
"        tmenu <silent> ToolBar.search Search
"      vunmenu <silent> ToolBar.search
"        vmenu <silent> ToolBar.search				:call Cream_find()<CR>
"
"    anoremenu <silent> 200.702 ToolBar.search_and_replace	:call Cream_replace()<CR>
"        tmenu <silent> ToolBar.search_and_replace Search and Replace
"      vunmenu <silent> ToolBar.search_and_replace
"        vmenu <silent> ToolBar.search_and_replace   		:call Cream_replace()<CR>
"endif
"
"
"anoremenu <silent> 200.750    ToolBar.-sep750-		<nul>
"anoremenu <silent> 200.751 ToolBar.spellcheck	:call Cream_spell_next()<CR>
"tmenu <silent> ToolBar.spellcheck Spell Check
"
"anoremenu <silent> 200.800    ToolBar.-sep800-		<nul>
"anoremenu <silent> 200.802 ToolBar.font			:call Cream_font_set()<CR>
"tmenu <silent> ToolBar.font Font
"
"
""anoremenu <silent> 200.245 ToolBar.-sep6-		<nul>
""anoremenu <silent> 200.250 ToolBar.convert		:make<CR>
""anoremenu <silent> 200.260 ToolBar.terminal		:silent sh<CR>
""anoremenu <silent> 200.270 ToolBar.RunCtags		:!ctags -R .<CR>
""anoremenu <silent> 200.280 ToolBar.jump-to		g]
"
"anoremenu <silent> 200.900 ToolBar.-sep900-		    <nul>
"anoremenu <silent> 200.901 ToolBar.book		:call Cream_help_find()<CR>
"    tmenu <silent> ToolBar.book Help Topic
"anoremenu <silent> 200.902 ToolBar.help		:help<CR>
"    tmenu <silent> ToolBar.help Help
"
"
""---------------------------------------------------------------------
"else

	imenu <silent> icon=new 200.05 ToolBar.new		    <C-b>:call Cream_file_new()<CR>
	vmenu <silent> icon=new 200.06 ToolBar.new		    :<C-u>call Cream_file_new()<CR>
	tmenu <silent> ToolBar.new New File
	imenu <silent> icon=open 200.10 ToolBar.open		<C-b>:call Cream_file_open()<CR>
	vmenu <silent> icon=open 200.11 ToolBar.open		:<C-u>call Cream_file_open()<CR>
	tmenu <silent> ToolBar.open Open
	imenu <silent> icon=save 200.15 ToolBar.save		<C-b>:call Cream_save()<CR>
	vmenu <silent> icon=save 200.15 ToolBar.save		:<C-u>call Cream_save()<CR>
	tmenu <silent> ToolBar.save Save
	imenu <silent> icon=save_as 200.17 ToolBar.save_as	<C-b>:call Cream_saveas()<CR>
	vmenu <silent> icon=save_as 200.17 ToolBar.save_as	:<C-u>call Cream_saveas()<CR>
	tmenu <silent> ToolBar.save_as Save As
	imenu <silent> icon=save_all 200.20 ToolBar.save_all	<C-b>:call Cream_saveall()<CR>
	vmenu <silent> icon=save_all 200.20 ToolBar.save_all	:<C-u>call Cream_saveall()<CR>
	tmenu <silent> ToolBar.save_all Save All
	imenu <silent> icon=broken_image 200.25 ToolBar.broken_image	<C-b>:call Cream_close()<CR>
	vmenu <silent> icon=broken_image 200.25 ToolBar.broken_image	:<C-u>call Cream_close()<CR>
	tmenu <silent> ToolBar.broken_image Close
	imenu <silent> icon=exit 200.30 ToolBar.exit		<C-b>:call Cream_exit()<CR>
	vmenu <silent> icon=exit 200.30 ToolBar.exit		:<C-u>call Cream_exit()<CR>
	tmenu <silent> ToolBar.exit Exit Vim


	imenu <silent> icon=print 200.41 ToolBar.print	<C-b>:call Cream_print("i")<CR>
	vmenu <silent> icon=print 200.41 ToolBar.print	:<C-u>call Cream_print("v")<CR>
    tmenu <silent> ToolBar.print Print

anoremenu <silent> 200.45 ToolBar.-sep45-	<nul>
anoremenu <silent> icon=undo 200.50 ToolBar.undo		:call Cream_undo("i")<CR>
	tmenu <silent> ToolBar.undo Undo
anoremenu <silent> icon=redo 200.60  ToolBar.redo		:call Cream_redo("i")<CR>
	tmenu <silent> ToolBar.redo Redo

anoremenu <silent> 200.65 ToolBar.-sep65-	<nul>
	vmenu <silent> icon=cut_alt 200.70 ToolBar.cut_alt		:<C-u>call Cream_cut("v")<CR>
	tmenu <silent> ToolBar.cut_alt Cut (to Clipboard)
	vmenu <silent> icon=copy_alt 200.80 ToolBar.copy_alt    :<C-u>call Cream_copy("v")<CR>
	tmenu <silent> ToolBar.copy_alt Copy (to Clipboard)
	imenu <silent> icon=paste 200.85.1 ToolBar.paste    <C-b>:call Cream_paste("i")<CR>
	vmenu <silent> icon=paste 200.85.2 ToolBar.paste    :<C-u>call Cream_paste("v")<CR>
	tmenu <silent> ToolBar.paste Paste (from Clipboard)


anoremenu <silent> 200.600 ToolBar.-sep600-	<nul>
	imenu <silent> icon=text_align_left 200.601 ToolBar.text_align_left       <C-b>:call Cream_quickwrap_set("i", "left")<CR>
	vmenu <silent> icon=text_align_left 200.602 ToolBar.text_align_left       :<C-u>call Cream_quickwrap_set("v", "left")<CR>
	tmenu <silent> ToolBar.text_align_left Justify, Left
	imenu <silent> icon=text_align_center 200.603 ToolBar.text_align_center   <C-b>:call Cream_quickwrap_set("i", "center")<CR>
	vmenu <silent> icon=text_align_center 200.604 ToolBar.text_align_center   :<C-u>call Cream_quickwrap_set("v", "center")<CR>
	tmenu <silent> ToolBar.text_align_center Justify, Center
	imenu <silent> icon=text_align_right 200.605 ToolBar.text_align_right     <C-b>:call Cream_quickwrap_set("i", "right")<CR>
	vmenu <silent> icon=text_align_right 200.606 ToolBar.text_align_right     :<C-u>call Cream_quickwrap_set("v", "right")<CR>
	tmenu <silent> ToolBar.text_align_right Justify, Right
	imenu <silent> icon=text_align_justify 200.607 ToolBar.text_align_justify <C-b>:call Cream_quickwrap_set("i", "full")<CR>
	vmenu <silent> icon=text_align_justify 200.608 ToolBar.text_align_justify :<C-u>call Cream_quickwrap_set("v", "full")<CR>
	tmenu <silent> ToolBar.text_align_justify Justify, Full

if !has("gui_athena")
	anoremenu <silent> 200.700 ToolBar.-sep700-		<nul>

	anoremenu <silent> icon=search 200.701 ToolBar.search		:call Cream_find()<CR>
		tmenu <silent> ToolBar.search Search
	  vunmenu <silent> ToolBar.search
		vmenu <silent> icon=search 200.702 ToolBar.search		:call Cream_find()<CR>

	anoremenu <silent> icon=search_and_replace 200.710 ToolBar.search_and_replace	:call Cream_replace()<CR>
		tmenu <silent> ToolBar.search_and_replace Search and Replace
	  vunmenu <silent> ToolBar.search_and_replace
		vmenu <silent> icon=search_and_replace 200.711 ToolBar.search_and_replace   :call Cream_replace()<CR>
endif


anoremenu <silent> 200.750 ToolBar.-sep750-		<nul>
anoremenu <silent> icon=spellcheck 200.751 ToolBar.spellcheck	:call Cream_spell_next()<CR>
	tmenu <silent> ToolBar.spellcheck Spell Check


"anoremenu <silent> 200.245 ToolBar.-sep6-		<nul>
"anoremenu <silent> 200.250 ToolBar.convert		:make<CR>
"anoremenu <silent> 200.260 ToolBar.terminal		:silent sh<CR>
"anoremenu <silent> 200.270 ToolBar.RunCtags		:!ctags -R .<CR>
"anoremenu <silent> 200.280 ToolBar.jump-to		g]

anoremenu <silent> 200.900 ToolBar.-sep900-		    <nul>
anoremenu <silent> icon=book 200.901 ToolBar.book		:call Cream_help_find()<CR>
	tmenu <silent> ToolBar.book Help Topic
anoremenu <silent> icon=help 200.902 ToolBar.help		:help<CR>
	tmenu <silent> ToolBar.help Help


"endif

