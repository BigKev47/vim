"
" cream-syntax2html.vim -- converts syntax-highlighted text files to HTML
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
" * A wrapper for Vim's 'TOhtml' syntax-aware text to html conversion script

" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Convert Syntax Highlighting to HTML', 
	\ 'Convert syntax highlighting to HTML.', 
	\ 'Convert syntax highlighting into the HTML equivalent. Produces colorized output using the current syntax highlighting and color theme.',
	\ 'Convert.Syntax Highlighting to HTML', 
	\ 'call Cream_source2html("i")',
	\ '<C-u>call Cream_source2html("v")'
	\ )
endif

function! Cream_source2html(mode)

	if exists("g:html_number_lines")
		let save_html_number_lines = g:html_number_lines
	endif
	if exists("g:html_use_css")
		let save_html_use_css = g:html_use_css
	endif
	if exists("g:html_no_pre")
		let save_html_no_pre = g:html_no_pre
	endif
	let g:html_number_lines = g:CREAM_LINENUMBERS
	let g:html_use_css = 1
	let g:html_no_pre = 1

	set eventignore=all
	if a:mode == "v"
		execute ":'\<,'\>TOhtml"
	else
		execute ":TOhtml"
	endif
	set eventignore=
	doautocmd BufEnter *

	if exists("l:save_html_number_lines")
		let g:html_number_lines = save_html_number_lines
	endif
	if exists("l:save_html_use_css")
		let g:html_use_css = save_html_use_css
	endif
	if exists("l:save_html_no_pre")
		let g:html_html_no_pre = save_html_no_pre
	endif

endfunction

