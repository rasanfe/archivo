$PBExportHeader$encryptgenerator.sra
$PBExportComments$Generated Application Object
forward
global type encryptgenerator from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type encryptgenerator from application
string appname = "encryptgenerator"
end type
global encryptgenerator encryptgenerator

on encryptgenerator.create
appname="encryptgenerator"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on encryptgenerator.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_main)
end event

