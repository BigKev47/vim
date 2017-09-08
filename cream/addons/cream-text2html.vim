"
" cream-text2html.vim -- converts text files to basic HTML
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
" * Still very basic.
" * Escapes offending characters
" * Adds headers and footers
" * Eventually, we want to be able to colorize based on syntax

" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Convert Text to HTML', 
	\ 'Convert a text file to crude HTML.', 
	\ 'Convert a text file into a crude HTML equivilent. Escapes offending characters, spaces whitespace at line beginnings and adds headers and footers.', 
	\ 'Convert.Text to HTML', 
	\ 'call Cream_text2html()',
	\ '<Nil>'
	\ )
endif

function! Cream_text2html()
" * Ampersands in the pattern are accepted literally
" * Ampersands in the string must be double escaped(!?)

	" capture cmdheight
	let cmdheight = &cmdheight
	" setting to 10+ avoids 'Press Enter...'
	if cmdheight < 10
		let &cmdheight = 10
	endif

	" save as [filename].html
	" prompt
	let m = confirm(
		\ "SaveAs current file with \".html\" extension first?\n" .
		\ "  (" . fnamemodify(expand("%"), ":p:t") . ".html)".
		\ "\n", "&Ok\n&No", 1, "Info")
	if m == 1
		let n = Cream_appendext(expand("%", ":p"), "html")
		if n == -1
			call confirm(
				\ "Saving file with \".html\" extension failed. Quitting...\n" .
				\ "\n", "&Ok", 1, "Info")
			" restore cmdheight
			let &cmdheight = cmdheight
			" quit
			return
		endif
	endif

	" convert all "&" to "&amp;"
	execute ":%s/&/\\&amp;/ge"
	" convert all """ to "&quot;")
	execute ":%s/\"/\\&quot;/ge"
	" convert all "<" to "&lt;")
	execute ":%s/</\\&lt;/ge"
	" convert all ">" to "&gt;")
	execute ":%s/>/\\&gt;/ge"

	" convert all tabs to character equivalent spaces
	" TODO: convert spaces based on tabstop setting
	execute ":%s/\t/\\&nbsp;\\&nbsp;\\&nbsp;\\&nbsp;/ge"

	" convert all linebreaks to linebreaks with <br> tag
	execute ":%s/\\n/<br>\<CR>/ge"
	execute ":%s/<br>\\n\\n/<br>\<CR><br>\<CR>/ge"

	" convert line leading spaces to "&nbsp;"
	execute ":%s/\\n\\ \\ \\ \\ /\\r\\&nbsp;\\&nbsp;\\&nbsp;\\&nbsp;/ge"
	execute ":%s/\\n\\ \\ \\ /\\r\\&nbsp;\\&nbsp;\\&nbsp;/ge"
	execute ":%s/\\n\\ \\ /\\r\\&nbsp;\\&nbsp;/ge"
	execute ":%s/\\n\\ /\\r\\&nbsp;/ge"

	" add header HTML tags (at top of doc)
	normal gg
	normal O<html>
	normal o<head>
	normal o	<title></title>
	normal o
	normal <<
	normal i</head>
	normal o<body>
	normal o
	normal o<tt>
	normal o

	" add footer HTML tags (at bottom of doc)
	normal G
	normal o
	normal o</tt>
	normal o
	normal o</body>
	normal o</html>
	normal o

	" restore cmdheight
	let &cmdheight = cmdheight

endfunction

