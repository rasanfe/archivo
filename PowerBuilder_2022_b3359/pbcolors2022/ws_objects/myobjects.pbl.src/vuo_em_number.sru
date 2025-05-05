$PBExportHeader$vuo_em_number.sru
forward
global type vuo_em_number from vs_em_master
end type
end forward

global type vuo_em_number from vs_em_master
integer width = 343
integer height = 80
integer textsize = -8
fontcharset fontcharset = defaultcharset!
string facename = "Arial"
long textcolor = 0
long backcolor = 16777215
alignment alignment = right!
string mask = "#############0"
end type
global vuo_em_number vuo_em_number

on vuo_em_number.create
call super::create
end on

on vuo_em_number.destroy
call super::destroy
end on

