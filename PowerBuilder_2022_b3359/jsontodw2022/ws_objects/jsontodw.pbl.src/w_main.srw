$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type dw_1 from u_datawindow within w_main
end type
type cb_2 from commandbutton within w_main
end type
type cb_1 from commandbutton within w_main
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
integer width = 4741
integer height = 2816
boolean titlebar = true
string title = "Json To Datawindow"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
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
public subroutine wf_version ()
public function string wf_get_json_example ()
public function string wf_restclient (string as_url)
end prototypes

public subroutine wf_version ();String ls_version, ls_platform
Integer li_rtn
Environment l_env

li_rtn = GetEnvironment(l_env)

IF li_rtn <> 1 THEN 
	ls_version = string(year(today()))
	ls_platform="32"
ELSE
	ls_version = "20"+ string(l_env.pbmajorrevision)+ "." + string(l_env.pbbuildnumber)
	ls_platform=string(l_env.ProcessBitness)
END IF

ls_platform += " Bits"

st_myversion.text=ls_version
st_platform.text=ls_platform

end subroutine

public function string wf_get_json_example ();string ls_json
JsonGenerator lnv_JsonGenerator
Long ll_RootArray

lnv_JsonGenerator = Create JsonGenerator

ls_json = '[ ' +&
    '{  ' +&
    '"invoice_id": "INV001", ' +&
    '"customer": "John Doe", ' +&
    '"date": "2025-01-01", ' +&
    '"total_amount": 250.00, ' +&
    '"status": "Paid", ' +&
    '"line_items": [  ' +&
    '{  ' +&
    '"description": "Product A", ' +&
    '"quantity": 2, ' +&
    '"unit_price": 50.00, ' +&
    '"total_price": 100.00  ' +&
    '}, ' +&
    '{  ' +&
    '"description": "Service B", ' +&
    '"quantity": 1, ' +&
    '"unit_price": 150.00, ' +&
    '"total_price": 150.00  ' +&
    '}  ' +&
    '], ' +&
    '"notes": ["Paid in full", "Delivered on 2025-01-02"], ' +&
    '"location": "New York"  ' +&
    '}, ' +&
    '{  ' +&
    '"invoice_id": "INV002", ' +&
    '"customer": "Jane Smith", ' +&
    '"date": "2025-01-03", ' +&
    '"total_amount": 400.00, ' +&
    '"status": "Pending", ' +&
    '"line_items": [  ' +&
    '{  ' +&
    '"description": "Product C", ' +&
    '"quantity": 4, ' +&
    '"unit_price": 100.00, ' +&
    '"total_price": 400.00  ' +&
    '}  ' +&
    '], ' +&
    '"notes": ["Awaiting payment"]  ' +&
    '}, ' +&
    '{  ' +&
    '"invoice_id": "INV003", ' +&
    '"customer": "Acme Corp.", ' +&
    '"date": "2025-01-05", ' +&
    '"total_amount": 300.00, ' +&
    '"status": "Overdue", ' +&
    '"line_items": [  ' +&
    '{  ' +&
    '"description": "Consulting Service", ' +&
    '"quantity": 3, ' +&
    '"unit_price": 100.00, ' +&
    '"total_price": 300.00  ' +&
    '}  ' +&
    '], ' +&
    '"notes": ["Late fee applied", "Reminder sent on 2025-01-10"], ' +&
    '"discount": 10.00  ' +&
    '}, ' +&
    '{  ' +&
    '"invoice_id": "INV004", ' +&
    '"customer": "Global Industries", ' +&
    '"date": "2025-01-10", ' +&
    '"total_amount": 500.00, ' +&
    '"status": "Paid", ' +&
    '"line_items": [  ' +&
    '{  ' +&
    '"description": "Software License", ' +&
    '"quantity": 5, ' +&
    '"unit_price": 100.00, ' +&
    '"total_price": 500.00  ' +&
    '}  ' +&
    '], ' +&
    '"notes": ["License keys delivered", "Support included"], ' +&
    '"location": "San Francisco", ' +&
    '"discount": 25.00  ' +&
    '}, ' +&
    '{  ' +&
    '"invoice_id": "INV005", ' +&
    '"customer": "Tech Solutions", ' +&
    '"date": "2025-01-12", ' +&
    '"total_amount": 700.00, ' +&
    '"status": "Pending", ' +&
    '"line_items": [  ' +&
    '{  ' +&
    '"description": "Hardware Components", ' +&
    '"quantity": 7, ' +&
    '"unit_price": 100.00, ' +&
    '"total_price": 700.00  ' +&
    '}  ' +&
    '], ' +&
    '"notes": ["Pending approval", "Expected delivery on 2025-01-20"]  ' +&
    '}]' 
 

	 
	 
// Create an object root item
lnv_JsonGenerator.ImportString(ls_Json)


// Gets the JSON string
ls_Json = lnv_JsonGenerator.GetJsonString()


return ls_json
end function

public function string wf_restclient (string as_url);RestClient ln_api
String ls_json
Integer li_rtn

ln_api = Create RestClient

li_rtn = ln_api.SendGetRequest(as_url, ref ls_json)

If li_rtn <> 1 Then
	gf_mensaje("RestClient", as_url + " " + "Error !")
	ls_json = ""
End If

Destroy ln_api
Return ls_json
end function

on w_main.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.p_2=create p_2
this.st_info=create st_info
this.st_myversion=create st_myversion
this.st_platform=create st_platform
this.r_2=create r_2
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1,&
this.p_2,&
this.st_info,&
this.st_myversion,&
this.st_platform,&
this.r_2}
end on

on w_main.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.p_2)
destroy(this.st_info)
destroy(this.st_myversion)
destroy(this.st_platform)
destroy(this.r_2)
end on

event open;wf_version()






end event

event resize;r_2.width = newwidth
st_myversion.x = newwidth - st_myversion.width -20
st_platform.x = newwidth - st_myversion.width -20
st_info.x = newwidth - st_info.width -20
st_info.y = newheight - st_info.height  - 20

dw_1.height = Newheight -550
dw_1.width = newwidth -100
cb_1.y = dw_1.height + dw_1.y + 25
cb_2.y = cb_1.y 
end event

type dw_1 from u_datawindow within w_main
integer x = 64
integer y = 328
integer width = 4599
integer height = 2180
integer taborder = 10
string dragicon = "0"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_2 from commandbutton within w_main
integer x = 837
integer y = 2552
integer width = 791
integer height = 128
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve Api example"
end type

event clicked;String ls_json, ls_url
Long ll_RowCount

ls_url = "https://jsonplaceholder.typicode.com/posts"
//ls_url = "https://jsonplaceholder.typicode.com/albums"

ls_json = wf_restclient(ls_url)

ll_RowCount = dw_1.of_cargar_json(ls_json)

If ll_RowCount < 0 Then Return




end event

type cb_1 from commandbutton within w_main
integer x = 23
integer y = 2552
integer width = 795
integer height = 128
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve Json example"
end type

event clicked;String ls_json
Long ll_RowCount

ls_json = wf_get_json_example()

ll_RowCount = dw_1.of_cargar_json(ls_json)

If ll_RowCount < 0 Then Return




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

type st_info from statictext within w_main
integer x = 3365
integer y = 2628
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
integer x = 4146
integer y = 40
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
integer x = 4146
integer y = 128
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
integer width = 4686
integer height = 260
end type

