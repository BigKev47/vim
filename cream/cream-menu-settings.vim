"
" cream-menu-settings.vim
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

function! Cream_menu_settings()
" functionalized so we can toggle texts based on state

	" remove menu and restore
	silent! unmenu &Settings
	silent! unmenu! &Settings

	" status check mark (GTK2)
	if has("gui_gtk2") && &encoding == "utf8" || &encoding == "utf-8"
		" try various chars, verifying they are one char width
		if     strlen(substitute(strtrans(nr2char(0x2713)), ".", "x", "g")) == 1
			let s:on = nr2char(0x2713) . '\ '  " ✓
			let s:off = '\ \ \ '
		elseif strlen(substitute(strtrans(nr2char(0x221a)), ".", "x", "g")) == 1
			let s:on = nr2char(0x221a) . '\ '  " √
			let s:off = '\ \ \ '
		elseif strlen(substitute(strtrans(nr2char(0x2714)), ".", "x", "g")) == 1
			let s:on = nr2char(0x2714) . '\ '  " ✔
			let s:off = '\ \ \ '
		endif
	endif

	" catch all platforms and GTK2 failures
	if !exists("s:on")
		"let s:on = nr2char(215) . '\ '
		let s:on = '*\ '
		let s:off = '\ \ \ '
	endif

	" Main Menu {{{1

	" invisibles
	function! Cream_menu_settings_invisibles()
		if exists("g:LIST") && g:LIST == 1
			silent! execute 'iunmenu &Settings.' . s:off . '&Show/Hide\ Invisibles<Tab>F4'
			silent! execute 'vunmenu &Settings.' . s:off . '&Show/Hide\ Invisibles<Tab>F4'
			execute 'imenu <silent> 60.001 &Settings.' . s:on . '&Show/Hide\ Invisibles<Tab>F4   <C-b>:call Cream_list_toggle("i")<CR>'
			execute 'vmenu <silent> 60.002 &Settings.' . s:on . '&Show/Hide\ Invisibles<Tab>F4   :<C-u>call Cream_list_toggle("v")<CR>'
		elseif exists("g:LIST") && g:LIST == 0
			silent! execute 'iunmenu &Settings.' . s:on . '&Show/Hide\ Invisibles<Tab>F4'
			silent! execute 'vunmenu &Settings.' . s:on . '&Show/Hide\ Invisibles<Tab>F4'
			execute 'imenu <silent> 60.001 &Settings.' . s:off . '&Show/Hide\ Invisibles<Tab>F4   <C-b>:call Cream_list_toggle("i")<CR>'
			execute 'vmenu <silent> 60.002 &Settings.' . s:off . '&Show/Hide\ Invisibles<Tab>F4   :<C-u>call Cream_list_toggle("v")<CR>'
		endif
	endfunction

	" line numbers
	function! Cream_menu_settings_linenumbers()
		if exists("g:CREAM_LINENUMBERS") && g:CREAM_LINENUMBERS == 1
			silent! execute 'aunmenu &Settings.' . s:off . 'Line\ &Numbers'
			execute 'anoremenu <silent> 60.003 &Settings.' . s:on . 'Line\ &Numbers   :call Cream_linenumbers_toggle()<CR>'
		elseif exists("g:CREAM_LINENUMBERS") && g:CREAM_LINENUMBERS == 0
			silent! execute 'aunmenu &Settings.' . s:on . 'Line\ &Numbers'
			execute 'anoremenu <silent> 60.003 &Settings.' . s:off . 'Line\ &Numbers   :call Cream_linenumbers_toggle()<CR>'
		endif
	endfunction

	anoremenu <silent> 60.004 &Settings.-Sep004-		<Nul>

	" word wrap
	function! Cream_menu_settings_wordwrap()
		if exists("g:CREAM_WRAP") && g:CREAM_WRAP == 1
			silent! execute 'aunmenu &Settings.' . s:off . '&Word\ Wrap<Tab>Ctrl+W'
			execute 'anoremenu <silent> 60.005 &Settings.' . s:on . '&Word\ Wrap<Tab>Ctrl+W	:call Cream_wrap("i")<CR>'
		elseif exists("g:CREAM_WRAP") && g:CREAM_WRAP == 0
			silent! execute 'aunmenu &Settings.' . s:on . '&Word\ Wrap<Tab>Ctrl+W'
			execute 'anoremenu <silent> 60.005 &Settings.' . s:off . '&Word\ Wrap<Tab>Ctrl+W	:call Cream_wrap("i")<CR>'
		endif
	endfunction

	" auto wrap
	function! Cream_menu_settings_autowrap()
		if exists("g:CREAM_AUTOWRAP") && g:CREAM_AUTOWRAP == 1
			silent! execute 'aunmenu &Settings.' . s:off . 'A&uto\ Wrap<Tab>Ctrl+E'
			execute 'anoremenu <silent> 60.006 &Settings.' . s:on . 'A&uto\ Wrap<Tab>Ctrl+E    :call Cream_autowrap("i")<CR>'
		elseif exists("g:CREAM_AUTOWRAP") && g:CREAM_AUTOWRAP == 0
			silent! execute 'aunmenu &Settings.' . s:on . 'A&uto\ Wrap<Tab>Ctrl+E'
			execute 'anoremenu <silent> 60.006 &Settings.' . s:off . 'A&uto\ Wrap<Tab>Ctrl+E    :call Cream_autowrap("i")<CR>'
		endif
	endfunction

	" wrap width
	anoremenu <silent> 60.007 &Settings.&Set\ Wrap\ Width\.\.\.				:call Cream_autowrap_setwidth()<CR>

	" highlight wrap width
	function! Cream_menu_settings_highlightwrapwidth()
		if exists("b:cream_col_highlight")
			silent! execute 'aunmenu &Settings.' . s:off . '&Highlight\ Wrap\ Width'
			execute 'anoremenu <silent> 60.008 &Settings.' . s:on . '&Highlight\ Wrap\ Width    :call Cream_highlight_columns(g:CREAM_AUTOWRAP_WIDTH)<CR>'
		else
			silent! execute 'aunmenu &Settings.' . s:on . '&Highlight\ Wrap\ Width'
			execute 'anoremenu <silent> 60.008 &Settings.' . s:off . '&Highlight\ Wrap\ Width    :call Cream_highlight_columns(g:CREAM_AUTOWRAP_WIDTH)<CR>'
		endif
	endfunction

	" tabs
	anoremenu <silent> 60.010 &Settings.-Sep010-							<Nul>
	anoremenu <silent> 60.011 &Settings.&Tabstop\ Width\.\.\.				:call Cream_tabstop()<CR>
	anoremenu <silent> 60.012 &Settings.Soft\ Ta&bstop\ Width\.\.\.			:call Cream_softtabstop()<CR>
	" expand tab
	function! Cream_menu_settings_expandtab()
		if exists("g:CREAM_EXPANDTAB") && g:CREAM_EXPANDTAB == 1
			silent! execute 'iunmenu &Settings.' . s:off . 'Tab\ &Expansion<Tab>Ctrl+T'
			silent! execute 'vunmenu &Settings.' . s:off . 'Tab\ &Expansion<Tab>Ctrl+T'
			execute 'imenu <silent> 60.014 &Settings.' . s:on . 'Tab\ &Expansion<Tab>Ctrl+T    <C-b>:call Cream_expandtab_toggle("i")<CR>'
			execute 'vmenu <silent> 60.015 &Settings.' . s:on . 'Tab\ &Expansion<Tab>Ctrl+T    :<C-u>call Cream_expandtab_toggle("v")<CR>'
		elseif exists("g:CREAM_EXPANDTAB") && g:CREAM_EXPANDTAB == 0
			silent! execute 'iunmenu &Settings.' . s:on . 'Tab\ &Expansion<Tab>Ctrl+T'
			silent! execute 'vunmenu &Settings.' . s:on . 'Tab\ &Expansion<Tab>Ctrl+T'
			execute 'imenu <silent> 60.014 &Settings.' . s:off . 'Tab\ &Expansion<Tab>Ctrl+T    <C-b>:call Cream_expandtab_toggle("i")<CR>'
			execute 'vmenu <silent> 60.015 &Settings.' . s:off . 'Tab\ &Expansion<Tab>Ctrl+T    :<C-u>call Cream_expandtab_toggle("v")<CR>'
		endif
	endfunction

	" autoindent
	function! Cream_menu_settings_autoindent()
		if exists("g:CREAM_AUTOINDENT") && g:CREAM_AUTOINDENT == 1
			silent! execute 'aunmenu &Settings.' . s:off . '&Auto-indent'
			execute 'anoremenu <silent> 60.016 &Settings.' . s:on . '&Auto-indent    :call Cream_autoindent_toggle()<CR>'
		elseif exists("g:CREAM_AUTOINDENT") && g:CREAM_AUTOINDENT == 0
			silent! execute 'aunmenu &Settings.' . s:on . '&Auto-indent'
			execute 'anoremenu <silent> 60.016 &Settings.' . s:off . '&Auto-indent    :call Cream_autoindent_toggle()<CR>'
		endif
	endfunction

	anoremenu <silent> 60.020 &Settings.-Sep020-							<Nul>

	" highlight find
	function! Cream_menu_settings_highlightsearch()
		if exists("g:CREAM_SEARCH_HIGHLIGHT") && g:CREAM_SEARCH_HIGHLIGHT == 1
			silent! execute 'aunmenu &Settings.' . s:off . 'Highlight\ Find'
			execute 'anoremenu <silent> 60.021 &Settings.' . s:on . 'Highlight\ Find    :call Cream_search_highlight_toggle()<CR>'
		elseif exists("g:CREAM_SEARCH_HIGHLIGHT") && g:CREAM_SEARCH_HIGHLIGHT == 0
			silent! execute 'aunmenu &Settings.' . s:on . 'Highlight\ Find'
			execute 'anoremenu <silent> 60.021 &Settings.' . s:off . 'Highlight\ Find    :call Cream_search_highlight_toggle()<CR>'
		endif
	endfunction
	" clear find
	    imenu <silent> 60.022 &Settings.Highlight\ Find\ &Clear   <C-b>:nohlsearch<CR>
	    vmenu <silent> 60.022 &Settings.Highlight\ Find\ &Clear   :<C-u>nohlsearch<CR>

	anoremenu <silent> 60.024 &Settings.-Sep024-							<Nul>

	" highlight current line
	function! Cream_menu_settings_highlightcurrentline()
		if exists("g:CREAM_HIGHLIGHT_CURRENTLINE")
			silent! execute 'aunmenu &Settings.' . s:off . 'Highlight\ Current\ Line'
			execute 'anoremenu <silent> 60.025 &Settings.' . s:on . 'Highlight\ Current\ Line   :call Cream_highlight_currentline_toggle()<CR>'
		else
			silent! execute 'aunmenu &Settings.' . s:on . 'Highlight\ Current\ Line'
			execute 'anoremenu <silent> 60.025 &Settings.' . s:off . 'Highlight\ Current\ Line   :call Cream_highlight_currentline_toggle()<CR>'
		endif
	endfunction

	" syntax menu
	function! Cream_menu_settings_syntax()
		if exists("g:CREAM_SYNTAX") && g:CREAM_SYNTAX == 1
			silent! execute 'iunmenu &Settings.' . s:off . 'Syntax\ Highlighting'
			silent! execute 'vunmenu &Settings.' . s:off . 'Syntax\ Highlighting'
			execute 'imenu <silent> 60.030 &Settings.' . s:on . 'Syntax\ Highlighting    <C-b>:call Cream_syntax_toggle("i")<CR>'
			execute 'vmenu <silent> 60.030 &Settings.' . s:on . 'Syntax\ Highlighting    :<C-u>call Cream_syntax_toggle("v")<CR>'
		elseif exists("g:CREAM_SYNTAX") && g:CREAM_SYNTAX == 0
			silent! execute 'iunmenu &Settings.' . s:on . 'Syntax\ Highlighting'
			silent! execute 'vunmenu &Settings.' . s:on . 'Syntax\ Highlighting'
			execute 'imenu <silent> 60.030 &Settings.' . s:off . 'Syntax\ Highlighting    <C-b>:call Cream_syntax_toggle("i")<CR>'
			execute 'vmenu <silent> 60.030 &Settings.' . s:off . 'Syntax\ Highlighting    :<C-u>call Cream_syntax_toggle("v")<CR>'
		endif
	endfunction

	" Filetypes {{{1

	"""function! Cream_menu_settings_filetypes()
	"""" *** called via VimEnter command on startup, so filetypes_list() is available ***
	"""" "menu-izes" the aviable filetypes
	"""
	"""    let idx = 200
	"""    execute "anoremenu \<silent> 60." . idx . " &Settings.-Sep200-  \<Nul>"
	"""    let idx = idx + 1
	"""
	"""    let myfiletypes = Cream_vim_syntax_list() . "\n"
	"""    "let myfiletypes = Cream_get_filetypes() . "\n"
	"""    " use destructive process, multvals too slow
	"""    let i = 0	" itteration index
	"""    while myfiletypes != ""
	"""        let pos = stridx(myfiletypes, "\n")
	"""        let myitem = strpart(myfiletypes, 0, pos)
	"""        let myfiletypes = strpart(myfiletypes, pos + 1)
	"""
	"""        let letters = "[" . toupper(myitem[0]) . "]"
	"""
	"""        let command = "anoremenu \<silent> 60." . (i + idx) . " &Settings.&Filetype." . letters . "." . myitem . "  :call Cream_filetype(\"" . myitem . "\")\<CR>"
	"""
	"""        execute command
	"""
	"""        let i = i + 1
	"""    endwhile
	"""
	"""endfunction

	" TODO: Experimentation with caching filetype menu and loading it
	" only when the user requests it.
	anoremenu <silent> 60.100 &Settings.-Sep100-  <Nul>

	function! Cream_menu_filetypes_init()
	" Initialize Filetypes submenu if cache exists.
		let myfile = g:cream_user . "menu-filetype.vim"
		" load if exists
		if filereadable(myfile)
			call Cream_source(myfile)
			anoremenu <silent> 60.101 &Settings.&Filetype.-Sep101-  <Nul>
			anoremenu <silent> 60.102 &Settings.&Filetype.Re-fresh\ Available\ Filetypes\.\.\.  :call Cream_menu_filetypes("refresh")<CR>
		else
			anoremenu <silent> 60.101 &Settings.&Filetype.Menu\ the\ Available\ Filetypes\.\.\.  :call Cream_menu_filetypes()<CR>
		endif
	endfunction
	call Cream_menu_filetypes_init()

	function! Cream_menu_filetypes(...)
	" Filetype submenu when user requests, either initially or to re-fresh.
	"
	" Notes:
	" o Called via VimEnter command on startup, so filetypes_list() is
	"   available! (We parse autocmds.)
	" o This submenu optimized for speed. Parsing each
	"   time is slow, so we cache it in g:cream_user / menu-filetype.vim.
	"   The function below creates the cache if it doesn't exist and then
	"   loads the menu from it.

		let myfile = g:cream_user . "menu-filetype.vim"

		" reasons to re-cache
		" 1. arg is "refresh"
		if a:0 > 0 && a:1 == "refresh"
			let flag = 1
		endif
		" 2. every 10 times used
		let mytime = localtime()
		if mytime[9] == "9"
			let flag = 1
		endif
		" delete cache
		if exists("flag")
			call delete(myfile)
		endif

		" cache if doesn't exist
		if !filereadable(myfile)
			call Cream_menu_filetypes_cache()
		endif
		" remove any existing submenu
		silent! unmenu &Settings.&Filetype
		silent! unmenu! &Settings.&Filetype
		" load
		anoremenu <silent> 60.105 &Settings.&Filetype.-Sep105-  <Nul>
		anoremenu <silent> 60.106 &Settings.&Filetype.Re-fresh\ Available\ Filetypes\.\.\.  :call Cream_menu_filetypes("refresh")<CR>
		call Cream_source(myfile)

	endfunction

	function! Cream_menu_filetypes_cache()
	" Re/creates filetype menu cache, overwriting any existing.

		let @x = ""
		let i = 0
		let idx = 110
		let myfts = Cream_vim_syntax_list() . "\n"
		" use destructive process, multvals too slow
		while myfts != ""
			let pos = stridx(myfts, "\n")
			let myitem = strpart(myfts, 0, pos)
			let myfts = strpart(myfts, pos + 1)

			let letters = "[" . toupper(myitem[0]) . "]"
			let @x = @x . "anoremenu \<silent> 60." . (i + idx) . " &Settings.&Filetype." . letters . "." . myitem . '  :call Cream_filetype("' . myitem . '")<CR>' . "\n"

			let i = i + 1
		endwhile

		" TODO: Fix windowing mistakes inherant in this...

		" mark place
		let mypos = Cream_pos()

		" TODO: use Vim7 to write var to file.
		" open temp buffer
		silent! enew
		silent! put x
		" save as
		silent! execute "silent! write! " . g:cream_user . "menu-filetype.vim"
		" close buffer
		silent! bwipeout!

		" return
		execute mypos

		call confirm(
		\ "Settings > Filetype menu filled.\n" .
		\ "\n", "&Ok", 1, "Info")

	endfunction

	" Preferences {{{1
	anoremenu <silent> 60.600 &Settings.-Sep600-		<Nul>

	function! Cream_menu_settings_preferences()

		" remove menu and restore
		silent! unmenu &Settings.P&references
		silent! unmenu! &Settings.P&references


		if has("gui")
		anoremenu <silent> 60.601 &Settings.P&references.Font\.\.\.	    	:call Cream_font_set()<CR>
		endif

		" toolbar
		if exists("g:CREAM_TOOLBAR") && g:CREAM_TOOLBAR == 1
			execute 'anoremenu <silent> 60.602 &Settings.P&references.' . s:on . 'Toolbar    :call Cream_toolbar_toggle()<CR>'
		else
			execute 'anoremenu <silent> 60.602 &Settings.P&references.' . s:off . 'Toolbar    :call Cream_toolbar_toggle()<CR>'
		endif

		" statusline
		if exists("g:CREAM_STATUSLINE") && g:CREAM_STATUSLINE == 1
			execute 'anoremenu <silent> 60.604 &Settings.P&references.' . s:on . 'Statusline    :call Cream_statusline_toggle()<CR>'
		else
			execute 'anoremenu <silent> 60.604 &Settings.P&references.' . s:off . 'Statusline    :call Cream_statusline_toggle()<CR>'
		endif

		" tabpages
		if exists("g:CREAM_TABPAGES") && g:CREAM_TABPAGES == 1
			execute 'anoremenu <silent> 60.606 &Settings.P&references.' . s:on . 'Tabbed\ Documents    :call Cream_tabpages_toggle()<CR>'
		else
			execute 'anoremenu <silent> 60.606 &Settings.P&references.' . s:off . 'Tabbed\ Documents    :call Cream_tabpages_toggle()<CR>'
		endif


		" Preferences, Color {{{2

		if has("gui")

			if exists("g:cream_dev")

				" color themes, selection
				anoremenu <silent> 60.610 &Settings.P&references.-Sep610-								<Nul>
				anoremenu <silent> 60.611 &Settings.P&references.&Color\ Themes.Selection.Reverse\ Black\ (default)	:call Cream_colors_selection("reverseblack")<CR>
				anoremenu <silent> 60.612 &Settings.P&references.&Color\ Themes.Selection.Reverse\ Blue	:call Cream_colors_selection("reverseblue")<CR>
				anoremenu <silent> 60.613 &Settings.P&references.&Color\ Themes.Selection.Terminal		:call Cream_colors_selection("terminal")<CR>
				anoremenu <silent> 60.614 &Settings.P&references.&Color\ Themes.Selection.Navajo		:call Cream_colors_selection("navajo")<CR>
				anoremenu <silent> 60.615 &Settings.P&references.&Color\ Themes.Selection.Navajo-Night	:call Cream_colors_selection("navajo-night")<CR>
				anoremenu <silent> 60.616 &Settings.P&references.&Color\ Themes.Selection.Night			:call Cream_colors_selection("night")<CR>
				anoremenu <silent> 60.617 &Settings.P&references.&Color\ Themes.Selection.Vim			:call Cream_colors_selection("vim")<CR>
				anoremenu <silent> 60.618 &Settings.P&references.&Color\ Themes.Selection.Magenta		:call Cream_colors_selection("magenta")<CR>

				" experimental
				anoremenu <silent> 60.620 &Settings.P&references.&Color\ Themes.Selection.-Sep620-		<Nul>
				anoremenu <silent> 60.621 &Settings.P&references.&Color\ Themes.Selection.(experimental\ below)	<Nul>
				anoremenu <silent> 60.622 &Settings.P&references.&Color\ Themes.Selection.-Sep622-		<Nul>
				anoremenu <silent> 60.623 &Settings.P&references.&Color\ Themes.Selection.Lt\.\ Magenta	:call Cream_colors_selection("ltmagenta")<CR>
				anoremenu <silent> 60.624 &Settings.P&references.&Color\ Themes.Selection.Dk\.\ Magenta	:call Cream_colors_selection("dkmagenta")<CR>
				anoremenu <silent> 60.625 &Settings.P&references.&Color\ Themes.Selection.Magenta		:call Cream_colors_selection("magenta")<CR>
				anoremenu <silent> 60.626 &Settings.P&references.&Color\ Themes.Selection.Blue			:call Cream_colors_selection("blue")<CR>
				anoremenu <silent> 60.627 &Settings.P&references.&Color\ Themes.Selection.Orange		:call Cream_colors_selection("orange")<CR>
				anoremenu <silent> 60.628 &Settings.P&references.&Color\ Themes.Selection.Green			:call Cream_colors_selection("green")<CR>
				anoremenu <silent> 60.629 &Settings.P&references.&Color\ Themes.Selection.Gold			:call Cream_colors_selection("gold")<CR>
				anoremenu <silent> 60.630 &Settings.P&references.&Color\ Themes.Selection.Purple		:call Cream_colors_selection("purple")<CR>
				anoremenu <silent> 60.631 &Settings.P&references.&Color\ Themes.Selection.Wheat			:call Cream_colors_selection("wheat")<CR>
				anoremenu <silent> 60.632 &Settings.P&references.&Color\ Themes.-Sep632-				<Nul>

			endif

			" color schemes (Cream)
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "cream"
				execute 'anoremenu <silent> 60.633 &Settings.P&references.&Color\ Themes.' . s:on . 'Cream\ (default)    :call Cream_colors("cream")<CR>'
			else
				execute 'anoremenu <silent> 60.633 &Settings.P&references.&Color\ Themes.' . s:off . 'Cream\ (default)    :call Cream_colors("cream")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "blackwhite"
				execute 'anoremenu <silent> 60.634 &Settings.P&references.&Color\ Themes.' . s:on . 'Black\ and\ White    :call Cream_colors("blackwhite")<CR>'
			else
				execute 'anoremenu <silent> 60.634 &Settings.P&references.&Color\ Themes.' . s:off . 'Black\ and\ White    :call Cream_colors("blackwhite")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "chocolateliquor"
				execute 'anoremenu <silent> 60.635 &Settings.P&references.&Color\ Themes.' . s:on . 'Chocolate\ Liquor    :call Cream_colors("chocolateliquor")<CR>'
			else
				execute 'anoremenu <silent> 60.635 &Settings.P&references.&Color\ Themes.' . s:off . 'Chocolate\ Liquor    :call Cream_colors("chocolateliquor")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "dawn"
				execute 'anoremenu <silent> 60.636 &Settings.P&references.&Color\ Themes.' . s:on . 'Dawn    :call Cream_colors("dawn")<CR>'
			else
				execute 'anoremenu <silent> 60.636 &Settings.P&references.&Color\ Themes.' . s:off . 'Dawn    :call Cream_colors("dawn")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "inkpot"
				execute 'anoremenu <silent> 60.637 &Settings.P&references.&Color\ Themes.' . s:on . 'Inkpot    :call Cream_colors("inkpot")<CR>'
			else
				execute 'anoremenu <silent> 60.637 &Settings.P&references.&Color\ Themes.' . s:off . 'Inkpot    :call Cream_colors("inkpot")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "matrix"
				execute 'anoremenu <silent> 60.638 &Settings.P&references.&Color\ Themes.' . s:on . 'Matrix    :call Cream_colors("matrix")<CR>'
			else
				execute 'anoremenu <silent> 60.638 &Settings.P&references.&Color\ Themes.' . s:off . 'Matrix    :call Cream_colors("matrix")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "navajo"
				execute 'anoremenu <silent> 60.639 &Settings.P&references.&Color\ Themes.' . s:on . 'Navajo    :call Cream_colors("navajo")<CR>'
			else
				execute 'anoremenu <silent> 60.639 &Settings.P&references.&Color\ Themes.' . s:off . 'Navajo    :call Cream_colors("navajo")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "navajo-night"
				execute 'anoremenu <silent> 60.640 &Settings.P&references.&Color\ Themes.' . s:on . 'Navajo-Night    :call Cream_colors("navajo-night")<CR>'
			else
				execute 'anoremenu <silent> 60.640 &Settings.P&references.&Color\ Themes.' . s:off . 'Navajo-Night    :call Cream_colors("navajo-night")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "night"
				execute 'anoremenu <silent> 60.641 &Settings.P&references.&Color\ Themes.' . s:on . 'Night    :call Cream_colors("night")<CR>'
			else
				execute 'anoremenu <silent> 60.641 &Settings.P&references.&Color\ Themes.' . s:off . 'Night    :call Cream_colors("night")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "oceandeep"
				execute 'anoremenu <silent> 60.642 &Settings.P&references.&Color\ Themes.' . s:on . 'Ocean\ Deep    :call Cream_colors("oceandeep")<CR>'
			else
				execute 'anoremenu <silent> 60.642 &Settings.P&references.&Color\ Themes.' . s:off . 'Ocean\ Deep    :call Cream_colors("oceandeep")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "terminal"
				execute 'anoremenu <silent> 60.643 &Settings.P&references.&Color\ Themes.' . s:on . 'Terminal\ (reverse)    :call Cream_colors("terminal")<CR>'
			else
				execute 'anoremenu <silent> 60.643 &Settings.P&references.&Color\ Themes.' . s:off . 'Terminal\ (reverse)    :call Cream_colors("terminal")<CR>'
			endif
			if exists("g:CREAM_COLORS") && g:CREAM_COLORS == "zenburn"
				execute 'anoremenu <silent> 60.644 &Settings.P&references.&Color\ Themes.' . s:on . 'Zenburn    :call Cream_colors("zenburn")<CR>'
			else
				execute 'anoremenu <silent> 60.644 &Settings.P&references.&Color\ Themes.' . s:off . 'Zenburn    :call Cream_colors("zenburn")<CR>'
			endif


			function! Cream_menu_colors()
			" color schemes (Vim's only! Ours are specifically "menu-ized" ;)
			" * This function is called via VimEnter autocmd so multvals is available.

				" this should be dev-only!
				if !exists("g:cream_dev")
					return
				else
					anoremenu <silent> 60.650 &Settings.P&references.&Color\ Themes.-Sep650-				<Nul>
					"anoremenu <silent> 60.651 &Settings.P&references.&Color\ Themes.gVim\ themes\ (non-Cream):	<Nul>
				endif

				let mycolors = globpath(&runtimepath, "colors/*.vim")
				if strlen(mycolors) > 0
					let mycolors = mycolors . "\n"
				endif

				" menu each item
				let idx = 652
				let i = 0
				while i < MvNumberOfElements(mycolors, "\n")

					let mycolor = MvElementAt(mycolors, "\n", i)

					" name doesn't have path
					let mycolor = substitute(mycolor, '.*[/\\:]\([^/\\:]*\)\.vim', '\1', '')
					execute "anoremenu <silent> 60." . idx . ' &Settings.P&references.&Color\ Themes.gVim\ themes\ (non-Cream).' . mycolor . " :colors " . mycolor . "\<CR>"

					let i = i + 1
				endwhile

			endfunction
			"" load on re-sets, not startup (multvals isn't avialable)
			"call Cream_menu_colors()

		endif
		" 2}}}

		anoremenu <silent> 60.700 &Settings.P&references.-Sep700-		<Nul>
		
		" last file restore
		if !exists("g:CREAM_LAST_BUFFER_FORGET")
			"silent! execute 'aunmenu &Settings.P&references.' . s:off . 'Last\ File\ Restore'
			execute 'anoremenu <silent> 60.701 &Settings.P&references.' . s:on . 'Last\ File\ Restore    :call Cream_last_buffer_toggle()<CR>'
		else
			"silent! execute 'aunmenu &Settings.P&references.' . s:on . 'Last\ File\ Restore'
			execute 'anoremenu <silent> 60.701 &Settings.P&references.' . s:off . 'Last\ File\ Restore    :call Cream_last_buffer_toggle()<CR>'
		endif


        "if exists("g:CREAM_SINGLESERVER") && g:CREAM_SINGLESERVER == 1
        "    execute 'anoremenu <silent> 60.702 &Settings.P&references.' . s:on . '&Single-Session\ Mode    :call Cream_singleserver_toggle()<CR>'
        "else
        "    execute 'anoremenu <silent> 60.702 &Settings.P&references.' . s:off . '&Single-Session\ Mode    :call Cream_singleserver_toggle()<CR>'
        "endif

		if exists("g:CREAM_WINPOS") && g:CREAM_WINPOS == 1
			execute 'anoremenu <silent> 60.703 &Settings.P&references.' . s:on . 'Remember\ Window\ Position    :call Cream_winpos_toggle()<CR>'
		else
			execute 'anoremenu <silent> 60.703 &Settings.P&references.' . s:off . 'Remember\ Window\ Position    :call Cream_winpos_toggle()<CR>'
		endif

		if exists("g:CREAM_MOUSE_XSTYLE") && g:CREAM_MOUSE_XSTYLE == 1
			execute 'anoremenu <silent> 60.704 &Settings.P&references.' . s:on . '&Middle-Mouse\ Pastes    :call Cream_mouse_middle_toggle()<CR>'
		else
			execute 'anoremenu <silent> 60.704 &Settings.P&references.' . s:off . '&Middle-Mouse\ Pastes    :call Cream_mouse_middle_toggle()<CR>'
		endif

		if exists("g:CREAM_BRACKETMATCH") && g:CREAM_BRACKETMATCH == 1
			execute 'anoremenu <silent> 60.705 &Settings.P&references.' . s:on . 'Bracket\ Flashing    :call Cream_bracketmatch_toggle()<CR>'
		else
			execute 'anoremenu <silent> 60.705 &Settings.P&references.' . s:off . 'Bracket\ Flashing    :call Cream_bracketmatch_toggle()<CR>'
		endif

		anoremenu <silent> 60.706 &Settings.P&references.-Sep706-		<Nul>
		anoremenu <silent> 60.707 &Settings.P&references.Info\ Pop\ Options\.\.\.		:call Cream_pop_options()<CR>


		" language
		anoremenu <silent> 60.708 &Settings.P&references.-Sep708-	<Nul>
		anoremenu <silent> 60.709 &Settings.P&references.Language\.\.\.\ (Future)			<Nop>


		" Keymap {{{2

		if has("keymap")

			" get vim's list
			let maps = Cream_getfilelist($VIMRUNTIME . "/keymap/*.vim")
			if maps != ""

				" none
				if exists("g:CREAM_KEYMAP") && g:CREAM_KEYMAP == ""
					execute 'anoremenu <silent> 60.799 &Settings.P&references.&Keymap.' . s:on . 'None :call Cream_keymap("")<CR>'
				else
					execute 'anoremenu <silent> 60.799 &Settings.P&references.&Keymap.' . s:off . 'None :call Cream_keymap("")<CR>'
				endif

				" other
				let cnt = MvNumberOfElements(maps, "\n")
				let i = 0
				while i < cnt
					let mapp = MvElementAt(maps, "\n", i)
					let mapp = matchstr(mapp, 'keymap/\zs.*\ze\.vim')
					" cat string
					let idx = i
					while strlen(idx) < 2
						let idx = "0" . idx
					endwhile
					if exists("g:CREAM_KEYMAP") && g:CREAM_KEYMAP == mapp
						" if this map is active
						execute 'anoremenu <silent> 60.8' . idx . ' &Settings.P&references.&Keymap.' . s:on . mapp . ' :call Cream_keymap("' . mapp . '")<CR>'
					else
						" if this map isn't
						execute 'anoremenu <silent> 60.8' . idx . ' &Settings.P&references.&Keymap.' . s:off . mapp . ' :call Cream_keymap("' . mapp . '")<CR>'
					endif
					let i = i + 1
				endwhile

			endif

		endif

		" 2}}}

		anoremenu <silent> 60.900 &Settings.P&references.-Sep900-	<Nul>

		" Expert mode
		if exists("g:CREAM_EXPERTMODE") && g:CREAM_EXPERTMODE == 1
			execute 'anoremenu <silent> 60.901 &Settings.P&references.' . s:on . '&Expert\ Mode\.\.\.    :call Cream_expertmode_toggle()<CR>'
		else
			execute 'anoremenu <silent> 60.901 &Settings.P&references.' . s:off . '&Expert\ Mode\.\.\.    :call Cream_expertmode_toggle()<CR>'
		endif

		" Behavior
		anoremenu <silent> 60.902 &Settings.P&references.&Behavior.&Cream\ (default)	:call Cream_behave_cream()<CR>
		anoremenu <silent> 60.903 &Settings.P&references.&Behavior.&Cream\ Lite\.\.\.	:call Cream_behave_creamlite()<CR>
		anoremenu <silent> 60.904 &Settings.P&references.&Behavior.&Vim\.\.\.			:call Cream_behave_vim()<CR>
		anoremenu <silent> 60.905 &Settings.P&references.&Behavior.&Vi\.\.\.			:call Cream_behave_vi()<CR>

	endfunction


endfunction
call Cream_menu_settings()

" 1}}}
" vim:foldmethod=marker
