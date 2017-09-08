"
" cream-filetype-html.vim
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
" * We've reserved Alt+[letter] combinations for language specific functions.
" * This stuff belongs in other (individual?) files, perhaps loadable from the menu.


setlocal commentstring=<!--%s-->
setlocal comments+=s1:\<!--,mb:\\t,ex:-->

" we do not like Vim's autoindent in HTML!
setlocal indentexpr=""
setlocal noautoindent

""	Insert HTML <li> item
"imap <M-l> <li></li><Left><Left><Left><Left><Left>

"	Insert HTML <ol> structure
"*** BROKEN: <C-o> is the mapping for single command mode!! ***
"imap <C-o> <ol><CR><li></li><CR></ol><CR><Up><Up><Right><Right><Right><Right>

""	Insert HTML <ul> structure
"" * Note: "<C-S><C-u>" doesn't work.
"imap <M-u> <ul><CR><li></li><CR></ul><CR><Up><Up><Right><Right><Right><Right>

""	Insert HTML <b></b> pair
"imap <C-b> <C-o>:call Cream_html_bold()<CR>
"function! Cream_html_bold()
"    normal i<b></b>
"    normal hhh
"endfunction
"	Insert HTML <b></b> pair, pasting selection within
vmap <silent> <C-b> :<C-u>call Cream_html_bold_select("v")<CR>
function! Cream_html_bold_select(mode)

	if a:mode == "v"
		normal gv
	else
		return
	endif
	
	" cut
 	normal "xx

	let @x = "\<b>" . @x . "\</b>"
	normal "xP

	" re-select 
	normal gv

	" adjust for added chars inserted
	normal o
	execute "normal lll"
	normal o
	execute "normal lll"
	normal o

endfunction

""	Insert HTML <i></i> pair
""*** Broken *** (interfering with [Tab])
""imap <C-i> <C-o>:call Cream_html_italicize()<CR>
"function! Cream_html_italicize()
"    normal i<i></i>
"    normal hhh
"endfunction
"	Insert HTML <i></i> pair, pasting selection within
"*** Broken *** (interfering with [Tab])
"vmap <C-i> "xxh:call Cream_html_italicize_select()<CR>
function! Cream_html_italicize_select()
	let mystr = @x
	let mystr = "\<i>" . mystr . "\</i>"
	let @x = mystr
	normal "xp
	" now re-select, and adjust for added chars inserted
	normal gv
	normal o
	execute "normal lll"
	normal O
	execute "normal lll"
	normal o
endfunction

"*** BROKEN: Conflicts with other :<C-u>call... stuff
"""	Insert HTML <u></u> pair
""imap <C-u> <C-o>:call Cream_html_underline()<CR>
""function! Cream_html_underline()
""    normal i<u></u>
""    normal hhh
""endfunction
""	Insert HTML <u></u> pair, pasting selection within
"vmap <C-u> "xxh:call Cream_html_underline_select()<CR>
"function! Cream_html_underline_select()
"    let mystr = @x
"    let mystr = "\<u>" . mystr . "\</u>"
"    let @x = mystr
"    normal "xp
"    " now re-select, and adjust for added chars inserted
"    normal gv
"    normal o
"    execute "normal lll"
"    normal O
"    execute "normal lll"
"    normal o
"endfunction
"***

""	Insert "&nbsp;"
""nmap <M-Space> i&nbsp;
"imap <M-Space> &nbsp;

""	Insert header (<h#>)
"imap <M-1> <h1></h1><Left><Left><Left><Left><Left>
"imap <M-2> <h2></h2><Left><Left><Left><Left><Left>
"imap <M-3> <h3></h3><Left><Left><Left><Left><Left>
"imap <M-4> <h4></h4><Left><Left><Left><Left><Left>
"imap <M-5> <h5></h5><Left><Left><Left><Left><Left>
"imap <M-6> <h6></h6><Left><Left><Left><Left><Left>

""	Insert HTML <p></p>
""nmap <M-p> i<p></p><Left><Left><Left><Left>
"imap <M-p>  <p></p><Left><Left><Left><Left>
""vmap <M-p> <Esc>i<p></p><Left><Left><Left><Left>


" HTML Character Equivalences

"" ">" to "&gt;" (remember, this is [Alt]+[Shift]+[.] ;)
"imap <M-<> &lt;
"" "<" to "&lt;" (remember, this is [Alt]+[Shift]+[,] ;)
"imap <M->> &gt;
"" "&" to "&amp;"
"imap <M-&> &amp;
"" """ to "&quot;"
"imap <M-"> &quot;

