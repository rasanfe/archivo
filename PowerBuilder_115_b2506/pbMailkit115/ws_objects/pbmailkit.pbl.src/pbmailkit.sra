$PBExportHeader$pbmailkit.sra
$PBExportComments$Generated Application Object
forward
global type pbmailkit from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type pbmailkit from application
string appname = "pbmailkit"
end type
global pbmailkit pbmailkit

on pbmailkit.create
appname="pbmailkit"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbmailkit.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;Open(w_main)

end event

