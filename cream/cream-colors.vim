"=
" cream-colors.vim
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
" * This file responsible for setting colors, either directly or by
"   calling other color schemes.
" * We're going to menu the typical Vim color schemes, but source
"   custom (and better coordinated) ones from here. That way we can
"   mandate that everything is better coordinated and complete.

function! Cream_colors_reset()
	" turn on syntax highlighting (formerly cream-behavior.vim)
	" * Must follow menu setup
	syntax enable

	"" set 'background' back to the default.  The value can't always be estimated
	"" and is then guessed.
	"highlight clear Normal
	"set background&

	" Remove all existing highlighting and set the defaults.
	highlight clear

	" guess background (will be adjusted/re-set in individual color schemes)
	if has("gui_running")
		set background=light
	else
		set background=dark
	endif

	" Load the syntax highlighting defaults, if it's enabled.
	if exists("syntax_on")
		syntax reset
	endif
endfunction
call Cream_colors_reset()

function! Cream_colors(...)
" source custom Cream color schemes

	" don't allow color choice in terminal
	if     !has("gui_running")
		let mychoice = "terminal"
	" use argument
	elseif exists("a:1")
		let mychoice = a:1
	" use global variable
	elseif exists("g:CREAM_COLORS")
		let mychoice = g:CREAM_COLORS
	" initialize
	else
		let mychoice = "cream"
	endif

	if     mychoice == "terminal"
		call Cream_source($CREAM . "cream-colors-terminal.vim")
		" if called, change selection, too (otherwise don't change)
		if exists("a:1")
			call Cream_colors_selection("terminal")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif	
	elseif mychoice == "blackwhite"
		call Cream_source($CREAM . "cream-colors-blackwhite.vim")
		" if called, change selection, too (otherwise don't change)
		if exists("a:1")
			call Cream_colors_selection("vim")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif
	elseif mychoice == "chocolateliquor"
		call Cream_source($CREAM . "cream-colors-chocolateliquor.vim")
		" if called, change selection, too (otherwise don't change)
		if exists("a:1")
			call Cream_colors_selection("chocolateliquor")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif
	elseif mychoice == "dawn"
		call Cream_source($CREAM . "cream-colors-dawn.vim")
		" if called, change selection, too (otherwise don't change)
		if exists("a:1")
			call Cream_colors_selection("night")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif
	elseif mychoice == "inkpot"
		call Cream_source($CREAM . "cream-colors-inkpot.vim")
		" if called, change selection, too (otherwise don't change)
		if exists("a:1")
			call Cream_colors_selection("night")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif
	elseif mychoice == "matrix"
		call Cream_source($CREAM . "cream-colors-matrix.vim")
		" we don't offer the selection to others, this scheme only
		"" if called, change selection, too (otherwise don't change)
		"if exists("a:1")
		"    call Cream_colors_selection("matrix")
		"elseif exists("g:CREAM_COLORS_SEL")
		"    call Cream_colors_selection(g:CREAM_COLORS_SEL)
		"endif
	elseif mychoice == "night"
		call Cream_source($CREAM . "cream-colors-night.vim")
		" if called, change selection, too (otherwise don't change)
		if exists("a:1")
			call Cream_colors_selection("night")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif
	elseif mychoice == "navajo"
		call Cream_source($CREAM . "cream-colors-navajo.vim")
		" if called, change selection, too (otherwise don't change)
		if exists("a:1")
			call Cream_colors_selection("navajo")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif
	elseif mychoice == "navajo-night"
		call Cream_source($CREAM . "cream-colors-navajo-night.vim")
		" if called, change selection, too (otherwise don't change)
		if exists("a:1")
			call Cream_colors_selection("navajo-night")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif
	elseif mychoice == "oceandeep"
		call Cream_source($CREAM . "cream-colors-oceandeep.vim")
		" if called, change selection, too (otherwise don't change)
		if exists("a:1")
			call Cream_colors_selection("oceandeep")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif
	elseif mychoice == "zenburn"
		call Cream_source($CREAM . "cream-colors-zenburn.vim")
		" if called, change selection, too (otherwise don't change)
		if exists("a:1")
			call Cream_colors_selection("zenburn")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif
	else
		let mychoice = "cream"
		call Cream_source($CREAM . "cream-colors-default.vim")
		" if called, change selection, too
		if exists("a:1")
			call Cream_colors_selection("reverseblack")
		elseif exists("g:CREAM_COLORS_SEL")
			call Cream_colors_selection(g:CREAM_COLORS_SEL)
		endif
	endif

	let g:CREAM_COLORS = mychoice

	call Cream_menu_settings_preferences()

endfunction

function! Cream_colors_selection(...)
" * Changes the highlighting scheme for selections.
" * Pass the selection theme name to change
" * Retains final setting via global sessions variable.

	if exists("a:1")
		let mychoice = a:1
	elseif exists("g:CREAM_COLORS_SEL")
		let mychoice = g:CREAM_COLORS_SEL
	else
		let mychoice = "reverseblack"
	endif

" From gui_w48.c
"                       Color       Inverse
" "Black",			RGB(000000)     (ffffff)
" "DarkGray",		RGB(808080)     (7f7f7f)
" "Gray",			RGB(c0c0c0)     (3f3f3f)
" "LightGray",		RGB(e0e0e0)     (1f1f1f)
" "White",			RGB(ffffff)     (000000)
" "DarkRed",		RGB(800000)     (7fffff)
" "Red",			RGB(ff0000)     (00ffff)
" "LightRed",		RGB(ffa0a0)     (005f5f)
" "DarkBlue",		RGB(000080)     (ffff7f)
" "Blue",			RGB(0000ff)     (ffff00)
" "LightBlue",		RGB(a0a0ff)     (5f5f00)
" "DarkGreen",		RGB(008000)     (ff7fff)
" "Green",			RGB(00ff00)     (ff00ff)
" "LightGreen",		RGB(a0ffa0)     (5f005f)
" "DarkCyan",		RGB(008080)     (ff7f7f)
" "Cyan",			RGB(00ffff)     (ff0000)
" "LightCyan",		RGB(a0ffff)     (5f0000)
" "DarkMagenta",	RGB(800080)     (7fff7f)
" "Magenta",		RGB(ff00ff)     (00ff00)
" "LightMagenta",	RGB(ffa0ff)     (005f00)
" "Brown",			RGB(804040)     (7fbfbf)
" "Yellow",			RGB(ffff00)     (0000ff)
" "LightYellow",	RGB(ffffa0)     (00005f)
" "DarkYellow",		RGB(bbbb00)     (4444ff)
" "SeaGreen",		RGB(2e8b57)     (d174a8)
" "Orange",			RGB(ffa500)     (005aff)
" "Purple",			RGB(a020f0)     (5fdf0f)
" "SlateBlue",		RGB(6a5acd)     (95a532)
" "Violet",			RGB(ee82ee)     (117d11)

	if     mychoice == "reverseblack"
		" (default)
		" reverse white chars on black
		highlight Visual   gui=bold  guibg=#000000  guifg=White  cterm=NONE ctermfg=White ctermbg=Black
	elseif mychoice == "reverseblue"
		" reverse white chars on blue
		highlight Visual   gui=bold  guifg=#ffffff  guibg=#000080 cterm=NONE ctermfg=White ctermbg=DarkBlue
	elseif mychoice == "terminal"
		" (default)
		" reverse white chars on blue
		highlight Visual   gui=none  guifg=#000000  guibg=#cccccc cterm=NONE ctermfg=DarkBlue ctermbg=White
	elseif mychoice == "vim"
		" Vim grey
		highlight Visual   gui=bold  guifg=#000000  guibg=#c0c0c0
	elseif mychoice == "chocolateliquor"
		" white on black
		highlight Visual   gui=bold  guifg=#1f0f0f  guibg=#998866
	elseif mychoice == "navajo"
		" reverse white chars on soft blue
		highlight Visual   gui=bold  guifg=#ffffff  guibg=#553388
	elseif mychoice == "navajo-night"
		" reverse white chars on soft blue
		highlight Visual   gui=bold  guifg=#000000  guibg=#aacc77
	elseif mychoice == "night"
		" soft blue
		highlight Visual   gui=bold  guibg=#7070c0  guifg=#ffffff
	elseif mychoice == "oceandeep"
		" white on sea green
		highlight Visual   gui=bold  guibg=SeaGreen guifg=#ffffff
	elseif mychoice == "zenburn"
		" original
		"highlight Visual   gui=bold  guibg=#233323  guifg=#71d3b4
		highlight Visual   gui=bold  guibg=#000000  guifg=#71d3b4
	elseif mychoice == "cream"
		" my magenta
		highlight Visual   gui=bold  guibg=#ffccff guifg=#000000  cterm=NONE ctermfg=White ctermbg=Magenta

" experimentations
	elseif mychoice == "ltmagenta"
		" ltmagenta
		highlight Visual   gui=NONE    guifg=#000000  guibg=#f0ccff
	elseif mychoice == "dkmagenta"
		" dkmagenta
		highlight Visual   gui=NONE    guifg=#000000  guibg=#ffaaff
	elseif mychoice == "blue"
		" blue
		highlight Visual   gui=NONE    guifg=#000000  guibg=#ddddff
	elseif mychoice == "orange"
		" orange
		highlight Visual   gui=NONE    guifg=#000000  guibg=#ffdd99
	elseif mychoice == "green"
		" green
		highlight Visual   gui=NONE    guifg=#000000  guibg=#eeff99
	elseif mychoice == "gold"
		" gold
		highlight Visual   gui=NONE    guifg=#000000 guibg=#eedd66
	elseif mychoice == "purple"
		" purple
		highlight Visual   gui=NONE    guifg=#000000  guibg=#cc99cc
	elseif mychoice == "wheat"
		" wheat
		highlight Visual   gui=NONE    guifg=#000000 guibg=#eedd99
	endif

	let g:CREAM_COLORS_SEL = mychoice

endfunction

