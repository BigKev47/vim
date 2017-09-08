"
" Filename: cream-autocmd.vim
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
" TEST: What autocmds are activated?
"function! Cream_test_1(word)
"    call confirm(
"        \ "AutoCmd: " . a:word . "\n" .
"        \ "\n", "&Ok", 1, "Info")
"endfunction
"autocmd VimEnter * call Cream_test_1("VimEnter")
"autocmd TabEnter * call Cream_test_1("TabEnter")
"autocmd WinEnter * call Cream_test_1("WinEnter")
"autocmd BufEnter * call Cream_test_1("BufEnter")

" behavior (Cream/CreamLite/Vim/Vi) {{{1
" * Note that this is called only for the condition that the over-ride
"   setting in cream-conf differs from default "cream". Isn't it
"   ironic that neither Vim nor Vi settings can retain this. ;)

autocmd VimEnter * call Cream_behave_init()

" single server {{{1

autocmd VimEnter * call Cream_singleserver_init()
autocmd VimEnter * call Cream_singleserver()

" initialize (fix vars, etc.) {{{1
autocmd VimEnter * call Cream_var_manage()

" conf  {{{1
" (testing for existance checks if even available)
if exists("*Cream_conf_override")
	autocmd BufEnter * call Cream_conf_override()
endif

" lib {{{1

" fix version 6.0 hang in normal mode...
autocmd BufEnter * call Cream_bufenter_fix()

" helps if user exits via window manager close function
augroup CreamExit
	autocmd!
	autocmd VimLeavePre * call Cream_exit()
augroup END

" path and filename {{{1

autocmd VimEnter * call Cream_buffers_pathfile()
autocmd BufEnter,BufWritePost * call Cream_buffer_pathfile()

" tabpages and last buffer restore {{{1

" NOTES:
" * DO NOT USE BufEnter HERE!! We only need it once.
" * Must precede last buffer restore (so file is correctly displayed in
"   the active tab).
autocmd VimEnter * call Cream_tabpages_init()

" (must follow tabpages init)
autocmd VimEnter * call Cream_last_buffer_restore()

" fix tab mis-count issue
autocmd FocusLost * call Cream_tabs_focuslost()
autocmd FocusGained * call Cream_tabs_focusgained()

" filetype and syntax highlighting {{{1

"" first buffer isn't detected
"autocmd VimEnter * filetype detect
" re-detect new or changed buffers
autocmd VimEnter,BufEnter,FileType * call Cream_filetype()

" syntax highlighting (must follow filetype detection)
autocmd VimEnter * call Cream_syntax_init()

" settings {{{1

" view load
autocmd BufRead * if &buftype != "quickfix" | loadview | endif
" view save
autocmd BufWrite * mkview

autocmd BufEnter,BufNewFile * call Cream_autoindent_init()
autocmd BufEnter,BufNewFile * call Cream_tabstop_init()
autocmd BufEnter,BufNewFile * call Cream_wrap_init()
autocmd BufEnter,BufNewFile * call Cream_autowrap_init()

autocmd BufEnter,BufNew * call Cream_expandtab_init()

autocmd BufEnter,BufNew * call Cream_linenumbers_init()

autocmd BufEnter,BufNewFile * call Cream_search_highlight_init()

" printer settings
autocmd VimEnter * call Cream_print_init()

" window titling
autocmd VimEnter * call Cream_titletext_init()

" statusline
autocmd VimEnter * call Cream_statusline_init()

" show invisibles (list)
autocmd BufEnter,BufNewFile * call Cream_list_init()

" keymap
autocmd VimEnter * call Cream_keymap_init()

" current working directory
autocmd VimEnter,BufEnter * call Cream_cwd()

" modelines
autocmd VimEnter,BufEnter,BufWrite * call SecureModelines_DoModelines()

" colors {{{1
autocmd VimEnter * call Cream_colors()

" GTK1 seems to have trouble remembering these across buffers...
autocmd VimEnter * call Cream_colors_selection()

" gui {{{1

" font must preceed Cream_screen_init()
if has("gui")
autocmd VimEnter * call Cream_font_init()
endif

if has("gui")
autocmd VimEnter * call Cream_winpos_init()
endif

if has("gui")
autocmd VimEnter * call Cream_screen_init()
endif

" NOTE: tabpages initialization must occur before last buffer restore.

" errorbells (must occur after GUI starts)
autocmd VimEnter * call Cream_errorbells_off()

" features {{{1

" bookmarks
autocmd VimEnter,BufEnter * call Cream_ShowMarks()

" fold, open current
autocmd VimEnter * call Cream_fold_init()

" middle mouse button behavior
autocmd VimEnter * call Cream_mouse_middle_init()

" current line highlighting
autocmd BufEnter * call Cream_highlight_currentline_init()

"" spell check
"autocmd VimEnter * call Cream_spell_init()
" auto-correct (abbreviations)
autocmd VimEnter * call Cream_autocorrect_init()

" expertmode
autocmd VimEnter * call Cream_expertmode_init()

" calendar
autocmd VimEnter * call Cream_calendar_init()

" auto-popup
autocmd VimEnter * call Cream_pop_init()

" bracket match flashing
autocmd VimEnter * call Cream_bracketmatch_init()

" diff updating
autocmd BufEnter,BufWritePost * call Cream_diffmode_update()


" menus {{{1

" Note: Menus are late since they are slow. This allows the user to see Vim
" starting earlier, although the tradeoff is slightly more flutter as they see
" final setup.

" Settings menu
autocmd VimEnter * call Cream_menu_settings()
autocmd VimEnter * call Cream_menu_settings_invisibles()
autocmd VimEnter * call Cream_menu_settings_linenumbers()
autocmd VimEnter * call Cream_menu_settings_wordwrap()
autocmd VimEnter * call Cream_menu_settings_autowrap()
autocmd VimEnter * call Cream_menu_settings_highlightwrapwidth()
autocmd VimEnter * call Cream_menu_settings_expandtab()
autocmd VimEnter * call Cream_menu_settings_autoindent()
autocmd VimEnter * call Cream_menu_settings_highlightsearch()
autocmd VimEnter * call Cream_menu_settings_highlightcurrentline()
autocmd VimEnter * call Cream_menu_settings_syntax()
" Settings > Preferences
autocmd VimEnter * call Cream_menu_settings_preferences()

" Colors
autocmd VimEnter * call Cream_menu_colors()

" Most recent used (MRU)
autocmd VimEnter * call MRUInitialize()
autocmd BufEnter * call MRUAddToList()

" Window.Buffer menu
" TODO: We are unable to react when an unnamed buffer becomes modified
" since Vim has no event for this.
autocmd VimEnter,BufWinEnter,BufEnter,BufNew,WinEnter * call BMShow()

" Developer menu
if exists("g:cream_dev")
	autocmd VimEnter * call Cream_menu_devel()
endif

" Toolbar
if has("gui_running")
	autocmd VimEnter * call Cream_toolbar_init()
endif

" load menu
autocmd VimEnter * set guioptions+=m

" user location {{{1
" Note: This is placed penultimatly here so it over-rides all prior
" except addons. This enables the alphabetical menuization of user
" addons with the default addons.
autocmd VimEnter * call Cream_load_user()

" add-ons {{{1

autocmd VimEnter * call Cream_addon_loadall()
autocmd VimEnter * call Cream_addon_menu()
autocmd VimEnter * call Cream_addon_maps_init()

" 1}}}
" vim:foldmethod=marker
