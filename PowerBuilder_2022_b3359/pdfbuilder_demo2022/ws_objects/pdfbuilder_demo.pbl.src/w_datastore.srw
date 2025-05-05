$PBExportHeader$w_datastore.srw
forward
global type w_datastore from window
end type
type dw_1 from datawindow within w_datastore
end type
end forward

global type w_datastore from window
integer width = 3040
integer height = 1192
boolean titlebar = true
string title = "Comparativa Ventas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_datastore w_datastore

event open;dw_1.ImportFile( CSV!, "d_grafico_2valores.csv" )
end event

on w_datastore.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_datastore.destroy
destroy(this.dw_1)
end on

event resize;dw_1.Resize ( newwidth - 20, newheight  - 20)
end event

type dw_1 from datawindow within w_datastore
integer x = 50
integer y = 36
integer width = 2912
integer height = 1008
integer taborder = 10
string title = "none"
string dataobject = "d_grafico_2valores"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

