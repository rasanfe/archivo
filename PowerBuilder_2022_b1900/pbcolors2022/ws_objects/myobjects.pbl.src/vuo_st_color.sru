$PBExportHeader$vuo_st_color.sru
forward
global type vuo_st_color from vs_st_master
end type
end forward

global type vuo_st_color from vs_st_master
integer width = 69
integer height = 60
integer textsize = -8
fontcharset fontcharset = defaultcharset!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 16777215
long backcolor = 16777215
string text = ""
boolean border = true
long bordercolor = 12632256
end type
global vuo_st_color vuo_st_color

on vuo_st_color.create
call super::create
end on

on vuo_st_color.destroy
call super::destroy
end on

