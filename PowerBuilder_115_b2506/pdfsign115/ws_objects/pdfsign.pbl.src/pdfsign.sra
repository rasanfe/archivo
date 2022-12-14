$PBExportHeader$pdfsign.sra
$PBExportComments$Generated Application Object
forward
global type pdfsign from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_dir, gs_ini
end variables

global type pdfsign from application
string appname = "pdfsign"
end type
global pdfsign pdfsign

type prototypes

end prototypes
on pdfsign.create
appname="pdfsign"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pdfsign.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gs_dir= GetCurrentDirectory() +"\"

gs_ini=gs_dir+"pdfsign.ini"

Open(w_main)
end event

