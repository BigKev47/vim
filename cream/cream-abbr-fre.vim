"====================================================================
" cream-abbr-fre.vim
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

" Source:
"
"   File:		fr-abbr.vim
"   Author:	Luc Hermitte <hermitte at free.fr>
"   		<URL:http://hermitte.free.fr/vim>
"   Last Update:	21st jul 2002
"   Purpose:	Abbréviations et corrections automatiques pour documents en
"   		francais.
"

iabbrev Classifieur Classificateur
iabbrev classifieur classificateur
iabbrev LA La
iabbrev LE Le
iabbrev LEs Les
iabbrev JE Je
iabbrev Permanante Permanente
iabbrev permanante permanente
iabbrev Plsu Plus
iabbrev plsu plus
iabbrev traffic trafic

if &encoding == "latin1"
	iabbrev couteu coûteu
	iabbrev facon façon
	iabbrev ontrole ontrôle
	iabbrev Reseau Réseau
	iabbrev reseau réseau
	iabbrev tres très
	iabbrev Video Vidéo
	iabbrev video vidéo
endif

