"
" cream-conf.vim
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
"
"**********************************************************************
" WARNING:
" These options are for advanced users only. If you are not an
" experienced Vim user, it is recommended that you leave this file
" alone to avoid undesirable or destructive behavior. (Or at least
" to maintain your productivity. ;)
"
"**********************************************************************
"
" Description:
" o Use these options to over-ride default Cream conditions. Each should
"   be pretty self explanitory.
" o None of these options are required for Cream to initialize or
"   function properly. If in doubt, comment out.
" o Most of these are simply the globals we store in viminfo. An
"   autocmd calls this function to overwrite those pulled from the
"   viminfo on startup.
" o While called via autocmd VimEnter, the function is actually called
"   twice. The first time happens immediately after being sourced so
"   that Cream can abort further loads if a user has Vim or Vi
"   behavior set.
" o String values/types must be quoted
" o Number values/types must be unquoted, 1=on 0=off
"

function! Cream_conf_override()
" over-ride defaults and last-saved settings

	"----------------------------------------------------------------------
	" behavior and expert mode

	" behavior (default "cream", other
	"           options "creamlite", "vim", "vi")
	"let g:CREAM_BEHAVE = "cream"

	" behavior warning (default on=1, off=0)
	"let g:cream_behave_warn = 0

	" expert mode (default 0)
	"let g:CREAM_EXPERTMODE = 0

	" open last buffer (default "[path]")
	"let g:CREAM_LAST_BUFFER = ""

	" open last buffer (default [not existing] or 0, on=1)
	"let g:CREAM_LAST_BUFFER_FORGET = 0

	" bracket matching (default or 0, on=1)
	"let g:CREAM_BRACKETMATCH = 0

	" Vim plugins loading (default [not existing] or 0 to enable
	" plugins, 1 to disable them)
	"let g:CREAM_NOVIMPLUGINS = 0

	" Default path for current working directory
	"let g:CREAM_CWD = '/tmp'

	"----------------------------------------------------------------------
	" font and window positioning

	if has("win32")
		let os = "WIN"
	elseif has("unix")
		let os = "UNIX"
	else
		let os = "OTHER"
	endif

	" font (default "[font spec]")
	"let g:CREAM_FONT_{os} = ""

	" window position (default 50, 50, 50, 80)
	" Note: Relies on font size above.
	"let g:CREAM_WINPOSY_{os} = 50
	"let g:CREAM_WINPOSX_{os} = 50
	"let g:CREAM_LINES_{os} = 50
	"let g:CREAM_COLS_{os} = 80

	" font for column mode (default "[font spec]")
	"let g:CREAM_FONT_COLUMNS = ""

	"----------------------------------------------------------------------
	" editing

	" tabstop and shiftwidth (default 8)
	"let g:CREAM_TABSTOP = 8

	" autoindent (default 1)
	"let g:CREAM_AUTOINDENT = 1

	" wrap (default 1)
	"let g:CREAM_WRAP = 1

	" autowrap and expandtabs (default 0)
	"let g:CREAM_AUTOWRAP = 0

	" textwidth (default 80)
	"let g:CREAM_AUTOWRAP_WIDTH = 80

	" line numbers (default 1)
	"let g:CREAM_LINENUMBERS = 1

	" show invisibles (default 0)
	"let g:LIST = 0

	" show toolbar (default 1)
	"let g:CREAM_TOOLBAR = 1

	" make pop automatic upon "("  (default 0)
	" (Note: only available on Windows)
	"let g:CREAM_POP_AUTO = 0

	" color theme (default "[cream color theme]"))
	"let g:CREAM_COLORS = ""
	"let g:CREAM_COLORS_SEL = ""

	" daily read file (no default)
	"let g:CREAM_DAILYREAD = ""

	" single session (default 0)
	"let g:CREAM_SINGLESERVER = 0

	" spell check language (no default)
	"let g:CREAM_SPELL_LANG = ""
	" spell check multiple dictionaries (default 0)
	"let g:CREAM_SPELL_MULTIDICT = 0

	" selection highlighting (default 0)
	"let g:CREAM_SEARCH_HIGHLIGHT = 0

	"----------------------------------------------------------------------
	" find and replace

	" find
	" find string ("Find Me!")
	"let g:CREAM_FFIND = "Find Me!"
	" case sensitive (default 0)
	"let g:CREAM_FCASE = 0
	" use regular expressions (default 0)
	"let g:CREAM_FREGEXP = 0

	" replace
	" find string ("Find Me!")
	"let g:CREAM_RFIND = "Find Me!"
	" replace string ("Find Me!")
	"let g:CREAM_RREPL = "Replace Me!"
	" case sensitive (default 0)
	"let g:CREAM_RCASE = 0
	" use regular expressions (default 0)
	"let g:CREAM_RREGEXP = 0
	" replace one by one (default 0)
	"let g:CREAM_RONEBYONE = 0

	" replace-multi
	" find string ("Find Me!")
	"let g:CREAM_RMFIND = "Find Me!"
	" replace string ("Replace Me!")
	"let g:CREAM_RMREPL = "Replace Me!"
	" path/filename (no default)
	"let g:CREAM_RMPATH = ""
	" case sensitive (default 0)
	"let g:CREAM_RMCASE = 0
	" use regular expressions (default 0)
	"let g:CREAM_RMREGEXP = 0

endfunction
call Cream_conf_override()

