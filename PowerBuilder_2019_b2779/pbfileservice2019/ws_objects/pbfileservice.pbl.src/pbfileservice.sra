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
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 19.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditx64type = 3
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = "icono.ico"
string appruntimeversion = "19.2.0.2779"
end type
global pbfileservice pbfileservice

type variables

end variables

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

