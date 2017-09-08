"
" cream-menu-insert.vim
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


	imenu <silent> 40.102 I&nsert.Character\ Line\.\.\.<Tab>Shift+F4		<C-b>:call Cream_charline_prompt()<CR>
	imenu <silent> 40.103 I&nsert.Character\ Line\ (length\ of\ line\ above)\.\.\.<Tab>Shift+F4\ (x2)	<C-b>:call Cream_charline_lineabove_prompt()<CR>

anoremenu <silent> 40.110 I&nsert.-Sep40110-								<Nul>
anoremenu <silent> 40.111 I&nsert.Date/Time\.\.\.<Tab>F11					:call Cream_insert_datetime(1)<CR>
anoremenu <silent> 40.112 I&nsert.Date/Time\ (Last\ Used)<Tab>F11\ (x2)		:call Cream_insert_datetime()<CR>

anoremenu <silent> 40.120 I&nsert.-Sep40120-								<Nul>
	imenu <silent> 40.121 I&nsert.Character\ by\ Value<Tab>Alt+,			<C-b>:call Cream_insert_char()<CR>
	vmenu <silent> 40.122 I&nsert.Character\ by\ Value<Tab>Alt+,			:<C-u>call Cream_insert_char()<CR>
anoremenu <silent> 40.123 I&nsert.List\ Characters\ Available\.\.\.<Tab>Alt+,\ (x2)		:call Cream_allchars_list()<CR>
	imenu <silent> 40.124 I&nsert.List\ Character\ Values\ Under\ Cursor<Tab>Alt+\.		<C-b>:call Cream_char_codes("i")<CR>
	vmenu <silent> 40.125 I&nsert.List\ Character\ Values\ Under\ Cursor<Tab>Alt+\.		:<C-u>call Cream_char_codes("v")<CR>

anoremenu <silent> 40.130 I&nsert.-Sep40130-								<Nul>
	imenu <silent> 40.131 I&nsert.Character\ by\ Digraph<Tab>Ctrl+K   		<C-k>
anoremenu <silent> 40.132 I&nsert.List\ Digraphs\ Available\.\.\.<Tab>Ctrl+K\ (x2)	:call Cream_digraph_list()<CR>

anoremenu <silent> 40.150 I&nsert.-Sep40150-								<Nul>
	imenu <silent> 40.151 I&nsert.Text\ Filler\.\.\.						<C-b>:call Cream_loremipsum()<CR>

anoremenu <silent> 40.160 I&nsert.-Sep40160-								<Nul>
	vmenu <silent> 40.161 I&nsert.Line\ Numbers\.\.\.\ (selection)			:<C-u>call Cream_number_lines("v")<CR>


