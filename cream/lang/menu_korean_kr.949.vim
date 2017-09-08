" Menu Translations:	Korean (Windows)
" Translated By:	Hanjo Kim <lordmiss@gmail.com>
" Last Change:		Wed Oct 25 10:04:52 KST 2006

" translations for vimcream (http://cream.sourceforge.net)

" Quit when menu translations have already been done.
if exists("did_menu_trans")
  finish
endif
let did_menu_trans = 1

scriptencoding cp949

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &File				����(&F)
menutrans &New<Tab>Ctrl+N		��\ ����(&N)<Tab>Ctrl+N
menutrans &Open\.\.\.			����(&O)\.\.\.
menutrans &Open\ (selection)<Tab>Ctrl+Enter	������\ ����\ ����<Tab>Ctrl+Enter
menutrans &Open\ (Read-Only)\.\.\.	�б�\ ��������\ ����\.\.\.
menutrans &Close\ File			�ݱ�
menutrans C&lose\ All\ Files		���\ �ݱ�

menutrans &Save<Tab>Ctrl+S		����(&S)<Tab>Ctrl+S
menutrans Save\ &As\.\.\.		��\ �̸����� ����(&A)\.\.\.
menutrans Sa&ve\ All\.\.\.		���\ ����(&v)\.\.\.
menutrans &Print\.\.\.			�μ�(&P)\.\.\.
menutrans Prin&t\ Setup			�μ�\ ����
menutrans Save\ All\ and\ &Exit		���\ �����ϰ�\ ������

menutrans E&xit<Tab>Ctrl+F4		������(&X)<Tab>Ctrl+F4

menutrans &Recent\ Files,\ Options	�ֱ�����,\ �ɼ�
menutrans Set\ Menu\ Size		�޴�\ ũ��\ ����
menutrans Remove\ Invalid		�߸���\ �׸�\ �����
menutrans Clear\ List			���\ ����

" Print Setup
menutrans Paper\ Size			����\ ũ��
menutrans Paper\ Orientation		����\ ����
menutrans Margins			����
menutrans Header			�Ӹ���
menutrans Syntax\ Highlighting\.\.\.	����\ ����
menutrans Line\ Numbering\.\.\.		�ٹ�ȣ\.\.\.
menutrans Wrap\ at\ Margins\.\.\.	���鿡��\ �鿩����\.\.\.
menutrans &Encoding			���ڵ�(&E)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Edit menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Edit				����(&E)
menutrans &Undo<Tab>Ctrl+Z		�ǵ�����(&U)<Tab>Ctrl+Z
menutrans &Redo<Tab>Ctrl+Y		�ٽ��ϱ�(&R)<Tab>Ctrl+Y

menutrans Cu&t<Tab>Ctrl+X		�߶󳻱�(&T)<Tab>Ctrl+X
menutrans &Copy<Tab>Ctrl+C		����(&C)<Tab>Ctrl+C
menutrans &Paste<Tab>Ctrl+V		�ٿ��ֱ�(&P)<Tab>Ctrl+V

menutrans &Select\ All<Tab>Ctrl+A	���\ ����(&S)<Tab>Ctrl+A
menutrans &Go\ To\.\.\.<Tab>Ctrl+G	�̵�(&G)\.\.\.<Tab>Ctrl+G

menutrans &Find\.\.\.<Tab>Ctrl+F	ã��(&F)\.\.\.<Tab>Ctrl+F
menutrans &Replace\.\.\.<Tab>Ctrl+H	�ٲٱ�(&R)\.\.\.<Tab>Ctrl+H
menutrans &Find<Tab>/			ã��(&F)<Tab>/
menutrans Find\ and\ Rep&lace<Tab>:%s	ã��\ �ٲٱ�(&l)<Tab>:%s
menutrans Multi-file\ Replace\.\.\.	����\ ���Ͽ���\ �ٲٱ�\.\.\.

menutrans Fi&nd\ Under\ Cursor		Ŀ��\ ��ġ����\ ã��
menutrans &Find\ Under\ Cursor<Tab>F3	ã��<Tab>F3
menutrans &Find\ Under\ Cursor\ (&Reverse)<Tab>Shift+F3		����������\ ã��<Tab>Shift+F3
menutrans &Find\ Under\ Cursor\ (&Case-sensitive)<Tab>Alt+F3	��ҹ���\ �����Ͽ�\ ã��<Tab>Alt+F3
menutrans &Find\ Under\ Cursor\ (Cas&e-sensitive,\ Reverse)<Tab>Alt+Shift+F3	��ҹ���\ �����Ͽ�\ ���������� ã��<Tab>Alt+Shift+F3

menutrans Count\ &Word\.\.\.		�ܾ�\ ��\ ����(&W)\.\.\.
menutrans Cou&nt\ Total\ Words\.\.\.	��ü\ �ܾ�\ ��\ ����(&n)\.\.\.
menutrans Column\ Select<Tab>Alt+Shift+(motion)		�÷�\ ����<Tab>Alt+Shift+(������)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Insert			����(&I)
menutrans Character\ Line\.\.\.<Tab>Shift+F4	����\ ��\.\.\.<Tab>Shift+F4
menutrans Character\ Line\ (length\ of\ line\ above)\.\.\.<Tab>Shift+F4\ (x2)	����\ ��\ (��\ ����\ ���̷�)\.\.\.<Tab>Shift+F4\ (x2)
menutrans Date/Time\.\.\.<Tab>F11			��¥/�ð�\.\.\.<Tab>F11
menutrans Date/Time\ (Last\ Used)<Tab>F11\ (2x)	��¥/�ð�\ (������)<Tab>F11\ (2x)
menutrans Character\ by\ Value<Tab>Alt+,	���ڸ�\ ������<Tab>Alt+,
menutrans List\ Characters\ Available\.\.\.<Tab>Alt+,\ (x2)	 �Է�\ ������\ ����\.\.\.<Tab>Alt+,\ (x2)
menutrans List\ Character\ Values\ Under\ Cursor<Tab>Alt+\.	Ŀ��\ ��ġ��\ ���ڰ�<Tab>Alt+\.
"menutrans Character\ by\ Dialog\.\.\.		��ȭâ����\ ����\ ����\.\.\.
menutrans Character\ by\ Digraph<Tab>Ctrl+K	������<Tab>Ctrl+K
menutrans List\ Digraphs\ Available\.\.\.<Tab>Ctrl+K\ (x2)	������\ ���\.\.\.<Tab>Ctrl+K\ (x2)
menutrans Text\ Filler\.\.\.	��\ ä���
"menutrans ASCII\ Table			�ƽ�Ű\ ǥ
"menutrans ASCII\ Table,\ List		�ƽ�Ű\ ǥ,\ ����Ʈ
menutrans Line\ Numbers\.\.\.\ (selection)	�ٹ�ȣ(����)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Format menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans Fo&rmat			����(&r)

menutrans &Quick\ Wrap\ (selection\ or\ current\ paragraph)<Tab>Ctrl+Q		�ڵ�\ �ٹٲ�<Tab>Ctrl+Q
menutrans Quick\ &Un-Wrap\ (selection\ or\ current\ paragraph)<Tab>Alt+Q,\ Q	ɾ�ڵ�\ �ٹٲ�\ ����<Tab>Alt+Q,\ Q

menutrans Capitalize,\ Title\ Case<Tab>F5	��ҹ�����ȯ,\ ù\ ���ڸ�\ �빮�ڷ�(&T)<Tab>F5
menutrans Capitalize,\ UPPERCASE<Tab>Shift+F5	��ҹ�����ȯ,\ ���\ �빮�ڷ�(&U)<Tab>Shift+F5
menutrans Capitalize,\ lowercase<Tab>Alt+F5	��ҹ�����ȯ,\ ���\ �ҹ��ڷ�(&l)<Tab>Alt+F5
menutrans Capitalize,\ rEVERSE<Tab>Ctrl+F5	��ҹ�����ȯ,\ ù\ ���ڸ�\ �ҹ��ڷ�(&I)<Tab>Ctrl+F5

menutrans Justify,\ Left			����,\ ����(&L)
menutrans Justify,\ Center			����,\ ���(&C)
menutrans Justify,\ Right			����,\ ������(&R)
menutrans Justify,\ Full			����,\ ���(&F)

menutrans &Remove\ Trailing\ Whitespace ɾ��\ ����\ ����\ �����(&R)
menutrans Remove\ &Leading\ Whitespace  ɾ��\ ó����\ ����\ �����(&L)
menutrans &Collapse\ All\ Empty\ Lines\ to\ One		ɾ��\ ��\ ����\ ����\ ��\ �ٷ�(&C)
menutrans &Delete\ All\ Empty\ Lines	ɾ���\ ��\ ��\ ����(&D)
menutrans &Join\ Lines\ (selection)	��\ ��ġ��(&J)

menutrans Con&vert\ Tabs\ To\ Spaces	����\ ��������

menutrans &File\ Format\.\.\.		����\ ����(&F)\.\.\.

menutrans File\ &Encoding		����\ ���ڵ�(&E)
menutrans Asian				�ƽþƾ�
menutrans Unicode			�����ڵ�
menutrans Western\ European		��������
menutrans Eastern\ European		��������
menutrans East\ Asian			���ƽþƾ�
menutrans Middle\ Eastern		�߾Ӿƽþƾ�
menutrans SE\ and\ SW\ Asian		����/�����ƽþƾ�

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Settings			����(&S)
menutrans &Show/Hide\ Invisibles\ (toggle)<Tab>F4	���̱�/���߱�(&S)\ (toggle)<Tab>F4
menutrans Line\ &Numbers\ (toggle)	�ٹ�ȣ(&N)\ (toggle)

menutrans &Word\ Wrap<Tab>Ctrl+W	�ٹٲ�<Tab>Ctrl+W
menutrans A&uto\ Wrap<Tab>Ctrl+E	�ڵ�\ �ٹٲ�<Tab>Ctrl+E
menutrans &Set\ Wrap\ Width\.\.\.		�ٹٲ�\ ����\ ����(&S)\.\.\.
menutrans &Highlight\ Wrap\ Width\ (toggle)	�ٹٲ�\ ����\ ���̱�(&H)

menutrans &Tabstop\ Width\.\.\. 		��\ ����\.\.\.
menutrans Tab\ &Expansion\ (toggle)<Tab>Ctrl+T	��\ Ȯ��(&E)<Tab>Ctrl+T
menutrans &Auto-indent\ (toggle)		�ڵ�\ �鿩����(&A)

menutrans Syntax\ Highlighting\ (toggle)	����\ ����
menutrans Highlight\ Find\ (toggle)		�˻�\ ���\ ����
menutrans Highlight\ Current\ Line\ (toggle)	����\ ��\ ����
menutrans &Filetype			����\ ����

menutrans &Color\ Themes		��\ ��Ŵ(&C)
menutrans Selection			����

menutrans P&references			����(&r)
menutrans Font\.\.\.			�۲�\.\.\.
menutrans Toolbar\ (toggle)		����
menutrans Last\ File\ Restore\ Off	����\ ����\ ����\ ����
menutrans Last\ File\ Restore\ On	����\ ����\ ����\ ��

menutrans &Middle-Mouse\ Disabled	���콺\ ���\ ��ư\ ������
menutrans &Middle-Mouse\ Pastes		���콺\ ���\ ��ư\ �ٿ��ֱ�

menutrans Bracket\ Flashing\ Off	��ȣ\ ������\ ����
menutrans Bracket\ Flashing\ On		��ȣ\ ������\ �ѱ�
menutrans Info\ Pop\ Options\.\.\.	��\ �ɼ�\ ����\.\.\.

menutrans &Expert\ Mode\.\.\.		������\ ���(&E)\.\.\.
menutrans &Behavior			������(&B)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tools menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Tools			����(&T)

menutrans &Spell\ Check			�����\ �˻�
menutrans Next\ Spelling\ Error<Tab>F7			����\ �����\ ����<Tab>F7
menutrans Previous\ Spelling\ Error<Tab>Shift+F7	����\ �����\ ����<Tab>Shift+F7
menutrans Show\ Spelling\ Errors\ (toggle)<Tab>Alt+F7	�����\ ����\ ���̱�<Tab>Alt+F7
menutrans Add\ Word\ (under\ cursor)\ to\ Dictionary<Tab>Ctrl+F7	����\ �ܾ�\ ������\ �ֱ�<Tab>Ctrl+F7
menutrans Language\.\.\.		���\.\.\.
menutrans Options\.\.\.			�ɼ�\.\.\.

menutrans &Bookmarks			�ϸ�ũ(&B)
menutrans Bookmark\ Next<Tab>F2		����\ �ϸ�ũ<Tab>F2
menutrans Bookmark\ Previous<Tab>Shift+F2	������\ �ϸ�ũ<Tab>Shift+F2	
menutrans Bookmark\ Set\ (toggle)<Tab>Alt+F2	��ϸ�ũ\ ����<Tab>Alt+F2
menutrans Delete\ All\ Bookmarks<Tab>Alt+Shift+F2	ɾ���\ �ϸ�ũ\ ����<Tab>Alt+Shift+F2

menutrans Block\ Comment\ (selection)<Tab>F6		���ÿ���\ �ڸ�Ʈ��<Tab>F6
menutrans Block\ Un-Comment\ (selection)<Tab>Shift+F6	ɾ���ÿ���\ �ڸ�Ʈ\ Ǯ��<Tab>Shift+F6

menutrans Macro\ Play<Tab>F8				��ũ��\ ����<Tab>F8
menutrans Macro\ Record\ (toggle)<Tab>Shift+F8		��ũ��\ ���<Tab>Shift+F8

menutrans &Diff\ Mode			��\ ���(&D)

menutrans &Folding			����(&F)
menutrans &Fold\ Open/Close<Tab>F9	����\ ����/�ݱ�<Tab>F9
menutrans &Fold\ Open/Close<Tab>Shift+F9	����\ ����/�ݱ�<Tab>Shift+F9
menutrans &Set\ Fold\ (Selection)<Tab>F9	����\ ����
menutrans &Open\ All\ Folds<Tab>Ctrl+F9		���\ ����\ ����<Tab>Ctrl+F9
menutrans &Close\ All\ Folds<Tab>Ctrl+Shift+F9	���\ ����\ �ݱ�<Tab>Ctrl+Shift+F9
menutrans &Delete\ Fold\ at\ Cursor<Tab>Alt+F9	ɾĿ��\ ��ġ����\ ����\ ����<Tab>Alt+F9
menutrans D&elete\ All\ Folds<Tab>Alt+Shift+F9	ɾ���\ ����\ ����<Tab>Alt+Shift+F9

menutrans &Completion			�ڵ��ϼ�(&C)

menutrans &Tag\ Navigation		��\ �̵�
menutrans &Jump\ to\ Tag\ (under\ cursor)<Tab>Alt+Down	�±׷�\ �̵�<Tab>Alt+Down
menutrans &Close\ and\ Jump\ Back<Tab>Alt+Up		�ݰ�\ �ڷ�\ �̵�<Tab>Alt+Up
menutrans &Previous\ Tag<Tab>Alt+Left			����\ �±�<Tab>Alt+Left
menutrans &Next\ Tag<Tab>Alt+Right			����\ �±�<Tab>Alt+Right
menutrans &Tag\ Listing\.\.\.<Tab>Ctrl+Alt+Down		�±�\ ����Ʈ\.\.\.<Tab>Ctrl+Alt+Down

menutrans Add-ons\ E&xplore\ (Map/Unmap)	�߰����\ Ž��(&x)

" Add-ons
menutrans &Add-ons	��Ÿ
menutrans Color\ Invert			��\ ����
menutrans Convert			��ȯ
menutrans Cream\ Config\ Info	ũ��\ ����\ ����
menutrans Cream\ Devel	 ũ��\ ����
menutrans Fold\ Vim\ Functions	Vim\ �Լ�\ ����
menutrans Ctags\ Generate	Ctags\ ����
menutrans Daily\ Read	����\ �б�
menutrans De-binary	���̳ʸ�\ ����
menutrans &Email\ Prettyfier	�̸���\ �ٹ̱�
menutrans Sort				����
menutrans Encrypt			��ȣȭ
menutrans Highlight\ Control\ Characters	�����\ ���̶���Ʈ
menutrans Highlight\ Multibyte		��Ƽ����Ʈ\ ���̶���Ʈ
menutrans Stamp\ Time			�ð�\ ǥ��

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Window				â(&W)
menutrans Maximize\ (&Single)			�ִ�ȭ(&S)
menutrans Minimize\ (Hi&de)			�ּ�ȭ(&d)
menutrans Tile\ &Vertical			���η�\ ����
menutrans Tile\ Hori&zontal			���η�\ ����
menutrans Sizes\ E&qual				����\ ũ���(&q)
menutrans Height\ Max\ &=			�ִ����(&=)
menutrans Height\ Min\ &-			�ּҳ���(&-)
menutrans &Width\ Max				�ִ����(&W)
menutrans Widt&h\ Min				�ּҳ���(&h)
menutrans Split\ New\ Pane\ Vertical		��\ â��\ ���η�\ ����
menutrans Split\ New\ Pane\ Horizontal		��\ â��\ ���η�\ ����
menutrans Split\ Existing\ Vertically		����\ â��\ ���η�\ ����
menutrans Split\ Existing\ Horizontally		����\ â��\ ���η�\ ����
menutrans Start\ New\ Cream\ Ins&tance		ũ��\ ����\ ����(&t)

menutrans File\ Tr&ee				����\ Ʈ��
menutrans Open\ File\ E&xplorer	����\ Ž����(&x)
menutrans Open\ File\ in\ Default\ &Application	�⺻\ ���α׷�����\ ����\ ����
menutrans &Calendar\ (toggle)<Tab>Ctrl+F11	�޷�<Tab>Ctrl+F11

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Help menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Help			����(&H)

menutrans Keyboard\ Shortcuts<Tab>F1	����Ű<Tab>F1
menutrans Features		Ư¡
menutrans FAQ			����\ ����\ ����
menutrans License		���̼���
menutrans Contributors	������\ �е�
menutrans &Vim\ Help\ (expert)	VIM\ ����\ (��������)
menutrans &Overview		����(&O)
menutrans &User\ Manual		�����\ �Ŵ���(&U)
menutrans &GUI			�����\ �������̽�(&G)
menutrans &How-to\ links	HOWTO\ ��ũ\.\.\.(&H)
menutrans &Credits		���۱�(&C)
menutrans Co&pying		����(&P)
menutrans &Version\.\.\.	����(&V)\.\.\.
menutrans &About\.\.\.		Vim��\ ����(&A)
menutrans &List\ Help\ Topics\.\.\.<Tab>Alt+F1	����\ �׸�\ ����Ʈ<Tab>Alt+F1
menutrans &Go\ to\ Help\ Topic\.\.\.<Tab>Ctrl+F1	����\ �׸�����\ �̵�\.\.\.<Tab>Ctrl+F1

menutrans &About\ Cream\.\.\.	Cream��\ ����\.\.\.

" Popup menu
menutrans Select\ &All		���\ ����(&A)
menutrans Cu&t			�ڸ���(&t)
menutrans &Copy			����(&C)
menutrans &Paste		�ٿ��ֱ�(&P)
menutrans &Delete		����(&D)


" Toolbar #FIXME: not work?
menutrans New\ File		��\ ����
menutrans Open			����
menutrans Save			����
menutrans Save\ As		�ٸ�\ �̸�����\ ����
menutrans Close			�ݱ�
menutrans Exit\ Vim		Vim\ ����
menutrans Print			�μ�
menutrans Undo			�������
menutrans Redo			�ٽý���
menutrans Cut\ (to\ Clipboard)	Ŭ�������\ �ڸ���
menutrans Copy\ (to\ Clipboard)	Ŭ�������\ ����
menutrans Paste\ (from\ Clipboard)	Ŭ�����忡��\ �ٿ��ֱ�


" The GUI toolbar
if has("toolbar")
  if exists("*Do_toolbar_tmenu")
    delfun Do_toolbar_tmenu
  endif
  fun Do_toolbar_tmenu()
    tmenu ToolBar.new		������
    tmenu ToolBar.Open		����
    tmenu ToolBar.Save		����
    tmenu ToolBar.SaveAll	�������
    tmenu ToolBar.Print		�μ�
    tmenu ToolBar.Undo		�������
    tmenu ToolBar.Redo		�ٽý���
    tmenu ToolBar.Cut		�߶󳻱�
    tmenu ToolBar.Copy		����
    tmenu ToolBar.Paste		�ٿ��ֱ�
    tmenu ToolBar.Find		ã��...
    tmenu ToolBar.FindNext	����ã��
    tmenu ToolBar.FindPrev	����ã��
    tmenu ToolBar.Replace	�ٲٱ�...
    tmenu ToolBar.LoadSesn	���Ǻҷ�����
    tmenu ToolBar.SaveSesn	��������
    tmenu ToolBar.RunScript	��ũ��Ʈ����
    tmenu ToolBar.Make		Make
    tmenu ToolBar.Shell		��
    tmenu ToolBar.RunCtags	ctags����
    tmenu ToolBar.TagJump	�±��̵�
    tmenu ToolBar.Help		����
    tmenu ToolBar.FindHelp	����ã��
  endfun
endif



