"
" Filename: cream-typingtutor.vim
" Updated:  2008-02-04 12:19:08-0400
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
" TODO:
" o Penalize errant keys with a new char
" o Resolve non-printing characters (space, tab, enter, etc.)
" o 

" register as a Cream add-on {{{1
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Typing Tutor',
	\ "Play a game while learning to type.",
	\ "Play a game while learning to type.",
	\ 'Typing Tutor',
	\ 'call Cream_typingtutor()',
	\ '<Nil>'
	\ )
endif

" Cream_typingtutor() {{{1
function! Cream_typingtutor()

""*** DEBUG:
"let n = confirm(
"    \ "This is still a test routine, picking the options does not work. (Press Ctrl+C to stop.)" .
"    \ "\n", "&Continue\n&Quit", 1, "Info")
"if n != 1
"    return
"endif
""***

	" open new buffer
	call Cream_file_new()
	let ttbufnr = bufnr("%")

	" initialize vars, window, game space, maps, etc.
	call s:Init()

	" refresh initial switch to new buffer and setup
	redraw

	" set characters
	let s:chars = ""

	while s:level < s:levelmax

		" acceleration
		" new delay equals current delay minus the range of delay
		" (init - max) divided by the number of steps we'll take
		" (levelmax)
		let s:delay = s:delay - ((s:delayinit - s:delaymax) / s:levelmax)

		" add chars each level
		if exists("s:chars{s:level}")
			let s:chars = s:chars . s:chars{s:level}
		endif

		let play = s:PlayLevel()
		" if quit
		if play == -1
			break
		endif
	
		let s:level = s:level + 1
	endwhile

	" TODO: to s:Exit()
	let &guicursor = b:guicursor
	let &hlsearch = b:hlsearch


	"" quit buffer
	"if bufnr("%") == ttbufnr
	"    silent! bwipeout!
	"endif

endfunction

" s:Init() {{{1
function! s:Init()
" game initialization

	" turn off search highlighting
	let b:hlsearch = &hlsearch
	setlocal nohlsearch

	" hide normal-mode cursor
	let b:guicursor = &guicursor
	setlocal guicursor+=n:hor1-Ignore-blinkwait0-blinkon1-blinkoff1000

	" case is important!
	setlocal noignorecase

	" chars of each level --------------------------------
	" LOWER CASE
	" home row
	let s:chars1 = 'asdfjkl;'
	" home row, reach
	let s:chars2 = 'gh'
	" space
	let s:chars3 = ' '
	" upper row
	let s:chars4 = 'qweruiop'
	" upper row, reach
	let s:chars5 = 'ty'
	" lower row
	let s:chars6 = 'zxcvm,./'
	" lower row, reach
	let s:chars7 = 'bn'

	" UPPER CASE
	" home row
	let s:chars8 = 'ASDFJKL;'
	" home row, reach
	let s:chars9 = 'GH'
	" upper row
	let s:chars10 = 'QWERUIOP'
	" upper row, reach
	let s:chars11 = 'TY'
	" lower row
	let s:chars12 = 'ZXCVM,./'
	" lower row, reach
	let s:chars13 = 'BN'

	" numbers
	let s:chars14 = '12347890'
	" numbers, reach
	let s:chars15 = '56'

	" tab
	let s:chars16 = '<Tab>'

	" enter, backspace
	let s:chars17 = '<CR><BS>'
	" common sentence chars, non-shifted
	let s:chars18 = "'-`"
	" common sentence chars, shifted
	let s:chars19 = '?!":()'
	" less-used chars
	let s:chars20 = '@#$%^&*~_+'
	" basic coding chars
	let s:chars21 = '[]{}\\|'
	" insert, delete, home, end
	" function keys
	" pageup, pagedown
	" arrow keys
	" ctrl, alt, shift combinations
	" -----------------------------------------------------------------

	" frequency/density of chars based on level
	let s:density = 1

	" initial speed
	let s:delayinit = 800
	" current speed
	let s:delay = s:delayinit
	" max speed
	let s:delaymax = 400

	" wrong key warning
	let s:wrongkey = ""

	" track correct/total keys
	let s:total = str2nr(0)
	let s:correct = str2nr(0)
	let s:score = str2nr(0)

	" set maximum loops (chars) per level
	let s:loopmax = 20
	" set main level
	let s:level = 1
	" set levels max
	let s:levelmax = 21

	" find game area
	call s:GameArea()
	" add returns so setline() works
	call s:GameBoard()
	" clear any previous game scraps
	call s:ClearLines()

endfunction

" s:GameArea() {{{1
function! s:GameArea()
" find initial game area

	let s:winheight = winheight(0)
	let s:winwidth = Cream_linewidth() - 2
	if s:winwidth > 80
		let s:winwidth = 80
	endif

endfunction

" s:GameBoard() {{{1
function! s:GameBoard()
" initialize game space--put a return in each line, we can't
" setline() if a line doesn't exist
	
	if !exists("s:winheight")
		call s:GameArea()
	endif

	let @x = ""
	let i = 1
	while i < s:winheight
		let @x = @x . "\n"
		let i = i + 1
	endwhile
	normal "xP
endfunction

" s:ClearLines() {{{1
function! s:ClearLines()
" clears all lines
	let i = 0
	while i < s:winheight + 40
		if exists("s:ttline{i}")
			unlet s:ttline{i}
		endif
		let i = i + 1
	endwhile
endfunction

" s:Header() {{{1
function! s:Header()
" defines current header and it's length

	let s:tthelp = 6

	let s:ttline1 = ""
	let s:ttline2 = " Type letters before they reach the bottom!      " . s:wrongkey
	let s:ttline3 = " [Stop]"
	let s:score = ((s:correct*100)/(s:total*100))/100
	let s:ttline4 = " Correct: " . s:correct . "    Total: " . s:total . "    Score: " . s:score . "%"
	let s:ttline5 = " Seconds: " . s:loop  . "    Level: " . s:level . "    Speed: " . s:delay
	let s:ttline6 = ""
	let i = 0
	while i < s:winwidth
		let s:ttline6 = s:ttline6 . "-"
		let i = i + 1
	endwhile

""*** DEBUG:
"let n = confirm(
"    \ "DEBUG:\n" .
"    \ "  s:correct  = \"" . s:correct . "\"\n" .
"    \ "  str2nr(s:correct)  = \"" . str2nr(s:correct) . "\"\n" .
"    \ "  string(s:correct)  = \"" . string(s:correct) . "\"\n" .
"    \ "  s:total  = \"" . s:total . "\"\n" .
"    \ "  str2nr(s:total)  = \"" . str2nr(s:total) . "\"\n" .
"    \ "  string(s:total)  = \"" . string(s:total) . "\"\n" .
"    \ "  s:score  = \"" . s:score . "\"\n" .
"    \ "  str2nr(s:score)  = \"" . str2nr(s:score) . "\"\n" .
"    \ "  string(s:score)  = \"" . string(s:score) . "\"\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if n != 1
"    return
"endif
""***

endfunction

" s:MouseClick() {{{1
function! s:MouseClick()

	let word = expand("<cword>")

	if word == "Stop"
		let b:quit = 1
	endif

endfunction

" s:PlayLevel() {{{1
function! s:PlayLevel()

	" test if maximum loops reached
	let s:loop = 1
	while s:loop < s:loopmax && !exists("b:quit")

		" define game area (do it each loop in case window size
		" changed via mouse)
		call s:GameArea()

		" define header (do before line clearing so we know how
		" much)
		call s:Header()

		" advance existing lines 1 line, start from bottom
		let i = s:winheight - 1
		while i > s:tthelp
			if exists("s:ttline{i}")
				let s:ttline{i+1} = s:ttline{i}
			endif
			let i = i - 1
		endwhile
		" clear last line
		if exists("s:ttline{s:winheight}")
			unlet s:ttline{s:winheight}
		endif

		" decide column for new char
		let col = Urndm(4, s:winwidth - 4)

		" compose new line ( setline() )
		let newline = ""
		" cat leading spaces/padding
		let i = 0
		while i < col
			let newline = newline . " "
			let i = i + 1
		endwhile
		" pick new char
		let len = strlen(s:chars)
		" random position needs a few spaces at border
		let cnt = Urndm(0, len)
		let char = s:chars[cnt]
		let char = s:EquivChar(char)
		let newline = newline . char

		" draw screen
		" start at top
		let i = 1
		" header
		while i <= s:tthelp
			if exists("s:ttline{i}")
				call setline(i, s:ttline{i})
			endif
			let i = i + 1
		endwhile

		" play area, newline
		let s:ttline{s:tthelp+1} = newline

		" play area, existing
		while i < s:winheight
			if exists("s:ttline{i}")
				call setline(i, s:ttline{i})
			endif
			let i = i + 1
		endwhile
		" TODO: footer? (with history?)

		" "poof" indicator that char was correct
		let poof = "*poof*"
		" remove poofs
		while i > s:tthelp
			if exists("s:ttline{i}")
				if match(s:ttline{i}, escape(poof, '*')) != -1
					" remove it from line
					let s:ttline{i} = substitute(s:ttline{i}, '^ *' . escape(poof, '*'), '', '')
					" redraw line
					call setline(i, s:ttline{i})
					" refresh
					redraw
					"" quit remove loop
					"return
					break
				endif
			endif
			let i = i - 1
		endwhile
		" cleanup (should be unnecessary!)
		execute "%substitute/" . escape(poof, '*') . "//gei"
		" remove lines with just whitespace
		execute ':%substitute/\s\+$//ge'

		" refresh screen
		redraw

		let sleep = 0
		while sleep < s:delay
			" get char loop
			let char = getchar(0)
			let char = escape(char, '.')

			if exists("b:quit")
				return -1
			endif
			" Esc
			if     char == 27
				let b:quit = 1
				break
			" LeftMouse
			elseif  char == "\<LeftMouse>"
				\|| char2nr(char[0]) == 128
				\&& char2nr(char[1]) == 253
				\&& char2nr(char[2]) == 44
				\&& char2nr(char[3]) == 0
				execute "normal i\<LeftMouse>"
				call s:MouseClick()
				if exists("b:quit")
					break
				endif
			endif
			if char
				let s:total = s:total + 1
				let i = s:winheight
				" check if getchar matches char "in play" (from bottom up)
				let i = s:winheight
				while i > s:tthelp
					if exists("s:ttline{i}")
						if   match(s:ttline{i}, poof) == -1
						\ && match(s:ttline{i}, escape(s:EquivChar(nr2char(char)), '.\')) != -1
							" remove it from line
							let before = s:ttline{i}
							let s:ttline{i} = substitute(s:ttline{i}, escape(s:EquivChar(nr2char(char)), '.\'), poof, '')
							" redraw line
							call setline(i, s:ttline{i})
							let i = i - 1
							" refresh
							redraw
							" quit remove loop
							let flag = 0
							let s:correct = s:correct + 1
							break
						endif
					endif
					let i = i - 1
				endwhile
				" no match if we get here
				" penalty for wrong key is no delay
				if !exists("flag")
					let flag = 1
				endif
			endif
			" time of local loop to getchar() (*not* screen
			" refresh, that's "s:delay")
			if exists("flag") && flag == 1
				let sleep = s:delay
				let s:wrongkey = "*** WRONG KEY! ***"
			else
				let sleepdelay = 10
				execute "silent! sleep " . sleepdelay . " m"
				let sleep = sleep + sleepdelay
				let s:wrongkey = ""
			endif
			if exists("flag")
				unlet flag
			endif
		endwhile

		let s:loop = s:loop + 1
	endwhile

endfunction

" s:EquivChar() {{{1
function! s:EquivChar(char)
" return character equivalents for non-printing chars
	if     a:char == " "
		return "SPACE"
	elseif a:char == "SPACE"
		return " "
	elseif a:char == "<Tab>"
		return "TAB"
	elseif a:char == "TAB"
		return "<Tab>"
	elseif a:char == "<BS>"
		return "BACKSPACE"
	elseif a:char == "BACKSPACE"
		return "<BS>"
	"elseif a:char == "."
	"    return "."
	else
		return a:char
	endif
endfunction

" 1}}}
"""" Random number generation (obsolete)
"""" Random_int_range() {{{1
"""function! Random_int_range(min, max)
"""" Return a "random" integer (0-32768). Returns -1 on error.
"""" TODO: Currently unable to handle min.
"""
"""    " disallow string
"""    if type(a:min) == 1 || type(a:max) == 1
"""        call confirm("Error: Random() arguments must be numbers.")
"""        return -1
"""    endif
"""    " verify arguments
"""    if a:min < 0 || a:min > 32768
"""        call confirm("Error: Random() argument 1 must be between 0-32768.")
"""        return -1
"""    endif
"""    if a:max < 0 || a:max > 32768
"""        call confirm("Error: Random() argument 2 must be between 0-32768.")
"""        return -1
"""    endif
"""    if a:min >= a:max
"""        call confirm("Error: Random() argument 2 must be greater than 1.")
"""        return -1
"""    endif
"""
"""    if exists("rnd")
"""        " ensure balanced range (multiple)
"""        if a:min == 0 && Cream_isfactor(32768, a:max)
"""            return rnd % a:max
"""        else
"""            " TODO: unfinished
"""        endif
"""    endif
"""    return -1
"""
"""endfunction
"""
"""" Random_int() {{{1
"""function! Random_int()
"""" Return a random integer based on one of several available means.
"""
"""    " Unix/Linux (2^8)
"""    if has("unix")
"""        let rnd = system("echo $RANDOM")
"""        let rnd = matchstr(rnd, '\d\+')
"""    " Windows 2K/XP (2^8)
"""    elseif has("win32") && exists("$RANDOM")
"""        let rnd = $RANDOM
"""    " else
"""    else
"""        let rnd = Random_int_time()
"""    endif
"""
"""    return rnd
"""
"""endfunction
"""
"""" Random_int_time() {{{1
"""function! Random_int_time()
"""" Return a pseudo-random integer [0-32768 (2^16)] initially seeded by
"""" time.
"""
"""    " test function hasn't been run this second
"""    if !exists("s:localtime")
"""        " initialize seconds
"""        let s:localtime = localtime()
"""        " initialize millisecond fractions
"""        let s:rnd0100 = 0
"""        let s:rnd0010 = 0
"""        let s:rnd0001 = 0
"""    else
"""        " pause a millisecond
"""        call s:Random_pause()
"""    endif
"""
"""    " throw out returns greater than 2^16 (just 4 possibilities)
"""    while !exists("rnd")
"""
"""        " seed with time if no previous random exists
"""        if !exists("s:rnd")
"""
"""            " Vim can handle max 32-bit number (4,294,967,296)
"""            " get afresh (each loop)
"""            let time = localtime()
"""            let s:rnd9 = matchstr(time, '\zs.\ze.........$') + 0
"""            let s:rnd8 = matchstr(time, '.\zs.\ze........$') + 0
"""            let s:rnd7 = matchstr(time, '..\zs.\ze.......$') + 0
"""            let s:rnd6 = matchstr(time, '...\zs.\ze......$') + 0
"""            let s:rnd5 = matchstr(time, '....\zs.\ze.....$') + 0
"""            let s:rnd4 = matchstr(time, '.....\zs.\ze....$') + 0
"""            let s:rnd3 = matchstr(time, '......\zs.\ze...$') + 0
"""            let s:rnd2 = matchstr(time, '.......\zs.\ze..$') + 0
"""            let s:rnd1 = matchstr(time, '........\zs.\ze.$') + 0
"""            let s:rnd0 = matchstr(time, '.........\zs.\ze$') + 0
"""            " s:rnd0100 set above
"""            " s:rnd0010 set above
"""            " s:rnd0001 set above
"""
"""            " string repeating variables ("random" by chaos theory)
"""            let rnd =
"""                \ s:rnd3 .
"""                \ s:rnd2 .
"""                \ s:rnd1 .
"""                \ s:rnd0 .
"""                \ s:rnd0100 .
"""                \ s:rnd0010 .
"""                \ s:rnd0001
"""            " strip leading 0's prior to math (might be interpreted as octal)
"""            let rnd = (substitute(rnd, '^0\+', '', 'g') + 0)
"""
"""        " otherwise, use previous result as seed
"""        else
"""            let rnd = s:rnd
"""        endif
"""
"""        " Linear Congruential Generator
"""        "
"""        " o http://www.maths.abdn.ac.uk/~igc/tch/mx4002/notes/node78.html
"""        "   * recommends  M = 2^32, A = 1664525, C = 1
"""        " o http://www.cs.sunysb.edu/~skiena/jaialai/excerpts/node7.html
"""        " o http://www.embedded.com/showArticle.jhtml?articleID=20900500
"""        " o http://www.mathcom.com/corpdir/techinfo.mdir/scifaq/q210.html#q210.6.1
"""        "   *  x(n) = A * x(n-1) + C mod M
"""
"""        " M (smallest prime larger than 2^8, conveniently 2^8+4,
"""        " meaning only four results require throwing out)
"""        let m = 32771
"""
"""        " A (multiplier,  2 < a < m )
"""        " Note: we use digits here consecutive with first number to
"""        " make sure it's impossible to repeat frequently (115 days).
"""        let a = s:rnd5 . s:rnd4
"""        " strip leading 0's prior to math (might be interpreted as octal)
"""        let a = (substitute(a, '^0\+', '', 'g') + 0) + 2
"""
"""        " C
"""        let c = 1
"""
"""        let rnd = (((a * rnd) + c) % m)
"""
"""        " pause and increment if out of range
"""        if rnd > 32768
"""            call s:Random_pause()
"""        endif
"""
"""    endwhile
"""
"""    " update at end (after loops)
"""    let s:localtime = localtime()
"""
"""    " remember for next time
"""    let s:rnd = rnd
"""
"""    return rnd
"""
"""endfunction
"""
"""function! s:Random_pause()
"""" Used to count pause 10 milliseconds and to increment both the 10s
"""" and 100s of milliseconds script-globals.
"""
"""    let s:rnd0001 = (s:rnd0001 + 1)
"""    if s:rnd0001 > 9
"""        let s:rnd0001 = 0
"""        let s:rnd0010 = (s:rnd0010 + 1)
"""        if s:rnd0010 > 9
"""            let s:rnd0010 = 0
"""            let s:rnd0100 = (s:rnd0100 + 1)
"""            if s:rnd0100 > 9
"""                let s:rnd0100 = 0
"""            endif
"""        endif
"""    endif
"""    sleep 1 m
"""
"""endfunction
"""
"""" TTest() {{{1
"""function! TTest()
"""" Create set of random numbers in new buffer.
"""" 
"""" Note: 
"""" It can be convenient to create a data with a range equaling the
"""" number of iterations. (It's a square plot.) But in this case, you
"""" may not wish run the 2^8 iterations required to balance the integer
"""" range. (Although on my 5-year old PC, this only takes about ten
"""" minutes and this routine continually indicates progress.) So if you
"""" wish to run a smaller set, two options are available:
""""
"""" 1. Simply throw out each result that exceeds your range. This means
"""" wasted iterations, but should not have any affect on the results.
""""
"""" 2. It is far more efficient to iterate by some factor of 2^8 and
"""" then modulus each result by the same factor to ensure a balanced
"""" reduction of the integers returned. Example:
""""
""""   let max = 8192
""""   [...]
""""       let a = Random_int()
""""       let a = 32768 % max        <= ADD THIS LINE
""""
"""" Otherwise you will end up disfavoring results between the
"""" non-factor divisor and the next factor.
""""
"""
"""    let timein = localtime()
"""
"""    " iterations
"""    let max = 10000
"""
"""    let str = ""
"""    let i = 0
"""    while i < max
"""        " get random integer
"""        let a = Random_int_time()
"""        "let a = Rndm()
"""        let str = str . a . "\n"
"""
"""        " progress indication
"""        " pad iterations for ouput
"""        let cnt = i
"""        while strlen(cnt) < strlen(max)
"""            let cnt = " " . cnt
"""        endwhile
"""        " pad result for ouput
"""        let result = a
"""        while strlen(result) < strlen(max)
"""            let result = " " . result
"""        endwhile
"""        " echo to command line
"""        echo cnt . " = " . result
"""        redraw
"""
"""        let i = i + 1
"""    endwhile
"""
"""    let elapsed = localtime() - timein
"""    let str = "Elapsed time: " . elapsed . " seconds\n" . str
"""
"""    let @x = str
"""    enew
"""    normal "xP
"""
"""endfunction

" 1}}}
" vim:foldmethod=marker
