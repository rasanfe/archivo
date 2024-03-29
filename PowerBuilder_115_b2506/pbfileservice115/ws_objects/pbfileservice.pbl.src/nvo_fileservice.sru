$PBExportHeader$nvo_fileservice.sru
forward
global type nvo_fileservice from oleobject
end type
end forward

global type nvo_fileservice from oleobject
event ue_error ( )
end type
global nvo_fileservice nvo_fileservice

type variables
PUBLIC:
String is_assemblypath = "FileService.comhost.dll"
String is_classname = "FileService.FileService"

/* Exception handling -- Indicates how proxy handles .NET exceptions */
Boolean ib_CrashOnException = False

/*      Error types       */
Constant Int SUCCESS        =  0 // No error since latest reset
Constant Int LOAD_FAILURE   = -1 // Failed to load assembly
Constant Int CREATE_FAILURE = -2 // Failed to create .NET object
Constant Int CALL_FAILURE   = -3 // Call to .NET function failed

/* Latest error -- Public reset via of_ResetError */
PRIVATEWRITE Long il_ErrorType   
PRIVATEWRITE Long il_ErrorNumber 
PRIVATEWRITE String is_ErrorText 

PRIVATE:
/*  .NET object creation */
Boolean ib_objectCreated
String is_OleErrorText

/* Error handler -- Public access via of_SetErrorHandler/of_ResetErrorHandler/of_GetErrorHandler
    Triggers "ue_Error" event for each error when no current error handler */
PowerObject ipo_errorHandler // Each error triggers <ErrorHandler, ErrorEvent>
String is_errorEvent
end variables

forward prototypes
public subroutine of_seterrorhandler (powerobject apo_newhandler, string as_newevent)
public subroutine of_signalerror ()
private subroutine of_setdotneterror (string as_failedfunction, string as_errortext)
public subroutine of_reseterror ()
public function boolean of_createondemand ()
private subroutine of_setassemblyerror (long al_errortype, string as_actiontext, long al_errornumber, string as_errortext)
public subroutine of_geterrorhandler (ref powerobject apo_currenthandler,ref string as_currentevent)
public subroutine of_reseterrorhandler ()
public function string of_getextension (string as_fileinput)
public function string of_getfilenamewithoutextension (string as_fileinput)
public function string of_changeextension (string as_fileinput, string as_extension)
public function string of_getdirectoryname (string as_fileinput)
public function boolean of_endsindirectoryseparator (string as_fileinput)
public function boolean of_filerename (string as_fileinput, string as_newfile)
public function string of_getfilename (string as_fileinput)
public subroutine  of_copydirectory(string as_sourcedir,string as_destinationdir,boolean abln_recursive)
public subroutine  of_copydirectory(string as_sourcedir,string as_destinationdir,boolean abln_recursive,string as_searchpattern)
end prototypes

event ue_error ( );
/*-----------------------------------------------------------------------------------------*/
/*  Handler undefined or call failed (event undefined) => Signal object itself */
/*-----------------------------------------------------------------------------------------*/
end event

public subroutine of_seterrorhandler (powerobject apo_newhandler, string as_newevent);
//*-----------------------------------------------------------------*/
//*    of_seterrorhandler:  
//*                       Register new error handler (incl. event)
//*-----------------------------------------------------------------*/

This.ipo_errorHandler = apo_newHandler
This.is_errorEvent = Trim(as_newEvent)
end subroutine

public subroutine of_signalerror ();
//*-----------------------------------------------------------------------------*/
//* PRIVATE of_SignalError
//* Triggers error event on previously defined error handler.
//* Calls object's own UE_ERROR when handler or its event is undefined.
//*
//* Handler is "DEFINED" when
//* 	1) <ErrorEvent> is non-empty
//*	2) <ErrorHandler> refers to valid object
//*	3) <ErrorEvent> is actual event on <ErrorHandler>
//*-----------------------------------------------------------------------------*/

Boolean lb_handlerDefined
If This.is_errorEvent > '' Then
	If Not IsNull(This.ipo_errorHandler) Then
		lb_handlerDefined = IsValid(This.ipo_errorHandler)
	End If
End If

If lb_handlerDefined Then
	/* Try to call defined handler*/
	Long ll_status
	ll_status = This.ipo_errorHandler.TriggerEvent(This.is_errorEvent)
	If ll_status = 1 Then Return
End If

/* Handler undefined or call failed (event undefined) => Signal object itself*/
This.event ue_Error( )
end subroutine

private subroutine of_setdotneterror (string as_failedfunction, string as_errortext);
//*----------------------------------------------------------------------------------------*/
//* PRIVATE of_setDotNETError
//* Sets error description for specified error condition exposed by call to .NET  
//*
//* Error description layout
//*			| Call <failedFunction> failed.<EOL>
//*			| Error Text: <errorText> (*)
//* (*): Line skipped when <ErrorText> is empty
//*			| External Exception: <OleerrorText> (*)
//* (*): Line skipped when <OleErrorText> is empty
//*----------------------------------------------------------------------------------------*/

/* Format description*/
String ls_error
ls_error = "Call " + as_failedFunction + " failed."
If Len(Trim(as_errorText)) > 0 Then
	ls_error += "~r~nError Text: " + as_errorText
End If
If Len(Trim(is_OleErrorText)) > 0 Then
	ls_error += "~r~nExternal Exception: " + is_OleErrorText
End If


/* Retain state in instance variables*/
This.il_ErrorType = This.CALL_FAILURE
This.is_ErrorText = ls_error
This.il_ErrorNumber = 0
end subroutine

public subroutine of_reseterror ();
//*--------------------------------------------*/
//* PUBLIC of_ResetError
//* Clears previously registered error
//*--------------------------------------------*/

This.il_ErrorType = This.SUCCESS
This.is_ErrorText = ''
This.il_ErrorNumber = 0
end subroutine

public function boolean of_createondemand ();
//*--------------------------------------------------------------*/
//*  PUBLIC   of_createOnDemand( )
//*  Return   True:  .NET object created
//*               False: Failed to create .NET object
//*  Loads .NET assembly and creates instance of .NET class.
//*  Uses .NET Core when loading .NET assembly.
//*  Signals error If an error occurs.
//*  Resets any prior error when load + create succeeds.
//*--------------------------------------------------------------*/

This.of_ResetError( )
If This.ib_objectCreated Then Return True // Already created => DONE

Long ll_status 
String ls_action, ls_error

/* Load assembly using .NET Core */
ls_action = 'Load ' + This.is_AssemblyPath

ll_status = this.ConnectToNewObject(This.is_ClassName)

/* Abort when load fails */
If ll_status <> 0 Then
	CHOOSE CASE ll_status
		CASE -1 
			ls_error ="Invalid Call: the argument is the Object property of a control"
		CASE -2
			ls_error ="Class name not found"
		CASE -3 
			ls_error =" Object could not be created"
		CASE -4
			ls_error ="Could not connect to object"
		CASE -9
			ls_error ="Other error"
		CASE -15
			ls_error ="COM+ is not loaded on this computer"
		CASE -16
			ls_error ="Invalid Call: this function not applicable"
	END CHOOSE
	This.of_SetAssemblyError(This.LOAD_FAILURE, ls_action, ll_status, ls_error)
	This.of_SignalError( )
	Return False // Load failed => ABORT
End If


This.ib_objectCreated = True
Return True
end function

private subroutine of_setassemblyerror (long al_errortype, string as_actiontext, long al_errornumber, string as_errortext);
//*----------------------------------------------------------------------------------------------*/
//* PRIVATE of_setAssemblyError
//* Sets error description for specified error condition report by an assembly function
//*
//* Error description layout
//* 		| <actionText> failed.<EOL>
//* 		| Error Number: <errorNumber><EOL>
//* 		| Error Text: <errorText> (*)
//*  (*): Line skipped when <ErrorText> is empty
//*----------------------------------------------------------------------------------------------*/

/*    Format description */
String ls_error
ls_error = as_actionText + " failed.~r~n"
ls_error += "Error Number: " + String(al_errorNumber) + "."
If Len(Trim(as_errorText)) > 0 Then
	ls_error += "~r~nError Text: " + as_errorText
End If

/*  Retain state in instance variables */
This.il_ErrorType = al_errorType
This.is_ErrorText = ls_error
This.il_ErrorNumber = al_errorNumber
end subroutine

public subroutine of_geterrorhandler (ref powerobject apo_currenthandler,ref string as_currentevent);
//*-------------------------------------------------------------------------*/
//* PUBLIC of_GetErrorHandler
//* Return as REF-parameters current error handler (incl. event)
//*-------------------------------------------------------------------------*/

apo_currentHandler = This.ipo_errorHandler
as_currentEvent = This.is_errorEvent
end subroutine

public subroutine of_reseterrorhandler ();
//*---------------------------------------------------*/
//* PUBLIC of_ResetErrorHandler
//* Removes current error handler (incl. event)
//*---------------------------------------------------*/

SetNull(This.ipo_errorHandler)
SetNull(This.is_errorEvent)
end subroutine

public function string of_getextension (string as_fileinput);
//*-----------------------------------------------------------------*/
//*  .NET function : GetExtension
//*   Argument:
//*              String as_fileinput
//*   Return : String
//*-----------------------------------------------------------------*/
/* .NET  function name */
String ls_function
String ls_result

/* Set the dotnet function name */
ls_function = "GetExtension"

Try
	/* Create .NET object */
	If Not This.of_createOnDemand( ) Then
		SetNull(ls_result)
		Return ls_result
	End If

	/* Trigger the dotnet function */
	ls_result = this.getextension(as_fileinput)
	Return ls_result
Catch(runtimeerror re_error)

	If This.ib_CrashOnException Then Throw re_error

	
	/*   Handle .NET error */
	This.of_SetDotNETError(ls_function, re_error.Text)
	This.of_SignalError( )

	/*  Indicate error occurred */
	SetNull(ls_result)
	Return ls_result
End Try
end function

public function string of_getfilenamewithoutextension (string as_fileinput);
//*-----------------------------------------------------------------*/
//*  .NET function : GetFileNameWithoutExtension
//*   Argument:
//*              String as_fileinput
//*   Return : String
//*-----------------------------------------------------------------*/
/* .NET  function name */
String ls_function
String ls_result

/* Set the dotnet function name */
ls_function = "GetFileNameWithoutExtension"

Try
	/* Create .NET object */
	If Not This.of_createOnDemand( ) Then
		SetNull(ls_result)
		Return ls_result
	End If

	/* Trigger the dotnet function */
	ls_result = this.getfilenamewithoutextension(as_fileinput)
	Return ls_result
Catch(runtimeerror re_error)

	If This.ib_CrashOnException Then Throw re_error

	
	/*   Handle .NET error */
	This.of_SetDotNETError(ls_function, re_error.Text)
	This.of_SignalError( )

	/*  Indicate error occurred */
	SetNull(ls_result)
	Return ls_result
End Try
end function

public function string of_changeextension (string as_fileinput, string as_extension);
//*-----------------------------------------------------------------*/
//*  .NET function : ChangeExtension
//*   Argument:
//*              String as_fileinput
//*              String as_extension
//*   Return : String
//*-----------------------------------------------------------------*/
/* .NET  function name */
String ls_function
String ls_result

/* Set the dotnet function name */
ls_function = "ChangeExtension"

Try
	/* Create .NET object */
	If Not This.of_createOnDemand( ) Then
		SetNull(ls_result)
		Return ls_result
	End If

	/* Trigger the dotnet function */
	ls_result = this.changeextension(as_fileinput,as_extension)
	Return ls_result
Catch(runtimeerror re_error)

	If This.ib_CrashOnException Then Throw re_error

	
	/*   Handle .NET error */
	This.of_SetDotNETError(ls_function, re_error.Text)
	This.of_SignalError( )

	/*  Indicate error occurred */
	SetNull(ls_result)
	Return ls_result
End Try



end function

public function string of_getdirectoryname (string as_fileinput);
//*-----------------------------------------------------------------*/
//*  .NET function : GetDirectoryName
//*   Argument:
//*              String as_fileinput
//*   Return : String
//*-----------------------------------------------------------------*/
/* .NET  function name */
String ls_function
String ls_result

/* Set the dotnet function name */
ls_function = "GetDirectoryName"

Try
	/* Create .NET object */
	If Not This.of_createOnDemand( ) Then
		SetNull(ls_result)
		Return ls_result
	End If

	/* Trigger the dotnet function */
	ls_result = this.getdirectoryname(as_fileinput)
	Return ls_result
Catch(runtimeerror re_error)

	If This.ib_CrashOnException Then Throw re_error
	
	
	/*   Handle .NET error */
	This.of_SetDotNETError(ls_function, re_error.Text)
	This.of_SignalError( )

	/*  Indicate error occurred */
	SetNull(ls_result)
	Return ls_result
End Try
end function

public function boolean of_endsindirectoryseparator (string as_fileinput);
//*-----------------------------------------------------------------*/
//*  .NET function : EndsInDirectorySeparator
//*   Argument:
//*              String as_fileinput
//*   Return : Boolean
//*-----------------------------------------------------------------*/
/* .NET  function name */
String ls_function
Boolean lbln_result

/* Set the dotnet function name */
ls_function = "EndsInDirectorySeparator"

Try
	/* Create .NET object */
	If Not This.of_createOnDemand( ) Then
		SetNull(lbln_result)
		Return lbln_result
	End If

	/* Trigger the dotnet function */
	lbln_result = this.endsindirectoryseparator(as_fileinput)
	Return lbln_result
Catch(runtimeerror re_error)

	If This.ib_CrashOnException Then Throw re_error

	
	/*   Handle .NET error */
	This.of_SetDotNETError(ls_function, re_error.Text)
	This.of_SignalError( )

	/*  Indicate error occurred */
	SetNull(lbln_result)
	Return lbln_result
End Try
end function

public function boolean of_filerename (string as_fileinput, string as_newfile);
//*-----------------------------------------------------------------*/
//*  .NET function : FileRename
//*   Argument:
//*              String as_fileinput
//*              String as_newfile
//*   Return : Boolean
//*-----------------------------------------------------------------*/
/* .NET  function name */
String ls_function
Boolean lbln_result

/* Set the dotnet function name */
ls_function = "FileRename"

Try
	/* Create .NET object */
	If Not This.of_createOnDemand( ) Then
		SetNull(lbln_result)
		Return lbln_result
	End If

	/* Trigger the dotnet function */
	lbln_result = This.filerename(as_fileinput,as_newfile)
	Return lbln_result
Catch(runtimeerror re_error)

	If This.ib_CrashOnException Then Throw re_error

	
	/*   Handle .NET error */
	This.of_SetDotNETError(ls_function, re_error.Text)
	This.of_SignalError( )

	/*  Indicate error occurred */
	SetNull(lbln_result)
	Return lbln_result
End Try
end function

public function string of_getfilename (string as_fileinput);
//*-----------------------------------------------------------------*/
//*  .NET function : GetFilename
//*   Argument:
//*              String as_fileinput
//*   Return : String
//*-----------------------------------------------------------------*/
/* .NET  function name */
String ls_function
String ls_result

/* Set the dotnet function name */
ls_function = "GetFilename"

Try
	/* Create .NET object */
	If Not This.of_createOnDemand( ) Then
		SetNull(ls_result)
		Return ls_result
	End If

	/* Trigger the dotnet function */
	ls_result = This.getfilename(as_fileinput)
	Return ls_result
Catch(runtimeerror re_error)

	If This.ib_CrashOnException Then Throw re_error

	
	/*   Handle .NET error */
	This.of_SetDotNETError(ls_function, re_error.Text)
	This.of_SignalError( )

	/*  Indicate error occurred */
	SetNull(ls_result)
	Return ls_result
End Try
end function

public subroutine  of_copydirectory(string as_sourcedir,string as_destinationdir,boolean abln_recursive);
//*-----------------------------------------------------------------*/
//*  .NET function : CopyDirectory
//*   Argument:
//*              String as_sourcedir
//*              String as_destinationdir
//*              Boolean abln_recursive
//*   Return : (None)
//*-----------------------------------------------------------------*/
/* .NET  function name */
String ls_function

/* Set the dotnet function name */
ls_function = "CopyDirectory"

Try
	/* Create .NET object */
	If Not This.of_createOnDemand( ) Then
		Return 
	End If

	/* Trigger the dotnet function */
	This.copydirectory(as_sourcedir,as_destinationdir,abln_recursive)
Catch(runtimeerror re_error)

	If This.ib_CrashOnException Then Throw re_error

	/*   Handle .NET error */
	This.of_SetDotNETError(ls_function, re_error.text)
	This.of_SignalError( )

End Try
end subroutine

public subroutine  of_copydirectory(string as_sourcedir,string as_destinationdir,boolean abln_recursive,string as_searchpattern);
//*-----------------------------------------------------------------*/
//*  .NET function : CopyDirectory
//*   Argument:
//*              String as_sourcedir
//*              String as_destinationdir
//*              Boolean abln_recursive
//*              String as_searchpattern
//*   Return : (None)
//*-----------------------------------------------------------------*/
/* .NET  function name */
String ls_function

/* Set the dotnet function name */
ls_function = "CopyDirectory"

Try
	/* Create .NET object */
	If Not This.of_createOnDemand( ) Then
		Return 
	End If

	/* Trigger the dotnet function */
	This.copydirectory(as_sourcedir,as_destinationdir,abln_recursive,as_searchpattern)
Catch(runtimeerror re_error)

	If This.ib_CrashOnException Then Throw re_error

	/*   Handle .NET error */
	This.of_SetDotNETError(ls_function, re_error.text)
	This.of_SignalError( )

End Try
end subroutine

on nvo_fileservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_fileservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;IF ib_objectCreated THEN
	this.DisconnectObject()
END IF
end event

event externalexception; is_OleErrorText = description

end event

