$PBExportHeader$n_cst_systemtray.sru
forward
global type n_cst_systemtray from nonvisualobject
end type
type guid from structure within n_cst_systemtray
end type
type notifyicondata from structure within n_cst_systemtray
end type
type dllversioninfo from structure within n_cst_systemtray
end type
end forward

type guid from structure
	long		data1
	integer		data2
	integer		data3
	character		data4[8]
end type

type notifyicondata from structure
	long		cbsize
	long		hwnd
	long		uid
	long		uflags
	long		ucallbackmessage
	long		hicon
	character		sztip[128]
	long		dwstate
	long		dwstatemask
	character		szinfo[256]
	long		utimeout
	character		szinfotitle[64]
	long		ae_icons
	guid		guiditem
end type

type dllversioninfo from structure
	unsignedlong		cbsize
	unsignedlong		dwmajorversion
	unsignedlong		dwminorversion
	unsignedlong		dwbuildnumber
	unsignedlong		dwplatformid
end type

global type n_cst_systemtray from nonvisualobject
end type
global n_cst_systemtray n_cst_systemtray

type prototypes
/*
Method				:  (Declaration)
Author				: Chris Pollach
Scope  				: Public
Extended			: Yes
Level					: Extension

Description			: Used to control MS-Windows SYSTEM TRAY interaction
Behaviour			: Convets any PB App to work in the System Tray area and back out - at run-time! 
Note					: Uses mainly SDK fuinctions mapped in the Application Controller

Argument(s)		: None
Throws				: N/A

Return Value		: None

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 	Inital Version																							-	2010-12-13
1.1	Moved most declarations to the "nc_app_controller_master" object class				-	2019-01-01
*/

// External Declarations  (Local here because os structure dependancy)


FUNCTION	Boolean		Shell_NotifyIcon ( long dwMessage, ref notifyicondata pnid ) Library "shell32.dll" alias for "Shell_NotifyIcon;Ansi"
FUNCTION	Long			DllGetVersion( ref dllversioninfo pdvi ) Library "comctl32.dll" alias for "DllGetVersion;Ansi"
FUNCTION	Boolean		SetForegroundWindow ( unsignedlong  hwnd ) LIBRARY "USER32.dll"
FUNCTION	long			LoadImage ( long hInst, string lpszName, uint uType, int cxDesired, int cyDesired, uint fuLoad ) Library "USER32.dll" alias for "LoadImageW"
FUNCTION	Long			ExtractIcon ( long hInst, string lpszExeFileName, uint nIconIndex) Library "SHELL32.dll" alias for "ExtractIconW"
FUNCTION	Boolean 		DestroyIcon ( long hIcon ) Library "USER32.dll"
FUNCTION	Boolean 		RegisterHotKey ( ulong hWnd, 	int id, uint fsModifiers, uint vk ) Library "USER32.dll"
FUNCTION	Boolean 		UnregisterHotKey ( ulong hWnd, 	int id 	) Library "USER32.dll"
FUNCTION	long 		LoadLibrary ( string lpFileName ) Library "KERNEL32.dll" Alias For "LoadLibraryW"
FUNCTION	Boolean 		FreeLibrary ( Long hModule ) Library "KERNEL32.dll"
FUNCTION	long 		GetProcAddress ( 	long hModule, 	string lpProcName 	) Library "KERNEL32.dll" alias for "GetProcAddress;Ansi"
SUBROUTINE				DebugMsg ( String lpOutputString 	) 	Library "KERNEL32.dll" Alias For "OutputDebugStringW"

end prototypes

type variables
/*
Method				:  (Declaration)
Author				: Chris Pollach
Scope  				: Public/Protected/Private
Extended			: Yes
Level					: Extension

Description			: Used for MS-Windows System Tray processing
Behaviour			: Work variables
Note					: None

Argument(s)		: None
Throws				: N/A

Return Value		: None

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																						-	2010-12-13
1.1	Revised constants to reflect more up-to-date values											-	2019-01-01
*/

// Declarations


Private:

Boolean	ib_systemtray_active				= FALSE														// SW 4 SYSTEM TRAY mode
Long 		il_iconhandles [ ]
Long 		NOTIFYICONDATA_SIZE 		= 88
Long 		NOTIFYICON_VERSION 			= 1


Protected:

//Ramón San Félix Ramón
//rsrsystem.soft@gmail.com
//https://rsrsystem.blogspot.com/
//Extract From nc_master----------------------------------------------------------------------------------------------------------------------------------------------
Boolean				ib_rc																					// Generic BOOLEAN	 work var for Return Codes.
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// function constants
CONSTANT long NIF_MESSAGE				= 1
CONSTANT long NIF_ICON					= 2
CONSTANT long NIF_TIP						= 4
CONSTANT long NIF_STATE					= 8
CONSTANT long NIF_INFO					= 16

CONSTANT long NIM_ADD					= 0
CONSTANT long NIM_MODIFY				= 1
CONSTANT long NIM_DELETE				= 2
CONSTANT long NIM_SETFOCUS			= 3
CONSTANT long NIM_SETVERSION		= 4
CONSTANT long NIM_VERSION				= 5

CONSTANT long NIS_HIDDEN				= 1
CONSTANT long NIS_SHAREDICON		= 2

CONSTANT long NIIF_NONE					= 0
CONSTANT long NIIF_INFO					= 1
CONSTANT long NIIF_WARNING			= 2
CONSTANT long NIIF_ERROR				= 3
CONSTANT long NIIF_GUID					= 5
CONSTANT long NIIF_ICON_MASK		= 15
CONSTANT long NIIF_NOSOUND			= 16

CONSTANT ulong NOTIFYICONDATA_V1_SIZE = 88  // pre-5.0 structure size
CONSTANT ulong NOTIFYICONDATA_V2_SIZE = 488 // pre-6.0 structure size
CONSTANT ulong NOTIFYICONDATA_V3_SIZE = 504 // 6.0+ structure size

CONSTANT long ICON_SMALL					= 0
CONSTANT long ICON_BIG						= 1

CONSTANT uint IMAGE_BITMAP				= 0
CONSTANT uint IMAGE_ICON					= 1
CONSTANT uint IMAGE_CURSOR				= 2

CONSTANT uint LR_DEFAULTCOLOR			= 0
CONSTANT uint LR_MONOCHROME			= 1
CONSTANT uint LR_COLOR						= 2
CONSTANT uint LR_COPYRETURNORG		= 4
CONSTANT uint LR_COPYDELETEORG		= 8
CONSTANT uint LR_LOADFROMFILE			= 16
CONSTANT uint LR_LOADTRANSPARENT	= 32
CONSTANT uint LR_DEFAULTSIZE				= 64
CONSTANT uint LR_VGACOLOR				= 128
CONSTANT uint LR_LOADMAP3DCOLORS	= 4096
CONSTANT uint LR_CREATEDIBSECTION	= 8192
CONSTANT uint LR_COPYFROMRESOURCE	= 16384
CONSTANT uint LR_SHARED					= 32768

// hotkey values
CONSTANT uint MOD_NONE					= 0
CONSTANT uint MOD_ALT						= 1
CONSTANT uint MOD_CONTROL				= 2
CONSTANT uint MOD_SHIFT					= 4
CONSTANT uint MOD_WIN						= 8
uint iui_keycode 									= 0
uint iui_modifier 									= 0

// virtual keycodes
CONSTANT uint KeyBack							= 8
CONSTANT uint KeyTab							= 9
CONSTANT uint KeyEnter						= 13
CONSTANT uint KeyShift							= 16
CONSTANT uint KeyControl						= 17
CONSTANT uint KeyAlt							= 18
CONSTANT uint KeyPause						= 19
CONSTANT uint KeyCapsLock					= 20
CONSTANT uint KeyEscape						= 27
CONSTANT uint KeySpaceBar					= 32
CONSTANT uint KeyPageUp						= 33
CONSTANT uint KeyPageDown					= 34
CONSTANT uint KeyEnd							= 35
CONSTANT uint KeyHome						= 36
CONSTANT uint KeyLeftArrow					= 37
CONSTANT uint KeyUpArrow					= 38
CONSTANT uint KeyRightArrow				= 39
CONSTANT uint KeyDownArrow				= 40
CONSTANT uint KeyPrintScreen				= 44
CONSTANT uint KeyInsert						= 45
CONSTANT uint KeyDelete						= 46
CONSTANT uint Key0								= 48
CONSTANT uint Key1								= 49
CONSTANT uint Key2								= 50
CONSTANT uint Key3								= 51
CONSTANT uint Key4								= 52
CONSTANT uint Key5								= 53
CONSTANT uint Key6								= 54
CONSTANT uint Key7								= 55
CONSTANT uint Key8								= 56
CONSTANT uint Key9								= 57
CONSTANT uint KeyA								= 65
CONSTANT uint KeyB								= 66
CONSTANT uint KeyC								= 67
CONSTANT uint KeyD								= 68
CONSTANT uint KeyE								= 69
CONSTANT uint KeyF								= 70
CONSTANT uint KeyG								= 71
CONSTANT uint KeyH								= 72
CONSTANT uint KeyI								= 73
CONSTANT uint KeyJ								= 74
CONSTANT uint KeyK								= 75
CONSTANT uint KeyL								= 76
CONSTANT uint KeyM								= 77
CONSTANT uint KeyN								= 78
CONSTANT uint KeyO								= 79
CONSTANT uint KeyP								= 80
CONSTANT uint KeyQ								= 81
CONSTANT uint KeyR								= 82
CONSTANT uint KeyS								= 83
CONSTANT uint KeyT								= 84
CONSTANT uint KeyU								= 85
CONSTANT uint KeyV								= 86
CONSTANT uint KeyW							= 87
CONSTANT uint KeyX								= 88
CONSTANT uint KeyY								= 89
CONSTANT uint KeyZ								= 90
CONSTANT uint KeyLeftWindows				= 91
CONSTANT uint KeyRightWindows				= 92
CONSTANT uint KeyApps						= 93
CONSTANT uint KeyNumPad0					= 96
CONSTANT uint KeyNumPad1					= 97
CONSTANT uint KeyNumPad2					= 98
CONSTANT uint KeyNumPad3					= 99
CONSTANT uint KeyNumPad4					= 100
CONSTANT uint KeyNumPad5					= 101
CONSTANT uint KeyNumPad6					= 102
CONSTANT uint KeyNumPad7					= 103
CONSTANT uint KeyNumPad8					= 104
CONSTANT uint KeyNumPad9					= 105
CONSTANT uint KeyMultiply						= 106
CONSTANT uint KeyAdd							= 107
CONSTANT uint KeySubtract					= 109
CONSTANT uint KeyDecimal						= 110
CONSTANT uint KeyDivide						= 111
CONSTANT uint KeyF1							= 112
CONSTANT uint KeyF2							= 113
CONSTANT uint KeyF3							= 114
CONSTANT uint KeyF4							= 115
CONSTANT uint KeyF5							= 116
CONSTANT uint KeyF6							= 117
CONSTANT uint KeyF7							= 118
CONSTANT uint KeyF8							= 119
CONSTANT uint KeyF9							= 120
CONSTANT uint KeyF10							= 121
CONSTANT uint KeyF11							= 122
CONSTANT uint KeyF12							= 123
CONSTANT uint KeyNumLock					= 144
CONSTANT uint KeyScrollLock					= 145
CONSTANT uint KeySemiColon					= 186
CONSTANT uint KeyEqual						= 187
CONSTANT uint KeyComma						= 188
CONSTANT uint KeyDash						= 189
CONSTANT uint KeyPeriod						= 190
CONSTANT uint KeySlash						= 191
CONSTANT uint KeyBackQuote					= 192
CONSTANT uint KeyLeftBracket				= 219
CONSTANT uint KeyBackSlash					= 220
CONSTANT uint KeyRightBracket				= 221
CONSTANT uint KeyQuote						= 222


Public:
// windows messages
CONSTANT long WM_GETICON					= 127
CONSTANT long WM_MOUSEMOVE			= 512
CONSTANT long WM_LBUTTONDOWN		= 513
CONSTANT long WM_LBUTTONUP				= 514
CONSTANT long WM_LBUTTONDBLCLK		= 515
CONSTANT long WM_RBUTTONDOWN		= 516
CONSTANT long WM_RBUTTONUP				= 517
CONSTANT long WM_RBUTTONDBLCLK		= 518
CONSTANT long PBM_CUSTOM75				= 1024 + 74

//Ramón San Félix Ramón
//rsrsystem.soft@gmail.com
//https://rsrsystem.blogspot.com/
//I add this variable to control if the main window will become invisible
Boolean ib_HideWindow = FALSE
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
end variables
forward prototypes
public function boolean of_add_to_systemtray (window ao_window)
public function boolean of_add_to_systemtray (window ao_window, string as_imagename)
public function boolean of_add_to_systemtray (window ao_window, string as_imagename, unsignedinteger aui_index)
private function long of_load_image (string as_filename, unsignedinteger aui_iconindex)
public function boolean of_set_notification_message (window ao_window, string as_title, string as_info, icon ae_icon)
private function boolean of_modify_notification (window ao_window, string as_newtip)
private function boolean of_modify_tray_icon (window ao_window, string as_imagename)
private function boolean of_modify_tray_icon (window ao_window, string as_imagename, unsignedinteger aui_index)
private function integer of_get_dll_version ()
private function boolean of_is_hotkey (unsignedlong wparam, long lparam)
private function long of_load_image (string as_imagename)
private function boolean of_register_hotkey (window ao_window, integer ai_hotkeyid, unsignedinteger aui_modifier, unsignedinteger aui_keycode)
private function boolean of_unregister_hotkey (window ao_window, integer ai_hotkeyid)
public function boolean of_delete_from_systemtray (window ao_window, boolean ab_show)
public function boolean of_set_foreground (window ao_window)
public function boolean of_get_systemtray_active ()
end prototypes

public function boolean of_add_to_systemtray (window ao_window);/*
Method				: of_add_to_systemtray (Function)
Author				: Chris Pollach
Scope  				: Public
Extended			: No
Level					: Concrete

Description			: Call MS-Windows SDK functons to Add Icon to O/S
Behaviour			: add loaded icon to the system tray
Note					: None

Argument(s)		: window ao_window
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations

NOTIFYICONDATA 		lstr_notify

// populate structure
lstr_notify.cbSize		= NOTIFYICONDATA_SIZE
lstr_notify.hWnd		= Handle ( ao_window )
lstr_notify.uID			= 1
lstr_notify.uFlags		= NIF_ICON + NIF_TIP + NIF_MESSAGE
lstr_notify.uCallBackMessage	= PBM_CUSTOM75
lstr_notify.hIcon		= Send ( Handle ( ao_window ), WM_GETICON, ICON_SMALL, 0 )
lstr_notify.szTip		= ao_window.title + Char(0)

// add icon to system tray
IF	Shell_NotifyIcon ( NIM_ADD, lstr_notify ) = TRUE Then
	// make window invisible
	IF ib_HideWindow THEN ao_window.Hide ( )
	ib_rc	= TRUE
Else
	ib_rc	= FALSE
END IF

ib_systemtray_active	=	ib_rc
RETURN		ib_rc

end function

public function boolean of_add_to_systemtray (window ao_window, string as_imagename);/*
Method				: of_add_to_systemtray (Function)
Author				: Chris Pollach
Scope  				: Public
Extended			: No
Level					: Concrete

Description			: Call MS-Windows SDK functons to Add Icon to O/S
Behaviour			: add loaded icon to the system tray
Note					: None

Argument(s)		: window ao_window
							*	 string as_imagename
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations

// add loaded icon to the system tray

NOTIFYICONDATA		 lstr_notify

// populate structure
lstr_notify.cbSize		= NOTIFYICONDATA_SIZE
lstr_notify.hWnd		= Handle ( ao_window )
lstr_notify.uID			= 1
lstr_notify.uFlags		= NIF_ICON + NIF_TIP + NIF_MESSAGE
lstr_notify.uCallBackMessage	= PBM_CUSTOM75
lstr_notify.hIcon		= THIS.of_load_image ( as_imagename )
lstr_notify.szTip		= ao_window.title + Char( 0 )

// add icon to system tray
If Shell_NotifyIcon(NIM_ADD, lstr_notify) = TRUE Then
	// make window invisible
	IF ib_HideWindow THEN ao_window.Hide ( )
	ib_rc = TRUE
Else
	ib_rc = FALSE
End If

ib_systemtray_active		=	ib_rc
RETURN  ib_rc
end function

public function boolean of_add_to_systemtray (window ao_window, string as_imagename, unsignedinteger aui_index);/*
Method				: of_add_to_systemtray (Function)
Author				: Chris Pollach
Scope  				: Public
Extended			: No
Level					: Concrete

Description			: Call MS-Windows SDK functons to Add Icon to O/S
Behaviour			: add loaded icon to the system tray
Note					: None

Argument(s)		: window ao_window
							*	 string as_imagename
							*	 unsignedinteger aui_index
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations

// add loaded icon to the system tray

NOTIFYICONDATA 		lstr_notify

// populate structure
lstr_notify.cbSize		= NOTIFYICONDATA_SIZE
lstr_notify.hWnd		= Handle ( ao_window ) 
lstr_notify.uID			= 1
lstr_notify.uFlags		= NIF_ICON + NIF_TIP + NIF_MESSAGE
lstr_notify.uCallBackMessage	= PBM_CUSTOM75
lstr_notify.hIcon		= THIS.of_load_image ( as_imagename, aui_index )
lstr_notify.szTip		= ao_window.title + Char( 0 )

IF lstr_notify.hIcon 	= 0 Then 
	ib_rc	= FALSE
else
	// add icon to system tray
	IF Shell_NotifyIcon ( NIM_ADD, lstr_notify ) = TRUE Then
		// make window invisible
		IF ib_HideWindow THEN ao_window.Hide ( )
		ib_rc	= TRUE
	Else
		ib_rc	= FALSE
	END IF
END IF

ib_systemtray_active		=	ib_rc
RETURN  ib_rc

end function

private function long of_load_image (string as_filename, unsignedinteger aui_iconindex);/*
Method				: of_load_image (Function)
Author				: Chris Pollach
Scope  				: Private
Extended			: No
Level					: Base

Description			:  Call MS-Windows SDK functions to load an external image
Behaviour			:  load icon into memory from .exe or .dll file
Note					: aui_iconindex is zero based (first icon is 0, second is 1)

Argument(s)		: string as_filename
							*	 unsignedinteger aui_iconindex
Throws				: N/A

Return Value		: long

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations

Long 		ll_handle

// load icon
ll_handle = this.extracticon ( Handle(GetApplication( ) ), as_filename, aui_iconindex )

// save handle for destroy in destructor event
IF	ll_handle > 0 THEN
	il_iconhandles [ UpperBound ( il_iconhandles ) + 1 ] = ll_handle
End IF

Return ll_handle

end function

public function boolean of_set_notification_message (window ao_window, string as_title, string as_info, icon ae_icon);/*
Method				: of_set_notification_message (Function)
Author				: Chris Pollach
Scope  				: Public
Extended			: No
Level					: Base

Description			: Write a message to the O/S System Tray area
Behaviour			: <Comments here>
Note					: None

Argument(s)		: window ao_window
							*	 string as_title
							*	 string as_info
							*	 icon ae_icon
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Software Tool & Die Inc, here in known as STD Inc. All rights reserved.
Any distribution of the STD Foundation Classes (STD_FC) for PowerBuilder®, InfoMaker®,
PowerServer Web® or PowerServer Mobile® source code by other than by STD Inc. is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-05-01
*/

// Declarations


IF  ib_systemtray_active = TRUE THEN 
	// modify window icon tip in the system tray
	NOTIFYICONDATA lstr_notify
	
	// populate structure
	lstr_notify.cbSize		= NOTIFYICONDATA_SIZE
	lstr_notify.hWnd		= Handle(ao_window)
	lstr_notify.uID			= 1
	lstr_notify.uFlags		= NIF_INFO
	lstr_notify.szInfoTitle	= as_title + Char( 0 )
	lstr_notify.szInfo		= as_info + Char( 0 )
	lstr_notify.uTimeout	= 15000
	CHOOSE CASE ae_icon
		CASE StopSign!
			lstr_notify.ae_icons	= NIIF_ERROR
		CASE Information!
			lstr_notify.ae_icons	= NIIF_INFO
		CASE None!
			lstr_notify.ae_icons	= NIIF_NONE
		CASE Exclamation!
			lstr_notify.ae_icons	= NIIF_WARNING
		CASE ELSE
			lstr_notify.ae_icons	= NIIF_INFO
	END CHOOSE
	
	// modify icon tip
	ib_rc	=	Shell_NotifyIcon (NIM_MODIFY, lstr_notify)
else
	ib_rc	=	FALSE
END IF

Return 	ib_rc

end function

private function boolean of_modify_notification (window ao_window, string as_newtip);/*
Method				: of_modify_notification (Function)
Author				: Chris Pollach
Scope  				: Private
Extended			: No
Level					: Base

Description			: Call O/S SDK function to control Icon
Behaviour			: modify window icon tip in the system tray
Note					: None

Argument(s)		: window ao_window
							*	 string as_newtip
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations

NOTIFYICONDATA 	lstr_notify

// populate structure
lstr_notify.cbSize		= NOTIFYICONDATA_SIZE
lstr_notify.hWnd		= Handle ( ao_window )
lstr_notify.uID			= 1
lstr_notify.uFlags		= NIF_TIP
lstr_notify.szTip		= as_newtip + Char(0)

// modify icon tip
ib_rc	=	Shell_NotifyIcon ( NIM_MODIFY, lstr_notify )
RETURN 	ib_rc



end function

private function boolean of_modify_tray_icon (window ao_window, string as_imagename);/*
Method				: of_modify_tray_icon (Function)
Author				: Chris Pollach
Scope  				: Private
Extended			: No
Level					: Base

Description			: Call MS-Windows SDK for Icon processing
Behaviour			: Modify icon in the system tray
Note					: None

Argument(s)		: window ao_window
							*	 string as_imagename
							*	 unsignedinteger aui_index
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations


NOTIFYICONDATA lstr_notify

// populate structure
lstr_notify.cbSize		= NOTIFYICONDATA_SIZE
lstr_notify.hWnd		= Handle(ao_window)
lstr_notify.uID			= 1
lstr_notify.uFlags		= NIF_ICON
lstr_notify.hIcon		= THIS.of_load_image(as_imagename)

// modify icon in system tray
ib_rc	=	Shell_NotifyIcon(NIM_MODIFY, lstr_notify)
RETURN   ib_rc

end function

private function boolean of_modify_tray_icon (window ao_window, string as_imagename, unsignedinteger aui_index);/*
Method				: of_modify_tray_icon (Function)
Author				: Chris Pollach
Scope  				: Private
Extended			: No
Level					: Base

Description			: Call MS-Windows SDK for Icon processing
Behaviour			: Modify icon in the system tray
Note					: None

Argument(s)		: window ao_window
							*	 string as_imagename
							*	 unsignedinteger aui_index
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations

NOTIFYICONDATA lstr_notify

// populate structure
lstr_notify.cbSize		= NOTIFYICONDATA_SIZE
lstr_notify.hWnd		= Handle(ao_window)
lstr_notify.uID			= 1
lstr_notify.uFlags		= NIF_ICON
lstr_notify.hIcon		= THIS.of_load_image ( as_imagename, aui_index )

If lstr_notify.hIcon = 0 Then
	ib_rc	=	FALSE
else
	// modify icon in system tray
	ib_rc		=	Shell_NotifyIcon ( NIM_MODIFY, lstr_notify )
END IF

RETURN 	ib_rc

end function

private function integer of_get_dll_version ();/*
Method				: of_get_dll_version (Function)
Author				: Chris Pollach
Scope  				: Private
Extended			: No
Level					: Base

Description			: Called by this NVUO to get the version of the "comctl32"  DLL 
Behaviour			: determine NOTIFYICONDATA version to use
Note					: None

Argument(s)		: None
Throws				: N/A

Return Value		: integer

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																					-	2010-12-13
*/

// Declarations


// determine NOTIFYICONDATA version to use

DLLVERSIONINFO 		lstr_dvi
String 					ls_libname, ls_function
Long 						ll_rc, ll_module, ll_version


ll_version 	= 1																							// default to original
ls_libname  	= "comctl32.dll"
ls_function 	= "DllGetVersion"

ll_module = this.loadlibrary ( ls_libname )
If ll_module > 0 Then
	ll_rc = this.getprocaddress ( ll_module, ls_function )
	If ll_rc > 0 Then
		lstr_dvi.cbSize = 20
		ll_rc = DllGetVersion ( lstr_dvi )
		CHOOSE CASE lstr_dvi.dwMajorVersion
			CASE 6
				ll_version = 3
			CASE 5
				ll_version = 2
			CASE ELSE
				ll_version = 1
		END CHOOSE
	End If
	this.freelibrary ( ll_module )
End If

Return ll_version

end function

private function boolean of_is_hotkey (unsignedlong wparam, long lparam);/*
Method				: of_is_hotkey (Function)
Author				: Chris Pollach
Scope  				: Private
Extended			: No
Level					: Base

Description			:  return whether this is a WM_HOTKEY event
Behaviour			: Can be called from window 'Other' event
Note					: None

Argument(s)		: unsignedlong wparam
*	 long lparam
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations

IF wparam = 1 Then
	IF IntHigh(lparam) = iui_keycode Then
		IF IntLow(lparam)  = iui_modifier Then
			ib_rc	=	True
		End IF
	End IF
End IF
ib_rc	=	FALSE
RETURN  	ib_rc

end function

private function long of_load_image (string as_imagename);/*
Method				: of_load_image (Function)
Author				: Chris Pollach
Scope  				: Private
Extended			: No
Level					: Base

Description			: Call MS-Windows SDK functions to load an external image
Behaviour			:  load image into memory from .ico, .cur or .ani file
Note					: None

Argument(s)		: string as_imagename
Throws				: N/A

Return Value		: long

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations

// load image into memory from .ico, .cur or .ani file

Long 		ll_handle

CHOOSE CASE Lower ( Right ( as_imagename, 4 ) )
	CASE ".ico"
		ll_handle = this.loadimage ( 0, as_imagename, IMAGE_ICON, 0, 0, LR_LOADFROMFILE + LR_DEFAULTSIZE )
	CASE ".cur", ".ani"
		ll_handle = this.loadimage ( 0, as_imagename, IMAGE_CURSOR, 0, 0, LR_LOADFROMFILE + LR_DEFAULTSIZE )
	CASE ELSE
		
END CHOOSE

Return ll_handle

end function

private function boolean of_register_hotkey (window ao_window, integer ai_hotkeyid, unsignedinteger aui_modifier, unsignedinteger aui_keycode);/*
Method				: of_register_hotkey (Function)
Author				: Chris Pollach
Scope  				: Private
Extended			: No
Level					: Base

Description			: Register the current Window to the O/S
Behaviour			: <Comments here>
Note					: None

Argument(s)		: window ao_window
							*	 integer ai_hotkeyid
							*	 unsignedinteger aui_modifier
							*	 unsignedinteger aui_keycode
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations


// remember hotkey info
iui_keycode  	= aui_keycode
iui_modifier 		= aui_modifier

// register a system wide hotkey
ib_rc	=	this.Registerhotkey ( Handle (ao_window), ai_hotkeyid, aui_modifier, aui_keycode )

Return   ib_rc

end function

private function boolean of_unregister_hotkey (window ao_window, integer ai_hotkeyid);/*
Method				: of_unregister_hotkey (Function)
Author				: Chris Pollach
Scope  				: Private
Extended			: No
Level					: Base

Description			: Unregister HotKey from the O/S
Behaviour			: <Comments here>
Note					: None

Argument(s)		: window ao_window
*	 integer ai_hotkeyid
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations


// unregister a system wide hotkey
ib_rc	=	this.unregisterhotkey ( Handle ( ao_window ), ai_hotkeyid )	

Return 	ib_rc

end function

public function boolean of_delete_from_systemtray (window ao_window, boolean ab_show);/*
Method				: of_delete_from_systemtray (Function)
Author				: Chris Pollach
Scope  				: Public
Extended			: No
Level					: Concrete

Description			: Call MS-Windows SDK functions to detach App from O/S system tray
Behaviour			: delete window icon from the system tray
Note					: None

Argument(s)		: window ao_window
							*	 boolean ab_show
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations


NOTIFYICONDATA lstr_notify

// populate structure
lstr_notify.cbSize		= NOTIFYICONDATA_SIZE
lstr_notify.hWnd		= Handle(ao_window)
lstr_notify.uID			= 1

If ab_show Then
	// make window visible
	ao_window.Show ( )
	// give the window primary focus
	THIS.of_set_Foreground (ao_window )
End If

// Remove icon from system tray
ib_rc	=	Shell_NotifyIcon ( NIM_DELETE, lstr_notify )
ib_systemtray_active		=	FALSE
Return ib_rc

end function

public function boolean of_set_foreground (window ao_window);/*
Method				: of_set_foreground (Function)
Author				: Chris Pollach
Scope  				: Private
Extended			: No
Level					: Base

Description			: Bring the current window to the Foreground!
Behaviour			: <Comments here>
Note					: None

Argument(s)		: window ao_window
Throws				: N/A

Return Value		: boolean

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations


// give window proper focus

ib_rc	=	this.SetForegroundWindow ( Handle ( ao_window ) )

RETURN  ib_rc


end function

public function boolean of_get_systemtray_active ();/*
Method				: of_get_systemtray_active()
Author				: Ramón San Félix Ramón
Scope  				: Public
Extended			: No
Level					: Concrete

Description			: Return ib_systemtray_active
Behaviour			: It simply returns the value of a private variable.
Note					: None

Argument(s)		: None
Throws				: N/A

Return Value		: boolean

-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2022-02-27
*/


RETURN ib_systemtray_active
end function

on n_cst_systemtray.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_systemtray.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;call super::constructor;/*
Method				: constructor (Event)
Author				: Chris Pollach
Scope  				: {Public/Protected/Private}
Extended			: {Yes/No}
Level					: {Base, Extension, Concrete}

Description			: Code to initialize System Tray processing
Behaviour			: <Comments here>
Note					: None

Argument(s)		: None
Throws				: N/A

Return Value		: long

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations

// determine version of NOTIFYICONDATA to use

NOTIFYICON_VERSION = THIS.of_get_dll_version()										// Get DLL version

CHOOSE CASE NOTIFYICON_VERSION														// Get version
	CASE 3
		NOTIFYICONDATA_SIZE = NOTIFYICONDATA_V3_SIZE
	CASE 2
		NOTIFYICONDATA_SIZE = NOTIFYICONDATA_V2_SIZE
	CASE ELSE
		NOTIFYICONDATA_SIZE = NOTIFYICONDATA_V1_SIZE
END CHOOSE

end event

event destructor;/*
Method				: destructor (Event)
Author				: Chris Pollach
Scope  				: Public
Extended			: Yes
Level					: Extension

Description			: Code to Clean-up environment & deregister from O/S
Behaviour			: <Comments here>
Note					: None

Argument(s)		: None
Throws				: N/A

Return Value		: long

--------------------------------------------  CopyRight -----------------------------------------------------
Copyright © 2018 by Appeon. All rights reserved.
Any distribution of this PowerBuilder® application or its source code
by other than by Appeon is prohibited.
-------------------------------------------  Revisions -------------------------------------------------------
1.0 		Inital Version																		-	2010-12-13
*/

// Declarations

Integer li_cnt, li_max

// destroy icon handles created by ExtractIcon function
li_max = UpperBound(il_iconhandles)
FOR li_cnt = 1 TO li_max
	this.destroyicon(  il_iconhandles [ li_cnt ] )
NEXT
end event

