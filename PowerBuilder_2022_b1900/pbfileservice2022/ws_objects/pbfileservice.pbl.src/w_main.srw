$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_6 from commandbutton within w_main
end type
type cb_5 from commandbutton within w_main
end type
type cb_4 from commandbutton within w_main
end type
type cb_2 from commandbutton within w_main
end type
type cb_1 from commandbutton within w_main
end type
type p_2 from picture within w_main
end type
type cb_3 from commandbutton within w_main
end type
type st_6 from statictext within w_main
end type
type sle_file from singlelineedit within w_main
end type
type st_info from statictext within w_main
end type
type sle_result from singlelineedit within w_main
end type
type st_4 from statictext within w_main
end type
type st_myversion from statictext within w_main
end type
type st_platform from statictext within w_main
end type
type cb_sign from commandbutton within w_main
end type
type r_2 from rectangle within w_main
end type
end forward

global type w_main from window
integer width = 2363
integer height = 1228
boolean titlebar = true
string title = "PbFileService"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
string icon = "AppIcon!"
boolean center = true
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_2 cb_2
cb_1 cb_1
p_2 p_2
cb_3 cb_3
st_6 st_6
sle_file sle_file
st_info st_info
sle_result sle_result
st_4 st_4
st_myversion st_myversion
st_platform st_platform
cb_sign cb_sign
r_2 r_2
end type
global w_main w_main

type prototypes

end prototypes

type variables
nvo_fileservice in_file
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
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.p_2=create p_2
this.cb_3=create cb_3
this.st_6=create st_6
this.sle_file=create sle_file
this.st_info=create st_info
this.sle_result=create sle_result
this.st_4=create st_4
this.st_myversion=create st_myversion
this.st_platform=create st_platform
this.cb_sign=create cb_sign
this.r_2=create r_2
this.Control[]={this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_2,&
this.cb_1,&
this.p_2,&
this.cb_3,&
this.st_6,&
this.sle_file,&
this.st_info,&
this.sle_result,&
this.st_4,&
this.st_myversion,&
this.st_platform,&
this.cb_sign,&
this.r_2}
end on

on w_main.destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.p_2)
destroy(this.cb_3)
destroy(this.st_6)
destroy(this.sle_file)
destroy(this.st_info)
destroy(this.sle_result)
destroy(this.st_4)
destroy(this.st_myversion)
destroy(this.st_platform)
destroy(this.cb_sign)
destroy(this.r_2)
end on

event open;wf_version(st_myversion, st_platform)


in_file =  CREATE  nvo_fileservice 
end event

event closequery;Destroy in_file
end event

type cb_6 from commandbutton within w_main
integer x = 1189
integer y = 928
integer width = 745
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Change File Extension to TMP"
end type

event clicked;String ls_fileName

ls_fileName =in_file.of_changeextension(sle_file.text, ".tmp")

//Checks the result
IF in_file.il_ErrorType < 0 THEN
  messagebox("Failed", in_file.is_ErrorText)
  RETURN
END IF


IF isnull(ls_fileName) THEN ls_fileName=""

sle_result.text = ls_fileName


end event

type cb_5 from commandbutton within w_main
integer x = 1189
integer y = 820
integer width = 745
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ends in Directory DSeparator"
end type

event clicked;Boolean lb_result

lb_result =in_file.of_endsindirectoryseparator(sle_file.text)

//Checks the result
IF in_file.il_ErrorType < 0 THEN
  messagebox("Failed", in_file.is_ErrorText)
else
	messagebox("Result", string(lb_result ))
END IF


end event

type cb_4 from commandbutton within w_main
integer x = 1189
integer y = 708
integer width = 745
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Get Directory Name"
end type

event clicked;String ls_DirectoryName

ls_DirectoryName =  in_file.of_getdirectoryname(sle_file.text)

//Checks the result
IF in_file.il_ErrorType < 0 THEN
  messagebox("Failed", in_file.is_ErrorText)
  RETURN
END IF


IF isnull(ls_DirectoryName) THEN ls_DirectoryName=""

sle_result.text = ls_DirectoryName


end event

type cb_2 from commandbutton within w_main
integer x = 416
integer y = 708
integer width = 745
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Get Filename"
end type

event clicked;String ls_fileName

ls_fileName = in_file.of_getfilename(sle_file.text)

//Checks the result
IF in_file.il_ErrorType < 0 THEN
  messagebox("Failed", in_file.is_ErrorText)
  RETURN
END IF

IF isnull(ls_fileName) THEN ls_fileName=""

sle_result.text = ls_fileName




end event

type cb_1 from commandbutton within w_main
integer x = 416
integer y = 920
integer width = 745
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Get Extension"
end type

event clicked;String ls_FileExtension

ls_FileExtension = in_file.of_getextension(sle_file.text)

//Checks the result
IF in_file.il_ErrorType < 0 THEN
  messagebox("Failed", in_file.is_ErrorText)
  RETURN
END IF

IF isnull(ls_FileExtension) THEN ls_FileExtension=""

sle_result.text = ls_FileExtension



end event

type p_2 from picture within w_main
integer x = 5
integer y = 4
integer width = 1253
integer height = 248
boolean originalsize = true
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_main
integer x = 1934
integer y = 344
integer width = 174
integer height = 92
integer taborder = 20
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

ls_ruta=gs_dir
ls_current=GetCurrentDirectory ( )
li_rtn = GetFileOpenName("Archivo a cargar", sle_file.text, ls_path, "*.*", "All Files (*.*), *.*", ls_ruta)
ChangeDirectory ( ls_current )




end event

type st_6 from statictext within w_main
integer x = 64
integer y = 364
integer width = 279
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "File"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_file from singlelineedit within w_main
integer x = 361
integer y = 344
integer width = 1563
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
borderstyle borderstyle = stylelowered!
end type

type st_info from statictext within w_main
integer x = 1015
integer y = 1060
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

type sle_result from singlelineedit within w_main
integer x = 361
integer y = 488
integer width = 1563
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_main
integer x = 64
integer y = 508
integer width = 279
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Result"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_myversion from statictext within w_main
integer x = 1810
integer y = 56
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
integer x = 1810
integer y = 144
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

type cb_sign from commandbutton within w_main
integer x = 416
integer y = 816
integer width = 745
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Get Filename Without Extension"
end type

event clicked;String ls_fileName

ls_fileName =  in_file.of_getfilenamewithoutextension(sle_file.text)

//Checks the result
IF in_file.il_ErrorType < 0 THEN
  messagebox("Failed", in_file.is_ErrorText)
  RETURN
END IF

IF isnull(ls_fileName) THEN ls_fileName=""

sle_result.text = ls_fileName



end event

type r_2 from rectangle within w_main
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 33521664
integer width = 2331
integer height = 260
end type

