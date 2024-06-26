$PBExportHeader$pbpdffillformfields.sra
$PBExportComments$Generated Application Object
forward
global type pbpdffillformfields from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string gs_dir
end variables

global type pbpdffillformfields from application
string appname = "pbpdffillformfields"
string appruntimeversion = "21.0.0.1509"
end type
global pbpdffillformfields pbpdffillformfields

on pbpdffillformfields.create
appname="pbpdffillformfields"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbpdffillformfields.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gs_dir = GetCurrentDirectory() + "\"

Open(w_main)
end event

