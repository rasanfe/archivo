$PBExportHeader$pbpdfutilities.sra
$PBExportComments$Generated Application Object
forward
global type pbpdfutilities from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_dir
end variables

global type pbpdfutilities from application
string appname = "pbpdfutilities"
end type
global pbpdfutilities pbpdfutilities

type prototypes
//Funcion para tomar el directorio de la aplicacion
FUNCTION	uLong	GetModuleFileName ( uLong lhModule, ref string sFileName, ulong nSize )  LIBRARY "Kernel32.dll" ALIAS FOR "GetModuleFileNameW"
end prototypes

on pbpdfutilities.create
appname="pbpdfutilities"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbpdfutilities.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String ls_Path
unsignedlong lul_handle
integer rtn


ls_Path = space(1024)
setnull(lul_handle)
GetModuleFilename(lul_handle, ls_Path, 1024)

if right(UPPER(ls_path), 7)="115.EXE"  then
	ls_path="D:\POWER BUILDER\PowerBuilder 11.5\PbFileService115\pbpdfutilities.exe"
end if

gs_dir=left(ls_path, len(ls_path) - 18)



Open(w_main)

end event

