$PBExportHeader$n_cst_security_ext.sru
forward
global type n_cst_security_ext from n_cst_security
end type
end forward

global type n_cst_security_ext from n_cst_security
end type
global n_cst_security_ext n_cst_security_ext

forward prototypes
public function string of_decrypt (string as_source)
end prototypes

public function string of_decrypt (string as_source);String ls_decrypt, ls_token, ls_key, ls_IV
//Pongo Valores Fijos a Claves Maestras
Constant String ls_MasterKey =  "reports"
Constant String ls_MasterIV  = "IV202201900"

//Leemos el Token del Archivo INI
IF isPowerServerApp() = FALSE THEN
	ls_token =ProfileString("Setting.ini", "Setup", "SecurityToken", "")
ELSE 
	ls_token =ProfileString("CloudSetting.ini", "Setup", "SecurityToken", "")
END IF

IF  of_get_Token(ls_token, ls_MasterKey, ls_MasterIV, REF ls_key, REF ls_IV) THEN
	ls_decrypt = of_decrypt(as_source, ls_key, ls_iv)
END IF

RETURN ls_decrypt
end function

on n_cst_security_ext.create
call super::create
end on

on n_cst_security_ext.destroy
call super::destroy
end on

