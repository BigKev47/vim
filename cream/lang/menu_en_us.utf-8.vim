
" NOTE: This is all test code.




" File menu
"menutrans &File				Hooba(&F)

" The GUI toolbar
	"imenu <silent> icon=new 200.05 ToolBar.new		    {rhs}
	"vmenu <silent> icon=new 200.06 ToolBar.new		    {rhs}
	"tmenu <silent> ToolBar.new New File

"menutrans New\ File			Cows
"menutrans ToolBar\.new		Cowss
"menutrans new				Cowsss
"menutrans 200\.05			Cowssss
"menutrans New\\\ File		Cowsss

"if has("toolbar")
"  if exists("*Do_toolbar_tmenu")
"    delfun Do_toolbar_tmenu
"  endif
"  fun Do_toolbar_tmenu()
"    tmenu ToolBar.new		�½��ļ�
"    tmenu ToolBar.Open		���ļ�
"    tmenu ToolBar.Save		���浱ǰ�ļ�
"    tmenu ToolBar.SaveAll	����ȫ���ļ�
"    tmenu ToolBar.Print		��ӡ
"    tmenu ToolBar.Undo		�����ϴ��޸�
"    tmenu ToolBar.Redo		�����ϴγ����Ķ���
"    tmenu ToolBar.Cut		������������
"    tmenu ToolBar.Copy		���Ƶ�������
"    tmenu ToolBar.Paste		�ɼ�����ճ��
"    tmenu ToolBar.Find		����...
"    tmenu ToolBar.FindNext	������һ��
"    tmenu ToolBar.FindPrev	������һ��
"    tmenu ToolBar.Replace	�滻...
"    tmenu ToolBar.LoadSesn	���ػỰ
"    tmenu ToolBar.SaveSesn	���浱ǰ�ĻỰ
"    tmenu ToolBar.RunScript	����Vim�ű�
"    tmenu ToolBar.Make		ִ�� Make
"    tmenu ToolBar.Shell		��һ�������
"    tmenu ToolBar.RunCtags	ִ�� ctags
"    tmenu ToolBar.TagJump	������ǰ���λ�õı�ǩ
"    tmenu ToolBar.Help		Vim ����
"    tmenu ToolBar.FindHelp	���� Vim ����
"  endfun
"endif
"
"
