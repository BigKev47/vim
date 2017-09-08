"=
" cream-spell-french.vim
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
" Scripted process for condensing French spell check dictionary
"


" register as a Cream add-on
if exists("$CREAM")

	" only if developer
	if !exists("g:cream_dev")
		finish
	endif

	call Cream_addon_register(
	\ 'Spell French', 
	\ 'Condense raw French wordlist for Cream', 
	\ "Condense raw French wordlist to (mostly) single-word forms for faster Cream spell checking.",
	\ 'Cream Devel.Spell French', 
	\ 'call Cream_spell_french()',
	\ '<Nil>'
	\ )
endif

function! Cream_spell_french()

	" can't use without the proper encoding
	if &encoding != "latin1" && &encoding != "utf-8"
		call confirm(
			\ "Can not continue unless encoding is \"latin1\" or \"utf-8\" \n" . 
			\ "\n", "&Cancel", 1, "Warning")
		return
	endif

	" confirm
	let n = confirm(
		\ "Do you wish to convert this file as a proper French language \n" . 
		\ "wordlist to a form more suited to a Cream spell check dictionary?\n" .
		\ "\n", "&Ok\n&Cancel", 1, "Info")
	if n != 1
		return
	endif

	let mymagic = &magic
	set magic

	call s:Cream_spell_french_subs()


	" Now we're ready for uniq!
	call confirm(
		\ "Please use uniq on this file: \n" .
		\ "\n" .
		\ "   " . expand("%:p") . "\n" .
		\ "\n" .
		\ "to remove duplicates.\n" .
		\ "\n", "&Ok", 1, "Info")

	let &magic = mymagic

endfunction

function! s:Cream_spell_french_subs()

	" separated hyphenated words into separate words
	silent! %substitute/-/\r/gei

	" remove all multi-word shortings with the number of words reduced
	" as follows:
	"    C' -   0        c'  -      6
	"    D' - 301        d'  - 22,901
	"    J' -   0        j'  -  9,319
	"    L' -  84        l'  - 61,229
	"    M' -   0        m'  - 33,753
	"    N' -   0        n'  - 54,006
	"    Qu -   0        qu' - 54,051
	"    S' -   0        s'  - 15,886
	"    T' -   0        t'  - 33,754

	" Note: We replace the prefix with itself and a return so as to
	" ensure it remains in the dictionary. (A final uniq will rid us
	" of extra anyway.)
	"silent! %substitute/^\(C'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(c'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(D'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(d'\)\(.\+\)$/\1\r\2/gei
	"silent! %substitute/^\(J'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(j'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(L'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(l'\)\(.\+\)$/\1\r\2/gei
	"silent! %substitute/^\(M'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(m'\)\(.\+\)$/\1\r\2/gei
	"silent! %substitute/^\(N'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(n'\)\(.\+\)$/\1\r\2/gei
	"silent! %substitute/^\(Qu'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(qu'\)\(.\+\)$/\1\r\2/gei
	"silent! %substitute/^\(S'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(s'\)\(.\+\)$/\1\r\2/gei
	"silent! %substitute/^\(T'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(t'\)\(.\+\)$/\1\r\2/gei

	" separate a few more multi-word components
	"    entr'   - 47
	"    lorsqu' - 17
	"    puisqu' - 22
	"    quoiqu' - 22
	" Note: (same comment as above)
	silent! %substitute/^\(entr'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(lorsqu'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(puisqu'\)\(.\+\)$/\1\r\2/gei
	silent! %substitute/^\(quoiqu'\)\(.\+\)$/\1\r\2/gei

	silent! %substitute/'s$/\r's/gei


endfunction

