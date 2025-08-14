$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_get from commandbutton within w_main
end type
type st_columna from statictext within w_main
end type
type st_codigo from statictext within w_main
end type
type st_tipoter from statictext within w_main
end type
type st_empresa from statictext within w_main
end type
type sle_columna from singlelineedit within w_main
end type
type cb_delete from commandbutton within w_main
end type
type cb_update from commandbutton within w_main
end type
type cb_insert from commandbutton within w_main
end type
type sle_codigo from singlelineedit within w_main
end type
type sle_tipoter from singlelineedit within w_main
end type
type sle_empresa from singlelineedit within w_main
end type
type cb_retrieve from commandbutton within w_main
end type
type dw_1 from datawindow within w_main
end type
type p_2 from picture within w_main
end type
type st_info from statictext within w_main
end type
type st_myversion from statictext within w_main
end type
type st_platform from statictext within w_main
end type
type r_2 from rectangle within w_main
end type
end forward

global type w_main from window
integer width = 4773
integer height = 3236
boolean titlebar = true
string title = "Demo Use Objects"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
string icon = "AppIcon!"
boolean center = true
cb_get cb_get
st_columna st_columna
st_codigo st_codigo
st_tipoter st_tipoter
st_empresa st_empresa
sle_columna sle_columna
cb_delete cb_delete
cb_update cb_update
cb_insert cb_insert
sle_codigo sle_codigo
sle_tipoter sle_tipoter
sle_empresa sle_empresa
cb_retrieve cb_retrieve
dw_1 dw_1
p_2 p_2
st_info st_info
st_myversion st_myversion
st_platform st_platform
r_2 r_2
end type
global w_main w_main

type prototypes

end prototypes

type variables

end variables

forward prototypes
public subroutine wf_version (statictext ast_version, statictext ast_patform)
public subroutine wf_connect ()
end prototypes

public subroutine wf_version (statictext ast_version, statictext ast_patform);String ls_version, ls_platform
environment env
integer rtn

rtn = GetEnvironment(env)

IF rtn <> 1 THEN 
	ls_version = string(year(today()))
	ls_platform="32"
ELSE
	ls_version = "20"+ string(env.pbmajorrevision)+ "." + string(env.pbbuildnumber)
	ls_platform=string(env.ProcessBitness)
END IF

ls_platform += " Bits"

ast_version.text=ls_version
ast_patform.text=ls_platform

end subroutine

public subroutine wf_connect ();//Connect to Database
SQLCA.DBMS = ProfileString("Setting.ini", "Setup", "DBMS", "") 
SQLCA.ServerName = ProfileString("Setting.ini", "Setup", "ServerName", "")
SQLCA.LogId = ProfileString("Setting.ini", "Setup", "LogId", "")
SQLCA.LogPass = ProfileString("Setting.ini", "Setup", "LogPass", "")
				
if ProfileString("Setting.ini", "Setup", "AutoCommit", "False") = "True" then
	SQLCA.AutoCommit = True
else
	SQLCA.AutoCommit = False
end if
SQLCA.DBParm = ProfileString("Setting.ini", "Setup", "DBParm", "") 


// DataBase Connect
Connect Using SQLCA;

If SQLCA.SQLCode <> 0  Then
	MessageBox ("Error "+string(SQLCA.SQLCode), SQLCA.SQLErrText)
End If
end subroutine

on w_main.create
this.cb_get=create cb_get
this.st_columna=create st_columna
this.st_codigo=create st_codigo
this.st_tipoter=create st_tipoter
this.st_empresa=create st_empresa
this.sle_columna=create sle_columna
this.cb_delete=create cb_delete
this.cb_update=create cb_update
this.cb_insert=create cb_insert
this.sle_codigo=create sle_codigo
this.sle_tipoter=create sle_tipoter
this.sle_empresa=create sle_empresa
this.cb_retrieve=create cb_retrieve
this.dw_1=create dw_1
this.p_2=create p_2
this.st_info=create st_info
this.st_myversion=create st_myversion
this.st_platform=create st_platform
this.r_2=create r_2
this.Control[]={this.cb_get,&
this.st_columna,&
this.st_codigo,&
this.st_tipoter,&
this.st_empresa,&
this.sle_columna,&
this.cb_delete,&
this.cb_update,&
this.cb_insert,&
this.sle_codigo,&
this.sle_tipoter,&
this.sle_empresa,&
this.cb_retrieve,&
this.dw_1,&
this.p_2,&
this.st_info,&
this.st_myversion,&
this.st_platform,&
this.r_2}
end on

on w_main.destroy
destroy(this.cb_get)
destroy(this.st_columna)
destroy(this.st_codigo)
destroy(this.st_tipoter)
destroy(this.st_empresa)
destroy(this.sle_columna)
destroy(this.cb_delete)
destroy(this.cb_update)
destroy(this.cb_insert)
destroy(this.sle_codigo)
destroy(this.sle_tipoter)
destroy(this.sle_empresa)
destroy(this.cb_retrieve)
destroy(this.dw_1)
destroy(this.p_2)
destroy(this.st_info)
destroy(this.st_myversion)
destroy(this.st_platform)
destroy(this.r_2)
end on

event open;wf_version(st_myversion, st_platform)
wf_connect()

dw_1.SetTRansObject(SQLCA)






end event

event closequery;
end event

type cb_get from commandbutton within w_main
integer x = 622
integer y = 2824
integer width = 457
integer height = 128
integer taborder = 90
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Get"
end type

event clicked;String ls_empresa, ls_tipoter, ls_codigo
String ls_fieldname, ls_field

IF dw_1.RowCount() = 0 THEN
	messagebox("Error", "Retrieve data first.")
	RETURN
END IF

ls_empresa = sle_empresa.text
ls_tipoter = sle_tipoter.text
ls_codigo = sle_codigo.text
ls_field = sle_columna.text

ls_fieldname = gf_get_column_genter(ls_field, ls_empresa, ls_tipoter, ls_codigo)

messagebox("gf_get_column_genter("+char(34)+ls_field+char(34)+", "+ls_empresa+", "+ls_tipoter+", "+ls_codigo+")", "ls_fieldname = "+ls_fieldname)

end event

type st_columna from statictext within w_main
integer x = 155
integer y = 2744
integer width = 439
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
string text = "Columna"
boolean focusrectangle = false
end type

type st_codigo from statictext within w_main
integer x = 3648
integer y = 2652
integer width = 457
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
string text = "Codigo"
boolean focusrectangle = false
end type

type st_tipoter from statictext within w_main
integer x = 3191
integer y = 2656
integer width = 457
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
string text = "Tipoter"
boolean focusrectangle = false
end type

type st_empresa from statictext within w_main
integer x = 2715
integer y = 2656
integer width = 439
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
string text = "Empresa"
boolean focusrectangle = false
end type

type sle_columna from singlelineedit within w_main
integer x = 155
integer y = 2824
integer width = 457
integer height = 128
integer taborder = 90
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "razon"
borderstyle borderstyle = stylelowered!
string placeholder = "columna"
end type

type cb_delete from commandbutton within w_main
integer x = 3643
integer y = 2912
integer width = 457
integer height = 128
integer taborder = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;n_cst_genter ln_genter
Str_genter lstr_genter
String ls_empresa, ls_tipoter, ls_codigo

IF dw_1.RowCount() = 0 THEN
	messagebox("Error", "Retrieve data first.")
	RETURN
END IF

ls_empresa = sle_empresa.text
ls_tipoter = sle_tipoter.text
ls_codigo = sle_codigo.text

ln_genter =  CREATE n_cst_genter
TRY
	//Elimino un registro
	ln_genter.of_Delete(ls_empresa, ls_tipoter, ls_codigo)
	COMMIT;
CATCH(exception ex)
	ROLLBACK;
	messagebox("Error", ex.GetMessage())
END TRY


dw_1.Reset()

destroy n_cst_genter
end event

type cb_update from commandbutton within w_main
integer x = 3182
integer y = 2912
integer width = 457
integer height = 128
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Update"
end type

event clicked;n_cst_genter ln_genter
Str_genter lstr_genter
String ls_empresa, ls_tipoter, ls_codigo

IF dw_1.RowCount() = 0 THEN
	messagebox("Error", "Retrieve data first.")
	RETURN
END IF

ls_empresa = sle_empresa.text
ls_tipoter = sle_tipoter.text
ls_codigo = sle_codigo.text

ln_genter =  CREATE n_cst_genter
TRY
	//Selecciono un registro
	lstr_genter = ln_genter.of_select(ls_empresa, ls_tipoter, ls_codigo)
	
	//Modifico el Nombre 
	lstr_genter.nombre= "Prueba"
	
	ln_genter.of_update(lstr_genter)
	COMMIT;
CATCH(exception ex)
	ROLLBACK;
	messagebox("Error", ex.GetMessage())
END TRY

sle_codigo.text = ls_codigo

dw_1.Retrieve(ls_empresa, ls_tipoter, ls_codigo)

destroy n_cst_genter
end event

type cb_insert from commandbutton within w_main
integer x = 2715
integer y = 2908
integer width = 457
integer height = 128
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insert"
end type

event clicked;n_cst_genter ln_genter
Str_genter lstr_genter
String ls_empresa, ls_tipoter, ls_codigo

IF dw_1.RowCount() = 0 THEN
	messagebox("Error", "Retrieve data first.")
	RETURN
END IF	

ls_empresa = sle_empresa.text
ls_tipoter = sle_tipoter.text
ls_codigo = sle_codigo.text

ln_genter =  CREATE n_cst_genter
TRY
	//Selecciono un registro
	lstr_genter = ln_genter.of_select(ls_empresa, ls_tipoter, ls_codigo)
	
	//Modifico el Nombre 
	
	SELECT max(convert(numeric, codigo)) + 1
	INTO :ls_codigo
	FROM genter
	WHERE empresa=:ls_empresa
	AND tipoter=:ls_tipoter;
	
	lstr_genter.codigo = ls_codigo
	lstr_genter.nombre= "Prueba"
	
	ln_genter.of_insert(lstr_genter)
	COMMIT;
CATCH(exception ex)
	ROLLBACK;
	messagebox("Error", ex.GetMessage())
END TRY

sle_codigo.text = ls_codigo

dw_1.Retrieve(ls_empresa, ls_tipoter, ls_codigo)

destroy n_cst_genter
end event

type sle_codigo from singlelineedit within w_main
integer x = 3643
integer y = 2736
integer width = 457
integer height = 128
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string placeholder = "codigo"
end type

type sle_tipoter from singlelineedit within w_main
integer x = 3182
integer y = 2736
integer width = 457
integer height = 128
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string placeholder = "tipoter"
end type

type sle_empresa from singlelineedit within w_main
integer x = 2715
integer y = 2736
integer width = 457
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string placeholder = "empresa"
end type

type cb_retrieve from commandbutton within w_main
integer x = 4114
integer y = 2736
integer width = 457
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
end type

event clicked;String ls_empresa, ls_tipoter, ls_codigo

ls_empresa = sle_empresa.text
ls_tipoter = sle_tipoter.text
ls_codigo = sle_codigo.text
dw_1.Retrieve(ls_empresa, ls_tipoter, ls_codigo)
end event

type dw_1 from datawindow within w_main
integer x = 64
integer y = 336
integer width = 4654
integer height = 2300
integer taborder = 10
string title = "none"
string dataobject = "dw_genter"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type p_2 from picture within w_main
integer x = 5
integer y = 4
integer width = 1253
integer height = 248
boolean originalsize = true
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type st_info from statictext within w_main
integer x = 3447
integer y = 3084
integer width = 1289
integer height = 52
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 553648127
string text = "Copyright © Ramón San Félix Ramón  rsrsystem.soft@gmail.com"
boolean focusrectangle = false
end type

type st_myversion from statictext within w_main
integer x = 4242
integer y = 48
integer width = 489
integer height = 84
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Versión"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_platform from statictext within w_main
integer x = 4242
integer y = 136
integer width = 489
integer height = 84
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Bits"
alignment alignment = right!
boolean focusrectangle = false
end type

type r_2 from rectangle within w_main
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 33521664
integer width = 4768
integer height = 260
end type

