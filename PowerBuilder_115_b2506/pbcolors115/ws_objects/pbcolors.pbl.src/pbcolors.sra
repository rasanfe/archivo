$PBExportHeader$pbcolors.sra
$PBExportComments$Generated Application Object
forward
global type pbcolors from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type pbcolors from application
string appname = "pbcolors"
end type
global pbcolors pbcolors

on pbcolors.create
appname="pbcolors"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbcolors.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_seleccionar_color)
end event

