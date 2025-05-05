$PBExportHeader$reportsapi.sra
$PBExportComments$Generated Application Object
forward
global type reportsapi from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
Boolean gb_isPBIDE
String gs_dir
end variables

global type reportsapi from application
string appname = "reportsapi"
string themepath = "theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = "icono.ico"
string appruntimeversion = "22.2.0.3356"
boolean manualsession = false
boolean unsupportedapierror = false
boolean ultrafast = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global reportsapi reportsapi

type prototypes
//Funcion para tomar el directorio de la aplicacion  -64Bits 
FUNCTION	uLong	GetModuleFileName ( uLong lhModule, ref string sFileName, ulong nSize )  LIBRARY "Kernel32.dll" ALIAS FOR "GetModuleFileNameW"
end prototypes

on reportsapi.create
appname="reportsapi"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on reportsapi.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String ls_Path
ulong lul_handle
String ls_AppExe = "reportapiexample.exe" 

ls_Path = space(1024)
SetNull(lul_handle)
GetModuleFilename(lul_handle, ls_Path, len(ls_Path))

if right(UPPER(ls_path), 7)="220.EXE" or right(UPPER(ls_path), 7)="X64.EXE" then
	ls_path="C:\proyecto pw2022\Blog\PowerBuilder\TestNested\"+ls_AppExe
	gb_isPBIDE = TRUE
end if

gs_dir=left(ls_path, len(ls_path) - (len(ls_AppExe)))

open(w_main)
end event

