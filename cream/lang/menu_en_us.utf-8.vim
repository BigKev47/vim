
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
"    tmenu ToolBar.new		新建文件
"    tmenu ToolBar.Open		打开文件
"    tmenu ToolBar.Save		保存当前文件
"    tmenu ToolBar.SaveAll	保存全部文件
"    tmenu ToolBar.Print		打印
"    tmenu ToolBar.Undo		撤销上次修改
"    tmenu ToolBar.Redo		重做上次撤销的动作
"    tmenu ToolBar.Cut		剪切至剪贴板
"    tmenu ToolBar.Copy		复制到剪贴板
"    tmenu ToolBar.Paste		由剪贴板粘帖
"    tmenu ToolBar.Find		查找...
"    tmenu ToolBar.FindNext	查找下一个
"    tmenu ToolBar.FindPrev	查找上一个
"    tmenu ToolBar.Replace	替换...
"    tmenu ToolBar.LoadSesn	加载会话
"    tmenu ToolBar.SaveSesn	保存当前的会话
"    tmenu ToolBar.RunScript	运行Vim脚本
"    tmenu ToolBar.Make		执行 Make
"    tmenu ToolBar.Shell		打开一个命令窗口
"    tmenu ToolBar.RunCtags	执行 ctags
"    tmenu ToolBar.TagJump	跳到当前光标位置的标签
"    tmenu ToolBar.Help		Vim 帮助
"    tmenu ToolBar.FindHelp	查找 Vim 帮助
"  endfun
"endif
"
"
