$PBExportHeader$n_cst_genter.sru
$PBExportComments$Objeto Creado con ejemplo Table_to_Object https://rsrsystem.blogspot.com/
forward
global type n_cst_genter from nonvisualobject
end type
end forward

global type n_cst_genter from nonvisualobject
end type
global n_cst_genter n_cst_genter

type variables
end variables

forward prototypes
public function str_genter of_select (string as_empresa, string as_tipoter, string as_codigo) throws exception
public subroutine of_insert (str_genter astr_genter) throws exception
public subroutine of_update (str_genter astr_genter) throws exception
public subroutine of_delete  (string as_empresa, string as_tipoter, string as_codigo) throws exception
public function str_genter of_reset ()
public function boolean of_exists  (string as_empresa, string as_tipoter, string as_codigo)
public function string of_getfieldtype (string as_column)
public function long of_getitemnumber  (string as_column, string as_empresa, string as_tipoter, string as_codigo)
public function string of_getitemstring  (string as_column, string as_empresa, string as_tipoter, string as_codigo)
public function datetime of_getitemdatetime  (string as_column, string as_empresa, string as_tipoter, string as_codigo)
public function decimal of_getitemdecimal  (string as_column, string as_empresa, string as_tipoter, string as_codigo)
private function exception of_get_exception (string as_message)
end prototypes

public function str_genter of_select (string as_empresa, string as_tipoter, string as_codigo) throws exception;str_genter lstr_genter

SELECT	genter.empresa,
	genter.tipoter,
	genter.codigo,
	genter.nombre,
	genter.razon,
	genter.cif,
	genter.pais,
	genter.provincia,
	genter.cod_postal,
	genter.localidad,
	genter.domicilio,
	genter.telefono,
	genter.fax,
	genter.moneda,
	genter.riesgo,
	genter.falta,
	genter.apellidos,
	genter.sexo,
	genter.fecha_nacimiento,
	genter.idioma,
	genter.colocacion,
	genter.activo,
	genter.tipopais,
	genter.cl_domicilio,
	genter.nu_domicilio,
	genter.prefijo_provincia,
	genter.distribuidor,
	genter.codigo_cliente,
	genter.cuenta,
	genter.correos,
	genter.abreviado,
	genter.provisional,
	genter.web,
	genter.correo_electronico,
	genter.tipo_proveedor,
	genter.bloqueo_compras,
	genter.movil,
	genter.usuario_web,
	genter.pass_web,
	genter.lpd_confidencial,
	genter.tipo_empresa,
	genter.extinguida
INTO	:lstr_genter.empresa,
	:lstr_genter.tipoter,
	:lstr_genter.codigo,
	:lstr_genter.nombre,
	:lstr_genter.razon,
	:lstr_genter.cif,
	:lstr_genter.pais,
	:lstr_genter.provincia,
	:lstr_genter.cod_postal,
	:lstr_genter.localidad,
	:lstr_genter.domicilio,
	:lstr_genter.telefono,
	:lstr_genter.fax,
	:lstr_genter.moneda,
	:lstr_genter.riesgo,
	:lstr_genter.falta,
	:lstr_genter.apellidos,
	:lstr_genter.sexo,
	:lstr_genter.fecha_nacimiento,
	:lstr_genter.idioma,
	:lstr_genter.colocacion,
	:lstr_genter.activo,
	:lstr_genter.tipopais,
	:lstr_genter.cl_domicilio,
	:lstr_genter.nu_domicilio,
	:lstr_genter.prefijo_provincia,
	:lstr_genter.distribuidor,
	:lstr_genter.codigo_cliente,
	:lstr_genter.cuenta,
	:lstr_genter.correos,
	:lstr_genter.abreviado,
	:lstr_genter.provisional,
	:lstr_genter.web,
	:lstr_genter.correo_electronico,
	:lstr_genter.tipo_proveedor,
	:lstr_genter.bloqueo_compras,
	:lstr_genter.movil,
	:lstr_genter.usuario_web,
	:lstr_genter.pass_web,
	:lstr_genter.lpd_confidencial,
	:lstr_genter.tipo_empresa,
	:lstr_genter.extinguida
FROM genter
WHERE (genter.empresa = :as_empresa)
AND	(genter.tipoter = :as_tipoter)
AND	(genter.codigo = :as_codigo)
USING SQLCA;

IF SQLCA.SQLcode <> 0 THEN
	throw of_get_exception("Error Leyendo Tabla Genter. Código SQL:"+String(SQLCA.SQLCode)+": "+SQLCA.SQLErrText)
END IF

RETURN lstr_genter
end function

public subroutine of_insert (str_genter astr_genter) throws exception;INSERT INTO genter (genter.empresa,
	genter.tipoter,
	genter.codigo,
	genter.nombre,
	genter.razon,
	genter.cif,
	genter.pais,
	genter.provincia,
	genter.cod_postal,
	genter.localidad,
	genter.domicilio,
	genter.telefono,
	genter.fax,
	genter.moneda,
	genter.riesgo,
	genter.falta,
	genter.apellidos,
	genter.sexo,
	genter.fecha_nacimiento,
	genter.idioma,
	genter.colocacion,
	genter.activo,
	genter.tipopais,
	genter.cl_domicilio,
	genter.nu_domicilio,
	genter.prefijo_provincia,
	genter.distribuidor,
	genter.codigo_cliente,
	genter.cuenta,
	genter.correos,
	genter.abreviado,
	genter.provisional,
	genter.web,
	genter.correo_electronico,
	genter.tipo_proveedor,
	genter.bloqueo_compras,
	genter.movil,
	genter.usuario_web,
	genter.pass_web,
	genter.lpd_confidencial,
	genter.tipo_empresa,
	genter.extinguida)
VALUES	(:astr_genter.empresa,
	:astr_genter.tipoter,
	:astr_genter.codigo,
	:astr_genter.nombre,
	:astr_genter.razon,
	:astr_genter.cif,
	:astr_genter.pais,
	:astr_genter.provincia,
	:astr_genter.cod_postal,
	:astr_genter.localidad,
	:astr_genter.domicilio,
	:astr_genter.telefono,
	:astr_genter.fax,
	:astr_genter.moneda,
	:astr_genter.riesgo,
	:astr_genter.falta,
	:astr_genter.apellidos,
	:astr_genter.sexo,
	:astr_genter.fecha_nacimiento,
	:astr_genter.idioma,
	:astr_genter.colocacion,
	:astr_genter.activo,
	:astr_genter.tipopais,
	:astr_genter.cl_domicilio,
	:astr_genter.nu_domicilio,
	:astr_genter.prefijo_provincia,
	:astr_genter.distribuidor,
	:astr_genter.codigo_cliente,
	:astr_genter.cuenta,
	:astr_genter.correos,
	:astr_genter.abreviado,
	:astr_genter.provisional,
	:astr_genter.web,
	:astr_genter.correo_electronico,
	:astr_genter.tipo_proveedor,
	:astr_genter.bloqueo_compras,
	:astr_genter.movil,
	:astr_genter.usuario_web,
	:astr_genter.pass_web,
	:astr_genter.lpd_confidencial,
	:astr_genter.tipo_empresa,
	:astr_genter.extinguida)
USING SQLCA;

IF SQLCA.SQLcode <> 0 OR SQLCA.SQLNRows <> 1 THEN
	throw of_get_exception("Error Insertando en Tabla Genter. Código SQL:"+String(SQLCA.SQLCode)+": "+SQLCA.SQLErrText)
END IF

end subroutine

public subroutine of_update (str_genter astr_genter) throws exception;UPDATE genter
SET 	genter.nombre = :astr_genter.nombre,
	genter.razon = :astr_genter.razon,
	genter.cif = :astr_genter.cif,
	genter.pais = :astr_genter.pais,
	genter.provincia = :astr_genter.provincia,
	genter.cod_postal = :astr_genter.cod_postal,
	genter.localidad = :astr_genter.localidad,
	genter.domicilio = :astr_genter.domicilio,
	genter.telefono = :astr_genter.telefono,
	genter.fax = :astr_genter.fax,
	genter.moneda = :astr_genter.moneda,
	genter.riesgo = :astr_genter.riesgo,
	genter.falta = :astr_genter.falta,
	genter.apellidos = :astr_genter.apellidos,
	genter.sexo = :astr_genter.sexo,
	genter.fecha_nacimiento = :astr_genter.fecha_nacimiento,
	genter.idioma = :astr_genter.idioma,
	genter.colocacion = :astr_genter.colocacion,
	genter.activo = :astr_genter.activo,
	genter.tipopais = :astr_genter.tipopais,
	genter.cl_domicilio = :astr_genter.cl_domicilio,
	genter.nu_domicilio = :astr_genter.nu_domicilio,
	genter.prefijo_provincia = :astr_genter.prefijo_provincia,
	genter.distribuidor = :astr_genter.distribuidor,
	genter.codigo_cliente = :astr_genter.codigo_cliente,
	genter.cuenta = :astr_genter.cuenta,
	genter.correos = :astr_genter.correos,
	genter.abreviado = :astr_genter.abreviado,
	genter.provisional = :astr_genter.provisional,
	genter.web = :astr_genter.web,
	genter.correo_electronico = :astr_genter.correo_electronico,
	genter.tipo_proveedor = :astr_genter.tipo_proveedor,
	genter.bloqueo_compras = :astr_genter.bloqueo_compras,
	genter.movil = :astr_genter.movil,
	genter.usuario_web = :astr_genter.usuario_web,
	genter.pass_web = :astr_genter.pass_web,
	genter.lpd_confidencial = :astr_genter.lpd_confidencial,
	genter.tipo_empresa = :astr_genter.tipo_empresa,
	genter.extinguida = :astr_genter.extinguida
WHERE (genter.empresa = :astr_genter.empresa)
AND	(genter.tipoter = :astr_genter.tipoter)
AND	(genter.codigo = :astr_genter.codigo)
USING SQLCA;

IF SQLCA.SQLcode <> 0 OR SQLCA.SQLNRows <> 1 THEN
	throw of_get_exception("Error Actualizando Registro en Tabla Genter. Código SQL:"+String(SQLCA.SQLCode)+": "+SQLCA.SQLErrText)
END IF

end subroutine

public subroutine of_delete  (string as_empresa, string as_tipoter, string as_codigo) throws exception;DELETE genter
WHERE (genter.empresa = :as_empresa)
AND	(genter.tipoter = :as_tipoter)
AND	(genter.codigo = :as_codigo)
USING SQLCA;

IF SQLCA.SQLcode <> 0 OR SQLCA.SQLNRows <> 1 THEN
	throw of_get_exception("Error Eliminando Registro en Tabla Genter. Código SQL:"+String(SQLCA.SQLCode)+": "+SQLCA.SQLErrText)
END IF

end subroutine

public function str_genter of_reset ();str_genter lstr_genter

SetNull(lstr_genter.empresa)
SetNull(lstr_genter.tipoter)
SetNull(lstr_genter.codigo)
SetNull(lstr_genter.nombre)
SetNull(lstr_genter.razon)
SetNull(lstr_genter.cif)
SetNull(lstr_genter.pais)
SetNull(lstr_genter.provincia)
SetNull(lstr_genter.cod_postal)
SetNull(lstr_genter.localidad)
SetNull(lstr_genter.domicilio)
SetNull(lstr_genter.telefono)
SetNull(lstr_genter.fax)
SetNull(lstr_genter.moneda)
SetNull(lstr_genter.riesgo)
SetNull(lstr_genter.falta)
SetNull(lstr_genter.apellidos)
SetNull(lstr_genter.sexo)
SetNull(lstr_genter.fecha_nacimiento)
SetNull(lstr_genter.idioma)
SetNull(lstr_genter.colocacion)
SetNull(lstr_genter.activo)
SetNull(lstr_genter.tipopais)
SetNull(lstr_genter.cl_domicilio)
SetNull(lstr_genter.nu_domicilio)
SetNull(lstr_genter.prefijo_provincia)
SetNull(lstr_genter.distribuidor)
SetNull(lstr_genter.codigo_cliente)
SetNull(lstr_genter.cuenta)
SetNull(lstr_genter.correos)
SetNull(lstr_genter.abreviado)
SetNull(lstr_genter.provisional)
SetNull(lstr_genter.web)
SetNull(lstr_genter.correo_electronico)
SetNull(lstr_genter.tipo_proveedor)
SetNull(lstr_genter.bloqueo_compras)
SetNull(lstr_genter.movil)
SetNull(lstr_genter.usuario_web)
SetNull(lstr_genter.pass_web)
SetNull(lstr_genter.lpd_confidencial)
SetNull(lstr_genter.tipo_empresa)
SetNull(lstr_genter.extinguida)

RETURN lstr_genter
end function

public function boolean of_exists  (string as_empresa, string as_tipoter, string as_codigo);Long ll_Count
Boolean lb_exists = FALSE

SELECT count(*)
INTO :ll_Count
FROM genter
WHERE (genter.empresa = :as_empresa)
AND	(genter.tipoter = :as_tipoter)
AND	(genter.codigo = :as_codigo)
USING SQLCA;

IF isNull(ll_Count) THEN ll_Count = 0

IF ll_Count > 0 THEN lb_exists = TRUE

RETURN lb_exists
end function

public function string of_getfieldtype (string as_column);String ls_dataType
// Crear una sentencia SELECT Dinamica
String ls_sql
ls_sql = "SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'genter' AND COLUMN_NAME = ?"

// Declarar el cursor
DECLARE cur_genter DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA FROM :ls_sql  USING SQLCA;

// Abrir el cursor y ejecutar la consulta
OPEN DYNAMIC cur_genter USING :as_column;
FETCH cur_genter INTO :ls_dataType;
CLOSE cur_genter;

// Devolver el tipo de dato del campo
RETURN ls_dataType
end function

public function long of_getitemnumber  (string as_column, string as_empresa, string as_tipoter, string as_codigo);Long ll_fieldValue

// Crear una sentencia SELECT Dinamica
String ls_sql

ls_sql = "SELECT genter."+as_column+" FROM genter WHERE genter.empresa = ? AND genter.tipoter = ? AND genter.codigo = ?"

// Declarar el cursor
DECLARE cur_genter DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA FROM :ls_sql USING SQLCA;

// Abrir el cursor y ejecutar la consulta
OPEN DYNAMIC cur_genter USING :as_empresa, :as_tipoter, :as_codigo;
FETCH cur_genter INTO :ll_fieldValue;
CLOSE cur_genter;

RETURN ll_fieldValue
end function

public function string of_getitemstring  (string as_column, string as_empresa, string as_tipoter, string as_codigo);String ls_fieldValue

// Crear una sentencia SELECT Dinamica
String ls_sql

ls_sql = "SELECT genter."+as_column+" FROM genter WHERE genter.empresa = ? AND genter.tipoter = ? AND genter.codigo = ?"

// Declarar el cursor
DECLARE cur_genter DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA FROM :ls_sql USING SQLCA;

// Abrir el cursor y ejecutar la consulta
OPEN DYNAMIC cur_genter USING :as_empresa, :as_tipoter, :as_codigo;
FETCH cur_genter INTO :ls_fieldValue;
CLOSE cur_genter;

RETURN ls_fieldValue
end function

public function datetime of_getitemdatetime  (string as_column, string as_empresa, string as_tipoter, string as_codigo);Datetime ldt_fieldValue

// Crear una sentencia SELECT Dinamica
String ls_sql

ls_sql = "SELECT genter."+as_column+" FROM genter WHERE genter.empresa = ? AND genter.tipoter = ? AND genter.codigo = ?"

// Declarar el cursor
DECLARE cur_genter DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA FROM :ls_sql USING SQLCA;

// Abrir el cursor y ejecutar la consulta
OPEN DYNAMIC cur_genter USING :as_empresa, :as_tipoter, :as_codigo;
FETCH cur_genter INTO :ldt_fieldValue;
CLOSE cur_genter;

RETURN ldt_fieldValue
end function

public function decimal of_getitemdecimal  (string as_column, string as_empresa, string as_tipoter, string as_codigo);Decimal ld_fieldValue

// Crear una sentencia SELECT Dinamica
String ls_sql

ls_sql = "SELECT genter."+as_column+" FROM genter WHERE genter.empresa = ? AND genter.tipoter = ? AND genter.codigo = ?"

// Declarar el cursor
DECLARE cur_genter DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA FROM :ls_sql USING SQLCA;

// Abrir el cursor y ejecutar la consulta
OPEN DYNAMIC cur_genter USING :as_empresa, :as_tipoter, :as_codigo;
FETCH cur_genter INTO :ld_fieldValue;
CLOSE cur_genter;

RETURN ld_fieldValue
end function

private function exception of_get_exception (string as_message);
/* private
description:	helper function to get an exception object with message
parameters:		string as_message:	the string which should be set into the exception
return:			exception
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

exception lu_exception
lu_exception = Create exception
lu_exception.setmessage(as_message)
return lu_exception
end function

on n_cst_genter.create
call super::create
end on

on n_cst_genter.destroy
call super::destroy
end on

