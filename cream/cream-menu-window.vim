"
" cream-menu-window.vim
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

function! Cream_menu_window()

	"anoremenu <silent> 80.100 &Window.-SEP100-							<Nul>
	anoremenu <silent> 80.101 &Window.Maximize\ (&Single)				:call Cream_window_setup_maximize()<CR>
	anoremenu <silent> 80.102 &Window.Minimize\ (Hi&de)					:call Cream_window_setup_minimize()<CR>
	anoremenu <silent> 80.103 &Window.Tile\ &Vertical					:call Cream_window_setup_tile("vertical")<CR>
	anoremenu <silent> 80.104 &Window.Tile\ Hori&zontal					:call Cream_window_setup_tile("horizontal")<CR>

	anoremenu <silent> 80.200 &Window.-SEP200-							<Nul>
	anoremenu <silent> 80.201 &Window.Sizes\ E&qual						:call Cream_window_equal()<CR>
	anoremenu <silent> 80.202 &Window.Height\ Max\ &=					:call Cream_window_height_max()<CR>
	anoremenu <silent> 80.203 &Window.Height\ Min\ &-					:call Cream_window_height_min()<CR>
	anoremenu <silent> 80.204 &Window.&Width\ Max						:call Cream_window_width_max()<CR>
	anoremenu <silent> 80.205 &Window.Widt&h\ Min						:call Cream_window_width_min()<CR>

	"anoremenu <silent> 80.300 &Window.-SEP300-							<Nul>
	"anoremenu <silent> 80.302 &Window.Move\ To\ &Top					<C-W>K
	"anoremenu <silent> 80.303 &Window.Move\ To\ &Bottom				<C-W>J
	"anoremenu <silent> 80.304 &Window.Move\ To\ &Left\ side			<C-W>H
	"anoremenu <silent> 80.305 &Window.Move\ To\ &Right\ side			<C-W>L

	"anoremenu <silent> 80.350 &Window.-SEP350-							<Nul>
	"anoremenu <silent> 80.351 &Window.Rotate\ &Up						<C-W>R
	"anoremenu <silent> 80.352 &Window.Rotate\ &Down					<C-W>r

	anoremenu <silent> 80.400 &Window.-SEP400-							<Nul>
	anoremenu <silent> 80.401 &Window.Split\ New\ Pane\ Vertical		:call Cream_window_new_ver()<CR>
	anoremenu <silent> 80.402 &Window.Split\ New\ Pane\ Horizontal		:call Cream_window_new_hor()<CR>
	anoremenu <silent> 80.403 &Window.Split\ Existing\ Vertically		:call Cream_window_split_exist_ver()<CR>
	anoremenu <silent> 80.404 &Window.Split\ Existing\ Horizontally		:call Cream_window_split_exist_hor()<CR>

	" add tab handling functions to the menu
	anoremenu <silent> 80.450 &Window.-SEP450-							<Nul>
	anoremenu <silent> 80.451 &Window.&Tabs.Make\ Tab\ &First			:call Cream_tab_move_first()<CR>
	anoremenu <silent> 80.452 &Window.&Tabs.Move\ Tab\ &Left			:call Cream_tab_move_left()<CR>
	anoremenu <silent> 80.453 &Window.&Tabs.Move\ Tab\ &Right			:call Cream_tab_move_right()<CR>
	anoremenu <silent> 80.454 &Window.&Tabs.Make\ Tab\ Las&t			:call Cream_tab_move_last()<CR>
	anoremenu <silent> 80.455 &Window.&Tabs.-SEP455-					<Nul>
	anoremenu <silent> 80.460 &Window.&Tabs.R&efresh\ tabs				:call Cream_tabpages_refresh()<CR>
	":call Cream_tabpages_refresh()<CR>

	" OBSOLETE
	"anoremenu <silent> 80.500 &Window.-SEP500-							<Nul>
	"anoremenu <silent> 80.501 &Window.Start\ New\ Cream\ Instance		:call Cream_session_new()<CR>

	"anoremenu <silent> 80.550 &Window.-SEP80550-			<Nul>
	anoremenu <silent> 80.551 &Window.Open\ File\ in\ Default\ &Application		:call Cream_file_open_defaultapp()<CR>
	    imenu <silent> 80.570 &Window.Open\ File\ E&xplorer					<C-b>:call Cream_open_fileexplorer()<CR>
	    vmenu <silent> 80.571 &Window.Open\ File\ E&xplorer					:<C-u>call Cream_open_fileexplorer()<CR>

	anoremenu <silent> 80.700 &Window.-SEP700-							<Nul>
	anoremenu <silent> 80.701 &Window.&Calendar\ (toggle)<Tab>Ctrl+F11	:call Cream_calendar()<CR>

	anoremenu <silent> 80.900 &Window.-SEP900-							<Nul>

	" buffers added here (elsewhere)


endfunction
call Cream_menu_window()

