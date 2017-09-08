"
" cream-spell.vim
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

function! Cream_spellcheck(...)
" toggle error highlighting on/off
	if !exists("b:cream_spell")
		" set
		let b:cream_spell = 1
		set spell
	else
		" unset
		unlet b:cream_spell
		set nospell
	endif

	" reselect if visual
	if a:0 > 1
		if a:1 == "v"
			normal gv
		endif
	endif

endfunction

function! Cream_spell_altword(...)
" Show alternate words

	" turn on temporarily, if not already
	if !exists("b:cream_spell")
		let spellontemp = 1
		call Cream_spellcheck()
	endif

	"" TODO: broken, hangs with trailing "Hit any key..."
	"let mycmdheight = &cmdheight
	"set cmdheight=13
	"set spellsuggest=10
	"silent normal z=
	"let &cmdheight = mycmdheight

	" TEST WORD: spelll

	let word = expand("<cword>")
	if word != ""
		" rework Popup menu
		silent! unmenu PopUp
		silent! unmenu! PopUp
		amenu <silent> PopUp.Alternate\ spellings  <Nul>
		amenu <silent> PopUp.(pick\ to\ replace) <Nul>
		amenu <silent> PopUp.--PopUp--  <Nul>

		let max = 20
		let words = spellsuggest(word, max)
		let i = 0
		while i < max
			" add item to popup
			let item = get(words, i)
			execute 'imenu <silent> PopUp.' . item . ' <C-b>:call Cream_spell_altword_replace("' . item . '")<CR>'
			execute 'vmenu <silent> PopUp.' . item . ' :<C-u>call Cream_spell_altword_replace("' . item . '")<CR>'
			let i = i + 1
		endwhile
	elseif word == ""
		call confirm(
		\ "Not currently on a word.\n" .
		\ "\n", "&Ok", 1, "Info")
		return 0
	else
		" do normal right click behavior
		return -1
	endif

	" display
	" silent causes first usage to do nothing (Win95, 2003-04-04)
	" BUG HACK: first time through, fails, do twice
	if !exists("g:cream_popup")
		let g:cream_popup = 1
		silent! popup PopUp
	endif

	silent! popup PopUp
	"" un-backup space check
	"normal l

	" restore original state of spell check
	if exists("spellontemp")
		call Cream_spellcheck()
	endif

	" reselect if visual
	if a:0 > 1
		if a:1 == "v"
			normal gv
		endif
	endif

endfunction

function! Cream_spell_altword_replace(word)
" select word under cursor and replace with a:word
	normal viw
	let @x = a:word
	" paste over selection
	normal "xp
endfunction

