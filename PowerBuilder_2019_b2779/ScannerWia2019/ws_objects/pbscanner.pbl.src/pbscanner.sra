$PBExportHeader$pbscanner.sra
$PBExportComments$Generated Application Object
forward
global type pbscanner from application
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
global type pbscanner from application
string appname = "pbscanner"
string appruntimeversion = "19.2.0.2779"
end type
global pbscanner pbscanner

type variables

end variables

on pbscanner.create
appname="pbscanner"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbscanner.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gs_dir= GetCurrentDirectory() +"\"

Open(w_main)
end event

