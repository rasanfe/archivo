$PBExportHeader$vs_cst_displayname.sru
forward
global type vs_cst_displayname from userobject
end type
type p_project_type from picture within vs_cst_displayname
end type
type p_displayname from picture within vs_cst_displayname
end type
type uo_background from vs_r_master within vs_cst_displayname
end type
type st_copyright from statictext within vs_cst_displayname
end type
end forward

global type vs_cst_displayname from userobject
integer width = 3301
integer height = 280
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event resize pbm_size
p_project_type p_project_type
p_displayname p_displayname
uo_background uo_background
st_copyright st_copyright
end type
global vs_cst_displayname vs_cst_displayname

forward prototypes
public subroutine of_set_colors ()
end prototypes

event resize;uo_background.width = this.width
uo_background.height = this.height

end event

public subroutine of_set_colors ();Long ll_ColorFondo, ll_ColorTexto


ll_ColorTexto = 16777215
ll_ColorFondo = 33521664
	

uo_background.BackColor = ll_ColorFondo
st_copyright.textColor = ll_ColorTexto
st_copyright.backcolor= ll_ColorFondo


end subroutine

on vs_cst_displayname.create
this.p_project_type=create p_project_type
this.p_displayname=create p_displayname
this.uo_background=create uo_background
this.st_copyright=create st_copyright
this.Control[]={this.p_project_type,&
this.p_displayname,&
this.uo_background,&
this.st_copyright}
end on

on vs_cst_displayname.destroy
destroy(this.p_project_type)
destroy(this.p_displayname)
destroy(this.uo_background)
destroy(this.st_copyright)
end on

event constructor;CHOOSE CASE TRUE
	CASE isPowerServerapp() 
		p_project_type.PictureName = "imagenes\PowerServerApp.png"
	CASE isPowerClientApp()
		p_project_type.PictureName = "imagenes\PowerClientApp.png"
	CASE isPBApp()	
		p_project_type.PictureName = "imagenes\PBApp.png"
END CHOOSE

uo_background.x = 0
uo_background.y = 0
uo_background.width = this.width
uo_background.height = this.height


end event

type p_project_type from picture within vs_cst_displayname
integer x = 69
integer y = 28
integer width = 288
integer height = 216
string picturename = "imagenes\PowerServerApp.png"
boolean focusrectangle = false
end type

type p_displayname from picture within vs_cst_displayname
integer x = 393
integer y = 28
integer width = 1019
integer height = 208
string picturename = "imagenes\logo.png"
boolean focusrectangle = false
end type

type uo_background from vs_r_master within vs_cst_displayname
integer width = 3301
integer height = 272
integer taborder = 10
long backcolor = 33521664
end type

on uo_background.destroy
call vs_r_master::destroy
end on

type st_copyright from statictext within vs_cst_displayname
integer x = 1385
integer y = 144
integer width = 101
integer height = 84
boolean bringtotop = true
integer textsize = -12
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 553648127
string text = "©"
end type

event constructor;call super::constructor;of_set_colors()
end event

