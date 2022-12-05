$PBExportHeader$vuo_em_rgb_number.sru
forward
global type vuo_em_rgb_number from vs_em_master
end type
end forward

global type vuo_em_rgb_number from vs_em_master
integer width = 233
integer height = 80
string text = "255"
string mask = "##0"
string minmax = "0~~255"
long textcolor = 33554432
end type
global vuo_em_rgb_number vuo_em_rgb_number

on vuo_em_rgb_number.create
call super::create
end on

on vuo_em_rgb_number.destroy
call super::destroy
end on

