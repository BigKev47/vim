" Menu Translations:	Simplified Chinese (UNIX)
" Translated By:	Ralgh Young <glyoung@users.sourceforge.net>
" Last Change:		Thir Dec 2 11:26:52 CST 2004

" translations for vimcream (http://cream.sourceforge.net)

" Quit when menu translations have already been done.
if exists("did_menu_trans")
  finish
endif
let did_menu_trans = 1

scriptencoding gb2312

" File menu
menutrans &File				�ļ�(&F)
menutrans &New<Tab>Ctrl+N		�½�(&N)<Tab>Ctrl+N
menutrans &Open\.\.\.			��(&O)\.\.\.
menutrans &Open\ (selection)<Tab>Ctrl+Enter	�򿪹�����ļ�<Tab>Ctrl+Enter
menutrans &Close			�ر�(&C)
menutrans C&lose\ All			ȫ���ر�(&l)

menutrans &Save<Tab>Ctrl+S		����(&S)<Tab>Ctrl+S
menutrans Save\ &As\.\.\.		���Ϊ(&A)\.\.\.
menutrans Sa&ve\ All\.\.\.		ȫ������(&v)\.\.\.
menutrans &Print\.\.\.			��ӡ(&P)\.\.\.
menutrans Prin&t\ Setup			��ӡ����

menutrans E&xit<Tab>Ctrl+F4		�˳�(&X)<Tab>Ctrl+F4

menutrans &Recent\ Files,\ Options	����򿪵��ļ�,\ ����
menutrans Set\ Menu\ Size		������ʷ��¼��
menutrans Remove\ Invalid		ɾ����Ч��
menutrans Clear\ List			����б�

" Print Setup
menutrans Paper\ Size			ֽ�Ŵ�С
menutrans Paper\ Orientation		ҳ�淽��
menutrans Margins			�߿�
menutrans Header			����
menutrans Syntax\ Highlighting\.\.\.	�﷨����
menutrans Line\ Numbering\.\.\.		�к�\.\.\.
menutrans Wrap\ at\ Margins\.\.\.	�Զ�����\.\.\.
menutrans &Encoding			����(&E)

" Edit menu
menutrans &Edit				�༭(&E)
menutrans &Undo<Tab>Ctrl+Z		�ָ�(&U)<Tab>Ctrl+Z
menutrans &Redo<Tab>Ctrl+Y		����(&R)<Tab>Ctrl+Y

menutrans Cu&t<Tab>Ctrl+X		����(&T)<Tab>Ctrl+X
menutrans &Copy<Tab>Ctrl+C		����(&C)<Tab>Ctrl+C
menutrans &Paste<Tab>Ctrl+V		ճ��(&P)<Tab>Ctrl+V

menutrans &Select\ All<Tab>Ctrl+A	ȫѡ(&S)<Tab>Ctrl+A
menutrans &Go\ To\.\.\.<Tab>Ctrl+G	����ָ����(&G)\.\.\.<Tab>Ctrl+G

menutrans &Find\.\.\.<Tab>Ctrl+F	����(&F)\.\.\.<Tab>Ctrl+F
menutrans &Replace\.\.\.<Tab>Ctrl+H	�滻(&R)\.\.\.<Tab>Ctrl+H
menutrans &Find<Tab>/			����(&F)<Tab>/
menutrans Find\ and\ Rep&lace<Tab>:%s	���Ҳ��滻(&l)<Tab>:%s
menutrans Multi-file\ Replace\.\.\.	���ļ�����/�滻\.\.\.

menutrans Fi&nd\ Under\ Cursor		���ҹ���±�ʶ��
menutrans &Find\ Under\ Cursor<Tab>F3	����<Tab>F3
menutrans &Find\ Under\ Cursor\ (&Reverse)<Tab>Shift+F3		�������<Tab>Shift+F3
menutrans &Find\ Under\ Cursor\ (&Case-sensitive)<Tab>Alt+F3	��Сд����<Tab>Alt+F3
menutrans &Find\ Under\ Cursor\ (Cas&e-sensitive,\ Reverse)<Tab>Alt+Shift+F3	��Сд����,�������<Tab>Alt+Shift+F3

menutrans Count\ &Word\.\.\.		ͳ������(&W)\.\.\.
menutrans Cou&nt\ Total\ Words\.\.\.	ͳ��ȫ������(&n)\.\.\.
menutrans Column\ Select<Tab>Alt+Shift+(motion)		��ѡ��<Tab>Alt+Shift+(���)

" Insert menu
menutrans &Insert			����(&I)
menutrans Character\ Line\.\.\.<Tab>Shift+F4	�������ַ����\.\.\.<Tab>Shift+F4
menutrans Character\ Line\ (length\ of\ line\ above)\.\.\.<Tab>Shift+F4\ (x2)	�������ַ����,��ǰһ��ͬ��\.\.\.<Tab>Shift+F4\ (x2)
menutrans Date/Time			����/ʱ��

"menutrans Character\ by\ Decimal\ Value<Tab>Alt+,	�����ַ�<Tab>Alt+,
"menutrans I&nsert.Character\ by\ Dialog\.\.\.		ѡ�������ַ�\.\.\.
"menutrans Digraph<Tab>Ctrl+K
"menutrans Digraphs,\ List
"menutrans ASCII\ Table
"menutrans ASCII\ Table,\ List
menutrans Line\ Numbers\ (selection)	�к�(ѡ�в���)



" Format menu
menutrans Fo&rmat			��ʽ(&r)

menutrans &Quick\ Wrap\ (selection\ or\ current\ paragraph)<Tab>Ctrl+Q		��������<Tab>Ctrl+Q
menutrans Quick\ &Un-Wrap\ (selection\ or\ current\ paragraph)<Tab>Alt+Q,\ Q	ɾ������(��ǰ��)<Tab>Alt+Q,\ Q

menutrans Capitalize,\ Title\ Case<Tab>F5	����ĸ��д(&T)<Tab>F5
menutrans Capitalize,\ UPPERCASE<Tab>Shift+F5	ȫ����д(&U)<Tab>Shift+F5
menutrans Capitalize,\ lowercase<Tab>Alt+F5	ȫ��Сд(&l)<Tab>Alt+F5
menutrans Capitalize,\ rEVERSE<Tab>Ctrl+F5	��Сд��ת(&I)<Tab>Ctrl+F5

menutrans Justify,\ Left			�����(&L)
menutrans Justify,\ Center			�м����(&C)
menutrans Justify,\ Right			�Ҷ���(&R)
menutrans Justify,\ Full			���Ҿ�����(&F)

menutrans &Remove\ Trailing\ Whitespace ɾ����β�ո�(&R)
menutrans Remove\ &Leading\ Whitespace  ɾ�����׿ո�(&L)
menutrans &Collapse\ All\ Empty\ Lines\ to\ One		ɾ���������(&C)
menutrans &Delete\ All\ Empty\ Lines	ɾ�����п���(&D)
menutrans &Join\ Lines\ (selection)	�ϲ�ѡ����(&J)

menutrans Con&vert\ Tabs\ To\ Spaces	��Tabת��Ϊ�ո�

menutrans &File\ Format\.\.\.		�ļ���ʽ(&F)\.\.\.

menutrans File\ &Encoding		�ļ�����(&E)
menutrans Western\ European		��ŷ
menutrans Eastern\ European		��ŷ
menutrans East\ Asian			����
menutrans Middle\ Eastern		�ж�
menutrans SE\ and\ SW\ Asian		������/����
menutrans Simplified\ Chinese\ (ISO-2022-CN)<Tab>[chinese\ --\ simplified\ Chinese:\ on\ Unix\ "euc-cn",\ on\ MS-Windows\ cp936]	��������(ISO-2022-CN)<Tab>[Unix:\ "euc-cn",\ Windows:\ cp936]
menutrans Chinese\ Traditional\ (Big5)<Tab>[big5\ --\ traditional\ Chinese]		��������(������)<Tab>[Big5]
menutrans Chinese\ Traditional\ (EUC-TW)<Tab>[taiwan\ --\ on\ Unix\ "euc-tw",\ on\ MS-Windows\ cp950]			��������(EUC-TW)<Tab>[Unix:\ "euc-tw",\ Windows:\ cp950]

" Settings menu
menutrans &Settings			����(&S)
menutrans &Show/Hide\ Invisibles<Tab>F4	��ʾ/���ز��ɼ��ַ�(&S)<Tab>F4
menutrans Line\ &Numbers\ (toggle)	��ʾ/�����к�(&N) 

menutrans &Word\ Wrap\ (toggle)<Tab>Ctrl+W	������ʾ<Tab>Ctrl+W
menutrans A&uto\ Wrap\ (toggle)<Tab>Ctrl+E	�Զ�����<Tab>Ctrl+E
menutrans &Set\ Wrap\ Width\.\.\.		�����Զ�����λ��(&S)\.\.\.
menutrans &Highlight\ Wrap\ Width\ (toggle)	������ʾ�Զ�����λ��(&H)

menutrans &Tabstop\ Width\.\.\. 		&Tab���\.\.\.
menutrans Tab\ &Expansion\ (toggle)<Tab>Ctrl+T	Tab�Զ���չΪ�ո�(&E)<Tab>Ctrl+T
menutrans &Auto-indent\ (toggle)		�Զ�����(&A)

menutrans Syntax\ Highlighting\ (toggle)	�﷨������ʾ
menutrans Highlight\ Find\ (toggle)		������ʾ���ҽ��
menutrans Highlight\ Current\ Line\ (toggle)	������ʾ��ǰ��
menutrans &Filetype			��������

menutrans &Color\ Themes		ɫ������(&C)
menutrans Selection			ѡ������

menutrans P&references			ƫ��(&r)
menutrans Font\.\.\.			����\.\.\.
menutrans Toolbar\ (toggle)		��ʾ/���ع�����
"menutrans Last\ File\ Restore\ Off
"menutrans Last\ File\ Restore\ On

menutrans &Middle-Mouse\ Disabled	����м�:\ �ѽ���
menutrans &Middle-Mouse\ Pastes		����м�:\ ճ��

menutrans Bracket\ Flashing\ Off	����ƥ����˸:\ �ر�
menutrans Bracket\ Flashing\ On		����ƥ����˸:\ ��
menutrans Info\ Pop\ Options\.\.\.	�Զ������ʾ����\.\.\.

menutrans &Expert\ Mode\.\.\.		ר��ģʽ(&E)\.\.\.
menutrans &Behavior			��Ϊģʽ(&B)

" Tools menu
menutrans &Tools			����(&T)

menutrans &Spell\ Check			ƴд���
menutrans Next\ Spelling\ Error<Tab>F7			��һ������<Tab>F7
menutrans Previous\ Spelling\ Error<Tab>Shift+F7	��һ������<Tab>Shift+F7
menutrans Show\ Spelling\ Errors\ (toggle)<Tab>Alt+F7	��ʾȫ��ƴд����<Tab>Alt+F7
menutrans Add\ Word\ (under\ cursor)\ to\ Dictionary<Tab>Ctrl+F7	����ǰ���ʼ���ʵ�<Tab>Ctrl+F7
menutrans Language\.\.\.		����\.\.\.
menutrans Options\.\.\.			ѡ��\.\.\.

menutrans &Bookmarks			��ǩ(&B)
menutrans Bookmark\ Next<Tab>F2		��һ����ǩ<Tab>F2
menutrans Bookmark\ Previous<Tab>Shift+F2	��һ����ǩ<Tab>Shift+F2	
menutrans Bookmark\ Set\ (toggle)<Tab>Alt+F2	������ǩ<Tab>Alt+F2
menutrans Delete\ All\ Bookmarks<Tab>Alt+Shift+F2	ɾ��������ǩ<Tab>Alt+Shift+F2

menutrans Block\ Comment\ (selection)<Tab>F6		���ע��<Tab>F6
menutrans Block\ Un-Comment\ (selection)<Tab>Shift+F6	ɾ��ע��<Tab>Shift+F6

menutrans Macro\ Play<Tab>F8				�طź�<Tab>F8
menutrans Macro\ Record\ (toggle)<Tab>Shift+F8		��ʼ/ֹͣ¼�ƺ�<Tab>Shift+F8

menutrans &Diff\ Mode			�ļ��Ƚ�ģʽ(&D)

menutrans &Folding			�����۵�(&F)
menutrans &Fold\ Open/Close<Tab>F9	�۵�/��<Tab>F9
menutrans &Fold\ Open/Close<Tab>Shift+F9	�۵�/��<Tab>Shift+F9
"menutrans &Set\ Fold\ (Selection)<Tab>F9
menutrans &Open\ All\ Folds<Tab>Ctrl+F9		�������۵�<Tab>Ctrl+F9
menutrans &Close\ All\ Folds<Tab>Ctrl+Shift+F9	�ر������۵�<Tab>Ctrl+Shift+F9
menutrans &Delete\ Fold\ at\ Cursor<Tab>Alt+F9	ɾ����괦�۵�<Tab>Alt+F9
menutrans D&elete\ All\ Folds<Tab>Alt+Shift+F9	ɾ�������۵�<Tab>Alt+Shift+F9

menutrans &Completion			�Զ����(&C)

menutrans &Tag\ Navigation		&Tag����
menutrans &Jump\ to\ Tag\ (under\ cursor)<Tab>Alt+Down	��ת���˱��<Tab>Alt+Down
menutrans &Close\ and\ Jump\ Back<Tab>Alt+Up		�رղ��ص�ǰһλ��<Tab>Alt+Up
menutrans &Previous\ Tag<Tab>Alt+Left			ǰһ���<Tab>Alt+Left
menutrans &Next\ Tag<Tab>Alt+Right			��һ���<Tab>Alt+Right
menutrans &Tag\ Listing\.\.\.<Tab>Ctrl+Alt+Down	�г����б��\.\.\.<Tab>Ctrl+Alt+Down

menutrans Add-ons\ E&xplore\ (Map/Unmap)	�������/��ݼ�ӳ��(&x)

" Add-ons
menutrans Color\ Invert			��תHTML��ɫֵ
menutrans Convert			ת��
menutrans Sort				����
menutrans Encrypt			����
menutrans Highlight\ Control\ Characters	������ʾ�����ַ�
menutrans Highlight\ Multibyte		������ʾ���ֽ��ַ�
menutrans Stamp\ Time			����ʱ���


" Window menu
menutrans &Window			����(&W)
menutrans Maximize\ (&Single)			���(&S)
menutrans Minimize\ (Hi&de)			��С��/����(&d)
menutrans Tile\ &Vertical			��ֱƽ��
menutrans Tile\ Hori&zontal			ˮƽƽ��
menutrans Sizes\ E&qual				��ͬ��С(&q)
menutrans Height\ Max\ &=			���߶�(&=)
menutrans Height\ Min\ &-			��С�߶�(&-)
menutrans &Width\ Max				�����(&W)
menutrans Widt&h\ Min				��С���(&h)
menutrans Split\ New\ Pane\ Vertical		����ָ��´���
menutrans Split\ New\ Pane\ Horizontal		����ָ��´���	
menutrans Split\ Existing\ Vertically		����ָǰ����
menutrans Split\ Existing\ Horizontally		����ָǰ����
menutrans Start\ New\ Vim\ Ins&tance		������ʵ��(&t)

menutrans File\ Tr&ee				Ŀ¼��(&e)
menutrans File\ E&xplorer\ (obsolete)		�ļ������(&x)
menutrans &Calendar\ (toggle)<Tab>Ctrl+F11	��ʾ/��������<Tab>Ctrl+F11

" Help menu
menutrans &Help			����(&H)

menutrans &Vim\ Help		VIM����
menutrans &Overview<Tab>F1	����(&O)<Tab>F1
menutrans &User\ Manual		�û��ֲ�(&U)
menutrans &GUI			ͼ�ν���(&G)
menutrans &How-to\ links	HOWTO�ĵ�\.\.\.(&H)
menutrans &Credits		����(&C)
menutrans Co&pying		��Ȩ(&P)
menutrans &Version\.\.\.	�汾(&V)\.\.\.
menutrans &About\.\.\.		����\ Vim(&A)

menutrans &About\ Cream\.\.\.	����\ Cream\.\.\.

" Popup menu
menutrans Select\ &All		ȫѡ(&A)
menutrans Cu&t			����(&t)
menutrans &Copy			����(&C)
menutrans &Paste		ճ��(&P)
menutrans &Delete		ɾ��(&D)


" Toolbar #FIXME: not work?
menutrans New\ File		�½��ļ�
menutrans Open			��
menutrans Save			����
menutrans Save\ As		���Ϊ
menutrans Close			�ر�
menutrans Exit\ Vim		�˳�Vim
menutrans Print			��ӡ
menutrans Undo			�ָ�
menutrans Redo			����
menutrans Cut\ (to\ Clipboard)	���е�������
menutrans Copy\ (to\ Clipboard)	������������
menutrans Paste\ (from\ Clipboard)	�Ӽ�����ճ��


" The GUI toolbar
if has("toolbar")
  if exists("*Do_toolbar_tmenu")
    delfun Do_toolbar_tmenu
  endif
  fun Do_toolbar_tmenu()
    tmenu ToolBar.new		�½��ļ�
    tmenu ToolBar.Open		���ļ�
    tmenu ToolBar.Save		���浱ǰ�ļ�
    tmenu ToolBar.SaveAll	����ȫ���ļ�
    tmenu ToolBar.Print		��ӡ
    tmenu ToolBar.Undo		�����ϴ��޸�
    tmenu ToolBar.Redo		�����ϴγ����Ķ���
    tmenu ToolBar.Cut		������������
    tmenu ToolBar.Copy		���Ƶ�������
    tmenu ToolBar.Paste		�ɼ�����ճ��
    tmenu ToolBar.Find		����...
    tmenu ToolBar.FindNext	������һ��
    tmenu ToolBar.FindPrev	������һ��
    tmenu ToolBar.Replace	�滻...
    tmenu ToolBar.LoadSesn	���ػỰ
    tmenu ToolBar.SaveSesn	���浱ǰ�ĻỰ
    tmenu ToolBar.RunScript	����Vim�ű�
    tmenu ToolBar.Make		ִ�� Make
    tmenu ToolBar.Shell		��һ�������
    tmenu ToolBar.RunCtags	ִ�� ctags
    tmenu ToolBar.TagJump	������ǰ���λ�õı�ǩ
    tmenu ToolBar.Help		Vim ����
    tmenu ToolBar.FindHelp	���� Vim ����
  endfun
endif



