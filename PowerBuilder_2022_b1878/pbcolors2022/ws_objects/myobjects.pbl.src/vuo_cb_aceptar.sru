$PBExportHeader$vuo_cb_aceptar.sru
forward
global type vuo_cb_aceptar from vs_cb_master
end type
end forward

global type vuo_cb_aceptar from vs_cb_master
integer width = 343
integer height = 104
string text = "Aceptar"
end type
global vuo_cb_aceptar vuo_cb_aceptar

on vuo_cb_aceptar.create
call super::create
end on

on vuo_cb_aceptar.destroy
call super::destroy
end on

