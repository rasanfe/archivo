$PBExportHeader$w_docs.srw
forward
global type w_docs from window
end type
type cb_close from commandbutton within w_docs
end type
type lb_dirlist from listbox within w_docs
end type
type cb_open from commandbutton within w_docs
end type
type st_path from statictext within w_docs
end type
type sle_path from singlelineedit within w_docs
end type
end forward

global type w_docs from window
integer width = 3113
integer height = 1276
boolean titlebar = true
string title = "Documentos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
lb_dirlist lb_dirlist
cb_open cb_open
st_path st_path
sle_path sle_path
end type
global w_docs w_docs

on w_docs.create
this.cb_close=create cb_close
this.lb_dirlist=create lb_dirlist
this.cb_open=create cb_open
this.st_path=create st_path
this.sle_path=create sle_path
this.Control[]={this.cb_close,&
this.lb_dirlist,&
this.cb_open,&
this.st_path,&
this.sle_path}
end on

on w_docs.destroy
destroy(this.cb_close)
destroy(this.lb_dirlist)
destroy(this.cb_open)
destroy(this.st_path)
destroy(this.sle_path)
end on

event open;lb_dirlist.DirList(sle_path.text+"\*.jpg", 0)
end event

type cb_close from commandbutton within w_docs
integer x = 1339
integer y = 1052
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;String ls_docs, ls_delimiter
integer li_TotalItems, li_Item

li_TotalItems = lb_dirlist.TotalItems()

For li_Item = 1 To li_TotalItems
	If lb_dirlist.State(li_Item)= 1 Then
		ls_docs += ls_delimiter+sle_path.text+"\"+lb_dirlist.Text(li_Item)
		ls_delimiter = ","
	End if	
Next

CloseWithReturn ( parent, ls_docs )
end event

type lb_dirlist from listbox within w_docs
integer x = 274
integer y = 248
integer width = 2523
integer height = 740
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

type cb_open from commandbutton within w_docs
integer x = 2789
integer y = 96
integer width = 137
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;string ls_path = "C:\proyecto pw2022\Aprender\Dora Sistemas\PowerTalks2024\pdfbuilder_demo\documentos"
integer li_result

li_result = GetFolder( "Documents", ls_path )

sle_path.text=ls_path  

lb_dirlist.DirList(ls_path+"\*.jpg", 0)
end event

type st_path from statictext within w_docs
integer x = 69
integer y = 120
integer width = 183
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Path:"
boolean focusrectangle = false
end type

type sle_path from singlelineedit within w_docs
integer x = 265
integer y = 96
integer width = 2519
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "C:\proyecto pw2022\Aprender\Dora Sistemas\PowerTalks2024\pdfbuilder_demo\documentos"
borderstyle borderstyle = stylelowered!
end type

