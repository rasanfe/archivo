$PBExportHeader$w_settings.srw
forward
global type w_settings from window
end type
type st_1 from statictext within w_settings
end type
type cb_close from commandbutton within w_settings
end type
type sle_userpassword from singlelineedit within w_settings
end type
type sle_masterpassword from singlelineedit within w_settings
end type
type sle_title from singlelineedit within w_settings
end type
type sle_subject from singlelineedit within w_settings
end type
type sle_keywords from singlelineedit within w_settings
end type
type sle_author from singlelineedit within w_settings
end type
type sle_application from singlelineedit within w_settings
end type
type st_title from statictext within w_settings
end type
type st_subject from statictext within w_settings
end type
type st_keywords from statictext within w_settings
end type
type st_author from statictext within w_settings
end type
type st_application from statictext within w_settings
end type
type st_userpassword from statictext within w_settings
end type
type st_masterpassword from statictext within w_settings
end type
type cbx_allowprint from checkbox within w_settings
end type
type cbx_allowplainmetadata from checkbox within w_settings
end type
type cbx_allowmodify from checkbox within w_settings
end type
type cbx_allowhighresolutionprint from checkbox within w_settings
end type
type cbx_allowforms from checkbox within w_settings
end type
type cbx_allowcopy from checkbox within w_settings
end type
type cbx_allowassemble from checkbox within w_settings
end type
type cbx_allowannotations from checkbox within w_settings
end type
type gb_1 from groupbox within w_settings
end type
type gb_2 from groupbox within w_settings
end type
type gb_3 from groupbox within w_settings
end type
end forward

global type w_settings from window
integer width = 3200
integer height = 1444
boolean titlebar = true
string title = "Document Properties and Security"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_close cb_close
sle_userpassword sle_userpassword
sle_masterpassword sle_masterpassword
sle_title sle_title
sle_subject sle_subject
sle_keywords sle_keywords
sle_author sle_author
sle_application sle_application
st_title st_title
st_subject st_subject
st_keywords st_keywords
st_author st_author
st_application st_application
st_userpassword st_userpassword
st_masterpassword st_masterpassword
cbx_allowprint cbx_allowprint
cbx_allowplainmetadata cbx_allowplainmetadata
cbx_allowmodify cbx_allowmodify
cbx_allowhighresolutionprint cbx_allowhighresolutionprint
cbx_allowforms cbx_allowforms
cbx_allowcopy cbx_allowcopy
cbx_allowassemble cbx_allowassemble
cbx_allowannotations cbx_allowannotations
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_settings w_settings

type variables
PDFDocument		ipdf_doc
end variables

on w_settings.create
this.st_1=create st_1
this.cb_close=create cb_close
this.sle_userpassword=create sle_userpassword
this.sle_masterpassword=create sle_masterpassword
this.sle_title=create sle_title
this.sle_subject=create sle_subject
this.sle_keywords=create sle_keywords
this.sle_author=create sle_author
this.sle_application=create sle_application
this.st_title=create st_title
this.st_subject=create st_subject
this.st_keywords=create st_keywords
this.st_author=create st_author
this.st_application=create st_application
this.st_userpassword=create st_userpassword
this.st_masterpassword=create st_masterpassword
this.cbx_allowprint=create cbx_allowprint
this.cbx_allowplainmetadata=create cbx_allowplainmetadata
this.cbx_allowmodify=create cbx_allowmodify
this.cbx_allowhighresolutionprint=create cbx_allowhighresolutionprint
this.cbx_allowforms=create cbx_allowforms
this.cbx_allowcopy=create cbx_allowcopy
this.cbx_allowassemble=create cbx_allowassemble
this.cbx_allowannotations=create cbx_allowannotations
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.st_1,&
this.cb_close,&
this.sle_userpassword,&
this.sle_masterpassword,&
this.sle_title,&
this.sle_subject,&
this.sle_keywords,&
this.sle_author,&
this.sle_application,&
this.st_title,&
this.st_subject,&
this.st_keywords,&
this.st_author,&
this.st_application,&
this.st_userpassword,&
this.st_masterpassword,&
this.cbx_allowprint,&
this.cbx_allowplainmetadata,&
this.cbx_allowmodify,&
this.cbx_allowhighresolutionprint,&
this.cbx_allowforms,&
this.cbx_allowcopy,&
this.cbx_allowassemble,&
this.cbx_allowannotations,&
this.gb_1,&
this.gb_2,&
this.gb_3}
end on

on w_settings.destroy
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.sle_userpassword)
destroy(this.sle_masterpassword)
destroy(this.sle_title)
destroy(this.sle_subject)
destroy(this.sle_keywords)
destroy(this.sle_author)
destroy(this.sle_application)
destroy(this.st_title)
destroy(this.st_subject)
destroy(this.st_keywords)
destroy(this.st_author)
destroy(this.st_application)
destroy(this.st_userpassword)
destroy(this.st_masterpassword)
destroy(this.cbx_allowprint)
destroy(this.cbx_allowplainmetadata)
destroy(this.cbx_allowmodify)
destroy(this.cbx_allowhighresolutionprint)
destroy(this.cbx_allowforms)
destroy(this.cbx_allowcopy)
destroy(this.cbx_allowassemble)
destroy(this.cbx_allowannotations)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;ipdf_doc = message.PowerObjectParm

cbx_allowannotations.checked = ipdf_doc.security.allowannotations
cbx_allowassemble.checked = ipdf_doc.security.allowassemble
cbx_allowcopy.checked = ipdf_doc.security.allowcopy
cbx_allowforms.checked = ipdf_doc.security.allowforms
cbx_allowhighresolutionprint.checked = ipdf_doc.security.allowhighresolutionprint
cbx_allowmodify.checked = ipdf_doc.security.allowmodify
cbx_allowplainmetadata.checked = ipdf_doc.security.allowplainmetadata
cbx_allowprint.checked = ipdf_doc.security.allowprint

//Nota:
//La configuración de seguridad no incluye la contraseña maestra ni la contraseña de usuario.
//Para que la configuración de seguridad surta efecto, debe especificar manualmente las contraseñas 
//para el objeto PDFDocument antes o después de la importación.

sle_application.text = ipdf_doc.properties.application
sle_author.text = ipdf_doc.properties.author
sle_keywords.text = ipdf_doc.properties.keywords
sle_subject.text = ipdf_doc.properties.subject
sle_title.text = ipdf_doc.properties.title
end event

type st_1 from statictext within w_settings
integer x = 2066
integer y = 1192
integer width = 1047
integer height = 132
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

event clicked;sle_masterpassword.text = "rsrsystem"
sleep(0.5)
sle_userpassword.text = "dorasistemas"
sleep(0.5)
sle_application.text = "PowerBuilder 2022"
sleep(0.5)
sle_author.text = "Ramón San Félix Ramón"
sleep(0.5)
sle_keywords.text = "PDF Builder"
sleep(0.5)
sle_subject.text = "PDF Builder Demo"
sleep(0.5)
sle_title.text = "PowerBuilder PDF Builder Demo"
end event

type cb_close from commandbutton within w_settings
integer x = 1385
integer y = 1208
integer width = 402
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;ipdf_doc.security.allowannotations = cbx_allowannotations.checked
ipdf_doc.security.allowassemble = cbx_allowassemble.checked
ipdf_doc.security.allowcopy = cbx_allowcopy.checked
ipdf_doc.security.allowforms = cbx_allowforms.checked
ipdf_doc.security.allowhighresolutionprint = cbx_allowhighresolutionprint.checked
ipdf_doc.security.allowmodify = cbx_allowmodify.checked
ipdf_doc.security.allowplainmetadata = cbx_allowplainmetadata.checked
ipdf_doc.security.allowprint = cbx_allowprint.checked

ipdf_doc.security.masterpassword = sle_masterpassword.text
ipdf_doc.security.userpassword = sle_userpassword.text

ipdf_doc.properties.application = sle_application.text
ipdf_doc.properties.author = sle_author.text
ipdf_doc.properties.keywords = sle_keywords.text
ipdf_doc.properties.subject = sle_subject.text
ipdf_doc.properties.title = sle_title.text

CloseWithReturn ( parent, ipdf_doc )
end event

type sle_userpassword from singlelineedit within w_settings
integer x = 1595
integer y = 288
integer width = 1449
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_masterpassword from singlelineedit within w_settings
integer x = 1595
integer y = 156
integer width = 1449
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_title from singlelineedit within w_settings
integer x = 1595
integer y = 1016
integer width = 1449
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_subject from singlelineedit within w_settings
integer x = 1595
integer y = 884
integer width = 1449
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_keywords from singlelineedit within w_settings
integer x = 1595
integer y = 752
integer width = 1449
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_author from singlelineedit within w_settings
integer x = 1595
integer y = 620
integer width = 1449
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_application from singlelineedit within w_settings
integer x = 1595
integer y = 488
integer width = 1449
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_title from statictext within w_settings
integer x = 1088
integer y = 1040
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Title:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_subject from statictext within w_settings
integer x = 1088
integer y = 908
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Subject:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_keywords from statictext within w_settings
integer x = 1088
integer y = 776
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Keywords:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_author from statictext within w_settings
integer x = 1088
integer y = 644
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Author:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_application from statictext within w_settings
integer x = 1088
integer y = 512
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Application:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_userpassword from statictext within w_settings
integer x = 1143
integer y = 288
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "User:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_masterpassword from statictext within w_settings
integer x = 1088
integer y = 172
integer width = 443
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Master:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_allowprint from checkbox within w_settings
integer x = 133
integer y = 920
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "AllowPrint"
end type

type cbx_allowplainmetadata from checkbox within w_settings
integer x = 133
integer y = 808
integer width = 590
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "AllowPlainMetadata"
end type

type cbx_allowmodify from checkbox within w_settings
integer x = 133
integer y = 696
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "AllowModify"
end type

type cbx_allowhighresolutionprint from checkbox within w_settings
integer x = 133
integer y = 584
integer width = 727
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "AllowHighResolutionPrint"
end type

type cbx_allowforms from checkbox within w_settings
integer x = 133
integer y = 472
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "AllowForms"
end type

type cbx_allowcopy from checkbox within w_settings
integer x = 133
integer y = 360
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "AllowCopy"
end type

type cbx_allowassemble from checkbox within w_settings
integer x = 133
integer y = 248
integer width = 475
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "AllowAssemble"
end type

type cbx_allowannotations from checkbox within w_settings
integer x = 133
integer y = 136
integer width = 530
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "AllowAnnotations"
end type

type gb_1 from groupbox within w_settings
integer x = 41
integer y = 40
integer width = 942
integer height = 1044
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Security"
end type

type gb_2 from groupbox within w_settings
integer x = 1010
integer y = 392
integer width = 2112
integer height = 780
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Properties"
end type

type gb_3 from groupbox within w_settings
integer x = 1029
integer y = 76
integer width = 2112
integer height = 320
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Passwords"
end type

