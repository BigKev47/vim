"
" cream-email-formatter.vim
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
" Description:
" Mail clients destroy proper formatting, this script puts them back.
"


" register as a Cream add-on
if exists("$CREAM")

	call Cream_addon_register(
	\ 'Email Prettyfier',
	\ "Re-format email to \"proper\" form.",
	\ "Re-format email to \"proper\" form. (Currently only expands compressed >>> to > > > .)",
	\ '&Email Prettyfier',
	\ 'call Cream_email_formatter()',
	\ '<Nil>'
	\ )
endif

function! Cream_email_formatter()
" re-format email to "proper" form.

	" if filetype not Vim, quit
	if &filetype != "txt" &&
	\  &filetype != "mail" &&
	\  &filetype != ""
		call confirm(
			\ "Function designed only for text files. Please check this document's filetype.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" dialog
   
	" retain existing dialog button display orientation
	let sav_go = &guioptions
	" make vertical
	set guioptions+=v

	let str = ""
	let str = str . "EXAMPLES:                                                                                       \n"
	let str = str . "   Re-format headers, 1 line: (includes name and date/time)\n"
	let str = str . "\n"
	let str = str . "                 From:\n"
	let str = str . "\n"
	let str = str . "   Re-format headers, multi-line: (2-char abbreviations)\n"
	let str = str . "\n"
	let str = str . "                 By:\n"
	let str = str . "                 To:\n"
	let str = str . "                 Cc:\n"
	let str = str . "                 On:\n"
	let str = str . "                 Re:\n"
	let str = str . "\n"
	let str = str . "   Fix thread indentation: (one separating space)\n"
	let str = str . "\n"
	let str = str . "                 > > > >\n"
	let str = str . "                 > > >\n"
	let str = str . "                 > >\n"
	let str = str . "                 >\n"
	let str = str . "\n"
	let str = str . '   Spam-proof email addresses: (remove "@" and ".")' . "\n"
	let str = str . "\n"
	let str = str . "                 myname domain com\n"
	let str = str . "\n"
	let str = str . "   Collapse empty lines: (reduce to only one line)\n"
	let str = str . "\n"
	let str = str . "                 line 1\n"
	let str = str . "\n"
	let str = str . "                 line 2\n"
	let str = str . "\n"
	let i = 1
	let default = 1
	while exists("i")
		let n = confirm(str . "\n",
			\ "Re-format headers, 1 line\n" . 
			\ "Re-format headers, multi-line\n" . 
			\ "Fix thread indention\n" . 
			\ "Spam-proof email addresses\n" . 
			\ "Collapse empty lines\n" . 
			\ "Quit", default, "Info")
		if     n == 1
			call s:Cream_email_formatter_headers1()
			let default = 3
		elseif n == 2
			call s:Cream_email_formatter_headers2()
			let default = 3
		elseif n == 3
			call s:Cream_email_formatter_indention()
			let default = 4
		elseif n == 4
			call s:Cream_email_formatter_email()
			let default = 5
		elseif n == 5
			" condense all empty lines
			call Cream_emptyline_collapse()
			let default = 6
		else
			" Cancel
			unlet i
		endif
	endwhile

	" restore gui buttons
	let &guioptions = sav_go

endfunction

function! s:Cream_email_formatter_headers1()
	" Change
	"
	"    From: (name)
	"    To: (name)
	"    Cc: (name)
	"    Sent: (date)
	"
	" (and leading quote ">" chars) to
	"
	"    From: (name), (date)
	"
	"silent! %substitute/^\([> ]*\)\(From: \|By: \)\(.\{2,}\)\n[> ]*[To: ]*[[:print:]]*\n\=[> ]*\(Sent:\|On:\|Date:\)/\1\2\3,/gei
	silent! %substitute/^\([> ]*\)\(From: \|By: \)\(.\{2,}\)\n\([> ]*[To: ]*[[:print:]]*\n\)\=\([> ]*[Cc: ]*[[:print:]]*\n\)\=\([> ]*[Subject: ]*[[:print:]]*\n\)\=[> ]*\(Sent:\|On:\|Date:\)/\1\2\3,/gei
	" remove stray "To: (name)" lines
	silent! %substitute/^\([> ]*\)To:\(.\+\)\n//gei
	" remove stray "Subject: (text)" lines
	silent! %substitute/^\([> ]*\)\(Subject:\|Re:\)\(.\+\)\n//gei
	" remove stray "Cc: (names)" lines
	silent! %substitute/^\([> ]*\)\(Cc:\)\(.\+\)\n//gei
	" remove stray "Priority: (level)" lines
	silent! %substitute/^\([> ]*\)\(Priority:\)\(.\+\)\n//gei
	silent! %substitute/^\([> ]*\)\(Importance:\)\(.\+\)\n//gei
endfunction
function! s:Cream_email_formatter_headers2()
	" Change
	"
	"    From: (name)
	"    Sent: (date)
	"    To: (name)
	"    Subject: (text)
	"
	" (and leading quote ">" chars) to
	"
	"    By: (name)
	"    On: (date)
	"    To: (name)
	"    Cc: (name)
	"    Re: (text)
	"
	silent! %substitute/^\([> ]*\)From:\s\+\(.\+\)$/\1By: \2/gei
	silent! %substitute/^\([> ]*\)Cc:\s\+\(.\+\)$/\1Cc: \2/gei
	silent! %substitute/^\([> ]*\)Sent:\s\+\(.\+\)$/\1On: \2/gei
	silent! %substitute/^\([> ]*\)Date:\s\+\(.\+\)$/\1On: \2/gei
	silent! %substitute/^\([> ]*\)To:\s\+\(.\+\)$/\1To: \2/gei
	silent! %substitute/^\([> ]*\)Subject:\s\+\(.\+\)$/\1Re: \2/gei
	silent! %substitute/^\([> ]*\)Priority:\s\+\(.\+\)$/\1Pr: \2/gei
	silent! %substitute/^\([> ]*\)Importance:\s\+\(.\+\)$/\1Pr: \2/gei
endfunction

function! s:Cream_email_formatter_indention()
	" properly format indention chars
	let i = 0
	while i < 10
		" need spaces
		silent! %substitute/^[ >]*\zs\(>\) \@!/\1 /ge
		" but not too many!
		silent! %substitute/^[> ]*\zs\(>\)  \+/\1 /ge
		let i = i + 1
	endwhile
endfunction

function! s:Cream_email_formatter_email()
	" strip out bracketed email addresses (<name@domain.com>)
	%substitute/\s*<[a-zA-Z0-9_\.\-]\+@[a-zA-Z0-9\-]\+\.[a-zA-Z0-9]\{2,4}>//gei
	" spam-proof other email addresses
	%substitute/\([a-zA-Z0-9_\.\-]\+\)@\([a-zA-Z0-9\-]\+\)\.\([a-zA-Z0-9]\{2,4}\)/\1 \2 \3/gei
endfunction

