$PBExportHeader$toast.sra
$PBExportComments$Generated Application Object
forward
global type toast from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string gs_appdir

end variables

global type toast from application
string appname = "toast"
end type
global toast toast

type prototypes
//Funcion para tomar el directorio de la aplicacion  -64Bits 
FUNCTION	uLong	GetModuleFileName ( uLong lhModule, ref string sFileName, ulong nSize )  LIBRARY "Kernel32.dll" ALIAS FOR "GetModuleFileNameW"
end prototypes

on toast.create
appname="toast"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on toast.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;environment env
string ls_path
ulong lul_handle
Constant String ls_ExeFile="toast.exe"
Constant String ls_DeploymentPath="C:\proyecto pw2022\Blog\archivo\PowerBuilder126\toast126"

ls_Path = space(1024)
SetNull(lul_handle)
GetModuleFilename(lul_handle, ls_Path, len(ls_Path))

if right(UPPER(ls_path), 7)="126.EXE" then
	ls_path=ls_DeploymentPath+"\"+ls_ExeFile
end if

gs_appdir=left(ls_path, len(ls_path) - (len(ls_ExeFile) + 1))  

Open(w_main)
end event

