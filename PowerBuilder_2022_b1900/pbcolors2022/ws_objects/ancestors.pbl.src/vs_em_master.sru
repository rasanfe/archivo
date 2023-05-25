$PBExportHeader$vs_em_master.sru
forward
global type vs_em_master from editmask
end type
end forward

global type vs_em_master from editmask
integer width = 402
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type
global vs_em_master vs_em_master

on vs_em_master.create
end on

on vs_em_master.destroy
end on

event getfocus;This.SelectText(1,Len(trim(This.Text)))
end event

