$PBExportHeader$ean13_app.sra
$PBExportComments$Generated Application Object
forward
global type ean13_app from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type ean13_app from application
string appname = "ean13_app"
end type
global ean13_app ean13_app

on ean13_app.create
appname="ean13_app"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on ean13_app.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_ean13)
end event

