$PBExportHeader$expocomclient.sra
$PBExportComments$Generated Application Object
forward
global type expocomclient from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type expocomclient from application
string appname = "expocomclient"
string appruntimeversion = "21.0.0.1509"
end type
global expocomclient expocomclient

on expocomclient.create
appname="expocomclient"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on expocomclient.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_main)
end event

