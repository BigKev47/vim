"
" cream.vim -- General loader, the "Main()" function of Cream.
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
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
" General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software
" Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
" 02111-1307, USA.
"

" vars {{{1
let g:cream_version = 43
let g:cream_version_str = "0.43"
let g:cream_updated = "Updated:  2011-01-24"
let g:cream_mail = "digitect dancingpaper com"
let g:cream_url = "http://cream.sourceforge.net"

" source file function {{{1
function! Cream_source(file)
" source a file if available
	if filereadable(a:file) > 0
		execute "source " . a:file
		return 1
	else
		return -1
	endif
endfunction

" Load user custom over-rides (behavior) {{{1
"
" o We source cream-conf here in order to quit in case behavior has
"   been set to vim or vi.
" o Also, many other vars can potentially be set to shape the rest of
"   the load.
" o However, cream-conf is also *re-loaded* via autocmd VimEnter so
"   that viminfo settings can be over-ridden as well. A bit redundant
"   but very little overhead since we're only setting variables.
"

" load system overrides (first)
call Cream_source($CREAM . "cream-conf.vim")

" load user overrides (second)
if exists("g:cream_user")
	call Cream_source(g:cream_user . "cream-conf.vim")
endif


" quit if user-override behavior set to vim or vi
if exists("g:CREAM_BEHAVE")
	if g:CREAM_BEHAVE == "vim"
		" back off settings we've made to here
		set compatible&vim
		set cpoptions&vim
		set shellslash&vim
		" unset variables and paths
		let $CREAM = ""
		set viminfo&vim
		set backupdir&vim
		set directory&vim
		set viewdir&vim
		" quit cream
		finish
	elseif g:CREAM_BEHAVE == "vi"
		" back off settings we've made to here
		set compatible&vi
		set cpoptions&vi
		set shellslash&vi
		" unset variables and paths
		let $CREAM = ""
		set viminfo&vi
		set backupdir&vi
		set directory&vi
		set viewdir&vi
		" quit cream
		finish
	elseif g:CREAM_BEHAVE == "creamlite"
	endif
endif

" Load server {{{1

call Cream_source($CREAM . "cream-server.vim")


" Load project {{{1
"
" * Note that modularized autocommand loading removes critical
"   requirement to load these files in order. However, there are still
"   some items within scripts that depend on a certain orderliness
"   (filetype comments for example) so we'll preserve this until we
"   know exactly what we're doing.

" Note: cream-conf is loaded at the head of this file.

" settings first (no global Cream variables set here)
call Cream_source($CREAM . "cream-settings.vim")

" libraries second (no functions called here, nothing set)
call Cream_source($CREAM . "cream-lib.vim")
call Cream_source($CREAM . "cream-lib-os.vim")
call Cream_source($CREAM . "cream-lib-win-tab-buf.vim")
call Cream_source($CREAM . "multvals.vim")
call Cream_source($CREAM . "genutils.vim")

" menus third (must precede syntax highlighting enable in colors,
" requires multvals)
call Cream_source($CREAM . "cream-menu.vim")

" core
" * dependant and unremovable
" * menus and keyboard shortcuts may load corporately
call Cream_source($CREAM . "cream-addon.vim")
call Cream_source($CREAM . "cream-autocmd.vim")
call Cream_source($CREAM . "cream-colors.vim")
call Cream_source($CREAM . "cream-devel.vim")
call Cream_source($CREAM . "cream-filetype.vim")
call Cream_source($CREAM . "cream-gui.vim")
call Cream_source($CREAM . "cream-keys.vim")

" modules
call Cream_source($CREAM . "cream-abbr.vim")
call Cream_source($CREAM . "cream-ascii.vim")
call Cream_source($CREAM . "cream-behavior.vim")
call Cream_source($CREAM . "cream-bookmarks.vim")
call Cream_source($CREAM . "cream-capitalization.vim")
call Cream_source($CREAM . "cream-columns.vim")
call Cream_source($CREAM . "cream-expertmode.vim")
call Cream_source($CREAM . "cream-explorer.vim")
call Cream_source($CREAM . "cream-find.vim")
call Cream_source($CREAM . "cream-iso3166-1.vim")
call Cream_source($CREAM . "cream-iso639.vim")
call Cream_source($CREAM . "cream-justify.vim")
call Cream_source($CREAM . "cream-loremipsum.vim")
call Cream_source($CREAM . "cream-macros.vim")
call Cream_source($CREAM . "cream-numberlines.vim")
call Cream_source($CREAM . "cream-pop.vim")
call Cream_source($CREAM . "cream-print.vim")
call Cream_source($CREAM . "cream-replace.vim")
call Cream_source($CREAM . "cream-replacemulti.vim")
call Cream_source($CREAM . "cream-showinvisibles.vim")
call Cream_source($CREAM . "cream-sort.vim")
call Cream_source($CREAM . "cream-spell.vim")
call Cream_source($CREAM . "cream-statusline.vim")
call Cream_source($CREAM . "cream-templates.vim")
call Cream_source($CREAM . "cream-vimabbrev.vim")
".........................................
call Cream_source($CREAM . "calendar.vim")
call Cream_source($CREAM . "EasyHtml.vim")
call Cream_source($CREAM . "EnhancedCommentify.vim")
call Cream_source($CREAM . "opsplorer.vim")
call Cream_source($CREAM . "Rndm.vim")
call Cream_source($CREAM . "taglist.vim")
call Cream_source($CREAM . "securemodelines.vim")


" penultimately
" "cream-user" is loaded via autocmd in cream-autocmd.vim (needs to
" coordinate with add-on loading for alphabetically sorted menus).

" ultimate
autocmd VimEnter * call Cream_source($CREAM . "cream-playpen.vim")

" 1}}}
" vim:foldmethod=marker
