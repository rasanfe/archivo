$PBExportHeader$reports.sra
$PBExportComments$Generated Application Object
forward
global type reports from application
end type
type timing_1 from timing within reports
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
boolean gb_api
string gs_inifile

//Token expiresin
Long gl_Expiresin
//Refresh token clockskew 
Long gl_ClockSkew = 3



end variables
global type reports from application
string appname = "reports"
string themepath = "theme"
string themename = "Flat Design Dark"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = "imagenes/PBApp.ico"
string appruntimeversion = "22.0.0.1900"
boolean manualsession = true
boolean unsupportedapierror = true
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
timing_1 timing_1
end type
global reports reports

on reports.create
appname="reports"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
this.timing_1=create timing_1
end on

on reports.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
destroy(this.timing_1)
end on

event open;//Authorization
if isPowerServerApp() = true then
	If gf_Authorization() <> 1 Then 
		Return
	End If
		
	//StartSession
	long ll_return
	Try
		ll_return = Beginsession()
		If ll_return <> 0 Then
			Messagebox("Beginsession Failed:" + String(ll_return), GetHttpResponseStatusText())
		End if
	Catch ( Throwable ex)
	 MessageBox( "Throwable", ex.GetMessage())
	 Return
	End Try
		
	//Refresh Token for timing
	If gl_Expiresin > 0 And (gl_Expiresin - gl_ClockSkew) > 0 Then
	 //Timer = Expiresin - ClockSkew 
	 //3600 - 3
	 timing_1.Start(gl_Expiresin - gl_ClockSkew)
	End If
end if	


open(w_main)
end event

type timing_1 from timing within reports descriptor "pb_nvo" = "true" 
end type

on timing_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on timing_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;gf_Authorization()
end event

