$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_4 from statictext within w_main
end type
type st_platform from statictext within w_main
end type
type st_myversion from statictext within w_main
end type
type dw_1 from vs_dw_master within w_main
end type
type rb_3 from radiobutton within w_main
end type
type rb_2 from radiobutton within w_main
end type
type rb_1 from radiobutton within w_main
end type
type st_3 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type cb_retrieve from commandbutton within w_main
end type
type sle_department from singlelineedit within w_main
end type
type sle_customer from singlelineedit within w_main
end type
type sle_serie from singlelineedit within w_main
end type
type dp_2 from datepicker within w_main
end type
type dp_1 from datepicker within w_main
end type
type gb_1 from groupbox within w_main
end type
type gb_2 from groupbox within w_main
end type
type uo_background from vs_cst_displayname within w_main
end type
type gb_3 from groupbox within w_main
end type
end forward

global type w_main from window
integer width = 5248
integer height = 2824
boolean titlebar = true
string title = "Facturas Clientes"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_4 st_4
st_platform st_platform
st_myversion st_myversion
dw_1 dw_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
st_3 st_3
st_2 st_2
st_1 st_1
cb_retrieve cb_retrieve
sle_department sle_department
sle_customer sle_customer
sle_serie sle_serie
dp_2 dp_2
dp_1 dp_1
gb_1 gb_1
gb_2 gb_2
uo_background uo_background
gb_3 gb_3
end type
global w_main w_main

type prototypes
//Funcion para tomar el directorio de la aplicacion  -64Bits 
FUNCTION	uLong	GetModuleFileName ( uLong lhModule, ref string sFileName, ulong nSize )  LIBRARY "Kernel32.dll" ALIAS FOR "GetModuleFileNameW"
end prototypes

type variables
n_resize_service	inv_resize
end variables

forward prototypes
public subroutine wf_retrieve (vs_dw_master dwc)
public subroutine wf_version (statictext ast_version, statictext ast_patform)
public subroutine wf_set_resize (boolean ab_switch)
public subroutine wf_set_windows_size ()
end prototypes

public subroutine wf_retrieve (vs_dw_master dwc);string ls_empresa, ls_serie,  ls_cli1, ls_cli2, ls_situacion, ls_anyo, ls_obra, ls_reporttitle
Datetime ldt_fecha1, ldt_fecha2
any a_values[] 

ls_empresa="1"
ls_anyo="2020"
ldt_fecha1 = dp_1.value
ldt_fecha2 = dp_2.value

if trim(sle_serie.text)<>""  then
	ls_serie= trim(sle_serie.text)
else
	setnull(ls_serie)
end if	

choose case true
	case 	rb_1.checked
		ls_situacion="N"
	case	rb_2.checked
		ls_situacion="S"
	case	rb_3.checked
		 setnull(ls_situacion)
end choose

	
iF Trim(sle_customer.text) = "" Then
   ls_cli1 = "1"
   ls_cli2 = "99999"
   ls_reporttitle = THIS.title
ELSE
	ls_cli1 = sle_customer.text
	ls_cli2 = sle_customer.text
	ls_reporttitle = "Customer Nº "+ls_cli1+" Invoices"
END IF

If  trim(sle_department.text) = "" THEN
	setnull(ls_obra)
ELSE
	ls_obra = sle_department.text
END IF

dwc.setredraw(false)		

a_values[1]  = ls_empresa
a_values[2]  = ls_anyo
a_values[3]  = ls_serie
a_values[4]  = ldt_fecha1
a_values[5]  = ldt_fecha2
a_values[6]  = ls_cli1
a_values[7]  = ls_cli2
a_values[8]  = ls_obra
a_values[9]  = ls_situacion
a_values[10]  = ls_reporttitle


dwc.of_Retrieve(sqlca, a_values[])

dwc.setredraw(true)		
end subroutine

public subroutine wf_version (statictext ast_version, statictext ast_patform);n_osversion in_osver
String ls_build 
String ls_exeFile
String ls_pbyear
Environment		lo_env
integer ii_application_bitness
String ls_version, ls_platform
String ls_Path, ls_dir
ulong lul_handle
boolean lb_RunTime


ls_Path = space(1024)
SetNull(lul_handle)
GetModuleFilename(lul_handle, ls_Path, len(ls_Path))

if right(UPPER(ls_path), 7)="220.EXE" or right(UPPER(ls_path), 7)="X64.EXE" then
	ls_path="C:\proyecto pw2022\Blog\PowerBuilder\Reports_PowerServer\ReportApiExample.exe"
	lb_RunTime = TRUE
end if

ls_dir=left(ls_path, len(ls_path) - 20)


GetEnvironment(lo_env)

ii_application_bitness = lo_env.processbitness
ls_platform = string(ii_application_bitness)+"Bits"	

ls_pbyear =string(lo_env.pbmajorrevision)
if len( ls_pbyear ) = 2 then  ls_pbyear ="20"+ ls_pbyear 

IF lb_RunTime THEN
	ls_build =  string(lo_env.pbbuildnumber)
ELSE	
	ls_exeFile = ls_dir+"ReportApiExample.exe"
	in_osver.of_GetFileVersionInfo(ls_exeFile)
	ls_build= mid(in_osver.FixedProductVersion, lastPos(in_osver.FixedProductVersion, ".") + 1, len(in_osver.FixedProductVersion) - lastPos(in_osver.FixedProductVersion, ".")) 
END IF

ls_version= ls_pbyear+"."+ ls_build

ast_version.text=ls_version
ast_patform.text=ls_platform
end subroutine

public subroutine wf_set_resize (boolean ab_switch);IF ab_switch THEN
	IF NOT IsValid(inv_resize) THEN
		inv_resize = CREATE n_resize_service
	END IF
	//inv_resize.of_setorigsize(this.width, this.height)
	//Prueba para PoerBuilder2022 Quie renderiza las ventanas con un borde mas gordo.
	inv_resize.of_setorigsize(this.width + 25, this.height + 50)
ELSE
	IF IsValid(inv_resize) THEN
		DESTROY inv_resize
	END IF
END IF
this.SetRedraw(TRUE)
end subroutine

public subroutine wf_set_windows_size ();Integer li_AnchoPantalla, li_width, li_height, li_WorkSpaceWidth, li_WorkSpaceHeight
environment	 lenv_object
GetEnvironment (lenv_object) 

li_AnchoPantalla =lenv_object.screenwidth

li_WorkSpaceWidth = This.WorkSpaceWidth() 
li_WorkSpaceHeight =This.WorkSpaceHeight() 

CHOOSE CASE li_AnchoPantalla
	CASE IS < 1600 
		 li_width =li_WorkSpaceWidth + 27
		 li_height = li_WorkSpaceHeight - 400
	CASE 1600 to 1899
			 li_width =li_WorkSpaceWidth + 27
		 li_height = li_WorkSpaceHeight + 132
	CASE  IS >1899
		 li_width =li_WorkSpaceWidth + 27
		 li_height = li_WorkSpaceHeight + 625
END CHOOSE

//li_width = This.Width
//li_height =app.iw_padre.workSpaceHeight() - 700

inv_resize.of_setminsize(li_width - 50, li_height - 50)
this.Resize( li_width, li_height)

end subroutine

on w_main.create
this.st_4=create st_4
this.st_platform=create st_platform
this.st_myversion=create st_myversion
this.dw_1=create dw_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_retrieve=create cb_retrieve
this.sle_department=create sle_department
this.sle_customer=create sle_customer
this.sle_serie=create sle_serie
this.dp_2=create dp_2
this.dp_1=create dp_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.uo_background=create uo_background
this.gb_3=create gb_3
this.Control[]={this.st_4,&
this.st_platform,&
this.st_myversion,&
this.dw_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_retrieve,&
this.sle_department,&
this.sle_customer,&
this.sle_serie,&
this.dp_2,&
this.dp_1,&
this.gb_1,&
this.gb_2,&
this.uo_background,&
this.gb_3}
end on

on w_main.destroy
destroy(this.st_4)
destroy(this.st_platform)
destroy(this.st_myversion)
destroy(this.dw_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_retrieve)
destroy(this.sle_department)
destroy(this.sle_customer)
destroy(this.sle_serie)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.uo_background)
destroy(this.gb_3)
end on

event open;String ls_logidCrypted, ls_logpassCrypted, ls_logid, ls_logpass
n_cst_security_ext ln_seg
dp_1.value=datetime("01-01-2020")
dp_2.value=datetime("31-01-2020")
wf_version(st_myversion, st_platform)


IF isPowerServerApp() = FALSE THEN
	// Profile AdventureWorks2012
	SQLCA.DBMS = ProfileString("Setting.ini", "Setup", "DBMS", "") 
	SQLCA.ServerName = ProfileString("Setting.ini", "Setup", "ServerName", "")
		
	ls_logidCrypted= ProfileString("Setting.ini", "Setup", "LogId", "")
	ls_logpassCrypted=ProfileString("Setting.ini", "Setup", "LogPass", "")
	
	ln_seg = CREATE n_cst_security_ext
	ls_logid=  ln_seg.of_Decrypt(ls_logidCrypted)
	ls_logpass= ln_seg.of_Decrypt( ls_logpassCrypted)
	destroy ln_seg
	
	SQLCA.LogId =ls_logid
	SQLCA.LogPass = ls_logpass
				
	if ProfileString("Setting.ini", "Setup", "AutoCommit", "False") = "True" then
		SQLCA.AutoCommit = True
	else
		SQLCA.AutoCommit = False
	end if
	SQLCA.DBParm = ProfileString("Setting.ini", "Setup", "DBParm", "") 
END IF

// DataBase Connect
Connect Using SQLCA;

//Turn on Resize Service
wf_set_resize(TRUE)
inv_resize.of_setminsize(this.width, this.height)
inv_resize.of_register(uo_background, inv_resize.SCALERIGHT)
inv_resize.of_register(dw_1, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_register(st_myversion, inv_resize.FIXEDRIGHT)
inv_resize.of_register(st_platform, inv_resize.FIXEDRIGHT)
inv_resize.of_register(cb_retrieve, inv_resize.FIXEDRIGHT)
wf_set_windows_size()

end event

event resize;If IsValid (inv_resize) and This.windowstate <> minimized! Then
	inv_resize.Event pfc_Resize (sizetype, newwidth, newheight)
End If
end event

type st_4 from statictext within w_main
integer x = 1938
integer y = 40
integer width = 1257
integer height = 152
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
string text = "PowerTalks2023"
boolean focusrectangle = false
end type

type st_platform from statictext within w_main
integer x = 4672
integer y = 96
integer width = 489
integer height = 84
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 553648127
string text = "Bits"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_myversion from statictext within w_main
integer x = 4672
integer y = 20
integer width = 489
integer height = 84
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 553648127
string text = "Versión"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from vs_dw_master within w_main
integer x = 55
integer y = 572
integer width = 5115
integer height = 2116
integer taborder = 60
string dataobject = "dw_con_listado_venfac_obra"
boolean vscrollbar = true
end type

event constructor;call super::constructor;of_Set_Resize(TRUE)

inv_Resize.of_register("razon_t", inv_Resize.Scaleright)
inv_Resize.of_register("razon", inv_Resize.Scaleright)

inv_Resize.of_register("obra_t", inv_Resize.Fixedright)
inv_Resize.of_register("obra", inv_Resize.Fixedright)

inv_Resize.of_register("descripcion_t", inv_Resize.Fixedright)
inv_Resize.of_register("descripcion", inv_Resize.Fixedright)

inv_Resize.of_register("cod_fp_t", inv_Resize.Fixedright)
inv_Resize.of_register("cod_fp", inv_Resize.Fixedright)

inv_Resize.of_register("forma_pago_t", inv_Resize.Fixedright)
inv_Resize.of_register("forma_pago", inv_Resize.Fixedright)

inv_Resize.of_register("subtotal_t", inv_Resize.Fixedright)
inv_Resize.of_register("subtotal", inv_Resize.Fixedright)

inv_Resize.of_register("total_iva_t", inv_Resize.Fixedright)
inv_Resize.of_register("total_iva", inv_Resize.Fixedright)

inv_Resize.of_register("importe_t", inv_Resize.Fixedright)
inv_Resize.of_register("importe", inv_Resize.Fixedright)
end event

type rb_3 from radiobutton within w_main
integer x = 2249
integer y = 480
integer width = 402
integer height = 56
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todas"
boolean checked = true
end type

type rb_2 from radiobutton within w_main
integer x = 2249
integer y = 416
integer width = 402
integer height = 56
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Contabilizadas"
end type

type rb_1 from radiobutton within w_main
integer x = 2249
integer y = 356
integer width = 462
integer height = 56
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No Contabilizadas"
end type

type st_3 from statictext within w_main
integer x = 1746
integer y = 412
integer width = 119
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Obra"
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer x = 1129
integer y = 412
integer width = 279
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cod. Cliente"
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer x = 818
integer y = 412
integer width = 128
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_main
integer x = 4741
integer y = 448
integer width = 402
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;dw_1.dataobject="dw_con_listado_venfac_obra"
wf_retrieve(dw_1)
end event

type sle_department from singlelineedit within w_main
integer x = 1865
integer y = 392
integer width = 261
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_customer from singlelineedit within w_main
integer x = 1413
integer y = 392
integer width = 261
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_serie from singlelineedit within w_main
integer x = 960
integer y = 392
integer width = 137
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
end type

type dp_2 from datepicker within w_main
integer x = 411
integer y = 392
integer width = 311
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
datetimeformat format = dtfcustom!
string customformat = "dd-MM-yy"
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2023-04-26"), Time("10:14:09.000000"))
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_main
integer x = 91
integer y = 392
integer width = 311
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
datetimeformat format = dtfcustom!
string customformat = "dd-MM-yy"
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2023-04-26"), Time("10:14:09.000000"))
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type gb_1 from groupbox within w_main
integer x = 37
integer y = 284
integer width = 736
integer height = 276
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fechas"
end type

type gb_2 from groupbox within w_main
integer x = 2185
integer y = 288
integer width = 558
integer height = 276
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Situación"
end type

type uo_background from vs_cst_displayname within w_main
event destroy ( )
integer width = 5221
integer taborder = 20
end type

on uo_background.destroy
call vs_cst_displayname::destroy
end on

type gb_3 from groupbox within w_main
integer x = 786
integer y = 288
integer width = 1385
integer height = 276
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Critérios"
end type

