"
" Filename: cream-slide-generator.vim
" Updated:  2007-07-04 17:04:47EDT
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
"
" A auto-slideshow generator:
" o Maintains all the original images.
" o Creates thumbnails of all the images in the directory.
" o Creates an HTML document that displays all the thumbnails, where
"   each links to another HMTL page displaying the fullsize image.
" o Provides navigation bar on each slide page through all slides.
"
" TODO:
" o Link subdirectories.
" o Indicates each filename and size on the slide page.
"

" register as a Cream add-on
if exists("$CREAM")

	call Cream_addon_register(
	\ 'Slide Generator',
	\ "Generate an HTML thumbnail page from a directory's images.",
	\ "Generate an HTML thumbnail page displaying all the images in a directory.",
	\ 'Slide Generator',
	\ 'call Cream_slide_generator()',
	\ '<Nil>'
	\ )
endif

function! Cream_slide_generator()

	" verify dependencies
	" on PATH
	if exists("g:CREAM_SLIDE_GENERATOR_CONVERTPATH")
		if !executable(g:CREAM_SLIDE_GENERATOR_CONVERTPATH)
			call confirm(
				\ "Remembered ImageMagick convert utility not found.\n" .
				\ "\n", "&Ok", 1, "Info")
			unlet g:CREAM_SLIDE_GENERATOR_CONVERTPATH
		endif
	endif

	if exists("g:CREAM_SLIDE_GENERATOR_CONVERTPATH")
		let myconvert = g:CREAM_SLIDE_GENERATOR_CONVERTPATH
	else
		if !executable("convert")
			let msg = "ImageMagick's convert utility not found on PATH."
		" Windows convert.exe test
		elseif stridx(system('convert /?'), "Converts FAT volumes to NTFS") >= 0
			let msg = "The convert.exe found on PATH is the Windows system utility, not the ImageMagick application."
		endif
		" option to find manually
		if exists("msg")
			let n = confirm(
				\ msg . "\n" .
				\ "Would you like to find the ImageMagick convert application?\n" .
				\ "\n", "&Yes\n&No", 1, "Info")
			if n != 1
				return
			endif
			let myconvert = browse(0, "ImageMagick convert utility", getcwd(), "")
			if myconvert == ""
				return
			endif
			let myconvert = fnamemodify(myconvert, ":p:8")
			let myconvert = Cream_path_fullsystem(myconvert)
			let g:CREAM_SLIDE_GENERATOR_CONVERTPATH = myconvert
		" default: on PATH
		else
			let myconvert = "convert"
		endif
	endif

	" get the directory
	if exists("g:CREAM_SLIDE_GENERATOR")
		let slidepath = g:CREAM_SLIDE_GENERATOR
	elseif exists("b:cream_pathfilename")
		let slidepath = b:cream_pathfilename
	else
		let slidepath = getcwd()
	endif
	let slidepath = browsedir("Confirm location to slideshow:", slidepath)
	if slidepath == ""
		" cancelled...
		return
	endif

	" name of html and css index files
	let s:slideshow = Inputdialog("Enter name of default page:", "index")
	if s:slideshow == "{cancel}" || ""
		return
	endif
	" warn if already exist
	if filereadable(slidepath . s:slideshow . ".html")
		let n = confirm(
			\ "File \n" .
			\ "    " . slidepath . s:slideshow . ".html" . "\n" .
			\ "already exists, overwrite?\n" .
			\ "\n", "&Ok\n&Cancel", 1, "Info")
		if n != 1
			return
		endif
	endif
	if filereadable(slidepath . s:slideshow . ".css")
		let n = confirm(
			\ "File \n" .
			\ "    " . slidepath . s:slideshow . ".css" . "\n" .
			\ "already exists, overwrite?\n" .
			\ "\n", "&Ok\n&Cancel", 1, "Info")
		if n != 1
			return
		endif
	endif

	" use current path to avoid pathing issues
	let mycd = getcwd()
	execute "cd " . slidepath

	" reduce spaces
	if Cream_has("ms")
		let slidepath = fnamemodify(slidepath, ":p:8")
		let slidepath = Cream_path_fullsystem(slidepath)
	endif
	" ensure has trailing slash
	let slidepath = Cream_path_addtrailingslash(slidepath)

	" remember
	let g:CREAM_SLIDE_GENERATOR = slidepath
	
	" get all files in directory
	let myfiles = Cream_getfilelist(slidepath . '*.*')

	" cull non-relevant (non-graphic) files first
	let i = 0
	let max = MvNumberOfElements(myfiles, "\n")
	let mynewfiles = ""
	while i < max

		let mypathfile = MvElementAt(myfiles, "\n", i)
		let myfileext = fnamemodify(mypathfile, ":e")

		" only web-compatible graphic files
		if myfileext !~? '\(jpg\|gif\|png\)'
			let i = i + 1
			continue
		endif

		" build new array of names of accepted graphics
		let mynewfiles = MvAddElement(mynewfiles, "\n", mypathfile)

		let i = i + 1
	endwhile
	let myfiles = mynewfiles
	unlet mynewfiles

	let max = MvNumberOfElements(myfiles, "\n")


	" quit if none found
	if max == 0
		return
	endif

	" start new slideshow
	silent! call Cream_file_new()
	silent! execute 'silent! write! ' . slidepath . s:slideshow . '.html'
	let mybuf = bufnr("%")
	" place HTML skeleton
	silent! call s:Html_template()
	" title
	let @x = '	<h3>' . s:slideshow . '.html</h3>' . "\n"
	let @x = @x . "\n"
	silent! put x

	" nav bar:   <<   <   Index   >   >>
	" first item nav item
	let mypathfile = MvElementAt(myfiles, "\n", 0)
	let myfilename = fnamemodify(mypathfile, ":t:r")
	let myfilehtml = myfilename . '.html'
	let navbar_first = '<a href="' . myfilehtml . '">&laquo;&laquo;</a>'
	" index
	let navbar_index = '<a href="' . s:slideshow . '.html">Index</a>'
	" last item
	let mypathfile = MvElementAt(myfiles, "\n", max-1)
	let myfilename = fnamemodify(mypathfile, ":t:r")
	let myfilehtml = myfilename . '.html'
	let navbar_last = '<a href="' . myfilehtml . '">&raquo;&raquo;</a>'

	" for each image...
	let i = 0
	while i < max

		" previous file
		if i > 0
			let mypathfile = MvElementAt(myfiles, "\n", i-1)
			let myfilename = fnamemodify(mypathfile, ":t:r")
			let myfilehtml = myfilename . '.html'
			let navbar_prev = '<a href="' . myfilehtml . '">&nbsp; &laquo; &nbsp;</a>'
		else
			let navbar_first_sub = "&laquo;&laquo;"
			let navbar_prev = "&nbsp; &laquo; &nbsp;"
		endif

		" next file
		if i+1 < max
			let mypathfile = MvElementAt(myfiles, "\n", i+1)
			let myfilename = fnamemodify(mypathfile, ":t:r")
			let myfilehtml = myfilename . '.html'
			let navbar_next = '<a href="' . myfilehtml . '">&nbsp; &raquo; &nbsp;</a>'
		else
			let navbar_last_sub = "&raquo;&raquo;"
			let navbar_next = "&nbsp; &raquo; &nbsp;"
		endif

		" this file
		let mypathfile = MvElementAt(myfiles, "\n", i)
		let myfileext = fnamemodify(mypathfile, ":e")
		let myfilename = fnamemodify(mypathfile, ":t:r")
		let myfilenameext = myfilename . '.' . myfileext
		let myfilethumb = myfilename . '-thumb.' . myfileext
		let myfilehtml = myfilename . '.html'

""*** DEBUG:
"let n = confirm(
"    \ "DEBUG:\n" .
"    \ "  slidepath  = \"" . slidepath . "\"\n" .
"    \ "  myfileext  = \"" . myfileext . "\"\n" .
"    \ "  myfilename  = \"" . myfilename . "\"\n" .
"    \ "  myfilenameext  = \"" . myfilenameext . "\"\n" .
"    \ "  myfilethumb  = \"" . myfilethumb . "\"\n" .
"    \ "  myfilehtml  = \"" . myfilehtml . "\"\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if n != 1
"    return
"endif
""***
		" progress indication
		let mycmdheight = &cmdheight
		set cmdheight=2
		echo " Progress: " . (i+1) . " of " . max . " (" . (((i+1)*100) / max) . "%)"
		let &cmdheight = mycmdheight

		" generate thumbnail
		if Cream_has("ms")
			let quote = '"'
		else
			let quote = ''
		endif
		set noshellslash
		" shell command
		silent! execute 'silent! !' . myconvert . ' ' . myfilenameext . " -thumbnail 120x120 -bordercolor white -border 50 -gravity center -crop 120x120+0+0 +repage " . myfilethumb
		set shellslash
		" reference to file
		let @x = ""
		let @x = @x . '	<a href="' . myfilehtml . '"><img class="slide" src="' . myfilethumb . '"></a>' . "\n"
		silent! put x


		" HTML doc for each full-size image
		call Cream_file_new()
		call s:Html_template()
		let @x = "\n"
		" nav bar
		let @x = @x . '	<!-- nav bar -->' . "\n"
		let @x = @x . '	<div class="navbar">' . "\n"
		" inactivate if not available
		if exists("navbar_first_sub")
			let @x = @x . '	' . navbar_first_sub . ' &nbsp; ' . "\n"
			unlet navbar_first_sub
		else
			let @x = @x . '	' . navbar_first . ' &nbsp; ' . "\n"
		endif
		let @x = @x . '	' . navbar_prev  . ' &nbsp; ' . "\n"
		let @x = @x . '	' . navbar_index . ' &nbsp; ' . "\n"
		let @x = @x . '	' . navbar_next  . ' &nbsp; ' . "\n"
		" inactivate if not available
		if exists("navbar_last_sub")
			let @x = @x . '	' . navbar_last_sub . ' &nbsp; ' . "\n"
			unlet navbar_last_sub
		else
			let @x = @x . '	' . navbar_last  . ' &nbsp; ' . "\n"
		endif
		let @x = @x . '	</div>' . "\n"
		let @x = @x . "\n"
		" title
		let @x = @x . '	<h4>' . myfilename . '.' . myfileext . '</h4>' . "\n"
		let @x = @x . "\n"
		" image
		let @x = @x . '	<img src="' . myfilename . '.' . myfileext . '" alt="' . myfilename . '.' . myfileext .'">' . "\n"
		let @x = @x . "\n"
		silent! put x
		" save and close
		silent! execute 'silent! write! ' . slidepath . myfilehtml
		silent! call Cream_close()

		" return to cream-slideshow.html
		silent! execute ":buf " . mybuf

		let i = i + 1
	endwhile
	" final save and close
	silent! write!
	" return to cream-slide.html
	silent! execute ":buf " . mybuf

	" generate .css
	silent! call Cream_file_new()
	" paste in reasonable CSS
	let @x = s:Css_template()
	silent! put x
	silent! execute 'silent! write! ' . slidepath . s:slideshow . '.css'
	silent! call Cream_close()

	" return to cream-slide.html
	silent! execute ":buf " . mybuf

	" open file in browser
	call Cream_file_open_defaultapp()
	" fix highlighting
	filetype detect

	let @x = ''

endfunction

function! s:Html_template()
" dump an HTML skeleton in the current file
	" HTML header (from template
	silent! execute 'normal i' . g:cream_template_html_html
	" Fix generic CSS name reference
	silent! execute '%s/main\.css/' . s:slideshow . '\.css/geI'
	" go to find char
	?{+}
	" delete line
	normal dd
	normal k
	" open up some space
	normal 5o
	" go back to top of space
	normal 4k
endfunction

function! s:Css_template()
" return a CSS skeleton
	let txt = "\n"
	let txt = txt . 'BODY {' . "\n"
	let txt = txt . '	font-family: "helvetica", "arial", sans-serif;' . "\n"
	let txt = txt . '	background-color: #999;' . "\n"
	let txt = txt . '	color: #fff;' . "\n"
	let txt = txt . '}' . "\n"
	let txt = txt . "\n"
	let txt = txt . 'IMG.slide {' . "\n"
	let txt = txt . '	padding: 10px;' . "\n"
	let txt = txt . '	background-color: #fff;' . "\n"
	let txt = txt . '}' . "\n"
	let txt = txt . "\n"
	let txt = txt . 'H4 {' . "\n"
	let txt = txt . '	color: #fff;' . "\n"
	let txt = txt . '}' . "\n"
	let txt = txt . "\n"
	let txt = txt . '.navbar {' . "\n"
	let txt = txt . '	text-align: center;' . "\n"
	let txt = txt . '	background: #aaa;' . "\n"
	let txt = txt . '	padding: 3px;' . "\n"
	let txt = txt . '}' . "\n"
	let txt = txt . 'A:link    {text-decoration: underline; font-weight:bold;}' . "\n"
	let txt = txt . 'A:visited {text-decoration: underline; font-weight:bold;}' . "\n"
	let txt = txt . 'A:hover   {text-decoration: none; font-weight:bold;}' . "\n"
	let txt = txt . 'A:active  {text-decoration: none; font-weight:bold;}' . "\n"
	let txt = txt . "\n"
	return txt
endfunction

