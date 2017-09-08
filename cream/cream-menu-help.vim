"
" Filename: cream-menu-help.vim
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

imenu <silent> 90.010 &Help.Keyboard\ Shortcuts<Tab>F1	<C-b>:call Cream_help("keyboardshortcuts.html")<CR>
vmenu <silent> 90.010 &Help.Keyboard\ Shortcuts<Tab>F1	:<C-u>call Cream_help("keyboardshortcuts.html")<CR>
imenu <silent> 90.011 &Help.Features					<C-b>:call Cream_help("features.html")<CR>
vmenu <silent> 90.011 &Help.Features					:<C-u>call Cream_help("features.html")<CR>
imenu <silent> 90.012 &Help.FAQ							<C-b>:call Cream_help("faq.html")<CR>
vmenu <silent> 90.012 &Help.FAQ							:<C-u>call Cream_help("faq.html")<CR>
imenu <silent> 90.013 &Help.License						<C-b>:call Cream_file_open_defaultapp("http://www.gnu.org/licenses/gpl.html")<CR>
vmenu <silent> 90.013 &Help.License						:<C-u>call Cream_file_open_defaultapp("http://www.gnu.org/licenses/gpl.html")<CR>
imenu <silent> 90.014 &Help.Contributors				<C-b>:call Cream_help("contributors.html")<CR>
vmenu <silent> 90.014 &Help.Contributors				:<C-u>call Cream_help("contributors.html")<CR>

imenu <silent> 90.800 &Help.-Sep800-							<Nul>
imenu <silent> 90.810 &Help.&Vim\ Help\ (expert).&Overview				<C-b>:help<CR>
vmenu <silent> 90.810 &Help.&Vim\ Help\ (expert).&Overview				:<C-u>help<CR>
imenu <silent> 90.811 &Help.&Vim\ Help\ (expert).&User\ Manual			<C-b>:help usr_toc<CR>
vmenu <silent> 90.811 &Help.&Vim\ Help\ (expert).&User\ Manual			:<C-u>help usr_toc<CR>
imenu <silent> 90.812 &Help.&Vim\ Help\ (expert).&List\ Help\ Topics\.\.\.<Tab>Alt+F1	<C-b>:call Cream_help_listtopics()<CR>
vmenu <silent> 90.812 &Help.&Vim\ Help\ (expert).&List\ Help\ Topics\.\.\.<Tab>Alt+F1	:<C-u>call Cream_help_listtopics()<CR>
imenu <silent> 90.813 &Help.&Vim\ Help\ (expert).&Go\ to\ Help\ Topic\.\.\.<Tab>Ctrl+F1	<C-b>:call Cream_help_find()<CR>
vmenu <silent> 90.813 &Help.&Vim\ Help\ (expert).&Go\ to\ Help\ Topic\.\.\.<Tab>Ctrl+F1	:<C-u>call Cream_help_find()<CR>

imenu <silent> 90.820 &Help.&Vim\ Help\ (expert).-Sep45-					<Nul>
imenu <silent> 90.821 &Help.&Vim\ Help\ (expert).&How-to\ links			<C-b>:help how-to<CR>
vmenu <silent> 90.821 &Help.&Vim\ Help\ (expert).&How-to\ links			:<C-u>help how-to<CR>
imenu <silent> 90.822 &Help.&Vim\ Help\ (expert).&GUI					<C-b>:help gui<CR>
vmenu <silent> 90.822 &Help.&Vim\ Help\ (expert).&GUI					:<C-u>help gui<CR>
imenu <silent> 90.823 &Help.&Vim\ Help\ (expert).&Credits					<C-b>:help credits<CR>
vmenu <silent> 90.823 &Help.&Vim\ Help\ (expert).&Credits					:<C-u>help credits<CR>
imenu <silent> 90.824 &Help.&Vim\ Help\ (expert).Co&pying					<C-b>:help uganda<CR>
vmenu <silent> 90.824 &Help.&Vim\ Help\ (expert).Co&pying					:<C-u>help uganda<CR>
imenu <silent> 90.825 &Help.&Vim\ Help\ (expert).&Version\.\.\.				<C-b>:version<CR>
vmenu <silent> 90.825 &Help.&Vim\ Help\ (expert).&Version\.\.\.				:<C-u>version<CR>
imenu <silent> 90.826 &Help.&Vim\ Help\ (expert).&About\.\.\.				<C-b>:intro<CR>
vmenu <silent> 90.826 &Help.&Vim\ Help\ (expert).&About\.\.\.				:<C-u>intro<CR>

imenu <silent> 90.900 &Help.-Sep900-				<Nul>
imenu <silent> 90.910 &Help.&About\ Cream\.\.\.		<C-b>:call Cream_splash()<CR>
vmenu <silent> 90.910 &Help.&About\ Cream\.\.\.		:<C-u>call Cream_splash()<CR>

