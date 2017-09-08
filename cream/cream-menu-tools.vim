"
" cream-menu-tools.vim
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


" Block Commenting
	vmenu <silent> 70.101 &Tools.Block\ Comment\ (selection)<Tab>F6				:call Cream_commentify("v")<CR>
	vmenu <silent> 70.102 &Tools.Block\ Un-Comment\ (selection)<Tab>Shift+F6	:call Cream_decommentify("v")<CR>

" Spell check
anoremenu <silent> 70.120 &Tools.-SEP120-										<Nul>
if v:version >= 700
    anoremenu <silent> 70.121 &Tools.&Spell\ Check.On/Off\ (toggle)<Tab>F7 				:call Cream_spellcheck()<CR>
    anoremenu <silent> 70.122 &Tools.&Spell\ Check.Suggest\ Alternatives<Tab>Alt+F7 	:call Cream_spell_altword()<CR>
else
    anoremenu <silent> 70.121 &Tools.&Spell\ Check.Next\ Spelling\ Error<Tab>F7 				:call Cream_spell_next()<CR>
    anoremenu <silent> 70.122 &Tools.&Spell\ Check.Previous\ Spelling\ Error<Tab>Shift+F7 		:call Cream_spell_prev()<CR>
    anoremenu <silent> 70.123 &Tools.&Spell\ Check.Show\ Spelling\ Errors\ (toggle)<Tab>Alt+F7 	:call Cream_spellcheck()<CR>
    anoremenu <silent> 70.124 &Tools.&Spell\ Check.Add\ Word\ (under\ cursor)\ to\ Dictionary<Tab>Ctrl+F7	:call Cream_spell_saveword()<CR>
	anoremenu <silent> 70.150 &Tools.&Spell\ Check.-SEP150-			<Nul>
	anoremenu <silent> 70.151 &Tools.&Spell\ Check.Language\.\.\.	:call Cream_spell_lang()<CR>
	anoremenu <silent> 70.152 &Tools.&Spell\ Check.Options\.\.\.	:call Cream_spell_options()<CR>
endif

" Bookmarking
anoremenu <silent> 70.200 &Tools.-SEP200-											<Nul>
anoremenu <silent> 70.201 &Tools.&Bookmarks.Bookmark\ Next<Tab>F2					:call Cream_WOK_mark_next()<CR>
anoremenu <silent> 70.202 &Tools.&Bookmarks.Bookmark\ Previous<Tab>Shift+F2			:call Cream_WOK_mark_prev()<CR>
anoremenu <silent> 70.203 &Tools.&Bookmarks.Bookmark\ Set\ (toggle)<Tab>Alt+F2		:call Cream_WOK_mark_toggle()<CR>
"anoremenu <silent> 70.204 &Tools.&Bookmarks.Show\ Bookmarks\ (toggle)<Tab>Ctrl+F2	:call Cream_ShowMarksToggle()<CR>
anoremenu <silent> 70.205 &Tools.&Bookmarks.Delete\ All\ Bookmarks<Tab>Alt+Shift+F2	:call Cream_WOK_mark_killall()<CR>

" Macros
anoremenu <silent> 70.300 &Tools.-SEP300-								<Nul>
	imenu <silent> 70.301 &Tools.Macro\ Play<Tab>F8						<C-b>@q
	imenu <silent> 70.302 &Tools.Macro\ Record\ (toggle)<Tab>Shift+F8	<C-b>:call Cream_macro_record("q")<CR>

" Diff mode
anoremenu <silent> 70.350 &Tools.-SEP350-								<Nul>
anoremenu <silent> 70.350 &Tools.&Diff\ Mode							:call Cream_diffmode_toggle()<CR>


" Folding
	imenu <silent> 70.400 &Tools.-SEP400-											<Nul>
	imenu <silent> 70.401 &Tools.&Folding.&Fold\ Open/Close<Tab>F9              <C-b>:call Cream_fold("down")<CR>
	vmenu <silent> 70.402 &Tools.&Folding.&Set\ Fold\ (Selection)<Tab>F9		     :<C-u>call Cream_fold_set("v")<CR>
	imenu <silent> 70.403 &Tools.&Folding.&Fold\ Open/Close<Tab>Shift+F9		<C-b>:call Cream_fold("up")<CR>
anoremenu <silent> 70.404 &Tools.&Folding.&Open\ All\ Folds<Tab>Ctrl+F9			     :call Cream_fold_openall()<CR>
anoremenu <silent> 70.405 &Tools.&Folding.&Close\ All\ Folds<Tab>Ctrl+Shift+F9	     :call Cream_fold_closeall()<CR>
anoremenu <silent> 70.406 &Tools.&Folding.&Delete\ Fold\ at\ Cursor<Tab>Alt+F9	     :call Cream_fold_delete()<CR>
anoremenu <silent> 70.407 &Tools.&Folding.D&elete\ All\ Folds<Tab>Alt+Shift+F9	     :call Cream_fold_deleteall()<CR>

" Completion
anoremenu <silent> 70.500 &Tools.-SEP500-													<Nul>
	imenu <silent> 70.501 &Tools.&Completion.&Word\ Completion<Tab>Ctrl+Space					<C-r>=Cream_complete_forward()<CR>
	imenu <silent> 70.502 &Tools.&Completion.W&ord\ Completion\ (reverse)<Tab>Ctrl+Shift+Space	<C-r>=Cream_complete_backward()<CR>
anoremenu <silent> 70.503 &Tools.&Completion.-SEP503-										<Nul>
	imenu <silent> 70.504 &Tools.&Completion.O&mni\ Completion<Tab>Ctrl+Enter					<C-r>=Cream_complete_omni_forward()<CR>
	imenu <silent> 70.505 &Tools.&Completion.Om&ni\ Completion\ (reverse)<Tab>Ctrl+Shift+Enter	<C-r>=Cream_complete_omni_backward()<CR>
anoremenu <silent> 70.506 &Tools.&Completion.-SEP506-										<Nul>
	imenu <silent> 70.507 &Tools.&Completion.&Template\ Completion<Tab>Esc+Space			<C-r>=Cream_template_expand()<CR>
anoremenu <silent> 70.508 &Tools.&Completion.Template\ Listing\.\.\.						:call Cream_template_listing()<CR>
"anoremenu <silent> 70.509 &Tools.&Completion.-SEP509-										<Nul>
"    imenu <silent> 70.510 &Tools.&Completion.&Lists\ (HTML\ tags/CSS\ properties)	        <C-b>:call Cream_EasyHtml_call()<CR>
anoremenu <silent> 70.511 &Tools.&Completion.-SEP511-										<Nul>
" only windows has the :popup feature (for now)
if has("win32")
	imenu <silent> 70.512 &Tools.&Completion.Info\ Pop<Tab>Alt+(							<C-b>:call Cream_pop_paren_map()<CR>
endif
anoremenu <silent> 70.513 &Tools.&Completion.Info\ Pop\ Options\.\.\.						:call Cream_pop_options()<CR>

" Tag jumping
anoremenu <silent> 70.600 &Tools.-SEP600-														<Nul>
	imenu <silent> 70.601 &Tools.&Tag\ Navigation.&Jump\ to\ Tag\ (under\ cursor)<Tab>Alt+Down	<C-b>:call Cream_tag_goto()<CR>
	imenu <silent> 70.602 &Tools.&Tag\ Navigation.&Close\ and\ Jump\ Back<Tab>Alt+Up			<C-b>:call Cream_tag_backclose()<CR>
	imenu <silent> 70.603 &Tools.&Tag\ Navigation.&Previous\ Tag<Tab>Alt+Left					<C-b>:call Cream_tag_backward()<CR>
	imenu <silent> 70.604 &Tools.&Tag\ Navigation.&Next\ Tag<Tab>Alt+Right						<C-b>:call Cream_tag_forward()<CR>
	imenu <silent> 70.605 &Tools.&Tag\ Navigation.&Tag\ List\ (toggle)<Tab>Ctrl+Alt+Down			<C-b>:call Cream_Tlist_toggle()<CR>

	imenu <silent> 70.610 &Tools.File/URL\ Na&vigation.&Open\ File/URL\ (under\ cursor)<Tab>Ctrl+Enter	<C-b>:call Cream_file_open_undercursor("i")<CR>
	vmenu <silent> 70.611 &Tools.File/URL\ Na&vigation.&Open\ File/URL\ (under\ cursor)<Tab>Ctrl+Enter	:<C-u>call Cream_file_open_undercursor("v")<CR>

" Add-ons (Note: autolisting begins at 70.910)
anoremenu <silent> 70.900 &Tools.-Sep900-							<Nul>
anoremenu <silent> 70.901 &Tools.Add-ons\ E&xplore\ (Map/Unmap) 	:call Cream_addon_select()<CR>

