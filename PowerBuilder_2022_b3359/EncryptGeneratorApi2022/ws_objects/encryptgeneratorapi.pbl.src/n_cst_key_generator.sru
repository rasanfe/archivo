﻿$PBExportHeader$n_cst_key_generator.sru
forward
global type n_cst_key_generator from nonvisualobject
end type
end forward

global type n_cst_key_generator from nonvisualobject
end type
global n_cst_key_generator n_cst_key_generator

type variables
RestClient irc_rc
nvo_coderobject in_coderobject
Constant String is_ApiUrl = "https://localhost:7923/api"
Constant String is_ApiController = "/KeyGenerator"


end variables

forward prototypes
public function boolean of_validar (string as_clave)
public function string of_generar ()
public subroutine of_total_caracteres (integer ai_totalcaracteres)
public function string of_restclienterrortext (integer ai_error_number)
end prototypes

public function boolean of_validar (string as_clave);Boolean lb_isValid
String ls_response, ls_url, ls_jsonSent
Integer li_rtn, li_StatusCode
Constant String ls_ApiMethod = "/validate"
nvo_JsonGenerator  lnv_JsonGenerator

//Sets URL
ls_url = is_ApiUrl+is_ApiController+ls_ApiMethod

as_clave = in_coderobject.of_Base64URLEncode(as_clave)

lnv_JsonGenerator = Create nvo_JsonGenerator
lnv_JsonGenerator.of_AddItemString("key", as_clave)
//Cambio Comillas Dobles por Simples
ls_jsonSent = lnv_JsonGenerator.of_GetJsonString()
destroy lnv_JsonGenerator

li_rtn = irc_rc.SendPostRequest(ls_url, ls_jsonSent, ls_response)

If li_rtn <> 1 Then
	Messagebox("Error al enviar la solicitud", of_restclienterrortext(li_rtn), Exclamation!)
    lb_isValid = False
Else
	li_StatusCode = irc_rc.GetResponseStatusCode() 
	
	//Checks if any error according to the value of ResponseStatuscode and ls_Response
	If li_StatusCode <> 200 Then
		 Messagebox("Error", "Codigo de error: " + String(li_StatusCode), Exclamation!)
		 lb_isValid = False
	Else
		If ls_response  ="true" Then lb_isValid = True
	End If
End If

RETURN lb_isValid

end function

public function string of_generar ();String ls_ClaveGenerada, ls_url
Integer li_rtn, li_StatusCode
Constant String ls_ApiMethod = "/generate"
JsonParser lnv_JsonParser
Long ll_RootObject


//Sets URL
ls_url = is_ApiUrl+is_ApiController+ls_ApiMethod 

clipboard(ls_url)

li_rtn = irc_rc.SendGetRequest(ls_url, ls_ClaveGenerada)

If li_rtn <> 1 Then
	  Messagebox("Error al enviar la solicitud", of_restclienterrortext(li_rtn), Exclamation!)
	ls_ClaveGenerada=""
Else
	li_StatusCode = irc_rc.GetResponseStatusCode() 
	
	//Checks if any error according to the value of ResponseStatuscode and ls_Response
	If li_StatusCode <> 200 Then
		 Messagebox("Error", "Codigo de error: "+string( irc_rc.GetResponseStatusCode()))
		ls_ClaveGenerada=""
	End If
End If


//Parseamos el Json Recibido
lnv_JsonParser = Create JsonParser

lnv_JsonParser.LoadString(ls_ClaveGenerada)
ll_RootObject = lnv_JsonParser.GetRootItem()

ls_ClaveGenerada = lnv_JsonParser.GetItemString(ll_RootObject, "generatedKey")
ls_ClaveGenerada = in_coderobject.of_Base64URLDecode(ls_ClaveGenerada)

destroy lnv_JsonParser

RETURN ls_ClaveGenerada
end function

public subroutine of_total_caracteres (integer ai_totalcaracteres);String ls_response, ls_url
Integer li_rtn, li_StatusCode
Constant String ls_ApiMethod = "/settotalchars"

//Sets URL
ls_url = is_ApiUrl+is_ApiController+ls_ApiMethod

li_rtn = irc_rc.SendPostRequest(ls_url, string(ai_totalcaracteres), ls_response)

If li_rtn <> 1 Then
    Messagebox("Error al enviar la solicitud", of_restclienterrortext(li_rtn), Exclamation!)
Else
	li_StatusCode = irc_rc.GetResponseStatusCode()
	
	//Checks if any error according to the value of ResponseStatuscode and ls_Response
	//Este metodo devuelve 204 NoContent si va bien.
	If li_StatusCode <> 204 Then
		 Messagebox("Error", "Codigo de error: " + String(li_StatusCode), Exclamation!)
	End If
End If

RETURN 
end subroutine

public function string of_restclienterrortext (integer ai_error_number);String ls_errorText

CHOOSE CASE ai_error_number
    CASE -1
       ls_errorText = "Error común"
    CASE -2
       ls_errorText = "URL inválida"
    CASE -3
       ls_errorText = "No se puede conectar a Internet"
    CASE -4
       ls_errorText = "Tiempo de espera agotado"
    CASE -5
       ls_errorText = "No se pudo obtener el token"
    CASE -6
       ls_errorText = "Fallo al exportar JSON"
    CASE -7
       ls_errorText = "Fallo al descomprimir los datos"
    CASE -10
       ls_errorText = "El token es inválido o ha expirado"
    CASE -11
       ls_errorText = "El parámetro es inválido"
    CASE -12
       ls_errorText = "Concesión inválida"
    CASE -13
       ls_errorText = "SCOPE inválido"
    CASE -14
       ls_errorText = "Fallo en la conversión de código"
    CASE -15
       ls_errorText = "Conjunto de caracteres no soportado"
    CASE -16
       ls_errorText = "El JSON no es un JSON plano con estructura de dos niveles"
    CASE -17
       ls_errorText = "No se insertaron datos en el DataWindow porque ninguna clave en el JSON coincide con algún nombre de columna"
    CASE -18
       ls_errorText = "Se ha habilitado la verificación de revocación de certificación, pero no se pudo verificar si un certificado ha sido revocado. El servidor utilizado para la verificación de revocación podría estar inalcanzable"
    CASE -19
       ls_errorText = "El certificado SSL es inválido"
    CASE -20
       ls_errorText = "El certificado SSL ha sido revocado"
    CASE -21
       ls_errorText = "La función no reconoce la Autoridad Certificadora que generó el certificado del servidor"
    CASE -22
       ls_errorText = "El nombre común del certificado SSL (campo nombre de host) es incorrecto. Por ejemplo, si ingresaste www.appeon.com y el nombre común en el certificado dice www.devmagic.com"
    CASE -23
       ls_errorText = "La fecha del certificado SSL recibido del servidor es incorrecta. El certificado ha expirado"
    CASE -24
       ls_errorText = "El certificado no fue emitido para la autenticación del servidor"
    CASE -25
       ls_errorText = "La aplicación experimentó un error interno al cargar las bibliotecas SSL"
    CASE -26
       ls_errorText = "Más de un tipo de errores al validar el certificado del servidor"
    CASE -27
       ls_errorText = "El servidor requiere que el cliente proporcione un certificado"
    CASE -28
       ls_errorText = "El certificado del cliente no ha sido asignado con una clave privada"
    CASE -29
       ls_errorText = "El certificado del cliente no tiene una clave privada accesible"
    CASE -30
       ls_errorText = "No se puede encontrar el certificado especificado"
    CASE -31
       ls_errorText = "Fallo al leer el certificado"
    CASE -32
       ls_errorText = "La contraseña del certificado es incorrecta"
    CASE -33
       ls_errorText = "Ha ocurrido un error de seguridad. Posible causa: El cliente no soporta la versión de SSL/TLS requerida por el servidor. Por ejemplo: El cliente no soporta TLS 1.3 cuando el servidor requiere TLS 1.3"
    CASE -34
       ls_errorText = "Respuesta no reconocible. Normalmente esto es porque la versión HTTP no coincide con la versión requerida por el servidor"
    CASE -35
       ls_errorText = "Error de TLS 1.3. El servidor no soporta TLS 1.3"
    CASE ELSE
       ls_errorText = "Código de error desconocido: " + string(ai_error_number)
END CHOOSE

Return ls_errorText
end function

on n_cst_key_generator.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_key_generator.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;irc_rc = Create RestClient
in_coderobject = Create nvo_coderobject

irc_rc.SetRequestHeaders("Content-Type:application/json;charset=UTF-8~r~nAccept-Encoding:gzip")
end event

event destructor;destroy irc_rc
destroy in_coderobject
end event

