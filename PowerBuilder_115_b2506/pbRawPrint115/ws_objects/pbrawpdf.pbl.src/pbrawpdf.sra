$PBExportHeader$pbrawpdf.sra
$PBExportComments$Generated Application Object
forward
global type pbrawpdf from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type pbrawpdf from application
string appname = "pbrawpdf"
end type
global pbrawpdf pbrawpdf

on pbrawpdf.create
appname="pbrawpdf"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbrawpdf.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_main) 
end event

