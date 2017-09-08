"
" Filename: cream-menu.vim
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

function! Cream_menu_translation()
" copied from vim's own menu.vim, with a little modification
	if exists("v:lang") || &langmenu != ""
		" Try to find a menu translation file for the current language.
		if &langmenu != ""
			if &langmenu =~ "none"
				let s:lang = ""
			else
				let s:lang = &langmenu
			endif
		else
			let s:lang = v:lang
		endif
		" A language name must be at least two characters, don't accept "C"
		if strlen(s:lang) > 1
			" When the language does not include the charset add 'encoding'
			if s:lang =~ '^\a\a$\|^\a\a_\a\a$'
				let s:lang = s:lang . '.' . &encoding
			endif

			" We always use a lowercase name.
			" Change "iso-8859" to "iso_8859" and "iso8859" to "iso_8859", some
			" systems appear to use this.
			" Change spaces to underscores.
			let s:lang = substitute(tolower(s:lang), '\.iso-', ".iso_", "")
			let s:lang = substitute(s:lang, '\.iso8859', ".iso_8859", "")
			let s:lang = substitute(s:lang, " ", "_", "g")
			" Remove "@euro", otherwise "LC_ALL=de_DE@euro gvim" will show English menus
			let s:lang = substitute(s:lang, "@euro", "", "")
			" Change "iso_8859-1" and "iso_8859-15" to "latin1", we always use the
			" same menu file for them.
			let s:lang = substitute(s:lang, 'iso_8859-15\=$', "latin1", "")
			menutrans clear
			execute "runtime! cream/lang/menu_" . s:lang . ".vim"

			if !exists("did_menu_trans")
				" There is no exact match, try matching with a wildcard added
				" (e.g. find menu_de_de.iso_8859-1.vim if s:lang == de_DE).
				let s:lang = substitute(s:lang, '\.[^.]*', "", "")
				execute "runtime! cream/lang/menu_" . s:lang . "*.vim"

				if !exists("did_menu_trans") && strlen($LANG) > 1
					" On windows locale names are complicated, try using $LANG, it might
					" have been set by set_init_1().
					execute "runtime! cream/lang/menu_" . tolower($LANG) . "*.vim"
				endif
			endif
		endif
	endif
endfunction

function! Cream_menus()
" Creates each menu loader and calls it

	" remove existing menus
	source $VIMRUNTIME/delmenu.vim
	call Cream_menu_translation()

	" TODO: We really shouldn't be tampering with this here...
	" Make sure the '<' and 'C' flags are not included in 'cpoptions', otherwise
	" <CR> would not be recognized.  See ":help 'cpoptions'".
	let cpo_save = &cpoptions
	set cpoptions&vim

	"+++ Cream: necessary for GTK (set also from vimrc, but not effective there)
	set guioptions+=M
	"+++

	"+++ Cream: GTK loads menus, even if you ask it not to!
	unmenu! *
	unmenu *
	"+++

	" load Cream menus
	call Cream_source($CREAM . "cream-menu-file.vim")
	call Cream_source($CREAM . "cream-menu-edit.vim")
	call Cream_source($CREAM . "cream-menu-insert.vim")
	call Cream_source($CREAM . "cream-menu-format.vim")
	call Cream_source($CREAM . "cream-menu-settings.vim")
	call Cream_source($CREAM . "cream-menu-tools.vim")
	call Cream_source($CREAM . "cream-menu-window.vim")
	call Cream_source($CREAM . "cream-menu-window-buffer.vim")
	call Cream_source($CREAM . "cream-menu-help.vim")
	call Cream_source($CREAM . "cream-menu-window.vim")

	call Cream_source($CREAM . "cream-menu-developer.vim")

	call Cream_source($CREAM . "cream-menu-toolbar.vim")
	call Cream_source($CREAM . "cream-menu-popup.vim")

	" restore
	let &cpo = cpo_save

endfunction
call Cream_menus()

