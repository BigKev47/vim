"
" cream-gui.vim -- portion of Cream available only to the GUI (gVim)
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

if !has("gui_running")
	finish
endif

" initial margin to leave at top of screen when fitting the gui to
" accommodate top menu bars
set guiheadroom=50

" cursor
set guicursor=
	\n:block-Error/lCursor-blinkwait700-blinkoff50-blinkon800,
	\c:block-Error/lCursor,
	\o:hor50-Error,
	\i-ci-v:ver25-Cursor/lCursor,
	\r-cr:block-Cursor/lCursor,
	\sm:block-Cursor


" number of pixels inserted between font characters. (default 0, 1 for Win32 GUI)
"set linespace=

" scrollbars
set guioptions+=r	" Right hand scroll bar always present
set guioptions-=L	" Left hand scroll bar always present when vertically split

" 1}}}
" vim:foldmethod=marker
