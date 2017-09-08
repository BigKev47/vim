"=
" cream-addon.vim
"
" Cream -- An easy-to-use configuration of the famous Vim text  editor
" [ http://cream.sourceforge.net ] Copyright (C) 2001-2011 Steve Hall
"
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 2 of  the  License,  or
" (at your option) any later version.
" [ http://www.gnu.org/licenses/gpl.html ]
"
" This program is distributed in the hope that it will be useful,  but
" WITHOUT  ANY  WARRANTY;  without  even  the  implied   warranty   of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR  PURPOSE.  See  the  GNU
" General Public License for more details.
"
" You should have received a copy of the GNU  General  Public  License
" along with  this  program;  if  not,  write  to  the  Free  Software
" Foundation,  Inc.,  59  Temple  Place  -  Suite  330,   Boston,   MA
" 02111-1307, USA.
"

" README {{{1
" Description:
"
" A Cream add-on is simply a Vim script written to add functionality
" not provided in the standard Cream distribution. Through these
" add-ons, a wide range of functionality can be made available to the
" user through both menus and key mappings.
"
" o See Cream_addon_list() for how to register an add-on.
"
" o Automatically loaded from the cream/addons/ subdirectory.
"
" o Placed into a submenu in the Tools menu.
"
" o Each add-on must provide a single functionality in the form of
"   a function call made through either the menu or the optional key
"   mapping if the user opts to map it.
"
" o 6 variations of F12 key are available for the user to map: F12,
"   Shift+F12, Ctl+F12, Alt+F12, Ctrl+Shift+F12 and Alt+Shift+F12.
"   (Ctrl+Alt+F12 unused due to typical GNU/Linux window manager
"   restrictions).
"
" Notes:
"
" o Should we check to ensure there are no duplicate functions?
"
" o This is a pretty simple scheme. Someone with even moderate
"   knowledge of the Vim scripting language can theoretically do most
"   anything with it since we automatically load the script, put it in
"   the menu and execute the call statement. Much the same way Vim
"   plugins are flexible and powerful, so are add-ons.
"
" o Functionality may depend on the available Cream environment. But
"   we suggest you supply your own functions unless you keep us up to
"   speed on what you're depending on.
"
" o Obviously, each function should act as if called from a standing
"   normal mode. You should never use <Esc> within Vim script because
"   it has different implications depending on whether insertmode has
"   been set or not. *Always select your intended mode, never assume
"   a user is in a particular one.*
"
" o It would be trivial to devise a massively intertwined set of
"   libraries with multiple files to create a whole suite of
"   functions. Talk to us if you're so inclined, that's crazy. ;)
"
" o All functions should be script-scoped (s:) except for the one
"   called.
"
" o Developers should use keys intuitively
"
" o Developers can provide extensively more flexibility through dialog
"   choices, not key mappings.
"
" o Some existing Cream tools should probably be here:
"   * Capitalize?
"   * Whitespace handling?
"   * Cream_debug()
"   * Backup
"

" Cream_addon_loadall() {{{1
function! Cream_addon_loadall()

	" Default:
	call s:Cream_addon_loader($CREAM . 'addons/*.vim')
	" User: (only if exist)
	if exists("g:cream_user")
		call s:Cream_addon_loader(g:cream_user . 'addons/*.vim')
	endif

endfunction
function! s:Cream_addon_loader(path)
" load add-ons

	" get file list
	let myaddons = glob(a:path)
	if strlen(myaddons) > 0
		let myaddons = myaddons . "\n"
	else
		" none found, quit
		return
	endif

	" source each item (destroys array in process)
	let i = 0
	let max = MvNumberOfElements(myaddons, "\n")
	while i < max
		let idx = stridx(myaddons, "\n")
		let myaddon = strpart(myaddons, 0, idx)
		call Cream_source(myaddon)
		let myaddons = strpart(myaddons, idx + 1)
		" *** we're not establishing g:cream_addons here! Each add-on
		" loads itself!! ***
		let i = i + 1
	endwhile

endfunction

" Cream_addon_register() {{{1
function! Cream_addon_register(name, tag, summary, menu, icall, ...)
" called by each add-on to register:
"
"   call Cream_addon_list("{name}","{tag}","{summary}","{menu}","{icall}","{vcall}")
"
"   o Name
"   o Tag is a brief one-line, 40-character descripter
"   o Summary should briefly describe usage.
"   o Menu name as it should apear in the menu (no accelerator)
"   o Insert mode function call or execute statement that Cream will
"     run on menu select or key press.
"     * Optional: Use '<Nil>' to eliminate insertmode call/map.
"       Requires valid visual mode call then.
"   o Visual mode (optional) functon call if the function behaves
"     differently from Insert and Visual modes. If not provided,
"     no visual call is made available. '<Nil>' also excepted.
"
"   This call loads the array into a global structure of add-ons, and
"   also manages and retains the user-defined key mappings.
"

	" visual call specified
	if a:0 == 1
		let myvcall = a:1
	else
		let myvcall = '<Nil>'
	endif

	" validate
	" cannot have empty values
	if     a:name == ""
		call confirm(
			\ "Error: Required \"name\" missing to list add-on--not loaded.\n" .
			\ "\n", "&Ok", 1, "Info")
		return -1
	elseif a:tag     == ""
		call confirm(
			\ "Error: Required parameter \"tag\" missing to list add-on \"" . a:name . "\"--not loaded.\n" .
			\ "\n", "&Ok", 1, "Info")
		return -1
	elseif a:summary == ""
		call confirm(
			\ "Error: Required parameter \"summary\" missing to list add-on \"" . a:name . "\"--not loaded.\n" .
			\ "\n", "&Ok", 1, "Info")
		return -1
	elseif a:menu    == ""
		call confirm(
			\ "Error: Required parameter \"menu\" missing to list add-on \"" . a:name . "\"--not loaded.\n" .
			\ "\n", "&Ok", 1, "Info")
		return -1
	elseif a:icall   == ""
		call confirm(
			\ "Error: Required parameter \"icall\" missing to list add-on \"" . a:name . "\"--not loaded.\n" .
			\ "\n", "&Ok", 1, "Info")
		return -1
	endif

	"----------------------------------------------------------------------
	" escape dis-allowed characters
	" (nah, let them eat cake for now)

	"" validate
	"let myname = substitute(a:name, "[\n\t\r]", '', 'g')
	"let mytag  = substitute(a:tag,  "[\n\t\r]", '', 'g')

	"let mysummary = a:summary
	""let mysummary = substitute(mysummary,  "[\r]", "\n", 'g')
	""let mysummary = substitute(mysummary,  "\\[!nt]", "\\\\", 'g')

	"" escape
	"let mysummary = substitute(mysummary, '\\', '\\\\', 'g')

	"" un-escape desired escapes
	"" * Anything not recovered here is escaped forever ;)
	"let mysummary = substitute(mysummary, '\\\\n', '\\n', 'g')
	"let mysummary = substitute(mysummary, '\\\\r', '\\n', 'g')
	"let mysummary = substitute(mysummary, '\\\\t', '\\t', 'g')
	"
	"" escape slashes (thwarts substitute!)
	"let mysummary = substitute(mysummary, '/', '\\/', 'g')
	"----------------------------------------------------------------------

	" compose this add-on's sub-array
	"let myitem = a:name . "\t" . a:tag . "\t" . a:summary . "\t" . a:menu . "\t" . a:icall . "\t" . myvcall . "\t"
	if !exists("g:cream_addons{0}")
		let g:cream_addons{0} = 1
	else
		let g:cream_addons{0} = g:cream_addons{0} + 1
	endif
	let g:cream_addons{g:cream_addons{0}}_{1} = a:name
	let g:cream_addons{g:cream_addons{0}}_{2} = a:tag
	let g:cream_addons{g:cream_addons{0}}_{3} = a:summary
	let g:cream_addons{g:cream_addons{0}}_{4} = a:menu
	let g:cream_addons{g:cream_addons{0}}_{5} = a:icall
	let g:cream_addons{g:cream_addons{0}}_{6} = myvcall

endfunction

function! Cream_addon_sort()
	"*** BROKEN: too much memory, crash
	"let g:cream_addons = MvQSortElements(g:cream_addons, '\n', 'CmpAddonMenu', 1)
	"***
endfunction
function! CmpAddonMenu(item1, item2, direction)
" compares menu components of two addon registries

	" get menu item (4th, index 3) of each
	let mymenu1 = MvElementAt(a:item1, "\t", 3) + 0
	let mymenu2 = MvElementAt(a:item2, "\t", 3) + 0

	""*** DEBUG:
	"let n = confirm(
	"    \ "DEBUG:\n" .
	"    \ "  mymenu1   = \"" . mymenu1 . "\"\n" .
	"    \ "  mymenu2   = \"" . mymenu2 . "\"\n" .
	"    \ "\n", "&Ok\n&Cancel", 1, "Info")
	"if n != 1
	"    return
	"endif
	""***

	if     mymenu1 < mymenu2
		return -a:direction
	elseif mymenu1 > mymenu2
		return a:direction
	else
		return 0
	endif
endfunction

function! Cream_addon_menu()

	let i = 0
	while i < g:cream_addons{0}
		let i = i + 1

		let mymenu  = g:cream_addons{i}_{4}
		let myicall = g:cream_addons{i}_{5}
		let myvcall = g:cream_addons{i}_{6}

		"...................................................................
		" menu priority number according to it's name, first two chars:
		"   decimal value of char 1 * 26^3
		" + decimal value of char 2 * 26^2
		" Notes:
		" o This is base26 (26^2 * [1-26] is the largest value we can
		"   fit in Vim's self-imposed 32000 (16-bit) priority menu
		"   limit)
		" o No sorting happens below submenus
		"
		let charcnt = 2
		let menupriority = 1
		" we might destroy the name in prioritizing (e.g., removing
		" ampersands)
		let mymenumunge = mymenu
		let j = 1
		let max = charcnt
		if strlen(mymenumunge) < charcnt
			let max = strlen(mymenumunge)
		endif
		" get each char
		while j <= max

			" get 26 * j
			let power = 1
			let h = charcnt
			let charval = 0
			while h > j
				let power = power * 26
				let h = h - 1
			endwhile

			" validate char (keep removing them till one falls in
			" range)
			let valid = 0
			while valid == 0
				let mycharval = char2nr(mymenumunge[j-1])

				" A-Z
				if     mycharval >= 65
				\ &&   mycharval <= 90
					break
				" period
				elseif mycharval == 46
					break
				" a-z
				elseif mycharval >= 97
				\ &&   mycharval <= 122
					break
				else
					" remove the offending characters
					let mymenumunge = strpart(mymenumunge, 0, j-1) . strpart(mymenumunge, j)
				endif

			endwhile

			" get value
			" Note: we're converting A-Z to 1-26
			if     char2nr(mymenumunge[j-1]) == 32
				" space (highest, makes broken word first)
				let charval = 27
			elseif char2nr(mymenumunge[j-1]) == 46
				" period (quit)
				break
			else
				" else (whatever passed through filter above)
				let charval = (toupper(char2nr(mymenumunge[j-1]))-64)
			endif

			let value = charval * power
			let menupriority = menupriority + value

""*** DEBUG:
"let n = confirm(
"    \ "DEBUG:\n" .
"    \ "  mymenu         = \"" . mymenu . "\"\n" .
"    \ "  mymenumunge    = \"" . mymenumunge . "\"\n" .
"    \ "  i              = \"" . i . "\"\n" .
"    \ "  j              = \"" . j . "\"\n" .
"    \ "  h              = \"" . h . "\"\n" .
"    \ "  mymenumunge[j-1]        = \"" . mymenumunge[j - 1] . "\"\n" .
"    \ "  char2nr(mymenumunge[j - 1])   = \"" . char2nr(mymenumunge[j - 1]) . "\"\n" .
"    \ "  toupper(char2nr(mymenumunge[j -1]))    = \"" . toupper(char2nr(mymenumunge[j - 1])) . "\"\n" .
"    \ "  (toupper(char2nr(mymenumunge[j-1]))-64) = \"" . (toupper(char2nr(mymenumunge[j-1]))-64) . "\"\n" .
"    \ "  charval        = \"" . charval . "\"\n" .
"    \ "  power          = \"" . power . "\"\n" .
"    \ "  value          = \"" . value . "\"\n" .
"    \ "  menupriority   = \"" . menupriority . "\"\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if n != 1
"    return
"endif
""***
			let j = j + 1
		endwhile
		"...................................................................

		" make sure spaces and slashes in name are escaped
		let mymenu = escape(mymenu, ' \')

		" add menus
		" (a:icall cannot be empty, validated above)
		" both '<Nil>', skip
		if     myicall ==? '<Nil>' && myvcall ==? '<Nil>'
			return
		" icall live (vcall dead menu)
		elseif myvcall ==? '<Nil>'
			execute 'imenu <silent> 70.910.' . menupriority . ' &Tools.&Add-ons.' . mymenu . ' <C-b>:' . myicall . '<CR>'
			execute 'vmenu <silent> 70.910.' . menupriority . ' &Tools.&Add-ons.' . mymenu . " :\<C-u>call confirm(\"Option not available with selection.\", \"&Ok\", 1, \"Info\")\<CR>"
		" vcall live (icall dead menu) (could show inactive without selection?)
		elseif myicall ==? '<Nil>'
			execute 'imenu <silent> 70.910.' . menupriority . ' &Tools.&Add-ons.' . mymenu . " \<C-b>:call confirm(\"Option not available without selection.\", \"&Ok\", 1, \"Info\")\<CR>"
			execute 'vmenu <silent> 70.910.' . menupriority . ' &Tools.&Add-ons.' . mymenu . ' :' . myvcall . '<CR>'
		" both live
		else
			execute 'imenu <silent> 70.910.' . menupriority . ' &Tools.&Add-ons.' . mymenu . ' <C-b>:' . myicall . '<CR>'
			" Note: myvcall must be complete mapping. Remember that
			"       a <C-u> should be passed if range is not desired.
			execute 'vmenu <silent> 70.910.' . menupriority . ' &Tools.&Add-ons.' . mymenu . ' :' . myvcall . '<CR>'
		endif
	endwhile

endfunction

" Cream_addon_select() {{{1
function! Cream_addon_select()
" * Compose elements to be posted in s:Cream_addon_map_dialog()

	" condition maximum displayed
	let max = 7
	let addoncount = g:cream_addons{0}
	if addoncount < max
		" if less than max
		let max = addoncount
	endif

	" current item begins in the middle of the height
	let current = max / 2

	" set maximum line length
	let maxline = 70

	" display dialog
	let quit = 0
	while quit == 0

		"----------------------------------------------------------------------
		" compose dialog

		" compose selection and description areas
		let selection = ""
		let description = ""

		" wrap at beginning
		if     current < 0
			let current = addoncount - 1
		" wrap at end
		elseif current > addoncount - 1
			let current = 0
		endif

		"" First Item Displayed Is Half The Diplay Height Before Current
		"let Addon = Current - ( Max / 2 )
		"" Catch Error When Current <= 1/4 Max To List Start
		"if Current <= ( ( Max / 2 ) / 2 )
		"    Let Addon = Addoncount - ( Max / 2 ) + Current
		"endif

		" first item displayed is half the diplay height before current
		let addon = current - ( max / 2 )
		" catch error when current <= 1/4 max to list start
		if addon < 0
			let addon = addon + addoncount
		endif

		" compose each add-on
		let i = 0
		while i < max

			" wrap starting item
			if addon < 0
				let addon = addoncount - 1
			elseif addon > addoncount - 1
				let addon = 0
			endif

			" get specific elements of item
			let myaddonname    = g:cream_addons{addon+1}_{1}
			let myaddontag     = g:cream_addons{addon+1}_{2}
			let myaddonsummary = g:cream_addons{addon+1}_{3}
			"let myaddonmenu    = g:cream_addons{addon+1}_{4}
			"let myaddonicall   = g:cream_addons{addon+1}_{5}
			"let myaddonvcall   = g:cream_addons{addon+1}_{6}

			" truncate name and tag so we fit consistently
			let myname = myaddonname
			if strlen(myname) > 25
				let myname = strpart(myname, 0, 22) . "..."
			endif
			let mytag = myaddontag
			if strlen(myname . mytag) > maxline - 3
				let mytag = strpart(mytag, 0, maxline - strlen(myname)) . "..."
			endif
			" beef each up slightly for nicer margins
			while strlen(myname . mytag) < maxline + 10
				let mytag = mytag . " "
			endwhile
				
			" truncate summary so we fit in the box consistently
			let mysummary = myaddonsummary
			if strlen(mysummary) > maxline * 9
				let mysummary = strpart(mysummary, 0, maxline * 9 - 3) . "..."
			endif
			" insert newlines to paragraph summary
			let remaining = mysummary
			let mynewstr = ""
			while strlen(remaining) > maxline
				" truncate at a space
				let j = 0
				" find space
				while strpart(remaining, maxline - j, 1) != " "
					let j = j + 1
					" hmm... didn't find a space, just slash at maxline
					if j == maxline
						let j = 0
						break
					endif
				endwhile
				" now section there and add newline (add 1 to keep the space outboard)
				let mynewstr = mynewstr . strpart(remaining, 0, maxline - j + 1) . "\n"
				" remaining is from there beyond
				let remaining = strpart(remaining, maxline - j + 1)
			endwhile
			" get remainder
			let mysummary = mynewstr . strpart(remaining, 0) . "\n"
			" make sure each summary has the same number of lines for good looks ;)
			" (this is an abuse of this function, but it works!)
			while MvNumberOfElements(mysummary, "\n") < 4
				let mysummary = mysummary . "\n"
			endwhile

			" add selection indicators for current
			if addon == current
				let selection = selection . ">>  " . myname . " -- " . mytag . "\n"
				" title with current add-on's name
				let description = "Description:  " . myaddonname . "\n" . mysummary
			else
				let selection = selection . "       " . myname . " -- " . mytag . "\n"
			endif

			let addon = addon + 1
			let i = i + 1
		endwhile

		" remove iterations above
		let addon = addon - max

		"----------------------------------------------------------------------
		" post dialog accounting
		let n = s:Cream_addon_map_dialog(selection, description)
		if     n == "prev"
			let current = current - 1
			let addon = addon - 1
			continue
		elseif n == "next"
			let current = current + 1
			let addon = addon + 1
			continue
		elseif n == "map"

			" get map key
			let mykey = s:Cream_addon_getkey()

			" if none selected, drop back to select dialog again
			if mykey == -1
				continue
			endif

			" get mapping sub-elements
			let icall = g:cream_addons{current+1}_{5}
			let vcall = g:cream_addons{current+1}_{6}

			" map
			let n = s:Cream_addon_maps(mykey, icall, vcall)

			" retain across sessions if valid
			if n == 1
				" if key matches, stick into right array position so
				" we never have to sort
				if     mykey == '<F12>'
					let mykeyno = 1
				elseif mykey == '<S-F12>'
					let mykeyno = 2
				elseif mykey == '<C-F12>'
					let mykeyno = 3
				elseif mykey == '<M-F12>'
					let mykeyno = 4
				elseif mykey == '<C-S-F12>'
					let mykeyno = 5
				elseif mykey == '<M-S-F12>'
					let mykeyno = 6
				elseif mykey == '<C-M-F12>'
					let mykeyno = 7
				elseif mykey == '<C-M-S-F12>'
					let mykeyno = 8
				endif
				if exists("mykeyno")
					let g:CREAM_ADDON_MAPS{mykeyno}_{1} = mykey
					let g:CREAM_ADDON_MAPS{mykeyno}_{2} = icall
					let g:CREAM_ADDON_MAPS{mykeyno}_{3} = vcall
					unlet mykeyno
				endif
			endif

		elseif n == "unmap"
			" go to unmap routine
			let quit = Cream_addon_unmap_select()

		elseif n == -1
			" quit
			let quit = 1
		endif
	
	endwhile

	return 1

endfunction

" Cream_addon_map_dialog() {{{1
function! s:Cream_addon_map_dialog(selections, description)
" * Prompt user to select an addon through dialog
" * Return key
"
"   +------------------------------------------------------+
"   |       Item 1 -- Encrypt.                             |
"   |    >  Item 2 -- Color everything green.     <        |
"   |       Item 3 -- Color everything blue.               |
"   |   -----------------------------------------------    |
"   |                                                      |
"   |  Simply select whatever you wish to highlight        |
"   |  green, and press Ok!                                |
"   |                                                      |
"   |                                                      |
"   | +--------+ +--------+ +-------+ +-------+ +--------+ |
"   | |   Up   | |  Down  | |  Map  | | UnMap | | Cancel | |
"   | +--------+ +--------+ +-------+ +-------+ +--------+ |
"   +------------------------------------------------------+

	let sav_go = &guioptions
	set guioptions+=v

	" remember focus
	if !exists("s:focus_map")
		let s:focus_map = 2
	endif

	let key = ""
	let n = confirm(
		\ a:selections . "\n" .
		\ "\----------------------------------------------------------------------------------------------------------------------------          \n" .
		\ a:description . "\n" .
		\ "\n", "&Up\n&Down\n&Map\nU&nMap...\n&Quit", s:focus_map, "Info")
	if     n == 1
		let myreturn = "prev"
		let s:focus_map = 1
	elseif n == 2
		let myreturn = "next"
		let s:focus_map = 2
	elseif n == 3
		let myreturn = "map"
		let s:focus_map = 2
	elseif n == 4
		let myreturn = "unmap"
		let s:focus_map = 2
	else
		let myreturn = -1
		let s:focus_map = 2
	endif

	" restore and return
	let &guioptions = sav_go
	return myreturn

endfunction

" Cream_addon_getkey() {{{1
function! s:Cream_addon_getkey()
" Return requested mapping
"
"   +---------------------------------------------------------------------------------+
"   |                                                                                 |
"   |                 Select key (or combination) to map add-on to...                 |
"   |                                                                                 |
"   |                                                                                 |
"   | ......... ......... ......... ......... .............. ............. .......... |
"   | :  F12  : : +Shft : : +Ctrl : : +Alt  : : +Shft+Ctrl : : +Shft+Alt : : Cancel : |
"   | :.......: :.......: :.......: :.......: :............: :...........: :........: |
"   +---------------------------------------------------------------------------------+
"

	let sav_go = &guioptions
	set guioptions+=v

	let n = confirm(
		\ "Select key (or combination) to map add-on to...\n" .
		\ "\n", "&F12\nShift+F12\nCtrl+F12\nAlt+F12\nCtrl+Shift+F12\nAlt+Shift+F12\nCtrl+Alt+F12\nCtrl+Alt+Shift+F12\n&Cancel", 1, "Info")
	if     n == 1
		let myreturn = '<F12>'
	elseif n == 2
		let myreturn = '<S-F12>'
	elseif n == 3
		let myreturn = '<C-F12>'
	elseif n == 4
		let myreturn = '<M-F12>'
	elseif n == 5
		let myreturn = '<C-S-F12>'
	elseif n == 6
		let myreturn = '<M-S-F12>'
	elseif n == 7
		let myreturn = '<C-M-F12>'
	elseif n == 8
		let myreturn = '<C-M-S-F12>'
	else
		let myreturn = -1
	endif

	" restore and return
	let &guioptions = sav_go
	return myreturn

endfunction

" Cream_addon_unmap_select() {{{1
function! Cream_addon_unmap_select()
" * Compose elements to be posted in s:Cream_addon_unmap_dialog()

	" initialize to first item (0-based)
	let current = 0

	" list of mappings to display
	let mapdisplay = ""

	" main event loop
	let quit = 0
	while quit == 0

		" wrap at beginning
		if     current < 0
			let current = 7
		" wrap at end
		elseif current > 7
			let current = 0
		endif

		" compose
		let mapdisplay = "UNMAP:\n\n\n"
		" Note: keys are 1-based!
		let i = 0
		while i < 8
			"if exists("g:CREAM_ADDON_MAPS{i + 1}_{1}")
			"    let mykey   = g:CREAM_ADDON_MAPS{i + 1}_{1}
			"endif
			if exists("g:CREAM_ADDON_MAPS{i + 1}_{2}")
				let myicall = g:CREAM_ADDON_MAPS{i + 1}_{2}
			endif
			if exists("g:CREAM_ADDON_MAPS{i + 1}_{3}")
				let myvcall = g:CREAM_ADDON_MAPS{i + 1}_{3}
			endif
			" display each key, even if unmapped
			if     i == 0
				let tmpkey = '<F12>:                                     '
			elseif i == 1
				let tmpkey = '<S-F12>:                        '
			elseif i == 2
				let tmpkey = '<C-F12>:                          '
			elseif i == 3
				let tmpkey = '<M-F12>:                           '
			elseif i == 4
				let tmpkey = '<C-S-F12>:             '
			elseif i == 5
				let tmpkey = '<M-S-F12>:              '
			elseif i == 6
				let tmpkey = '<C-M-F12>:                '
			elseif i == 7
				let tmpkey = '<C-M-S-F12>:   '
			endif
			" convert key mapping to human-readable form just for
			" dialog
			let tmpkey = substitute(tmpkey, '[<>]', '', 'g')
			let tmpkey = substitute(tmpkey, 'C-', 'Ctrl + ', 'g')
			let tmpkey = substitute(tmpkey, 'M-', 'Alt + ', 'g')
			let tmpkey = substitute(tmpkey, 'S-', 'Shift + ', 'g')
			" highlight first line
			if i == current
				let mapdisplay = mapdisplay . "                    >>  " . tmpkey
			else
				let mapdisplay = mapdisplay . "                           " . tmpkey
			endif
			" info lines for mapping explaining current calls
			if myicall ==? '<Nil>'
				let mapdisplay = mapdisplay . myvcall . "\n"
			else
				let mapdisplay = mapdisplay . myicall . "\n"
			endif

			let i = i + 1
		endwhile
		" pad bottom of text to even map dialog
		while MvNumberOfElements(mapdisplay, "\n") < 11
			let mapdisplay = mapdisplay . "\n"
		endwhile

		" post dialog accounting
		let n = s:Cream_addon_unmap_dialog(mapdisplay)
		if     n == "prev"
			let current = current - 1
			continue
		elseif n == "next"
			let current = current + 1
			continue
		elseif n == "unmap"

			" get element's key
			let mykey = g:CREAM_ADDON_MAPS{current + 1}_{1}

			" if already empty, just go back to select dialog
			if mykey == -1
				continue
			endif

			" unmap both insert and visual modes
			execute "silent! iunmap " . mykey . '<CR>'
			execute "silent! vunmap " . mykey . '<CR>'

			" drop from global
			let g:CREAM_ADDON_MAPS{current + 1}_{1} = ""
			let g:CREAM_ADDON_MAPS{current + 1}_{2} = ""
			let g:CREAM_ADDON_MAPS{current + 1}_{3} = ""

		elseif n == "map"
			" go to unmap routine
			let quit = Cream_addon_select()

		elseif n == -1
			" quit
			let quit = 1
		endif
	
	endwhile

	return 1

endfunction

" Cream_addon_unmap_dialog() {{{1
function! s:Cream_addon_unmap_dialog(selections)
" * Prompt user to select an addon through dialog
" * Return key

	let sav_go = &guioptions
	set guioptions+=v

	" remember focus
	if !exists("s:focus_unmap")
		let s:focus_unmap = 2
	endif

	let key = ""
	let n = confirm(
		\ a:selections .
		\ "\n\n\n\n\----------------------------------------------------------------------------------------------------------------------------          " .
		\ "\n", "&Up\n&Down\nU&nMap\n&Map...\n&Quit", s:focus_unmap, "Info")
	if     n == 1
		let myreturn = "prev"
		let s:focus_unmap = 1
	elseif n == 2
		let myreturn = "next"
		let s:focus_unmap = 2
	elseif n == 3
		let myreturn = "unmap"
		let s:focus_unmap = 2
	elseif n == 4
		let myreturn = "map"
		let s:focus_unmap = 2
	else
		let myreturn = -1
		let s:focus_unmap = 2
	endif

	" restore and return
	let &guioptions = sav_go
	return myreturn

endfunction

" Cream_addon_maps() {{{1
function! s:Cream_addon_maps(key, icall, vcall)
" map keys for add-ons
" * return 1 if successful, -1 if either are bad

	" both "<Nil>"
	if     a:icall ==? '<Nil>' && a:vcall ==? '<Nil>'
		" do nothing
		return 1
	endif
	
	" icall
	if a:icall ==? '<Nil>'
		" dead key
		execute 'imap <silent> ' . a:key . ' <Nop>'
	else
		" validate prior to mapping
		if s:Cream_addon_function_check(a:icall) == 1
			execute 'imap <silent> ' . a:key . ' <C-b>:' . a:icall . '<CR>'
		else
			return -1
		endif
	endif
	" vcall
	if a:vcall ==? '<Nil>'
		" dead key
		execute 'vmap <silent> ' . a:key . ' <Nop>'
	else
		" validate function existance
		if s:Cream_addon_function_check(a:vcall) == 1
			" map
			execute 'vmap <silent> ' . a:key . ' :' . a:vcall . '<CR>'
		else
			" unmap icall
			execute 'iunmap <silent> ' . a:key . '<CR>'
			return -1
		endif
	endif

	" valid functions
	return 1


	"" if vcall passed
	"if a:0 == 1
	"    let vcall = a:1
	"endif
	"
	"" if visual call distinguished
	"if exists("vcall")
	"    let vcall = a:1
	"    " if icall live
	"    if a:icall !=? '<Nil>'
	"        if s:Cream_addon_function_check(a:icall) == 1
	"            execute 'imap <silent> ' . a:key . ' <C-b>:' . a:icall . '<CR>'
	"        else
	"            " invalid
	"            return -1
	"        endif
	"    else
	"        " map key dead in insert mode
	"        execute 'imap <silent> ' . a:key . ' <Nop>'
	"    endif
	"    if s:Cream_addon_function_check(vcall) == 1
	"        execute 'vmap <silent> ' . a:key . ' :' . a:1 . '<CR>'
	"    else
	"        execute 'iunmap <silent> ' . a:key . '<CR>'
	"        " invalid (vcall)
	"        return -1
	"    endif
	"else
	"    " map key dead in visual mode
	"    execute 'vmap <silent> ' . a:key . ' <Nop>'
	"    if s:Cream_addon_function_check(a:icall) == 1
	"        execute 'imap <silent> ' . a:key . ' <C-b>:' . a:icall . '<CR>'
	"    else
	"        " unmap vcall
	"        execute 'vunmap <silent> ' . a:key . '<CR>'
	"        " invalid
	"        return -1
	"    endif
	"endif
	"
	"" valid functions
	"return 1

endfunction

" Cream_addon_function_check() {{{1
function! s:Cream_addon_function_check(call)
" * verifies specified add-on call belongs to an existing function
" * returns 1 on success, -1 on error
" * warns that a particular function is not available and that mapping
"   will be skipped.
	
	" empty returns success
	if a:call == ""
		return 1
	endif

	" strip preceding "*call  " off function ("*" includes "<C-u>", et,al.)
	let myfunction = substitute(a:call, '.*call\s*', '', 'g')

	" test exists
	if !exists("*" . myfunction)
		call confirm(
			\ "Warning: Referenced function \"" . myfunction . "\" not available to map. Skipping...\n" .
			\ "\n", "&Ok", 1, "Info")
		return -1
	endif
	return 1

endfunction

" Cream_addon_maps_init() {{{1
function! Cream_addon_maps_init()
" initialize a previous add-on map at session beginning
" * add-on maps stored in global g:CREAM_ADDON_MAPS as array
" * called by autocmd (thus, not s: script-local scope)

	"if !exists("g:CREAM_ADDON_MAPS{0}")
	"    let g:CREAM_ADDON_MAPS{0} = 0
	"    return
	"endif

	" iterate through array, assigning maps
	let i = 1
	while i <= 8
		" test exists and not empty
		if !exists("g:CREAM_ADDON_MAPS{i}_{1}")
		\ || g:CREAM_ADDON_MAPS{i}_{1} == ""
			let i = i + 1
			continue
		endif
		" map (validated here, too)
		let n = s:Cream_addon_maps(g:CREAM_ADDON_MAPS{i}_{1}, g:CREAM_ADDON_MAPS{i}_{2}, g:CREAM_ADDON_MAPS{i}_{3})
		" if failed, remove from string
		if n == -1
			unlet g:CREAM_ADDON_MAPS{i}_{1}
			unlet g:CREAM_ADDON_MAPS{i}_{2}
			unlet g:CREAM_ADDON_MAPS{i}_{3}
			" don't increment
			continue
		endif
		let i = i + 1
	endwhile
	
endfunction

" 1}}}
" vim:foldmethod=marker
