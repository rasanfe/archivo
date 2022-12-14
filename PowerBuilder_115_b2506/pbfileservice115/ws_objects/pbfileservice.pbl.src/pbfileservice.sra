$PBExportHeader$pbfileservice.sra
$PBExportComments$Generated Application Object
forward
global type pbfileservice from application
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

global type pbfileservice from application
string appname = "pbfileservice"
end type
global pbfileservice pbfileservice

type prototypes

end prototypes
on pbfileservice.create
appname="pbfileservice"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbfileservice.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gs_dir= GetCurrentDirectory() +"\"

Open(w_main)
end event

