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

global type qr_app from application
string appname = "qr_app"
string displayname = "Qr_App"
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

event open;Open(w_QR)
end event

