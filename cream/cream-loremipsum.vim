"
" Filename: cream-loremipsum.vim
" Updated:  2009-11-09, 09:11pm
"
" Cream -- An easy-to-use configuration of the famous Vim text editor
" (http://cream.sourceforge.net) Copyright (C) 2001-2011 Steve Hall
"
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 3 of the License, or
" (at your option) any later version.
" (http://www.gnu.org/licenses/gpl.html)
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

" Lorem Ipsum: Text filler from the 1500's classic.
"

" Cream_loremipsum() {{{1
function! Cream_loremipsum()
" Insert Latin at the cursor as user requests number of paragraphs.

	if !exists("s:cnt")
		let s:cnt = 1
	endif

	" request
	let n = Inputdialog("Please enter the number of paragraphs to enter:", s:cnt)
	" do nothing on cancel
	if     n == "{cancel}"
		return
	" warn only numbers allowed
	elseif match(n, '[^0-9]') != -1
		call confirm(
			\ "Only numbers are allowed.\n" .
			\ "\n", "&Ok", 1, "Error")
	" quit if 0
	elseif n == 0
		return
	else
		" remember it
		let s:cnt = n
	endif

	let str = ""
	let i = 0
	while i < n
		let str = str . Cream_loremipsum_getpara()
		" add returns if not at end
		if i-1 != n
			let str = str . "\n\n"
		endif
		let i = i + 1
	endwhile
	let @x = str
	normal "xP

endfunction

" Cream_loremipsum_getpara() {{{1
function! Cream_loremipsum_getpara()
" Return paragraph of 2-6 sentences.

	let para = ""
	let l = Urndm(2, 6)
	let i = 0
	while i < l
		let para = para . Cream_loremipsum_getsent() . " "
		let i = i + 1
	endwhile
	return substitute(para, ' $', '', '')

endfunction

" Cream_loremipsum_getsent() {{{1
function! Cream_loremipsum_getsent()
" Return consecutive sentences of lorem ipsum.

	" init
	if !exists("g:CREAM_LOREMIPSUM")
		let g:CREAM_LOREMIPSUM = 1
	" loop on twice the number we have
	elseif g:CREAM_LOREMIPSUM >= 14
		let g:CREAM_LOREMIPSUM = 1
	else
		let g:CREAM_LOREMIPSUM = g:CREAM_LOREMIPSUM + 1
	endif

	let rnd = g:CREAM_LOREMIPSUM

	" Source: http://www.lipsum.com/

	" The standard Lorem Ipsum passage, used since the 1500s
	if     rnd == 1 | return "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
	elseif rnd == 2 | return "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
	elseif rnd == 3 | return "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
	elseif rnd == 4 | return "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

	" Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC
	elseif rnd == 5 | return "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."
	elseif rnd == 6 | return "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt."
	elseif rnd == 7 | return "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem."
	elseif rnd == 8 | return "Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?"
	elseif rnd == 9 | return "Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"

	" Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC
	elseif rnd == 10 | return "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga."
	elseif rnd == 11 | return "Et harum quidem rerum facilis est et expedita distinctio."
	elseif rnd == 12 | return "Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus."
	elseif rnd == 13 | return "Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae."
	elseif rnd == 14 | return "Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."

	endif


endfunction
" 1}}}

" Cream Gibberish
"
" Description: Text filler from random characters. One of the dangers
" of generating random text is that it might produce actual words.
" This, in combination with a lengthy set of rules to get the text to
" look valid mostly rules out using these for the purpose of filler
" text.

" Cream_gibberish() {{{1
function! Cream_gibberish(paragraphs)
" {paragraphs} is the number of paragraphs to return.

	" initialize
	let s:lastchar = ""
	let s:lastword = ""
	let s:lastsent = ""
	let s:lastpara = ""

	let str = ""
	let i = 0
	while i < a:paragraphs
		let str = str . s:Cream_getpara() . "\n\n"
		let i = i + 1
	endwhile

	return str

endfunction

" s:Cream_getpara() {{{1
function! s:Cream_getpara()
" Return paragraph of length 3-8 sentances.

	let para = ""
	let l = Urndm(3, 8)
	let i = 0
	while i < l
		let para = s:Cream_getsent() . " " . para
		let i = i + 1
	endwhile
	return para

endfunction

" s:Cream_getsent() {{{1
function! s:Cream_getsent()
" Return sentence of length 5-24 words.

	let sent = ""
	let l = Urndm(5, 24)
	let i = 0
	while i < l
		let sent = sent . " " . s:Cream_getword()
		" capitalize first word (and strip leading space ;)
		if i == 0
		   let sent = substitute(sent, '^ \(.\)', '\u\1', "")
		endif
		let i = i + 1
	endwhile
	return sent . "."

endfunction

" s:Cream_getword() {{{1
function! s:Cream_getword()
" Return word.
" o Length 2-12 characters along a bell curve with an
"   average of 5.
" o No characters repeating.
" o
"

	let word = ""
	let len = Urndm(1, 3) + Urndm(1, 5) + Urndm(0, 2)
	let i = 0
	while i < len
		" rule check
		let valid = 0
		while valid == 0
			let prev = matchstr(word, '.$')
			let char = s:Cream_getchar()
			" don't let chars repeat
			if     prev == char
			" rarely (1:3) let vowels repeat
			elseif s:Cream_isvowel(prev) == 1 && s:Cream_isvowel(char) == 1 && Urndm(1, 3) > 1
			" rarely (1:3) let consonents repeat
			elseif s:Cream_isvowel(prev) == 0 && s:Cream_isvowel(char) == 0 && Urndm(1, 3) > 1
			" rarely (1:6) let vowels begin words
			elseif i == 0 && s:Cream_isvowel(char) == 1 && Urndm(1, 6) > 1
			" rarely (1:10) allow weird adjacencies
			elseif s:Cream_isweird(prev, char) == 1 && Urndm(1, 10) > 1

			" rarely (1:5) end word with non-characteristic letter
			elseif ((i + 1) == len) && s:Cream_isbadendchar(char) == 1 && Urndm(1, 5) > 1
				"" strip previous letter and de-increment
				"let word = substitute(word, '\(.*\).$', '\1', '')
				""let i = i - 1

				" try again
				let char = s:Cream_getchar()
				let valid = 1
			else
				let valid = 1
			endif
		endwhile
		let word = word . char
		let i = i + 1
	endwhile
	return word

endfunction

" s:Cream_isvowel() {{{1
function! s:Cream_isvowel(char)
	if     a:char =~ '[aeiou]'
		return 1
	elseif a:char =~ '[^aeiou]'
		return 0
	endif
	return -1
endfunction

" s:Cream_isbadendchar() {{{1
function! s:Cream_isbadendchar(char)
	if a:char =~ '[aceijoquvz]'
		return 1
	endif
endfunction

" s:Cream_isweird() {{{1
function! s:Cream_isweird(prev, char)
" avoids unrealistic adjacencies

	if     1 == 2 | return 1
	elseif a:prev == "n" && a:char == "l" | return 1
	elseif a:prev == "b"
		if  a:char == "c"
		\||	a:char == "d"
		\||	a:char == "f"
		\||	a:char == "g"
		\||	a:char == "h"
		\||	a:char == "j"
		\||	a:char == "k"
		\||	a:char == "l"
		\||	a:char == "m"
		\||	a:char == "n"
		\||	a:char == "p"
		\||	a:char == "q"
		\||	a:char == "s"
		\||	a:char == "t"
		\||	a:char == "v"
		\||	a:char == "w"
		\||	a:char == "x"
		\||	a:char == "z"
			return 1
		endif

	elseif a:prev == "d" && a:char == "b" | return 1
	elseif a:prev == "g" && a:char == "p" | return 1

	elseif a:prev == "h"
		if  a:char == "b"
		\||	a:char == "c"
		\||	a:char == "d"
		\||	a:char == "f"
		\||	a:char == "g"
		\||	a:char == "h"
		\||	a:char == "j"
		\||	a:char == "k"
		\||	a:char == "l"
		\||	a:char == "m"
		\||	a:char == "n"
		\||	a:char == "p"
		\||	a:char == "q"
		\||	a:char == "r"
		\||	a:char == "s"
		\||	a:char == "t"
		\||	a:char == "v"
		\||	a:char == "w"
		\||	a:char == "x"
		\||	a:char == "z"
			return 1
		endif

	elseif a:prev == "k"
		if  a:char == "b"
		\||	a:char == "c"
		\||	a:char == "d"
		\||	a:char == "f"
		\||	a:char == "g"
		\||	a:char == "h"
		\||	a:char == "j"
		\||	a:char == "k"
		\||	a:char == "m"
		\||	a:char == "p"
		\||	a:char == "q"
		\||	a:char == "s"
		\||	a:char == "t"
		\||	a:char == "v"
		\||	a:char == "w"
		\||	a:char == "x"
		\||	a:char == "z"
			return 1
		endif

	elseif a:prev == "k" && a:char == "t" | return 1
	elseif a:prev == "l" && a:char == "g" | return 1
	elseif a:prev == "n" && a:char == "r" | return 1
	elseif a:prev == "r" && a:char == "g" | return 1
	elseif a:prev == "t"
		if  a:char == "b"
		\||	a:char == "c"
		\||	a:char == "d"
		\||	a:char == "f"
		\||	a:char == "g"
		\||	a:char == "j"
		\||	a:char == "k"
		\||	a:char == "m"
		\||	a:char == "n"
		\||	a:char == "p"
		\||	a:char == "q"
		\||	a:char == "s"
		\||	a:char == "v"
		\||	a:char == "w"
		\||	a:char == "x"
		\||	a:char == "z"
			return 1
		endif
	elseif a:prev == "v" && a:char == "m" | return 1
	elseif a:prev == "y" && a:char == "g" | return 1
	endif
endfunction

function! s:Cream_getchar()
" Return character based on frequency in English.

	let rndm = Urndm(0, 10000)
	if rndm > 8883 | return "e" | endif
	if rndm > 8034 | return "a" | endif
	if rndm > 7276 | return "r" | endif
	if rndm > 6521 | return "i" | endif
	if rndm > 5805 | return "o" | endif
	if rndm > 5110 | return "t" | endif
	if rndm > 4444 | return "n" | endif
	if rndm > 3871 | return "s" | endif
	if rndm > 3322 | return "l" | endif
	if rndm > 2868 | return "c" | endif
	if rndm > 2505 | return "u" | endif
	if rndm > 2166 | return "d" | endif
	if rndm > 1850 | return "p" | endif
	if rndm > 1548 | return "m" | endif
	if rndm > 1248 | return "h" | endif
	if rndm > 1001 | return "g" | endif
	if rndm >  794 | return "b" | endif
	if rndm >  613 | return "f" | endif
	if rndm >  435 | return "y" | endif
	if rndm >  306 | return "w" | endif
	if rndm >  196 | return "k" | endif
	if rndm >   95 | return "v" | endif
	if rndm >   66 | return "x" | endif
	if rndm >   39 | return "z" | endif
	if rndm >   19 | return "j" | endif
	return "qu"

endfunction

" 1}}}
" vim:foldmethod=marker
