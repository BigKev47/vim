"=
" cream-ispell.vim
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
" Convert an ispell wordlist with various multi-character
" representations to actual encoding.
"

" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Ispell-To-Wordlist', 
	\ 'Convert ispell postfix diacritics to Latin1.', 
	\ "Convert ispell dictionary to common wordlist. Expand ispell form abbreviations (currently just deleted!) and substitute characters with postfix diacritics to Latin1. Converts the entire current file.",
	\ 'Ispell-To-Wordlist', 
	\ 'call Cream_ispell2wordlist()',
	\ '<Nil>'
	\ )
endif

function! Cream_ispell2wordlist()

	" can't use without the proper encoding
	if &encoding != "latin1"
		let n = confirm(
			\ "This script has only been tested with encoding=latin1.\n" .
			\ "\n" .
			\ "To continue, you must temporarily change encodings.\n" .
			\ "(Original will be restored.) Continue?\n" .
			\ "\n", "&Ok\n&Cancel", 1, "Info")
		if n == 1
			let myencoding = &encoding
			set encoding=latin1
		else
			call confirm(
				\ "Script aborted.\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
	endif

	" confirm
	let n = confirm(
		\ "Do you wish to convert this file as an ispell \n" . 
		\ "dictionary to a common expanded wordlist?\n" .
		\ "\n", "&Ok\n&Cancel", 1, "Info")
	if n != 1
		return
	endif

	let mymagic = &magic
	set magic

	call s:Cream_ispell_expand()
	call s:Cream_ispell_singlechar()

	if exists("myencoding")
		execute "let &encoding=" . myencoding
	endif
	let &magic = mymagic

endfunction

function! s:Cream_ispell_expand()
" trash duplicate forms until we figure out how to expand without
" ispell! ("ispell -e" expands munched words.)

	silent! %substitute/\/.\+$//gei

endfunction

function! s:Cream_ispell_singlechar(...)
" convert diacritics
" * optional argument bypasses dialog
	
	if a:0 == 1
		let mylang == a:1
	else
		let n = confirm(
			\ "Please select language...\n" .
			\ "\n", "&French\n&German\n&Spanish\n&Cancel", 4, "Info")
		if n == 1
			let mylang = "fre"
		elseif n == 2
			let mylang = "ger"
		elseif n == 3
			let mylang = "spa"
		else
			return
		endif
	endif

	" French
	" source: Francais-GUTenberg-v1.0
	if mylang ==? "fre"
		silent! %substitute/A`/�/geI
		silent! %substitute/A'/�/geI
		silent! %substitute/A\^/�/geI
		silent! %substitute/A~/�/geI
		silent! %substitute/A\"/�/geI
		silent! %substitute/C\//�/geI
		silent! %substitute/E`/�/geI
		silent! %substitute/E'/�/geI
		silent! %substitute/E\^/�/geI
		silent! %substitute/E\"/�/geI
		silent! %substitute/I`/�/geI
		silent! %substitute/I'/�/geI
		silent! %substitute/I\^/�/geI
		silent! %substitute/I\"/�/geI
		silent! %substitute/N~/�/geI
		silent! %substitute/O`/�/geI
		silent! %substitute/O'/�/geI
		silent! %substitute/O\^/�/geI
		silent! %substitute/O~/�/geI
		silent! %substitute/O\"/�/geI
		silent! %substitute/U`/�/geI
		silent! %substitute/U'/�/geI
		silent! %substitute/U\^/�/geI
		silent! %substitute/U\"/�/geI
		silent! %substitute/Y'/�/geI
		silent! %substitute/a`/�/geI
		silent! %substitute/a'/�/geI
		silent! %substitute/a\^/�/geI
		silent! %substitute/a~/�/geI
		silent! %substitute/a\"/�/geI
		silent! %substitute/c\//�/geI
		silent! %substitute/e`/�/geI
		silent! %substitute/e'/�/geI
		silent! %substitute/e\^/�/geI
		silent! %substitute/e\"/�/geI
		silent! %substitute/i`/�/geI
		silent! %substitute/i'/�/geI
		silent! %substitute/i\^/�/geI
		silent! %substitute/i\"/�/geI
		silent! %substitute/n~/�/geI
		silent! %substitute/o`/�/geI
		silent! %substitute/o'/�/geI
		silent! %substitute/o\^/�/geI
		silent! %substitute/o~/�/geI
		silent! %substitute/o\"/�/geI
		silent! %substitute/u`/�/geI
		silent! %substitute/u'/�/geI
		silent! %substitute/u\^/�/geI
		silent! %substitute/u\"/�/geI
		silent! %substitute/y'/�/geI

	" German
	" source: Wolfgang Hommel
	elseif mylang ==? "ger"
		silent! %substitute/sS/�/geI
	
	" Spanish
	" source: ispanish-1.7
	elseif mylang ==? "spa"
		silent! %substitute/'a/�/geI
		silent! %substitute/'e/�/geI
		silent! %substitute/'i/�/geI
		silent! %substitute/'o/�/geI
		silent! %substitute/'u/�/geI
		silent! %substitute/'n/�/geI
		silent! %substitute/"u/�/geI
		silent! %substitute/'A/�/geI
		silent! %substitute/'E/�/geI
		silent! %substitute/'I/�/geI
		silent! %substitute/'O/�/geI
		silent! %substitute/'U/�/geI
		silent! %substitute/'N/�/geI
		silent! %substitute/"U/�/geI
		" also
		silent! %substitute/~n/�/geI
		silent! %substitute/~N/�/geI
	endif

endfunction

