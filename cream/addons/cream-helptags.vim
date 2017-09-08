"
" Filename: cream-helptags.vim
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

" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Helptags Current Directory', 
	\ "Tag current buffer's directory .TXT files as Vim help files.", 
	\ "Use Vim's :helptags command to tag the current buffer's directory applicable files as Vim help files.", 
	\ 'Helptags Current Directory', 
	\ 'call Cream_help_tags()',
	\ '<Nil>'
	\ )
endif


" called function is in cream-lib.

