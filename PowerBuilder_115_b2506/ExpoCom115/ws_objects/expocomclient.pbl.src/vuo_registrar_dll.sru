$PBExportHeader$vuo_registrar_dll.sru
forward
global type vuo_registrar_dll from userobject
end type
type cb_unreg_dll from commandbutton within vuo_registrar_dll
end type
type cb_reg_dll from commandbutton within vuo_registrar_dll
end type
end forward

global type vuo_registrar_dll from userobject
integer width = 613
integer height = 136
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_unreg_dll cb_unreg_dll
cb_reg_dll cb_reg_dll
end type
global vuo_registrar_dll vuo_registrar_dll

type variables
String is_AssemblyPath, is_AssemblyName
end variables

on vuo_registrar_dll.create
this.cb_unreg_dll=create cb_unreg_dll
this.cb_reg_dll=create cb_reg_dll
this.Control[]={this.cb_unreg_dll,&
this.cb_reg_dll}
end on

on vuo_registrar_dll.destroy
destroy(this.cb_unreg_dll)
destroy(this.cb_reg_dll)
end on

event constructor;is_AssemblyPath = GetCurrentDirectory() +"\"

end event

type cb_unreg_dll from commandbutton within vuo_registrar_dll
integer x = 297
integer y = 16
integer width = 293
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "hyperlink!"
string text = "Unreg DLL"
end type

event clicked;String ls_assemblypath
String ls_Run

IF messagebox("Registrar", "¿ Quere Des-Registrar las Librerias ?" +"~r~n"+ "(Se requiere permiso de administrador)", question!, yesno!, 1) = 2 THEN RETURN

ls_Run = "regsvr32.exe /u "+char(34)+ls_AssemblyPath + is_AssemblyName +char(34)

Run(ls_Run, Minimized!)

end event

type cb_reg_dll from commandbutton within vuo_registrar_dll
integer y = 16
integer width = 293
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "hyperlink!"
string text = "Reg DLL"
end type

event clicked;String ls_Run

IF messagebox("Registrar", "¿ Quere Registrar las Librerias ?" +"~r~n"+ "(Se requiere permiso de administrador)", question!, yesno!, 1) = 2 THEN RETURN

ls_Run = "regsvr32.exe "+char(34)+is_AssemblyPath+ is_AssemblyName +char(34)

Run(ls_Run, Minimized!)


end event

