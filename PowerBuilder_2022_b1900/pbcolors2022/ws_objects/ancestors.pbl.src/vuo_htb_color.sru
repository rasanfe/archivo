$PBExportHeader$vuo_htb_color.sru
forward
global type vuo_htb_color from vs_htb_master
end type
end forward

global type vuo_htb_color from vs_htb_master
integer width = 1371
integer maxposition = 255
integer tickfrequency = 3
end type
global vuo_htb_color vuo_htb_color

on vuo_htb_color.create
call super::create
end on

on vuo_htb_color.destroy
call super::destroy
end on

