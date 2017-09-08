"
" Filename: cream-keys
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
" Notes:
" * Search on "non-function" to find all mappings which don't
"   completely rely on functions.

" KEY TO UNIVERSE: **************************************** {{{1
"
"         Remap Ctrl+o to Ctrl+b
"
" o Frees <C-b> to be used for File.Open mapping
" o Avoids over-writing mappings for non-english characters (like
"   any Alt+___ would.
" o Maintains the non-lossy position of <C-b> (absent in <C-\><C-n> ).
"
inoremap <C-b>  <C-o>
"
" PROBLEMS:
" o Ruins i18n keyboard entries.
" o Scattered bugs that we couldn't track down.
"
"********************************************************************** 1}}}
" Core
" Apple/Mac {{{1

" In gvim on OS X the usual OS keymappings are defined in macmap.vim
" and Command - f <D-f> is a mapping for / in normal mode.  Source the
" macmap file as a quick fix.
if has("mac")
	source $VIMRUNTIME/macmap.vim
endif

" Mouse {{{1
"imap <silent> <RightMouse> <LeftMouse><C-b>:call Cream_menu_popup()<CR>
inoremap <silent> <RightMouse> <LeftMouse><C-\><C-n>:call Cream_menu_popup()<CR>a<RightMouse>

" Note: see
" Cream_mouse_middle_init() for middle mouse control

" Motion {{{1

" Home -- toggles position between first non-white char and first
" char. (Functions with or without screen wrap.)
imap <silent> <Home> <C-b>:call Cream_motion_home()<CR>
vmap <silent> <Home> :call Cream_motion_home()<CR>

" End -- toggles position between last screen line char and last line
" char. (Functions with/without screen wrap.)
imap <silent> <End> <C-b>:call Cream_map_end()<CR>
"vmap <silent> <End> g$

" Up/Down -- move through line breaks maintaining line position with wrap on.
" * Need to accommodate all the mappings that use [Up] or [Down] ?
imap <silent> <Down>  <C-b>:call Cream_down("i")<CR>
vmap <silent> <Down>  :<C-u>call Cream_down("v")<CR>
vmap <silent> <Right> :<C-u>call Cream_down("v")<CR>

imap <silent> <Up>   <C-b>:call Cream_up("i")<CR>
vmap <silent> <Up>   :<C-u>call Cream_up("v")<CR>
vmap <silent> <Left> :<C-u>call Cream_up("v")<CR>

" [Ctrl]+[Arrow Up/Down] scroll up/down by line
imap <silent> <C-Down> <C-b>:call Cream_scroll_down()<CR>
vmap <silent> <C-Down> :<C-u>call Cream_scroll_down("v")<CR>

imap <silent> <C-Up> <C-b>:call Cream_scroll_up()<CR>
vmap <silent> <C-Up> :<C-u>call Cream_scroll_up("v")<CR>

" hmmm....
"imap <silent> <C-Left> <C-\><C-n>vh
"vmap <silent> <C-Left>       h


" Ctrl+Home Top of document
imap <silent> <C-Home> <C-b>:call Cream_motion_doctop()<CR>
vmap <silent> <C-Home> :<C-u>call Cream_motion_doctop()<CR>

" Ctrl+End Bottom of document
imap <silent> <C-End> <C-b>:call Cream_motion_docbottom()<CR>
vmap <silent> <C-End> :<C-u>call Cream_motion_docbottom()<CR>


" PageUp -- ensure motion to top if in first page
imap <silent> <PageUp> <C-b>:call Cream_pageup()<CR>
vmap <silent> <PageUp> :<C-u>call Cream_pageup()<CR>

" PageDown
imap <silent> <PageDown> <C-b>:call Cream_pagedown()<CR>
vmap <silent> <PageDown> :<C-u>call Cream_pagedown()<CR>


" * necessary only for GTK
" Go to top of current page
imap <silent> <C-PageUp> <C-b>:call Cream_motion_windowtop()<CR>
vmap <silent> <C-PageUp> :<C-u>call Cream_motion_windowtop()<CR>
" Go to bottom of current page
imap <silent> <C-PageDown> <C-b>:call Cream_motion_windowbottom()<CR>
vmap <silent> <C-PageDown> :<C-u>call Cream_motion_windowbottom()<CR>
" Go to middle of current page
imap <silent> <C-M-PageUp>   <C-b>:call Cream_motion_windowmiddle()<CR>
vmap <silent> <C-M-PageUp>   :<C-u>call Cream_motion_windowmiddle()<CR>
imap <silent> <C-M-PageDown> <C-b>:call Cream_motion_windowmiddle()<CR>
vmap <silent> <C-M-PageDown> :<C-u>call Cream_motion_windowmiddle()<CR>

" <BS> delete in Visual mode
vmap <silent> <BS> :<C-u>call Cream_delete_v()<CR>

" Shift+Backspace deletes word (see help for difference between "word" and "WORD")
imap <silent> <S-BS> <C-b>:call Cream_map_key_backspace()<CR>
" Ctrl+Backspace deletes WORD
imap <silent> <C-BS> <C-b>:call Cream_map_key_backspace("WORD")<CR>

" Selection {{{1

" Shift+Home
" * Select from cursor to screen line beginning, with either wrap on or off.
" * Toggle selection between first column and first character
imap <silent> <S-Home> <C-b>:call Cream_map_shift_home("i")<CR>
vmap <silent> <S-Home>      :<C-u>call Cream_map_shift_home("v")<CR>

" Shift+End -- select to end of screen line, not end of line
imap <silent> <S-End> <C-b>:call Cream_map_shift_end()<CR>
"*** Don't remap for visual mode *** (imap does the job)
"vmap <silent> <S-End> :call Cream_map_shift_end()<CR>

" Shift+Up -- select up one line (w/ or w/o wrap on) and maintain line pos
imap <silent> <S-Up> <C-b>:call Cream_map_shift_up("i")<CR>
vmap <silent> <S-Up>      :<C-u>call Cream_map_shift_up("v")<CR>
" Shift+Down -- select down one line (w/ or w/o wrap on) and maintain line pos
imap <silent> <S-Down> <C-b>:call Cream_map_shift_down("i")<CR>
vmap <silent> <S-Down>      :<C-u>call Cream_map_shift_down("v")<CR>

" Shift+PageUp -- select to top of screen, then up one screen length
imap <silent> <S-PageUp> <C-b>:call Cream_map_shift_pageup("i")<CR>
vmap <silent> <S-PageUp>      :<C-u>call Cream_map_shift_pageup("v")<CR>
" Shift+PageDown -- select to bottom of screen, then down one screen length
imap <silent> <S-PageDown> <C-b>:call Cream_map_shift_pagedown("i")<CR>
vmap <silent> <S-PageDown>      :<C-u>call Cream_map_shift_pagedown("v")<CR>

" Selection -- go to end specified
vmap <silent> <C-S-Up>   :<C-u>call Cream_visual_swappos("up")<CR>
vmap <silent> <C-S-Down> :<C-u>call Cream_visual_swappos("dn")<CR>

" Mouse -- drag
"*** Broken: This mapping breaks GTK2 (other?) dialogs, causing Vim
"            crash.
"vmap <silent> <S-LeftDrag> <LeftDrag>
"vmap <silent> <M-S-LeftDrag> <LeftDrag>
"***

" Ctrl+A -- select all
imap <silent> <C-a> <C-b>:call Cream_select_all()<CR>
vmap <silent> <C-a>      :<C-u>call Cream_select_all()<CR>

" Replace mode (Insert) {{{1

" <Insert> goes to gR not gr
" NOTE: This is one of the rare situations where we can't have a clean
"       mapping to a single function because we want the key to change
"       modes, but a function always returns to insertmode.
"imap <silent> <Insert> <C-r>=Cream_replacemode()<CR>
imap <silent> <Insert> <C-b>:call Cream_replacemode_remap()<CR><C-b>gR

" Folding {{{1
imap <silent> <F9>     <C-b>:call Cream_fold("down")<CR>
imap <silent> <S-F9>   <C-b>:call Cream_fold("up")<CR>

vmap <silent> <F9>          :<C-u>call Cream_fold_set("v")<CR>

imap <silent> <C-F9>   <C-b>:call Cream_fold_openall()<CR>
imap <silent> <C-S-F9> <C-b>:call Cream_fold_closeall()<CR>
imap <silent> <M-F9>   <C-b>:call Cream_fold_delete()<CR>
imap <silent> <M-S-F9> <C-b>:call Cream_fold_deleteall()<CR>

" Wrap {{{1

" Word wrap toggle
imap <silent> <C-w> <C-b>:call Cream_wrap("i")<CR>
vmap <silent> <C-w>      :<C-u>call Cream_wrap("v")<CR>

" Auto wrap toggle
imap <silent> <C-e> <C-b>:call Cream_autowrap("i")<CR>
vmap <silent> <C-e>      :<C-u>call Cream_autowrap("v")<CR>

" Quick Wrap
imap <silent> <C-q> <C-b>:call Cream_quickwrap("i")<CR>
vmap <silent> <C-q>      :<C-u>call Cream_quickwrap("v")<CR>

" Quick UnWrap
imap <silent> <M-q>q     <C-b>:call Cream_quickunwrap("i")<CR>
imap <silent> <M-Q>Q     <C-b>:call Cream_quickunwrap("i")<CR>
imap <silent> <M-q><M-q> <C-b>:call Cream_quickunwrap("i")<CR>
imap <silent> <M-Q><M-Q> <C-b>:call Cream_quickunwrap("i")<CR>
vmap <silent> <M-q>q          :<C-u>call Cream_quickunwrap("v")<CR>
vmap <silent> <M-Q>Q          :<C-u>call Cream_quickunwrap("v")<CR>
vmap <silent> <M-q><M-q>      :<C-u>call Cream_quickunwrap("v")<CR>
vmap <silent> <M-Q><M-Q>      :<C-u>call Cream_quickunwrap("v")<CR>

" Indent/Unindent
vmap <silent> <Tab>        :<C-u>call Cream_indent("v")<CR>

imap <silent> <S-Tab> <C-b>:call Cream_unindent("i")<CR>
vmap <silent> <S-Tab>      :<C-u>call Cream_unindent("v")<CR>

" 1}}}
" General Mappings
" Help {{{1

" general help
imap <silent> <F1>   <C-b>:call Cream_help()<CR>
vmap <silent> <F1>   :<C-u>call Cream_help()<CR>

" go to specific topic
imap <silent> <C-F1> <C-b>:call Cream_help_find()<CR>
" list possible matches
imap <silent> <M-F1> <C-b>:call Cream_help_listtopics()<CR>

" File {{{1

" Open (with dialog)
"**********************************************************************
" Note: This is only possible due to Key to Universe map at beginning!
"       Normally, <C-b> is a special Vim mapping.
imap <silent> <C-o> <C-b>:call Cream_file_open()<CR>
"**********************************************************************

" Open file under cursor
imap <silent> <S-CR> <C-b>:call Cream_file_open_undercursor("i")<CR>
vmap <silent> <S-CR> :<C-u>call Cream_file_open_undercursor("v")<CR>

" Save (only when changes)
imap <silent> <C-s> <C-b>:call Cream_update("i")<CR>
vmap <silent> <C-s> :<C-u>call Cream_update("v")<CR>

" New
imap <silent> <C-n> <C-b>:call Cream_file_new()<CR>

" Close
" Note: We kill this in gVim (see Terminal elsewhere) because we
" assume the Window Manager will intercept. If it doesn't, or if the
" user cancels (thereby returning to Vim) we don't want anything to
" happen.
imap <silent> <M-F4> <C-b>:call Cream_exit()<CR>
vmap <silent> <M-F4> <C-b>:call Cream_exit()<CR>

imap <silent> <C-F4> <C-b>:call Cream_close()<CR>
vmap <silent> <C-F4> :<C-u>call Cream_close()<CR>

" Cut/Copy/Paste {{{1

" Cut (two mappings)
"imap <silent> <C-x>   <Nop>
imap <silent> <S-Del> <Nop>
vmap <silent> <C-x>   :<C-u>call Cream_cut("v")<CR>
vmap <silent> <S-Del> :<C-u>call Cream_cut("v")<CR>

" Copy (two mappings)
imap <silent> <C-c>      <Nop>
imap <silent> <C-Insert> <Nop>
vmap <silent> <C-c>      :<C-u>call Cream_copy("v")<CR>
vmap <silent> <C-Insert> :<C-u>call Cream_copy("v")<CR>

" Paste
imap <silent> <C-v>      x<BS><C-b>:call Cream_paste("i")<CR>
imap <silent> <S-Insert> x<BS><C-b>:call Cream_paste("i")<CR>
vmap <silent> <C-v>           :<C-u>call Cream_paste("v")<CR>
vmap <silent> <S-Insert>      :<C-u>call Cream_paste("v")<CR>

" Undo/Redo {{{1

"	Undo
imap <silent> <C-z> <C-b>:call Cream_undo("i")<CR>
vmap <silent> <C-z> :<C-u>call Cream_undo("v")<CR>

"	Redo
"*** broken: fails (conflicts with <C-z>)
"imap <silent> <C-S-Z> <C-b>:call Cream_redo("i")<CR>
"vmap <silent> <C-S-Z> :<C-u>call Cream_redo("v")<CR>
"***
" also
imap <silent> <C-y> <C-b>:call Cream_redo("i")<CR>
vmap <silent> <C-y> :<C-u>call Cream_redo("v")<CR>


" Space exits insertmode. This allows undo to remember each word
" rather than an entire insert.
"inoremap <silent> <Space> <Space><C-b><C-\><C-n>i

" Show Invisibles (list) {{{1

imap <silent> <F4> <C-b>:call Cream_list_toggle("i")<CR>
vmap <silent> <F4> :<C-u>call Cream_list_toggle("v")<CR>

" Window/Buffer/Document select {{{1

" Window/Buffer Next/Previous -- Switch between windows unless only
" one open; then alternate between multiple buffers if existing
imap <silent> <C-Tab>   <C-b>:call Cream_nextwindow()<CR>
vmap <silent> <C-Tab>   :<C-u>call Cream_nextwindow()<CR>

imap <silent> <C-S-Tab> <C-b>:call Cream_prevwindow()<CR>
vmap <silent> <C-S-Tab> :<C-u>call Cream_prevwindow()<CR>

" Printing {{{1

imap <silent> <C-p> <C-b>:call Cream_print("i")<CR>
vmap <silent> <C-p> :<C-u>call Cream_print("v")<CR>

" Find and Replace {{{1

"imap <silent> <C-f> <C-b>:call Cream_find()<CR>
"imap <silent> <C-h> <C-b>:call Cream_replace()<CR>
" Notes:
" 1. Avoid calling wrapper functions, it breaks the dialog's
"    multi-modal behavior.
" 2. Mac currently can't use the dialogs
if !has("mac")
	imap <silent> <C-f> <C-b>:promptfind<CR>
	imap <silent> <C-h> <C-b>:promptrepl<CR>
endif

" Find, under cursor
" * DO NOT use the 'g' option preceeding the search, because it will
"   only yield a match for the single letter under the cursor!
" forward
imap <silent> <F3> <C-b>:call Cream_findunder("i")<CR>
vmap <silent> <F3> :<C-u>call Cream_findunder("v")<CR>

" backward
imap <silent> <S-F3> <C-b>:call Cream_findunder_reverse("i")<CR>
vmap <silent> <S-F3> :<C-u>call Cream_findunder_reverse("v")<CR>

" forward, case sensitive
imap <silent> <M-F3> <C-b>:call Cream_findunder_case("i")<CR>
vmap <silent> <M-F3> :<C-u>call Cream_findunder_case("v")<CR>

" backward, case sensitive
imap <silent> <M-S-F3> <C-b>:call Cream_findunder_case_reverse("i")<CR>
vmap <silent> <M-S-F3> :<C-u>call Cream_findunder_case_reverse("v")<CR>


" 1}}}
" Misc
" Completion, Word, Omni, Template {{{1

inoremap <silent> <C-Space>   <C-r>=Cream_complete_forward()<CR>
inoremap <silent> <C-S-Space> <C-r>=Cream_complete_backward()<CR>

inoremap <silent> <C-Enter>   <C-r>=Cream_complete_omni_forward()<CR>
inoremap <silent> <C-S-Enter> <C-r>=Cream_complete_omni_backward()<CR>

"imap <silent> <M-Space>          <C-r>=ProcessImapLeader()<cr>
"inoremap <silent> <S-Space><S-Space> <C-r>=Cream_template_expand()<cr>
inoremap <silent> <Esc><Space> <C-r>=Cream_template_expand()<cr>

" Tags, Goto {{{1

" web-like Forward/Back (good for help pages)
imap <silent> <M-Left>  <C-b>:call Cream_tag_backward()<CR>
imap <silent> <M-Right> <C-b>:call Cream_tag_forward()<CR>
imap <silent> <M-Up>    <C-b>:call Cream_tag_backclose()<CR>
" go to tag under cursor
imap <silent> <M-Down>  <C-b>:call Cream_tag_goto()<CR>

" tag list
imap <silent> <C-M-Down> <C-b>:call Cream_Tlist_toggle()<CR>

" Goto Line {{{1
imap <silent> <C-g> <C-b>:call Cream_goto()<CR>

" Pop {{{1

" pop
imap <silent> <M-9> <C-b>:call Cream_pop_paren_map()<CR>
imap <silent> <M-(> <C-b>:call Cream_pop_paren_map()<CR>

" auto-pop initialized and controled via autocmd and option preference

" Expandtab {{{1

imap <silent> <C-T> <C-b>:call Cream_expandtab_toggle("i")<CR>
vmap <silent> <C-T> :<C-u>call Cream_expandtab_toggle("v")<CR>

" Insert, Character Lines {{{1

" type first character entered after mapping textwidth number of times
imap <silent> <S-F4>		<C-b>:call Cream_charline()<CR>
imap <silent> <S-F4><S-F4>	<C-b>:call Cream_charline_lineabove()<CR>
imap <silent> <S-F4><F4>	<C-b>:call Cream_charline_lineabove()<CR>

" Insert, Character by value, digraph {{{1

" decimal insert
"inoremap <silent> <M-,> <C-q>
imap <silent> <M-,> <C-b>:call Cream_insert_char()<CR>
vmap <silent> <M-,> :<C-u>call Cream_insert_char()<CR>

imap <silent> <M-,><M-,> <C-b>:call Cream_allchars_list()<CR>

imap <silent> <M-.> <C-b>:call Cream_char_codes("i")<CR>
vmap <silent> <M-.> :<C-u>call Cream_char_codes("v")<CR>

" diagraph
" (Ctrl+K insertion is a Vim keystroke)
imap <silent> <C-K><C-K> <C-b>:call Cream_digraph_list()<CR>


" Spell Check {{{1

if v:version >= 700

	imap <silent> <F7> <C-b>:call Cream_spellcheck()<CR>
	vmap <silent> <F7> :<C-u>call Cream_spellcheck("v")<CR>
	" TODO: broken
	imap <silent> <M-F7> <C-b>:call Cream_spell_altword()<CR>
	vmap <silent> <M-F7> :<C-u>call Cream_spell_altword("v")<CR>

	"imap <silent> <M-F7> <C-\><C-n>z=

else
	" toggle error highlighting on/off
	imap <silent> <M-F7> <C-b>:call Cream_spellcheck()<CR>
	" Next word (and turn on if not on)
	imap <silent> <F7>   <C-b>:call Cream_spell_next()<CR>
	" Previous word (and turn on if not on)
	imap <silent> <S-F7> <C-b>:call Cream_spell_prev()<CR>
	" Save word to dictionary
	imap <silent> <C-F7> <C-b>:call Cream_spell_saveword()<CR>
	"*** non-function
	vmap <silent> <C-F7>   "xy:call Cream_spell_saveword_v()<CR>
endif

" Block comments (Enhanced Commentify) {{{1

imap <silent> <F6>   <C-b>:call Cream_commentify("i")<CR>
vmap <silent> <F6>   :<C-u>call Cream_commentify("v")<CR>

imap <silent> <S-F6> <C-b>:call Cream_decommentify("i")<CR>
vmap <silent> <S-F6> :<C-u>call Cream_decommentify("v")<CR>

imap <silent> <M-F6> <C-b>:call Cream_commentify_noindent("i")<CR>
vmap <silent> <M-F6> :<C-u>call Cream_commentify_noindent("v")<CR>
imap <silent> <C-F6> <C-b>:call Cream_commentify_noindent("i")<CR>
vmap <silent> <C-F6> :<C-u>call Cream_commentify_noindent("v")<CR>


" Macros {{{1

imap <silent> <S-F8> <C-b>:call Cream_macro_record("q")<CR>
" Note: Trailing backspace deletes the errant added newline. (Not
" able to be done within the function.)
imap <silent> <F8>   <C-b>:call Cream_macro_play("q")<CR>


" Bookmarking {{{1
" Jump forward/backward and toggle 'anonymous' marks for lines (by using marks a-z)
imap <silent> <F2>     <C-b>:call Cream_WOK_mark_next()<CR>
imap <silent> <S-F2>   <C-b>:call Cream_WOK_mark_prev()<CR>
imap <silent> <M-F2>   <C-b>:call Cream_WOK_mark_toggle()<CR>
imap <silent> <M-S-F2> <C-b>:call Cream_WOK_mark_killall()<CR>
"imap <silent> <C-F2>   <C-b>:call Cream_ShowMarksToggle()<CR>


" Calendar {{{1
imap <silent> <C-F11> <C-b>:call Cream_calendar()<CR>
vmap <silent> <C-F11>           :call Cream_calendar()<CR>

" Date/Time {{{1

" dialog
imap <silent> <F11> <C-b>:call Cream_insert_datetime(1)<CR>
vmap <silent> <F11> :<C-u>call Cream_insert_datetime(1)<CR>
" last used
imap <silent> <F11><F11> <C-b>:call Cream_insert_datetime()<CR>
vmap <silent> <F11><F11> :<C-u>call Cream_insert_datetime()<CR>

" Capitalization {{{1

" Title Case
imap <silent> <F5>   <C-b>:call Cream_case_title("i")<CR>
vmap <silent> <F5>   :<C-u>call Cream_case_title("v")<CR>
" UPPERCASE
imap <silent> <S-F5> <C-b>:call Cream_case_upper("i")<CR>
vmap <silent> <S-F5> :<C-u>call Cream_case_upper("v")<CR>
" lowercase
imap <silent> <M-F5> <C-b>:call Cream_case_lower("i")<CR>
vmap <silent> <M-F5> :<C-u>call Cream_case_lower("v")<CR>
"" rEVERSE CASE
"imap <silent> <C-F5> <C-b>:call Cream_case_reverse("i")<CR>
"vmap <silent> <C-F5> :<C-u>call Cream_case_reverse("v")<CR>

" Column Mode {{{1
"*** DEPRECATED:
imap <silent> <M-c>c     <C-b>:call Cream_columns()<CR>
imap <silent> <M-c><M-c> <C-b>:call Cream_columns()<CR>
imap <silent> <M-C>C     <C-b>:call Cream_columns()<CR>
imap <silent> <M-C><M-C> <C-b>:call Cream_columns()<CR>
"***

imap <silent> <M-S-Up>       <C-b>:call Cream_columns()<CR><S-Up>
imap <silent> <M-S-Down>     <C-b>:call Cream_columns()<CR><S-Down>
imap <silent> <M-S-Left>     <C-b>:call Cream_columns()<CR><S-Left>
imap <silent> <M-S-Right>    <C-b>:call Cream_columns()<CR><S-Right>
imap <silent> <M-S-Home>     <C-b>:call Cream_columns()<CR><S-Home>
imap <silent> <M-S-End>      <C-b>:call Cream_columns()<CR><S-End>
imap <silent> <M-S-PageUp>   <C-b>:call Cream_columns()<CR><S-PageUp>
imap <silent> <M-S-PageDown> <C-b>:call Cream_columns()<CR><S-PageDown>

vmap <silent> <M-S-Up>       <S-Up>
vmap <silent> <M-S-Down>     <S-Down>
vmap <silent> <M-S-Left>     <S-Left>
vmap <silent> <M-S-Right>    <S-Right>
vmap <silent> <M-Home>       <S-Home>
vmap <silent> <M-S-End>      <S-End>
vmap <silent> <M-S-PageUp>   <S-PageUp>
vmap <silent> <M-S-PageDown> <S-PageDown>
" drag
vmap <silent> <M-S-LeftDrag>     <S-LeftDrag>
vmap <silent> <M-S-RightDrag>    <S-RightDrag>

imap <silent> <M-S-LeftMouse> <C-b>:call Cream_columns()<CR><S-LeftMouse>
vmap <silent> <M-S-LeftMouse>                               <S-LeftMouse>
"*** BROKEN: Can't map mouse in visual-mode for some reason
"vmap <LeftMouse> <C-\><S-LeftMouse><Esc>
"***

" 1}}}
" Terminal Spoofing
"{{{1

if !has("gui_running")

	" console menus
	imap <silent> <F12> <C-\><C-n>:emenu <C-z>
	vmap <silent> <F12> :<C-u>emenu <C-z>

	" Quit
	"imap <silent> <C-F4> <C-b>:call Cream_exit()<CR>
	"vmap <silent> <C-F4> :<C-u>call Cream_exit()<CR>

	" File
	imap <silent> <M-f> <C-\><C-n>:emenu <C-z>
	vmap <silent> <M-f> :<C-u>emenu <C-z>

	" File.Save
	imap <silent> <M-f><M-s> <C-\><C-n>:w<CR>a
	vmap <silent> <M-f><M-s> <C-\><C-n>:w<CR>gv

	" File.SaveAs
	imap <silent> <M-f><M-a> <C-\><C-n>:browse confirm saveas<CR>i
	vmap <silent> <M-f><M-a> <C-\><C-n>:browse confirm saveas<CR>gv

	" File.Exit
	imap <silent> <M-f><M-x> <Esc>:q<CR>
	vmap <silent> <M-f><M-x> <Esc>:q<CR>gv

endif

" 1}}}
" vim:foldmethod=marker
