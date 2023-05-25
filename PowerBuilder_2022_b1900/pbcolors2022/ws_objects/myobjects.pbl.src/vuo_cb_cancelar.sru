$PBExportHeader$vuo_cb_cancelar.sru
forward
global type vuo_cb_cancelar from vs_cb_master
end type
end forward

global type vuo_cb_cancelar from vs_cb_master
integer width = 343
integer height = 104
string text = "Cancelar"
end type
global vuo_cb_cancelar vuo_cb_cancelar

on vuo_cb_cancelar.create
call super::create
end on

on vuo_cb_cancelar.destroy
call super::destroy
end on

