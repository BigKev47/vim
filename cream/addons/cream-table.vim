"
" Filename: cream-table.vim
" Updated:  2005-01-21 23:05:30-0400
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

" Limitations:
"
" As this script matures, we hope to eliminate these, but they exist
" for the time being:
" o No text may exist to the right or left of the table.
" o Assumes no wrapping.
" o Assumes expandtab


" register as a Cream add-on {{{1
if exists("$CREAM")
	" don't list unless developer
	if !exists("g:cream_dev")
		finish
	endif

	call Cream_addon_register(
	\ 'Table Edit',
	\ "Edit tables with special behaviors.",
	\ "Edit tables with special behaviors.",
	\ 'Table Edit',
	\ 'call Cream_table()',
	\ '<Nil>'
	\ )
endif

"  * http://table.sf.net features
"    - Cell size is dynamically adjusted as contents are typed in.
"    - Cells can be split horizontally and vertically.
"    - Cells can span into an adjacent cell.
"    - Cells maintains own justification.
"    - Can be translated into HTML source.


function! Cream_table()


endfunction

function! s:Cream_table_size()
endfunction

" Cream_table_getfirstline() {{{1
function! Cream_table_get_firstlinenr()
" return line number of table's first line

	" start from current line and work up
	let pos = line('.')
	while match(getline(pos), '^\s*[|+]') != -1
		let pos = pos - 1
	endwhile
	" return 0 if we don't find a table above cur pos
	if pos >= line('.')
		return 0
	endif
	return pos + 1

endfunction

" Cream_table_getlastline() {{{1
function! Cream_table_get_lastlinenr()
" return line number of table's first line

	" start from current line and work up
	let pos = line('.')
	while match(getline(pos), '^\s*[|+]') != -1
		let pos = pos + 1
	endwhile
	" return 0 if we don't find a table above cur pos
	if pos <= line('.')
		return 0
	endif
	return pos - 1

endfunction

function! s:Cream_table_getfirstcol()


endfunction

function! s:Cream_table_getlastcol()
endfunction

function! s:Cream_table_getcols()
" returns number of columns in the current line
endfunction

function! s:Cream_table_getlines()
" returns number of columns in the current line
endfunction

function! s:Cream_table_widen()
" add one char width to current column
endfunction

function! s:Cream_table_narrow()
" remove one char width of current column
endfunction

function! s:Cream_table_add_column()
" add column after current one
endfunction

function! s:Cream_table_add_line()
" insert line after current one
endfunction

function! s:Cream_table_pos()
" return col,line of current cell
endfunction

function! s:Cream_table_nextcell()
" go to next cell, including on next line if at end
endfunction

" Cream_table_insert() {{{1
function! Cream_table_insert()
" insert a new table, prompting for number of

	let n = Inputdialog("Enter number of columns:", 4)

	" cancel
	if     n == "{cancel}"
		return
	" empty or 0
	elseif n == "" || n == "0"
		" if empty
		call confirm("0 not allowed, defaulting to 4", "&Ok", 1)
		let n = 4
	" non-digits
	elseif n =~ '\D'
		call confirm(
			\ "Only number values accepted.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	let cells = "|"
	let rules = "+"
	let i = 0
	while i < n
		let rules = rules . "-----+"
		let cells = cells . "     |"
		let i = i + 1
	endwhile
	let rules = rules . "\n"
	let cells = cells . "\n"
	let x = rules . cells . rules
	let @x = x

	put x

endfunction

" s:Cream_columns() {{{1
function! s:Cream_columns()

endfunction

" Cream_table_isin() {{{1
function! Cream_table_isin()
" Return 1 if in a table, 0 if not.

	" if no pipes preceeding current position
	if     match(strpart(getline('.'), 0, col('.')), '[|+]') == -1
		return 0
	" if no pipes following current position
	elseif match(strpart(getline('.'), col('.')), '[|+]') == -1
		return 0
	" if not in table
	elseif Cream_table_getfirstline() == 0
		return 0
	else
		return 1
	endif


endfunction


finish
"#####################################################################


			+-----+-----+-----+-----+
			|     |     |     |     | 
			|     |     |     |     |
			+-----+-----+-----+-----+
			|     |     |     |     |
			|     |     |     |     |
			+-----+-----+-----+-----+
			|     |     |     |     |
			|     |     |     |     |
			+-----+-----+-----+-----+
			|     |     |     |     |
			|     |     |     |     |
			+-----+-----+-----+-----+
		
		
		

"#####################################################################

" 1}}}
" vim:foldmethod=marker
