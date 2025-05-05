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
string themepath = "C:\Program Files (x86)\Appeon\Shared\PowerBuilder\theme190"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
long richtextedittype = 2
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = "icono.ico"
string fullbuildruntimeversion = "19.2.0.2622"
string appruntimeversion = "22.2.0.3356"
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

