$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_fill from commandbutton within w_main
end type
type cb_get from commandbutton within w_main
end type
type wb_1 from webbrowser within w_main
end type
type p_1 from picture within w_main
end type
type st_infocopyright from statictext within w_main
end type
type st_myversion from statictext within w_main
end type
type st_platform from statictext within w_main
end type
type sle_file from singlelineedit within w_main
end type
type st_file from statictext within w_main
end type
type cb_openfile from commandbutton within w_main
end type
type r_2 from rectangle within w_main
end type
end forward

global type w_main from window
integer width = 4631
integer height = 3368
boolean titlebar = true
string title = "PowerBuilder Pdf Fill Form Fields"
boolean controlmenu = true
boolean minbox = true
string icon = "AppIcon!"
boolean center = true
cb_fill cb_fill
cb_get cb_get
wb_1 wb_1
p_1 p_1
st_infocopyright st_infocopyright
st_myversion st_myversion
st_platform st_platform
sle_file sle_file
st_file st_file
cb_openfile cb_openfile
r_2 r_2
end type
global w_main w_main

type prototypes
Function boolean QueryPerformanceFrequency ( &
	Ref Double lpFrequency &
	) Library "kernel32.dll"

Function boolean QueryPerformanceCounter ( &
	Ref Double lpPerformanceCount &
	) Library "kernel32.dll"

end prototypes

type variables
Double idbl_frequency = 0



end variables

forward prototypes
public subroutine wf_version (statictext ast_version, statictext ast_patform)
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

on w_main.create
this.cb_fill=create cb_fill
this.cb_get=create cb_get
this.wb_1=create wb_1
this.p_1=create p_1
this.st_infocopyright=create st_infocopyright
this.st_myversion=create st_myversion
this.st_platform=create st_platform
this.sle_file=create sle_file
this.st_file=create st_file
this.cb_openfile=create cb_openfile
this.r_2=create r_2
this.Control[]={this.cb_fill,&
this.cb_get,&
this.wb_1,&
this.p_1,&
this.st_infocopyright,&
this.st_myversion,&
this.st_platform,&
this.sle_file,&
this.st_file,&
this.cb_openfile,&
this.r_2}
end on

on w_main.destroy
destroy(this.cb_fill)
destroy(this.cb_get)
destroy(this.wb_1)
destroy(this.p_1)
destroy(this.st_infocopyright)
destroy(this.st_myversion)
destroy(this.st_platform)
destroy(this.sle_file)
destroy(this.st_file)
destroy(this.cb_openfile)
destroy(this.r_2)
end on

event open;wf_version(st_myversion, st_platform)

sle_file.text = gs_dir + "Modelo145.pdf"
wb_1.Navigate(sle_file.text)

end event

type cb_fill from commandbutton within w_main
integer x = 2592
integer y = 332
integer width = 411
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Fill Form Fileds"
end type

event clicked;nvo_pdffill ln_pdf
String ls_FormFields[], ls_FormData[]
String ls_PdfFile, ls_PdfFileOut, ls_error, ls_result, ls_format
Integer li_FormatLen
Long ll_Field, ll_TotalFileds

ln_pdf = CREATE nvo_pdffill

ls_PdfFile = sle_file.text

li_FormatLen = Len(ls_PdfFile) - LastPos(ls_PdfFile, ".") + 1

ls_format = lower(mid(ls_PdfFile, LastPos(ls_PdfFile, "."),  li_FormatLen))

ls_PdfFileOut = replace(ls_PdfFile, pos(ls_PdfFile, ls_format), li_FormatLen, "_2.pdf")

ls_FormFields[1] = "genter_compuesto"
ls_FormData[1]="APELLIDO APELLIDO, NOMBRE"

ls_FormFields[2] = "genter_anyo_nacimiento"
ls_FormData[2]="2001"

ls_FormFields[3] = "genter_localidad"
ls_FormData[3]="LOCALIDAD"

ls_FormFields[4] = "genter_mes"
ls_FormData[4]="ENERO"

ls_FormFields[5] = "empresa_localidad"
ls_FormData[5]="LOCALIDAD"

ls_FormFields[6] = "empresa_mes"
ls_FormData[6]="ENERO"

ls_FormFields[7] = "empresa_anyo"
ls_FormData[7]="2024"

ls_FormFields[8] = "genter_razon"
ls_FormData[8]="NOMBRE APELLIDO APELLIDO"

ls_FormFields[9] = "genter_anyo"
ls_FormData[9]="2024"

ls_FormFields[10] = "empresa_admin"
ls_FormData[10]="NOMBRE  GERENTE APELLIDOS"

ls_FormFields[11] = "empresa_razon"
ls_FormData[11]="NOMBRE EMPRESA S.L"

ls_FormFields[12] = "genter_dia"
ls_FormData[12]="03"

ls_FormFields[13] = "empresa_dia"
ls_FormData[13]="03"

ls_FormFields[14] = "genter_nif"
ls_FormData[14]="123456789Z"


If FileExists(ls_PdfFileOut) Then FileDelete(ls_PdfFileOut)
	 
ls_result = ln_pdf.of_FillFormFields(ls_PdfFile, ls_PdfFileOut,  ls_FormFields[], ls_FormData[])

if isnull(ls_result) then ls_result=""
		
//Checks the result
If ln_pdf.il_ErrorType < 0 or ls_result<>"" Then
	ls_error = ln_pdf.is_ErrorText + "Exception: "+ls_result
	Clipboard(ls_error)
	MessageBox("Failed", ls_error  )
	Return
End If

sle_file.text = ls_PdfFileOut
wb_1.Navigate(ls_PdfFileOut)

Destroy ln_pdf
end event

type cb_get from commandbutton within w_main
integer x = 2167
integer y = 332
integer width = 411
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Get Form Fileds"
end type

event clicked;nvo_pdffill ln_pdf
String ls_formfields[]
String ls_PdfFile, ls_error, ls_msg
Long ll_Field, ll_TotalFileds
String ls_result

ln_pdf = CREATE nvo_pdffill

ls_PdfFile = sle_file.text

ls_result = ln_pdf.of_getformfields(ls_PdfFile, ref ls_FormFields[])

if isnull(ls_result) then ls_result=""
		
//Checks the result
If ln_pdf.il_ErrorType < 0 or ls_result<>"" Then
	ls_error = ln_pdf.is_ErrorText + "Exception: "+ls_result
	MessageBox("Failed", ls_error  )
	Return
End If

ll_TotalFileds = UpperBound(ls_FormFields[])
For ll_Field = 1 To ll_TotalFileds
	ls_msg += ls_FormFields[ll_Field]+"~r~n"
Next	

//Mostramos Campos en Pantalla
MessageBox("Form Filelds", ls_msg)

//Para facilitar la programación dejo en clipboard el codigo a falta de poner los datos en los campos.
ls_msg = ""
For ll_Field = 1 To ll_TotalFileds
	ls_msg += "ls_FormFields["+string(ll_Field)+"] = "+char(34)+ ls_FormFields[ll_Field]+char(34)+"~r~n"+"  ls_FormData["+string(ll_Field)+"] = "+char(34)+char(34)+"~r~n"
Next	
clipboard(ls_msg)


end event

type wb_1 from webbrowser within w_main
integer x = 64
integer y = 472
integer width = 4489
integer height = 2712
end type

type p_1 from picture within w_main
integer x = 5
integer y = 4
integer width = 1253
integer height = 248
boolean originalsize = true
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type st_infocopyright from statictext within w_main
integer x = 3255
integer y = 3204
integer width = 1289
integer height = 56
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 553648127
string text = "Copyright © Ramón San Félix Ramón  rsrsystem.soft@gmail.com"
boolean focusrectangle = false
end type

type st_myversion from statictext within w_main
integer x = 4059
integer y = 60
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
integer x = 4059
integer y = 148
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

type sle_file from singlelineedit within w_main
integer x = 251
integer y = 332
integer width = 1673
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_file from statictext within w_main
integer x = 73
integer y = 344
integer width = 169
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "File:"
boolean focusrectangle = false
end type

type cb_openfile from commandbutton within w_main
integer x = 1934
integer y = 332
integer width = 174
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;integer li_rtn
string ls_path, ls_ruta
string  ls_current

ls_ruta= gs_dir
ls_current=GetCurrentDirectory ( )
li_rtn = GetFileOpenName ("Abrir",  sle_file.text, ls_path, "", "All Files (*.*),*.*") 
ChangeDirectory ( ls_current )

if li_rtn < 1 then 	sle_file.text = ""

wb_1.Navigate(sle_file.text)

end event

type r_2 from rectangle within w_main
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 33521664
integer width = 4599
integer height = 260
end type

