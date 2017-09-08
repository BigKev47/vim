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
		silent! %substitute/A`/À/geI
		silent! %substitute/A'/Á/geI
		silent! %substitute/A\^/Â/geI
		silent! %substitute/A~/Ã/geI
		silent! %substitute/A\"/Ä/geI
		silent! %substitute/C\//Ç/geI
		silent! %substitute/E`/È/geI
		silent! %substitute/E'/É/geI
		silent! %substitute/E\^/Ê/geI
		silent! %substitute/E\"/Ë/geI
		silent! %substitute/I`/Ì/geI
		silent! %substitute/I'/Í/geI
		silent! %substitute/I\^/Î/geI
		silent! %substitute/I\"/Ï/geI
		silent! %substitute/N~/Ñ/geI
		silent! %substitute/O`/Ò/geI
		silent! %substitute/O'/Ó/geI
		silent! %substitute/O\^/Ô/geI
		silent! %substitute/O~/Õ/geI
		silent! %substitute/O\"/Ö/geI
		silent! %substitute/U`/Ù/geI
		silent! %substitute/U'/Ú/geI
		silent! %substitute/U\^/Û/geI
		silent! %substitute/U\"/Ü/geI
		silent! %substitute/Y'/Ý/geI
		silent! %substitute/a`/à/geI
		silent! %substitute/a'/á/geI
		silent! %substitute/a\^/â/geI
		silent! %substitute/a~/ã/geI
		silent! %substitute/a\"/ä/geI
		silent! %substitute/c\//ç/geI
		silent! %substitute/e`/è/geI
		silent! %substitute/e'/é/geI
		silent! %substitute/e\^/ê/geI
		silent! %substitute/e\"/ë/geI
		silent! %substitute/i`/ì/geI
		silent! %substitute/i'/í/geI
		silent! %substitute/i\^/î/geI
		silent! %substitute/i\"/ï/geI
		silent! %substitute/n~/ñ/geI
		silent! %substitute/o`/ò/geI
		silent! %substitute/o'/ó/geI
		silent! %substitute/o\^/ô/geI
		silent! %substitute/o~/õ/geI
		silent! %substitute/o\"/ö/geI
		silent! %substitute/u`/ù/geI
		silent! %substitute/u'/ú/geI
		silent! %substitute/u\^/û/geI
		silent! %substitute/u\"/ü/geI
		silent! %substitute/y'/ý/geI

	" German
	" source: Wolfgang Hommel
	elseif mylang ==? "ger"
		silent! %substitute/sS/ß/geI
	
	" Spanish
	" source: ispanish-1.7
	elseif mylang ==? "spa"
		silent! %substitute/'a/á/geI
		silent! %substitute/'e/é/geI
		silent! %substitute/'i/í/geI
		silent! %substitute/'o/ó/geI
		silent! %substitute/'u/ú/geI
		silent! %substitute/'n/ñ/geI
		silent! %substitute/"u/ü/geI
		silent! %substitute/'A/Á/geI
		silent! %substitute/'E/É/geI
		silent! %substitute/'I/Í/geI
		silent! %substitute/'O/Ó/geI
		silent! %substitute/'U/Ú/geI
		silent! %substitute/'N/Ñ/geI
		silent! %substitute/"U/Ü/geI
		" also
		silent! %substitute/~n/ñ/geI
		silent! %substitute/~N/Ñ/geI
	endif

endfunction

