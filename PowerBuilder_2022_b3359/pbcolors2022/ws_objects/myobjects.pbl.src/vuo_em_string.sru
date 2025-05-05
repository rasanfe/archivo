$PBExportHeader$vuo_em_string.sru
forward
global type vuo_em_string from vs_em_master
end type
end forward

global type vuo_em_string from vs_em_master
integer width = 343
integer height = 80
integer textsize = -8
fontcharset fontcharset = defaultcharset!
string facename = "Arial"
long textcolor = 0
long backcolor = 16777215
string text = ""
alignment alignment = right!
maskdatatype maskdatatype = stringmask!
end type
global vuo_em_string vuo_em_string

on vuo_em_string.create
call super::create
end on

on vuo_em_string.destroy
call super::destroy
end on

