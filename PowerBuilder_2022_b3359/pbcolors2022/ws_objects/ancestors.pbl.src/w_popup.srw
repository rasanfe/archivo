$PBExportHeader$w_popup.srw
forward
global type w_popup from w_ancestor
end type
end forward

global type w_popup from w_ancestor
integer width = 2295
integer height = 1188
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
end type
global w_popup w_popup

on w_popup.create
call super::create
end on

on w_popup.destroy
call super::destroy
end on

