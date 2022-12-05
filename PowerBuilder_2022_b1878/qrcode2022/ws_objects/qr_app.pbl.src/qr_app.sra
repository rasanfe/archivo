$PBExportHeader$qr_app.sra
$PBExportComments$Generated Application Object
forward
global type qr_app from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables

end variables

global type qr_app from application
string appname = "qr_app"
string displayname = "Qr_App"
string themepath = "C:\Program Files (x86)\Appeon\Shared\PowerBuilder\theme190"
string themename = "Flat Design Dark"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 0
long richtexteditx64type = 3
long richtexteditversion = 0
string richtexteditkey = ""
string appicon = "icono.ico"
string appruntimeversion = "22.0.0.1878"
boolean manualsession = false
boolean unsupportedapierror = false
end type
global qr_app qr_app

on qr_app.create
appname="qr_app"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on qr_app.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;
Open(w_QR)
end event

