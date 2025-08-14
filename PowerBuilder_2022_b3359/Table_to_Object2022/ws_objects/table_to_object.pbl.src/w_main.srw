$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_info from statictext within w_main
end type
type st_10 from statictext within w_main
end type
type st_9 from statictext within w_main
end type
type st_7 from statictext within w_main
end type
type st_platform from statictext within w_main
end type
type st_myversion from statictext within w_main
end type
type p_2 from picture within w_main
end type
type st_3 from statictext within w_main
end type
type rb_gffun from radiobutton within w_main
end type
type rb_datawindow from radiobutton within w_main
end type
type st_8 from statictext within w_main
end type
type sle_filename from singlelineedit within w_main
end type
type mle_object_syntax from multilineedit within w_main
end type
type st_6 from statictext within w_main
end type
type mle_comment from multilineedit within w_main
end type
type sle_prefix from singlelineedit within w_main
end type
type st_5 from statictext within w_main
end type
type rb_structure from radiobutton within w_main
end type
type rb_autonvo from radiobutton within w_main
end type
type dw_datatype from datawindow within w_main
end type
type cbx_1 from checkbox within w_main
end type
type mle_sql_syntax from multilineedit within w_main
end type
type st_1 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type dw_tables from datawindow within w_main
end type
type dw_columns from datawindow within w_main
end type
type st_4 from statictext within w_main
end type
type gb_3 from groupbox within w_main
end type
type dw_new from datawindow within w_main
end type
type cb_close from commandbutton within w_main
end type
type cb_create from commandbutton within w_main
end type
type cb_createsyntax from commandbutton within w_main
end type
type cb_savesyntax from commandbutton within w_main
end type
type r_2 from rectangle within w_main
end type
end forward

global type w_main from window
integer width = 4791
integer height = 3252
boolean titlebar = true
string title = "Tablas a Objeto"
boolean controlmenu = true
boolean minbox = true
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
st_info st_info
st_10 st_10
st_9 st_9
st_7 st_7
st_platform st_platform
st_myversion st_myversion
p_2 p_2
st_3 st_3
rb_gffun rb_gffun
rb_datawindow rb_datawindow
st_8 st_8
sle_filename sle_filename
mle_object_syntax mle_object_syntax
st_6 st_6
mle_comment mle_comment
sle_prefix sle_prefix
st_5 st_5
rb_structure rb_structure
rb_autonvo rb_autonvo
dw_datatype dw_datatype
cbx_1 cbx_1
mle_sql_syntax mle_sql_syntax
st_1 st_1
st_2 st_2
dw_tables dw_tables
dw_columns dw_columns
st_4 st_4
gb_3 gb_3
dw_new dw_new
cb_close cb_close
cb_create cb_create
cb_createsyntax cb_createsyntax
cb_savesyntax cb_savesyntax
r_2 r_2
end type
global w_main w_main

type variables
string is_report_type, is_table
string old_string=""
integer old_fila=0

//datastore ids_lib_string
//string       is_lib
string       is_export_name
string       is_str_syntax
string	      is_file_ext=".srs"
string       is_comment
string       is_prefix="str"

end variables

forward prototypes
private function string wf_build_sql_syntax ()
private function string wf_build_dw_syntax ()
private function integer wf_create_structure_export ()
private function integer wf_save_syntax ()
private subroutine wf_aspecto ()
private function integer wf_create_auto_nvo_export ()
private function string wf_argumentos_funciones (boolean ab_tipos)
private function integer wf_create_datawindow_export ()
private function boolean wf_is_primary_key (string as_column)
private function string wf_dw_where_clause ()
private function integer wf_create_global_fun_export ()
public subroutine wf_connect ()
public subroutine wf_version ()
private subroutine wf_set_new ()
end prototypes

private function string wf_build_sql_syntax ();// This will build a sql syntax string based on the selected items in 
// the dw_columns and dw_tables datawindows.

// The function will return a string 

string	ls_columns, ls_column, ls_sql_syntax
long	ll_Rows, ll_index

//Scan the columns datawindow and find all the selected columns. 
//Build a string of columns based on the selected rows.
ll_Rows = dw_columns.RowCount ( )

For ll_index = 1 to ll_Rows
	If dw_columns.IsSelected(ll_index) Then 
		If ls_columns <> "" Then ls_columns = ls_columns + ", "
		ls_column = dw_columns.GetItemString(ll_index, 1)
		ls_columns = ls_columns + ls_column
	End If
Next

//contsruct the sql string 
If ls_columns <> "" Then		
	// Construct the Select statement
	ls_sql_syntax = "Select " + ls_columns + " from " + is_table
	return ls_sql_syntax
Else
	return ""
End If
end function

private function string wf_build_dw_syntax ();//This function will build the datawindow syntax based on the columns, and rows
//selected and the radio button for datawindow style.

//The function returns a string with the syntax in it.

string	ls_dw_err,	ls_dw_syntax, ls_style,	ls_sql_syntax
string ls_return ="~r~n"

// Construct the style options
ls_style = "style(type=" + is_report_type + ") datawindow(units=2 )"


// Create the DW syntax from the select
ls_dw_err = ""

//If there is now sql then do not build a syntax string
ls_sql_syntax =  wf_build_sql_syntax()
If ls_sql_syntax = "" Then
	return ""
Else
	ls_dw_syntax = SyntaxFromSQL(sqlca, wf_build_sql_syntax(), ls_style, ls_dw_err)
	if ls_dw_err <> "" then
		Messagebox("Error", ls_dw_err, Exclamation!)
	end if
		return ls_dw_syntax
End If

end function

private function integer wf_create_structure_export ();string ls_header="$PBExport"+"Header$"
string ls_comment="$PBExport"+"Comments$"
string ls_file_ext=".srs" 
string ls_tipo = "global type "
string ls_name 
string ls_tipo_end = " from structure"
string ls_end = "end type"
string ls_tab = "~t"
string ls_return ="~r~n"
string ls_export_txt
string ls_filename
int    li_i, li_count, li_file_handle
string ls_data_type
long   ll_pos
int    li_len
 is_file_ext=ls_file_ext
// Cabecera
ls_export_txt = ls_header+is_prefix+is_export_name+ls_file_ext+ls_return

if is_comment <> "" THEN
	ls_export_txt += ls_comment+is_comment+ls_return
end if

ls_export_txt += ls_tipo+ls_tab+is_prefix+is_export_name+ls_tipo_end+ls_return

li_count = dw_datatype.RowCount()

for li_i=1 to li_count
	// Valor para los tipos de datos
	ls_data_type = dw_datatype.object.coltype[li_i]
	if  Pos(ls_data_type, "decimal") > 0 then
		li_len = (Pos(ls_data_type, ")") - Pos(ls_data_type,"(")) -1
		ls_data_type = "decimal {" + Mid(ls_data_type, Pos(ls_data_type,"(")+1, li_len) + "}"
		
	elseif Pos(ls_data_type, "char") > 0 then
		ls_data_type="string"
	elseif Pos(ls_data_type, "num") > 0 then
		ls_data_type="integer"
	end if
	ls_export_txt += ls_tab+ls_data_type+ls_tab+dw_datatype.object.colname[li_i]+ls_return

next

ls_export_txt += ls_end

is_str_syntax = ls_export_txt

mle_object_syntax.text = ls_export_txt

return 1

end function

private function integer wf_save_syntax ();Integer		li_file_handle,  li_rc
String  ls_current, ls_docpath, ls_docname, ls_dir

ls_dir=gs_dir+"export"
ls_docpath=ls_dir+"\"+sle_filename.text

CreateDirectory ( ls_dir )

ls_current=GetCurrentDirectory ( )
li_rc=GetFileSaveName("Save File As",    ls_docpath, ls_docname,  Upper(is_file_ext),  + "Files "+Upper(is_file_ext)+" (*"+is_file_ext+"),*"+is_file_ext+"",  ls_dir)
ChangeDirectory ( ls_current )

CHOOSE CASE li_rc 
	CASE  1 
   		sle_filename.text =  ls_docpath 
	CASE -1
		MessageBox("Nombre no Valido", "Por favor introduce un nombre de fichero valido.", Exclamation!)
		RETURN -1
	CASE 0	
		RETURN 0
end choose

IF FileExists(ls_docpath) THEN
	if Messagebox("Advertencia", "El nombre de fichero ya existe. Lo remplazamos ?", Question!, YesNo!, 1)=2 then return -1
END IF

li_file_handle = FileOpen(sle_filename.text, linemode!, write!, lockwrite!, replace!)

Filewriteex(li_file_handle, is_str_syntax)

FileClose(li_file_handle)

RETURN 1

end function

private subroutine wf_aspecto ();dw_new.Reset()
dw_datatype.Reset()
sle_filename.text=""
mle_object_syntax.text=""
mle_comment.text=""
is_export_name=""
is_str_syntax=""
is_file_ext=""
is_comment="Objeto Creado con ejemplo Table_to_Object https://rsrsystem.blogspot.com/"
mle_comment.text = is_comment
end subroutine

private function integer wf_create_auto_nvo_export ();string ls_header="$PBExport"+"Header$"
string ls_comment="$PBExport"+"Comments$"
string ls_file_ext=".sru"
string ls_global_type = "global type "
string ls_global = "global "
string ls_forward = "forward"
string ls_end_forward = "end forward"
string ls_global_type_auto = " from nonvisualobject"
string ls_type_vars = "type variables"
string ls_end_vars = "end variables"
string ls_prototypes = "forward prototypes"
string ls_end_prototypes = "end prototypes"
string ls_argumentos_con, ls_argumentos_sin, ls_argumento_geter
string ls_name 
string ls_type_end = " from nonvisualobject"
string ls_end_type = "end type"
string ls_throws =  " throws exception"
string ls_tab = "~t"
string ls_space=" "
string ls_return ="~r~n"
string ls_column
string ls_export_txt
string ls_data_type, ls_prefix
int    li_i, li_count
int    li_file_handle
int    li_len
long   ll_pos
 is_file_ext=ls_file_ext
 String ls_where
 Boolean lb_primaryKey
 string ls_cursor_Arguments
// set header
ls_export_txt = ls_header+is_prefix+is_export_name+ls_file_ext+ls_return

if is_comment <> "" THEN
	ls_export_txt += ls_comment+is_comment+ls_return
end if

// forward
//ls_export_txt += ls_return
ls_export_txt += ls_forward+ls_return
ls_export_txt += ls_global_type+is_prefix+is_export_name+ls_type_end+ls_return
ls_export_txt += ls_end_type+ls_return
ls_export_txt += ls_end_forward+ls_return

// global
ls_export_txt += ls_return
ls_export_txt += ls_global_type+is_prefix+is_export_name+ls_global_type_auto+ls_return
ls_export_txt += ls_end_type+ls_return
ls_export_txt += ls_global+is_prefix+is_export_name+ls_space+is_prefix+is_export_name+ls_return


// type variables
ls_export_txt += ls_return
ls_export_txt += ls_type_vars+ls_return
// end type variables
ls_export_txt += ls_end_vars+ls_return

// set data types
li_count = dw_datatype.RowCount()

//Set functions

ls_export_txt += ls_return
ls_export_txt += ls_prototypes+ls_return
ls_argumentos_con=wf_argumentos_funciones(TRUE)


ls_export_txt += "public function"+ls_space+"str_"+is_table+ls_space+"of_select"+ls_Argumentos_con+ls_throws+ls_return
ls_export_txt += "public subroutine"+ls_space+"of_insert (str_"+is_table+" astr_"+is_table+")"+ls_throws+ls_return
ls_export_txt += "public subroutine"+ls_space+"of_update (str_"+is_table+" astr_"+is_table+")"+ls_throws+ls_return
ls_export_txt += "public subroutine"+ls_space+"of_delete "+ls_Argumentos_con+ls_throws+ls_return
ls_export_txt += "public function"+ls_space+"str_"+is_table+ls_space+"of_reset ()"+ls_return
ls_export_txt += "public function"+ls_space+"boolean of_exists "+ls_Argumentos_con+ls_return
ls_export_txt += "public function"+ls_space+"string of_getfieldtype (string as_column)"+ls_return
ls_export_txt += "public function"+ls_space+"long of_getitemnumber "+gf_replaceall(ls_Argumentos_con, "(", "(string as_column, ")+ls_return
ls_export_txt += "public function"+ls_space+"string of_getitemstring "+gf_replaceall(ls_Argumentos_con, "(", "(string as_column, ")+ls_return
ls_export_txt += "public function"+ls_space+"datetime of_getitemdatetime "+gf_replaceall(ls_Argumentos_con, "(", "(string as_column, ")+ls_return
ls_export_txt += "public function"+ls_space+"decimal of_getitemdecimal "+gf_replaceall(ls_Argumentos_con, "(", "(string as_column, ")+ls_return
ls_export_txt += "private function exception of_get_exception (string as_message)"+ls_return

// end functions
ls_export_txt += ls_end_prototypes+ls_return

//Set Delail functions

ls_export_txt += ls_return
ls_argumentos_sin=wf_argumentos_funciones(FALSE)


//function of_select ------------------------------------------------------------------------
ls_export_txt += "public function"+ls_space+"str_"+is_table+ls_space+"of_select"+ls_Argumentos_con+ls_throws+";"
ls_export_txt += "str_"+is_table+" lstr_"+is_table+ls_return
ls_export_txt += ls_return

for li_i=1 to li_count
	// set data type value
	if li_i = 1 then 
		ls_column=is_table+"."+trim(dw_datatype.object.colname[li_i])+","+ls_return
	else
		if li_i = li_count then
			ls_column+=ls_tab+is_table+"."+trim(dw_datatype.object.colname[li_i])+ls_return
		else
			ls_column+=ls_tab+is_table+"."+trim(dw_datatype.object.colname[li_i])+","+ls_return
		end if	
	end if	
next	

ls_export_txt += "SELECT"+ls_tab+ls_column
ls_column = ""

for li_i=1 to li_count
	// set data type value
	if li_i = 1 then 
		ls_column=":lstr_"+is_table+"."+trim(dw_datatype.object.colname[li_i])+","+ls_return
	else
		if li_i = li_count then
			ls_column+=ls_tab+":lstr_"+is_table+"."+trim(dw_datatype.object.colname[li_i])+ls_return
		else
			ls_column+=ls_tab+":lstr_"+is_table+"."+trim(dw_datatype.object.colname[li_i])+","+ls_return
		end if	
	end if	
next	

ls_export_txt += "INTO"+ls_tab+ls_column
ls_export_txt += "FROM"+ls_space+is_table+ls_return

ls_column = ""
ls_where = ""
//Clausula Where
for li_i=1 to li_count
	// set data type value
	ls_data_type = dw_datatype.object.coltype[li_i]
	ls_column=dw_datatype.object.colname[li_i]
	
	if  Pos(ls_data_type, "decimal") > 0 then
		li_len = (Pos(ls_data_type, ")") - Pos(ls_data_type,"(")) -1
		ls_data_type = "decimal {" + Mid(ls_data_type, Pos(ls_data_type,"(")+1, li_len) + "}"
		ls_prefix="ad_"
	elseif Pos(ls_data_type, "char") > 0 then
		ls_data_type="string"
			ls_prefix="as_"
	elseif Pos(ls_data_type, "num") > 0 then
		ls_data_type="integer"
		ls_prefix="ai_"
	elseif Pos(ls_data_type, "long") > 0 then
		ls_data_type="long"
		ls_prefix="al_"
	elseif Pos(ls_data_type, "datetime") > 0 then
		ls_data_type="datetime"
		ls_prefix="adt_"
	elseif Pos(ls_data_type, "text") > 0 then
		ls_data_type="string"
		ls_prefix="as_"	
	end if
	
	if wf_is_primary_key(ls_column) then 
		if ls_where = "" then
			ls_where = "WHERE"+ls_space+"("+is_table+"."+ls_column+" = :"+ls_prefix+ls_column+")"+ls_return
		else
			ls_where += "AND"+ls_tab+"("+is_table+"."+ls_column+" = :"+ls_prefix+ls_column+")"+ls_return
		end if	
	end if	
next
ls_export_txt += ls_where
ls_export_txt += "USING SQLCA;"
ls_export_txt += ls_return
ls_export_txt += ls_return
ls_export_txt +="IF SQLCA.SQLcode <> 0 THEN"+ls_return
ls_export_txt +=ls_tab+"throw of_get_exception("+char(34)+"Error Leyendo Tabla "+WordCap(is_table)+"."
ls_export_txt +=ls_space+"Código SQL:"+char(34)+"+String(SQLCA.SQLCode)+"+char(34)+": "+char(34)+"+SQLCA.SQLErrText)"+ls_return
ls_export_txt +="END IF"+ls_return
ls_export_txt += ls_return
ls_export_txt += "RETURN"+ls_space+"lstr_"+is_table+ls_return
ls_export_txt +="end function"+ls_return+ls_return
//---------------------------------------------------------------------end function of_select


//subroutine of_insert ------------------------------------------------------------------------
ls_export_txt += "public subroutine"+ls_space+"of_insert (str_"+is_table+" astr_"+is_table+")"+ls_throws+";"

for li_i=1 to li_count
	// set data type value
	choose case li_i
		case 1
			ls_column="("+is_table+"."+trim(dw_datatype.object.colname[li_i])+","+ls_return
		case 	li_count
			ls_column+=ls_tab+is_table+"."+trim(dw_datatype.object.colname[li_i])+")"+ls_return
		case else
			ls_column+=ls_tab+is_table+"."+trim(dw_datatype.object.colname[li_i])+","+ls_return
	end choose		
next	

ls_export_txt += "INSERT INTO"+ls_space+is_table+ls_space+ls_column 
ls_column = ""
lb_primaryKey = FALSE
for li_i=1 to li_count
	// set data type value
	choose case li_i
		case 1
			ls_column="(:astr_"+is_table+"."+trim(dw_datatype.object.colname[li_i])+","+ls_return
		case 	li_count
			ls_column+=ls_tab+":astr_"+is_table+"."+trim(dw_datatype.object.colname[li_i])+")"+ls_return
		case else
			ls_column+=ls_tab+":astr_"+is_table+"."+trim(dw_datatype.object.colname[li_i])+","+ls_return
	end choose	
	IF wf_is_primary_key(trim(dw_datatype.object.colname[li_i])) THEN
	 	lb_primaryKey = TRUE
	END IF	 
next	

ls_export_txt += "VALUES"+ls_tab+ls_column
ls_export_txt += "USING SQLCA;"
ls_export_txt += ls_return
ls_export_txt += ls_return
IF lb_primaryKey THEN
	ls_export_txt +="IF SQLCA.SQLcode <> 0 OR SQLCA.SQLNRows <> 1 THEN"+ls_return
ELSE
	ls_export_txt +="IF SQLCA.SQLcode <> 0 THEN"+ls_return
END IF	
ls_export_txt +=ls_tab+"throw of_get_exception("+char(34)+"Error Insertando en Tabla "+WordCap(is_table)+"."
ls_export_txt +=ls_space+"Código SQL:"+char(34)+"+String(SQLCA.SQLCode)+"+char(34)+": "+char(34)+"+SQLCA.SQLErrText)"+ls_return
ls_export_txt +="END IF"+ls_return
ls_export_txt += ls_return
ls_export_txt +="end subroutine"+ls_return+ls_return
//---------------------------------------------------------------------end subroutine of_insert

//subroutine of_update ------------------------------------------------------------------------
ls_export_txt += "public subroutine"+ls_space+"of_update (str_"+is_table+" astr_"+is_table+")"+ls_throws+";"
ls_export_txt += "UPDATE"+ls_space+is_table+ls_return

ls_column = ""
ls_where = ""

for li_i=1 to li_count

	ls_prefix = "astr_"+is_table+"."
	
	if wf_is_primary_key(trim(dw_datatype.object.colname[li_i])) then continue
		
	choose case li_i
		case 1
			ls_column = +is_table+"."+trim(dw_datatype.object.colname[li_i])+" = :"+ls_prefix+trim(dw_datatype.object.colname[li_i])+","+ls_return
		case 	li_count
			ls_column += +ls_tab+is_table+"."+trim(dw_datatype.object.colname[li_i])+" = :"+ls_prefix+trim(dw_datatype.object.colname[li_i])
		case else
			ls_column += +ls_tab+is_table+"."+trim(dw_datatype.object.colname[li_i])+" = :"+ls_prefix+trim(dw_datatype.object.colname[li_i])+","+ls_return
	end choose	
 
next

ls_export_txt += "SET"+ls_space+ls_column+ls_return

ls_column = ""
ls_where = ""
lb_primarykey=false
//Clausula Where
for li_i=1 to li_count

	ls_column=trim(dw_datatype.object.colname[li_i])
	
	ls_prefix = "astr_"+is_table+"."
	
	if wf_is_primary_key(ls_column) then 
		lb_primaryKey = true
		if ls_where = "" then
			ls_where = "WHERE"+ls_space+"("+is_table+"."+ls_column+" = :"+ls_prefix+ls_column+")"+ls_return
		else
			ls_where += "AND"+ls_tab+"("+is_table+"."+ls_column+" = :"+ls_prefix+ls_column+")"+ls_return
		end if	
	end if	
next

ls_export_txt += ls_where
ls_export_txt += "USING SQLCA;"
ls_export_txt += ls_return
ls_export_txt += ls_return
IF lb_primaryKey THEN
	ls_export_txt +="IF SQLCA.SQLcode <> 0 OR SQLCA.SQLNRows <> 1 THEN"+ls_return
ELSE
	ls_export_txt +="IF SQLCA.SQLcode <> 0 THEN"+ls_return
END IF	
ls_export_txt +=ls_tab+"throw of_get_exception("+char(34)+"Error Actualizando Registro en Tabla "+WordCap(is_table)+"."
ls_export_txt +=ls_space+"Código SQL:"+char(34)+"+String(SQLCA.SQLCode)+"+char(34)+": "+char(34)+"+SQLCA.SQLErrText)"+ls_return
ls_export_txt +="END IF"+ls_return
ls_export_txt += ls_return
ls_export_txt +="end subroutine"+ls_return+ls_return
//---------------------------------------------------------------------end subroutine of_update


//subroutine of_delete ------------------------------------------------------------------------
ls_export_txt += "public subroutine"+ls_space+"of_delete "+ls_Argumentos_con+ls_throws+";"

ls_export_txt += "DELETE"+ls_space+is_table+ls_return

ls_column = ""
ls_where = ""
lb_primarykey=false
//Clausula Where
for li_i=1 to li_count
	// set data type value
	ls_data_type = dw_datatype.object.coltype[li_i]
	ls_column=dw_datatype.object.colname[li_i]
	
	if  Pos(ls_data_type, "decimal") > 0 then
		li_len = (Pos(ls_data_type, ")") - Pos(ls_data_type,"(")) -1
		ls_data_type = "decimal {" + Mid(ls_data_type, Pos(ls_data_type,"(")+1, li_len) + "}"
		ls_prefix="ad_"
	elseif Pos(ls_data_type, "char") > 0 then
		ls_data_type="string"
			ls_prefix="as_"
	elseif Pos(ls_data_type, "num") > 0 then
		ls_data_type="integer"
		ls_prefix="ai_"
	elseif Pos(ls_data_type, "long") > 0 then
		ls_data_type="long"
		ls_prefix="al_"
	elseif Pos(ls_data_type, "datetime") > 0 then
		ls_data_type="datetime"
		ls_prefix="adt_"
	elseif Pos(ls_data_type, "text") > 0 then
		ls_data_type="string"
		ls_prefix="as_"	
	end if
	
	if wf_is_primary_key(ls_column) then 
		lb_primaryKey = true
		if ls_where = "" then
			ls_where = "WHERE"+ls_space+"("+is_table+"."+ls_column+" = :"+ls_prefix+ls_column+")"+ls_return
		else
			ls_where += "AND"+ls_tab+"("+is_table+"."+ls_column+" = :"+ls_prefix+ls_column+")"+ls_return
		end if	
	end if	
next
ls_export_txt += ls_where
ls_export_txt += "USING SQLCA;"
ls_export_txt += ls_return
ls_export_txt += ls_return
IF lb_primaryKey THEN
	ls_export_txt +="IF SQLCA.SQLcode <> 0 OR SQLCA.SQLNRows <> 1 THEN"+ls_return
ELSE
	ls_export_txt +="IF SQLCA.SQLcode <> 0 THEN"+ls_return
END IF	
ls_export_txt +=ls_tab+"throw of_get_exception("+char(34)+"Error Eliminando Registro en Tabla "+WordCap(is_table)+"."
ls_export_txt +=ls_space+"Código SQL:"+char(34)+"+String(SQLCA.SQLCode)+"+char(34)+": "+char(34)+"+SQLCA.SQLErrText)"+ls_return
ls_export_txt +="END IF"+ls_return
ls_export_txt += ls_return
ls_export_txt +="end subroutine"+ls_return+ls_return
//---------------------------------------------------------------------end subroutine of_delete

//function of_reset ------------------------------------------------------------------------
ls_export_txt += "public function"+ls_space+"str_"+is_table+ls_space+"of_reset ()"+";"
ls_export_txt += "str_"+is_table+" lstr_"+is_table+ls_return
ls_export_txt += ls_return

for li_i=1 to li_count
	ls_column="lstr_"+is_table+"."+trim(dw_datatype.object.colname[li_i])
	ls_export_txt += "SetNull("+ls_column+")"+ls_return
next	

ls_export_txt +=ls_return
ls_export_txt += "RETURN"+ls_space+"lstr_"+is_table+ls_return
ls_export_txt +="end function"+ls_return+ls_return
//---------------------------------------------------------------------end function of_reset

//function of_exists ------------------------------------------------------------------------
ls_export_txt += "public function"+ls_space+"boolean of_exists "+ls_Argumentos_con+";"

ls_export_txt +="Long ll_Count"+ls_return
ls_export_txt +="Boolean lb_exists = FALSE"+ls_return
ls_export_txt +=ls_return

ls_export_txt += "SELECT count(*)"+ls_return
ls_export_txt += "INTO :ll_Count"+ls_return
ls_export_txt += "FROM"+ls_space+is_table+ls_return

ls_column = ""
ls_where = ""
lb_primarykey=false
//Clausula Where
for li_i=1 to li_count
	// set data type value
	ls_data_type = dw_datatype.object.coltype[li_i]
	ls_column=dw_datatype.object.colname[li_i]
	
	if  Pos(ls_data_type, "decimal") > 0 then
		li_len = (Pos(ls_data_type, ")") - Pos(ls_data_type,"(")) -1
		ls_data_type = "decimal {" + Mid(ls_data_type, Pos(ls_data_type,"(")+1, li_len) + "}"
		ls_prefix="ad_"
	elseif Pos(ls_data_type, "char") > 0 then
		ls_data_type="string"
			ls_prefix="as_"
	elseif Pos(ls_data_type, "num") > 0 then
		ls_data_type="integer"
		ls_prefix="ai_"
	elseif Pos(ls_data_type, "long") > 0 then
		ls_data_type="long"
		ls_prefix="al_"
	elseif Pos(ls_data_type, "datetime") > 0 then
		ls_data_type="datetime"
		ls_prefix="adt_"
	elseif Pos(ls_data_type, "text") > 0 then
		ls_data_type="string"
		ls_prefix="as_"	
	end if
	
	if wf_is_primary_key(ls_column) then 
		lb_primaryKey = true
		if ls_where = "" then
			ls_where = "WHERE"+ls_space+"("+is_table+"."+ls_column+" = :"+ls_prefix+ls_column+")"+ls_return
		else
			ls_where += "AND"+ls_tab+"("+is_table+"."+ls_column+" = :"+ls_prefix+ls_column+")"+ls_return
		end if	
	end if	
next
ls_export_txt += ls_where
ls_export_txt += "USING SQLCA;"
ls_export_txt += ls_return
ls_export_txt += ls_return

ls_export_txt +="IF isNull(ll_Count) THEN ll_Count = 0"+ls_return
ls_export_txt += ls_return
ls_export_txt +="IF ll_Count > 0 THEN lb_exists = TRUE"+ls_return
ls_export_txt += ls_return
ls_export_txt +="RETURN lb_exists"
ls_export_txt += ls_return
ls_export_txt +="end function"+ls_return+ls_return
//---------------------------------------------------------------------end function of_exists

//function of_getfieldtype ------------------------------------------------------------------------
ls_export_txt += "public function"+ls_space+"string of_getfieldtype (string as_column);"
ls_export_txt +="String ls_dataType"+ls_return
ls_export_txt +="// Crear una sentencia SELECT Dinamica"+ls_return
ls_export_txt +="String ls_sql"+ls_return
ls_export_txt +="ls_sql = "+char(34)+"SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '"+is_table+"' AND COLUMN_NAME = ?"+char(34)+ls_return
ls_export_txt += ls_return
ls_export_txt +="// Declarar el cursor"+ls_return
ls_export_txt +="DECLARE cur_" +is_table+" DYNAMIC CURSOR FOR SQLSA;"+ls_return
ls_export_txt +="PREPARE SQLSA FROM :ls_sql  USING SQLCA;"+ls_return
ls_export_txt += ls_return
ls_export_txt +="// Abrir el cursor y ejecutar la consulta"+ls_return
ls_export_txt +="OPEN DYNAMIC cur_" +is_table+" USING :as_column;"+ls_return
ls_export_txt +="FETCH cur_" +is_table+" INTO :ls_dataType;"+ls_return
ls_export_txt +="CLOSE cur_" +is_table+";"+ls_return
ls_export_txt += ls_return
ls_export_txt +="// Devolver el tipo de dato del campo"+ls_return
ls_export_txt +="RETURN ls_dataType"+ls_return
ls_export_txt += "end function"+ls_return+ls_return
//---------------------------------------------------------------------end function of_getfieldtype

//function of_getitemnumber ------------------------------------------------------------------------
ls_export_txt += "public function"+ls_space+"long of_getitemnumber "+gf_replaceall(ls_Argumentos_con, "(", "(string as_column, ")+";"

ls_export_txt +="Long ll_fieldValue"+ls_return
ls_export_txt += ls_return
ls_export_txt += "SetNull(ll_fieldValue)"
ls_export_txt += ls_return
ls_export_txt +="// Crear una sentencia SELECT Dinamica"+ls_return
ls_export_txt +="String ls_sql"+ls_return+ls_return

ls_column = ""
ls_where = ""
ls_cursor_Arguments=""
lb_primarykey=false
//Clausula Where
for li_i=1 to li_count
	// set data type value
	ls_data_type = dw_datatype.object.coltype[li_i]
	ls_column=dw_datatype.object.colname[li_i]
	
	if  Pos(ls_data_type, "decimal") > 0 then
		li_len = (Pos(ls_data_type, ")") - Pos(ls_data_type,"(")) -1
		ls_data_type = "decimal {" + Mid(ls_data_type, Pos(ls_data_type,"(")+1, li_len) + "}"
		ls_prefix="ad_"
	elseif Pos(ls_data_type, "char") > 0 then
		ls_data_type="string"
			ls_prefix="as_"
	elseif Pos(ls_data_type, "num") > 0 then
		ls_data_type="integer"
		ls_prefix="ai_"
	elseif Pos(ls_data_type, "long") > 0 then
		ls_data_type="long"
		ls_prefix="al_"
	elseif Pos(ls_data_type, "datetime") > 0 then
		ls_data_type="datetime"
		ls_prefix="adt_"
	elseif Pos(ls_data_type, "text") > 0 then
		ls_data_type="string"
		ls_prefix="as_"	
	end if
	
	if wf_is_primary_key(ls_column) then 
		lb_primaryKey = true
		if ls_where = "" then
			ls_where = ls_space+"WHERE"+ls_space+is_table+"."+ls_column+" = ?"
			ls_cursor_Arguments = ls_space+"USING"+ls_space+":"+ls_prefix+ls_column
		else
			ls_where += ls_space+"AND"+ls_space+is_table+"."+ls_column+" = ?"
			ls_cursor_Arguments += ","+ls_space+":"+ls_prefix+ls_column
		end if	
	end if	
next


ls_export_txt +="ls_sql = "+char(34)+"SELECT "+is_table+"."+char(34)+"+as_column+"+char(34)+" FROM "+is_table+ls_where+char(34)+ls_return
ls_export_txt += ls_return
ls_export_txt +="// Declarar el cursor"+ls_Return
ls_export_txt +="DECLARE cur_"+is_table+" DYNAMIC CURSOR FOR SQLSA;"+ls_return
ls_export_txt +="PREPARE SQLSA FROM :ls_sql USING SQLCA;"+ls_return
ls_export_txt += ls_return
ls_export_txt += "// Abrir el cursor y ejecutar la consulta"+ls_return
ls_export_txt += "OPEN DYNAMIC cur_"+is_table+ls_cursor_Arguments+";"+ls_return
ls_export_txt += "FETCH cur_"+is_table+" INTO :ll_fieldValue;"+ls_return
ls_export_txt += "CLOSE cur_"+is_table+";"+ls_return
ls_export_txt += ls_return
ls_export_txt += "RETURN ll_fieldValue"+ls_return
ls_export_txt += "end function"+ls_return+ls_return

//---------------------------------------------------------------------end function of_getitemnumber


//function of_getitemstring ------------------------------------------------------------------------

ls_export_txt += "public function"+ls_space+"string of_getitemstring "+gf_replaceall(ls_Argumentos_con, "(", "(string as_column, ")+";"
ls_export_txt +="String ls_fieldValue"+ls_return
ls_export_txt += ls_return
ls_export_txt += "SetNull(ls_fieldValue)"
ls_export_txt += ls_return
ls_export_txt +="// Crear una sentencia SELECT Dinamica"+ls_return
ls_export_txt +="String ls_sql"+ls_return+ls_return
ls_export_txt +="ls_sql = "+char(34)+"SELECT "+is_table+"."+char(34)+"+as_column+"+char(34)+" FROM "+is_table+ls_where+char(34)+ls_return
ls_export_txt += ls_return
ls_export_txt +="// Declarar el cursor"+ls_Return
ls_export_txt +="DECLARE cur_"+is_table+" DYNAMIC CURSOR FOR SQLSA;"+ls_return
ls_export_txt +="PREPARE SQLSA FROM :ls_sql USING SQLCA;"+ls_return
ls_export_txt += ls_return
ls_export_txt += "// Abrir el cursor y ejecutar la consulta"+ls_return
ls_export_txt += "OPEN DYNAMIC cur_"+is_table+ls_cursor_Arguments+";"+ls_return
ls_export_txt += "FETCH cur_"+is_table+" INTO :ls_fieldValue;"+ls_return
ls_export_txt += "CLOSE cur_"+is_table+";"+ls_return
ls_export_txt += ls_return
ls_export_txt += "RETURN ls_fieldValue"+ls_return
ls_export_txt += "end function"+ls_return+ls_return

//---------------------------------------------------------------------end function of_getitemstring

//function of_getitemdatetime ------------------------------------------------------------------------
ls_export_txt += "public function"+ls_space+"datetime of_getitemdatetime "+gf_replaceall(ls_Argumentos_con, "(", "(string as_column, ")+";"
ls_export_txt +="Datetime ldt_fieldValue"+ls_return
ls_export_txt += ls_return
ls_export_txt += "SetNull(ldt_fieldValue)"
ls_export_txt += ls_return
ls_export_txt +="// Crear una sentencia SELECT Dinamica"+ls_return
ls_export_txt +="String ls_sql"+ls_return+ls_return
ls_export_txt +="ls_sql = "+char(34)+"SELECT "+is_table+"."+char(34)+"+as_column+"+char(34)+" FROM "+is_table+ls_where+char(34)+ls_return
ls_export_txt += ls_return
ls_export_txt +="// Declarar el cursor"+ls_Return
ls_export_txt +="DECLARE cur_"+is_table+" DYNAMIC CURSOR FOR SQLSA;"+ls_return
ls_export_txt +="PREPARE SQLSA FROM :ls_sql USING SQLCA;"+ls_return
ls_export_txt += ls_return
ls_export_txt += "// Abrir el cursor y ejecutar la consulta"+ls_return
ls_export_txt += "OPEN DYNAMIC cur_"+is_table+ls_cursor_Arguments+";"+ls_return
ls_export_txt += "FETCH cur_"+is_table+" INTO :ldt_fieldValue;"+ls_return
ls_export_txt += "CLOSE cur_"+is_table+";"+ls_return
ls_export_txt += ls_return
ls_export_txt += "RETURN ldt_fieldValue"+ls_return
ls_export_txt += "end function"+ls_return+ls_return
//---------------------------------------------------------------------end function of_getitemdatetime

//function of_getitemdecimal ------------------------------------------------------------------------
ls_export_txt += "public function"+ls_space+"decimal of_getitemdecimal "+gf_replaceall(ls_Argumentos_con, "(", "(string as_column, ")+";"
ls_export_txt +="Decimal ld_fieldValue"+ls_return
ls_export_txt += ls_return
ls_export_txt += "SetNull(ld_fieldValue)"
ls_export_txt += ls_return
ls_export_txt +="// Crear una sentencia SELECT Dinamica"+ls_return
ls_export_txt +="String ls_sql"+ls_return+ls_return
ls_export_txt +="ls_sql = "+char(34)+"SELECT "+is_table+"."+char(34)+"+as_column+"+char(34)+" FROM "+is_table+ls_where+char(34)+ls_return
ls_export_txt += ls_return
ls_export_txt +="// Declarar el cursor"+ls_Return
ls_export_txt +="DECLARE cur_"+is_table+" DYNAMIC CURSOR FOR SQLSA;"+ls_return
ls_export_txt +="PREPARE SQLSA FROM :ls_sql USING SQLCA;"+ls_return
ls_export_txt += ls_return
ls_export_txt += "// Abrir el cursor y ejecutar la consulta"+ls_return
ls_export_txt += "OPEN DYNAMIC cur_"+is_table+ls_cursor_Arguments+";"+ls_return
ls_export_txt += "FETCH cur_"+is_table+" INTO :ld_fieldValue;"+ls_return
ls_export_txt += "CLOSE cur_"+is_table+";"+ls_return
ls_export_txt += ls_return
ls_export_txt += "RETURN ld_fieldValue"+ls_return
ls_export_txt += "end function"+ls_return+ls_return
//---------------------------------------------------------------------end function of_getitemdecimal

//function of_get_exception ------------------------------------------------------------------------
ls_export_txt += "private function exception of_get_exception (string as_message);"+ls_return
ls_export_txt += "/* private"+ls_return
ls_export_txt += "description:	helper function to get an exception object with message"+ls_return
ls_export_txt += "parameters:		string as_message:	the string which should be set into the exception"+ls_return
ls_export_txt += "return:			exception"+ls_return
ls_export_txt += "created:			2019-10-14"+ls_return
ls_export_txt += "author:			georg.brodbeck@informaticon.com"+ls_return
ls_export_txt += "*/"+ls_return
ls_export_txt += ls_return
ls_export_txt += "exception lu_exception"+ls_return
ls_export_txt += "lu_exception = Create exception"+ls_return
ls_export_txt += "lu_exception.setmessage(as_message)"+ls_return
ls_export_txt += "return lu_exception"+ls_return
ls_export_txt += "end function"+ls_return+ls_return
//---------------------------------------------------------------------end function of_get_exception

// create event
ls_export_txt += ls_return
ls_export_txt += "on "+is_prefix+is_export_name+".create"+ls_return
ls_export_txt += "call super::create"+ls_return
ls_export_txt += "end on"+ls_return

// destructor event
ls_export_txt += ls_return
ls_export_txt += "on "+is_prefix+is_export_name+".destroy"+ls_return
ls_export_txt += "call super::destroy"+ls_return
ls_export_txt += "end on"+ls_return

//Si hay tablas sin clave primaria, las funciones getitem hay que retocarlas
ls_export_txt = gf_replaceall(ls_export_txt, "(string as_column, )", "(string as_column)")

// set instance variable
is_str_syntax = ls_export_txt

// set mle text
mle_object_syntax.text = ls_export_txt

return 1

end function

private function string wf_argumentos_funciones (boolean ab_tipos);string ls_argumentos=" ("
string ls_column, ls_data_type, ls_prefix
string ls_space = " "
integer li_count, li_i
integer li_keys=0

li_count = dw_datatype.RowCount()

for li_i=1 to li_count
ls_column = dw_datatype.object.colname[li_i]

if not wf_is_primary_key(ls_column) then continue

	// set data type value
	ls_data_type = dw_datatype.object.coltype[li_i]
	if  Pos(ls_data_type, "decimal") > 0 then
		ls_data_type = "decimal"
		ls_prefix="ad_"
	elseif Pos(ls_data_type, "char") > 0 then
		ls_data_type="string"
			ls_prefix="as_"
	elseif Pos(ls_data_type, "num") > 0 then
		ls_data_type="integer"
		ls_prefix="ai_"
	elseif Pos(ls_data_type, "long") > 0 then
		ls_data_type="long"
		ls_prefix="al_"
	elseif Pos(ls_data_type, "datetime") > 0 then
		ls_data_type="datetime"
		ls_prefix="adt_"
	elseif Pos(ls_data_type, "text") > 0 then
		ls_data_type="string"
		ls_prefix="as_"	
	end if
	if ls_argumentos <> " (" then ls_argumentos +=", "
	if ab_tipos then
		ls_argumentos +=ls_data_type+ls_space+ls_prefix+dw_datatype.object.colname[li_i]
	else
		ls_argumentos +=ls_prefix+dw_datatype.object.colname[li_i]
	end if
	li_keys ++
next
	
if li_keys =0 then return " ()"	

ls_Argumentos += ")"
	
return ls_Argumentos	

end function

private function integer wf_create_datawindow_export ();string ls_header="$PBExport"+"Header$"
string ls_comment="$PBExport"+"Comments$"
string ls_release="release 22;"
string ls_file_ext=".srd"
string ls_name 
string ls_tab = "~t"
string ls_return ="~r~n"
string ls_export_txt
string ls_filename
int    li_i, li_count, li_file_handle
string ls_data_type
long   ll_pos
int    li_len
string ls_datawindow, ls_dwheader, ls_detail, ls_summary, ls_footer, ls_table, ls_key, ls_where
string ls_dbname

 is_file_ext=ls_file_ext
// Cabecera
ls_export_txt = ls_header+is_prefix+is_export_name+ls_file_ext+ls_return

if is_comment <> "" THEN
	ls_export_txt += ls_comment+is_comment+ls_return
end if

ls_export_txt += ls_release + ls_return



ls_datawindow="datawindow(units=0 timer_interval=0 color=16777215 brushmode=0 transparency=0 gradient.angle=0 gradient.color=8421504 gradient.focus=0 gradient.repetition.count=0 gradient.repetition.length=100 gradient.repetition.mode=0 gradient.scale=100 gradient.spread=100 gradient.transparency=0 picture.blur=0 picture.clip.bottom=0 picture.clip.left=0 picture.clip.right=0 picture.clip.top=0 picture.mode=0 picture.scale.x=100 picture.scale.y=100 picture.transparency=0 processing=0 HTMLDW=no print.printername="+char(34)+""+char(34)+" print.documentname="+char(34)+""+char(34)+" print.orientation = 0 print.margin.left = 110 print.margin.right = 110 print.margin.top = 96 print.margin.bottom = 96 print.paper.source = 0 print.paper.size = 0 print.canusedefaultprinter=yes print.prompt=no print.buttons=no print.preview.buttons=no print.cliptext=no print.overrideprintjob=no print.collate=yes print.background=no print.preview.background=no print.preview.outline=yes hidegrayline=no showbackcoloronxp=no picture.file="+char(34)+""+char(34)+" )"
ls_dwheader="header(height=76 color="+char(34)+"536870912"+char(34)+" transparency="+char(34)+"0"+char(34)+" gradient.color="+char(34)+"8421504"+char(34)+" gradient.transparency="+char(34)+"0"+char(34)+" gradient.angle="+char(34)+"0"+char(34)+" brushmode="+char(34)+"0"+char(34)+" gradient.repetition.mode="+char(34)+"0"+char(34)+" gradient.repetition.count="+char(34)+"0"+char(34)+" gradient.repetition.length="+char(34)+"100"+char(34)+" gradient.focus="+char(34)+"0"+char(34)+" gradient.scale="+char(34)+"100"+char(34)+" gradient.spread="+char(34)+"100"+char(34)+" )"
ls_summary="summary(height=0 color="+char(34)+"536870912"+char(34)+" transparency="+char(34)+"0"+char(34)+" gradient.color="+char(34)+"8421504"+char(34)+" gradient.transparency="+char(34)+"0"+char(34)+" gradient.angle="+char(34)+"0"+char(34)+" brushmode="+char(34)+"0"+char(34)+" gradient.repetition.mode="+char(34)+"0"+char(34)+" gradient.repetition.count="+char(34)+"0"+char(34)+" gradient.repetition.length="+char(34)+"100"+char(34)+" gradient.focus="+char(34)+"0"+char(34)+" gradient.scale="+char(34)+"100"+char(34)+" gradient.spread="+char(34)+"100"+char(34)+" )"
ls_footer="footer(height=0 color="+char(34)+"536870912"+char(34)+" transparency="+char(34)+"0"+char(34)+" gradient.color="+char(34)+"8421504"+char(34)+" gradient.transparency="+char(34)+"0"+char(34)+" gradient.angle="+char(34)+"0"+char(34)+" brushmode="+char(34)+"0"+char(34)+" gradient.repetition.mode="+char(34)+"0"+char(34)+" gradient.repetition.count="+char(34)+"0"+char(34)+" gradient.repetition.length="+char(34)+"100"+char(34)+" gradient.focus="+char(34)+"0"+char(34)+" gradient.scale="+char(34)+"100"+char(34)+" gradient.spread="+char(34)+"100"+char(34)+" )"
ls_detail="detail(height=84 color="+char(34)+"536870912"+char(34)+" transparency="+char(34)+"0"+char(34)+" gradient.color="+char(34)+"8421504"+char(34)+" gradient.transparency="+char(34)+"0"+char(34)+" gradient.angle="+char(34)+"0"+char(34)+" brushmode="+char(34)+"0"+char(34)+" gradient.repetition.mode="+char(34)+"0"+char(34)+" gradient.repetition.count="+char(34)+"0"+char(34)+" gradient.repetition.length="+char(34)+"100"+char(34)+" gradient.focus="+char(34)+"0"+char(34)+" gradient.scale="+char(34)+"100"+char(34)+" gradient.spread="+char(34)+"100"+char(34)+" )"

ls_export_txt +=  ls_datawindow  + ls_return 
ls_export_txt +=  ls_dwheader + ls_return 
ls_export_txt +=  ls_summary + ls_return 
ls_export_txt +=  ls_footer + ls_return 
ls_export_txt +=  ls_detail + ls_return 

//Ahora vamos hacer la tabla
string	ls_columns, ls_column, Retrieve_columns, ls_coltype, ls_sql_syntax, ls_Retrieve
long	ll_Rows, ll_index

//Buscamos todas las columnas del dw_datatype para saber la columnas seleccionadas y el tipo de dato.
ll_Rows =dw_datatype.RowCount ( )

ls_Retrieve= "retrieve="+char(34)+"PBSELECT( VERSION(400) TABLE(NAME="+char(126)+char(34)+is_table+char(126)+char(34)+" ) "
if  ll_Rows =0 then 
	MessageBox("Atención", "No hay columnas seleccionadas", Exclamation!)
	return 0
end if	


For ll_index = 1 to ll_Rows
		If ls_columns <> "" Then ls_columns = ls_columns +ls_return+ " column=(type="
		 ls_coltype=dw_datatype.GetItemString(ll_index, "coltype")
		 ls_column = dw_datatype.GetItemString(ll_index, "colname")
          ls_dbname=gf_column_dbname(is_table, ls_column)
	if wf_is_primary_key(ls_column) then 
		ls_key=" key=yes "
	else
		ls_key=" "
	end if	
	
		ls_columns = ls_columns +  ls_coltype+" update=yes updatewhereclause=yes"+ls_key+"name="+ls_column+" dbname="+char(34)+is_table+"."+ls_dbname+char(34)+" )"
		Retrieve_columns= Retrieve_columns +" COLUMN(NAME="+char(126)+char(34)+is_table+"."+ls_dbname+char(126)+char(34)+")" 
Next

ls_where=wf_dw_where_clause()
ls_export_txt +="table(column=(type="+ls_columns +ls_Return
ls_export_txt += ls_Retrieve +Retrieve_columns+ls_where

//Ahora vamos a crear las bandas del header y las columnas del detail
string ls_text, ls_cols, ls_format, ls_alignment
integer li_posx, li_posy, li_width, li_height, li_limit

li_posx=0
li_width=0
li_posy=8
li_height=60
For ll_index = 1 to ll_Rows
		li_posx=li_posx +li_width+14
		 ls_coltype=dw_datatype.GetItemString(ll_index, "coltype")
		ls_column = dw_datatype.GetItemString(ll_index, "colname")
	CHOOSE CASE left(Upper( ls_coltype), 5)
		CASE  "DECIM"
			 li_width=485 
			 ls_format="###,###,###,##0.00"
			 ls_alignment="1"
			 li_limit=0
		CASE "REAL", "NUMBE", "INT", "INTEG", "FLOAT", "LONG"
			 li_width=485 
			ls_format="[general]"
      		 ls_alignment="1"
			li_limit=0
		CASE "CHAR(", "VARCH", "TEXT"
			li_limit=integer(mid(ls_coltype, pos(ls_coltype, "(") + 1, pos(ls_coltype, ")") - pos(ls_coltype, "(") - 1))
			li_width=li_limit * 30
			if 	li_width > 1600 then li_width =1600
			ls_format="[general]"
			ls_alignment="0"
		CASE "DATET", "DATE"
			 li_width=485 
			 li_limit=0
			 ls_format="dd-mm-yy"
			 ls_alignment="2"
	END CHOOSE
	
	ls_text+="text(band=header alignment="+char(34)+"2"+char(34)+" text="+char(34)+ls_column+char(34)+" border="+char(34)+"2"+char(34)+" color="+char(34)+"0"+char(34)+" x="+char(34)+string(li_posx)+char(34)+" y="+char(34)+string(li_posy)+char(34)+" height="+char(34)+string(li_height)+char(34)+" width="+char(34)+string(li_width)+char(34)+" html.valueishtml="+char(34)+"0"+char(34)+"  name="+ls_column+"_t pointer="+char(34)+"HyperLink!"+char(34)+" visible="+char(34)+"1"+char(34)+"  font.face="+char(34)+"Arial"+char(34)+" font.height="+char(34)+"-8"+char(34)+" font.weight="+char(34)+"400"+char(34)+"  font.family="+char(34)+"2"+char(34)+" font.pitch="+char(34)+"1"+char(34)+" font.charset="+char(34)+"1"+char(34)+" background.mode="+char(34)+"2"+char(34)+" background.color="+char(34)+"15780518"+char(34)+" background.transparency="+char(34)+"0"+char(34)+" background.gradient.color="+char(34)+"8421504"+char(34)+" background.gradient.transparency="+char(34)+"0"+char(34)+" background.gradient.angle="+char(34)+"0"+char(34)+" background.brushmode="+char(34)+"0"+char(34)+" background.gradient.repetition.mode="+char(34)+"0"+char(34)+" background.gradient.repetition.count="+char(34)+"0"+char(34)+" background.gradient.repetition.length="+char(34)+"100"+char(34)+" background.gradient.focus="+char(34)+"0"+char(34)+" background.gradient.scale="+char(34)+"100"+char(34)+" background.gradient.spread="+char(34)+"100"+char(34)+" tooltip.backcolor="+char(34)+"134217752"+char(34)+" tooltip.delay.initial="+char(34)+"0"+char(34)+" tooltip.delay.visible="+char(34)+"32000"+char(34)+" tooltip.enabled="+char(34)+"0"+char(34)+" tooltip.hasclosebutton="+char(34)+"0"+char(34)+" tooltip.icon="+char(34)+"0"+char(34)+" tooltip.isbubble="+char(34)+"0"+char(34)+" tooltip.maxwidth="+char(34)+"0"+char(34)+" tooltip.textcolor="+char(34)+"134217751"+char(34)+" tooltip.transparency="+char(34)+"0"+char(34)+" transparency="+char(34)+"0"+char(34)+" )"+ ls_return 
	ls_cols+="column(band=detail id="+string(ll_index) +" alignment="+char(34)+ls_alignment+char(34)+" tabsequence=32766 border="+char(34)+"0"+char(34)+" color="+char(34)+"0"+char(34)+" x="+char(34)+string(li_posx)+char(34)+" y="+char(34)+string(li_posy)+char(34)+" height="+char(34)+string(li_height)+char(34)+" width="+char(34)+string(li_width)+char(34)+" format="+char(34)+ls_format+char(34)+" html.valueishtml="+char(34)+"0"+char(34)+"  name="+ls_column+" visible="+char(34)+"1"+char(34)+" edit.limit="+string(li_limit)+" edit.case=any edit.focusrectangle=no edit.autoselect=yes edit.autohscroll=yes  font.face="+char(34)+"Arial"+char(34)+" font.height="+char(34)+"-8"+char(34)+" font.weight="+char(34)+"400"+char(34)+"  font.family="+char(34)+"2"+char(34)+" font.pitch="+char(34)+"1"+char(34)+" font.charset="+char(34)+"1"+char(34)+" background.mode="+char(34)+"1"+char(34)+" background.color="+char(34)+"536870912"+char(34)+" background.transparency="+char(34)+"0"+char(34)+" background.gradient.color="+char(34)+"8421504"+char(34)+" background.gradient.transparency="+char(34)+"0"+char(34)+" background.gradient.angle="+char(34)+"0"+char(34)+" background.brushmode="+char(34)+"0"+char(34)+" background.gradient.repetition.mode="+char(34)+"0"+char(34)+" background.gradient.repetition.count="+char(34)+"0"+char(34)+" background.gradient.repetition.length="+char(34)+"100"+char(34)+" background.gradient.focus="+char(34)+"0"+char(34)+" background.gradient.scale="+char(34)+"100"+char(34)+" background.gradient.spread="+char(34)+"100"+char(34)+" tooltip.backcolor="+char(34)+"134217752"+char(34)+" tooltip.delay.initial="+char(34)+"0"+char(34)+" tooltip.delay.visible="+char(34)+"32000"+char(34)+" tooltip.enabled="+char(34)+"0"+char(34)+" tooltip.hasclosebutton="+char(34)+"0"+char(34)+" tooltip.icon="+char(34)+"0"+char(34)+" tooltip.isbubble="+char(34)+"0"+char(34)+" tooltip.maxwidth="+char(34)+"0"+char(34)+" tooltip.textcolor="+char(34)+"134217751"+char(34)+" tooltip.transparency="+char(34)+"0"+char(34)+" transparency="+char(34)+"0"+char(34)+" )"+ ls_return 

Next

ls_export_txt +=ls_return+ls_text+ls_cols


// Añadimos el pie de página que siempre es igual.
string  ls_pie

ls_pie="htmltable(border="+char(34)+"1"+char(34)+" )"+ls_return+&
"htmlgen(clientevents="+char(34)+"1"+char(34)+" clientvalidation="+char(34)+"1"+char(34)+" clientcomputedfields="+char(34)+"1"+char(34)+" clientformatting="+char(34)+"0"+char(34)+" clientscriptable="+char(34)+"0"+char(34)+" generatejavascript="+char(34)+"1"+char(34)+" encodeselflinkargs="+char(34)+"1"+char(34)+" netscapelayers="+char(34)+"0"+char(34)+" pagingmethod=0 generatedddwframes="+char(34)+"1"+char(34)+" )"+ls_return+&
"xhtmlgen() cssgen(sessionspecific="+char(34)+"0"+char(34)+" )"+ls_return+&
"xmlgen(inline="+char(34)+"0"+char(34)+" )"+ls_return+&
"xsltgen()"+ls_return+&
"jsgen()"+ls_return+&
"export.xml(headgroups="+char(34)+"1"+char(34)+" includewhitespace="+char(34)+"0"+char(34)+" metadatatype=0 savemetadata=0 )"+ls_return+&
"import.xml()"+ls_return+&
"export.pdf(method=0 distill.custompostscript="+char(34)+"0"+char(34)+" nativepdf.customsize=0 nativepdf.customorientation=0 nativepdf.pdfstandard=0 nativepdf.useprintspec=no )"+ls_return+&
"export.xhtml()"

ls_export_txt +=ls_pie

mle_object_syntax.text = ls_export_txt
is_str_syntax = ls_export_txt


return 1

end function

private function boolean wf_is_primary_key (string as_column);	integer li_key
	boolean lb_key
	
	select count(*)
	Into :li_key
	From information_schema.key_column_usage
	WHERE TABLE_NAME=:is_table and column_name=:as_column;
	
	if li_key = 1 then 
		lb_key=true
	else
		lb_key=false
	end if	
	
	return lb_key
end function

private function string wf_dw_where_clause ();string ls_where=""
string ls_column, ls_data_type, ls_prefix
string ls_space = " "
integer li_count, li_i
integer li_keys=0
string ls_keys[]
string ls_prefixs[]
string ls_types[]
String ls_dbname

li_count = dw_datatype.RowCount()

for li_i=1 to li_count
	ls_column = dw_datatype.object.colname[li_i]
	if not wf_is_primary_key(ls_column) then continue
	// set data type value
	ls_data_type = dw_datatype.object.coltype[li_i]
	if  Pos(ls_data_type, "decimal") > 0 then
		ls_data_type = "decimal"
		ls_prefix="ad_"
	elseif Pos(ls_data_type, "char") > 0 then
		ls_data_type="string"
			ls_prefix="as_"
	elseif Pos(ls_data_type, "num") > 0 then
		ls_data_type="number"
		ls_prefix="ai_"
	elseif Pos(ls_data_type, "long") > 0 then
		ls_data_type="number"
		ls_prefix="al_"
	elseif Pos(ls_data_type, "datetime") > 0 then
		ls_data_type="datetime"
		ls_prefix="adt_"
	elseif Pos(ls_data_type, "text") > 0 then
		ls_data_type="string"
		ls_prefix="as_"	
	end if
		if ls_where <>"" then ls_where +="	LOGIC ="+char(126)+char(34)+"And"+char(126)+char(34)+" )"
		ls_dbname=gf_column_dbname(is_table, ls_column)
		ls_where +="WHERE(    EXP1 ="+char(126)+""+char(34)+is_table+"."+ls_dbname+char(126)+""+char(34)+"   OP ="+char(126)+""+char(34)+"="+char(126)+""+char(34)+"    EXP2 ="+char(126)+""+char(34)+":"+ls_prefix+ls_column+char(126)+char(34)
		ls_where +=" "
	li_keys ++
	ls_keys[li_keys]=ls_column 
	ls_prefixs[li_keys]=ls_prefix
	ls_types[li_keys]=ls_data_type
next

ls_where +=+") )"

if li_keys = 0 then 
	ls_where = ") "+char(34)+" )"
	return ls_where
end if	


for li_i=1 to li_keys
	ls_where +=" ARG(NAME = "+char(126)+""+char(34)+ls_prefixs[ li_i]+ls_keys[ li_i]+char(126)+""+char(34)+" TYPE = "+ls_types[ li_i]+")"
next	

ls_where +=" "+char(34)+" update="+char(34)+is_table+char(34)+" updatewhere=1 updatekeyinplace=yes arguments=("

for li_i=1 to li_keys
	if  li_i > 1 then ls_where +=","
	ls_where +="("+char(34)+ls_prefixs[ li_i]+ls_keys[ li_i]+char(34)+", "+ls_types[ li_i]+")"
next	

ls_where +=") )"


return ls_where	

end function

private function integer wf_create_global_fun_export ();string ls_header="$PBExport"+"Header$"
string ls_comment="$PBExport"+"Comments$"
string ls_file_ext=".srf"
string ls_global_type = "global type "
string ls_global = "global "
string ls_forward_prototypes= "forward prototypes"
string ls_end_prototypes = "end prototypes"
string ls_global_type_auto = " from function_object"
string ls_global_function= "global function"
string ls_end_function = "end function"
string ls_argumentos_con, ls_argumentos_sin
string ls_end_type = "end type"
string ls_tab = "~t"
string ls_space=" "
string ls_return ="~r~n"
string ls_export_txt
string ls_prefix
String ls_return_type="string"
String ls_objeto_tabla, ls_var_tabla

 
 ls_objeto_tabla="n_cst_"+is_table
 ls_var_tabla = "ln_"+is_table
 
// set header
ls_export_txt = ls_header+is_prefix+"get_column_"+is_export_name+ls_file_ext+ls_return

if is_comment <> "" THEN
	ls_export_txt += ls_comment+is_comment+ls_return
end if

// global type
ls_export_txt += ls_global_type+is_prefix+"get_column_"+is_export_name+ls_global_type_auto+ls_return
ls_export_txt += ls_end_type+ls_return

ls_argumentos_con=wf_argumentos_funciones(true)
if ls_argumentos_con =" ()" then
	ls_argumentos_con	=" (string as_column)"
else	
	ls_argumentos_con=gf_replaceall(ls_argumentos_con, "(", "(string as_column, ")
end if

ls_argumentos_sin=wf_argumentos_funciones(false)
if ls_argumentos_sin =" ()" then
	ls_argumentos_sin	=" (as_column)"
else	
	ls_argumentos_sin=gf_replaceall(ls_argumentos_sin, "(", "(as_column, ")
end if
// forward prototypes
ls_export_txt += ls_return
ls_export_txt += ls_forward_prototypes+ls_return
ls_export_txt += ls_global_function+ls_space+ls_return_type+ls_space+is_prefix+"get_column_"+is_export_name+ls_argumentos_con+ls_return
ls_export_txt += ls_end_prototypes+ls_return

// global function
ls_export_txt += ls_return
ls_export_txt += ls_global_function+ls_space+ls_return_type+ls_space+is_prefix+"get_column_"+is_export_name+ls_argumentos_con+";"+ls_objeto_tabla+ls_space+ls_var_tabla+ls_return
ls_export_txt +="String ls_field, ls_fieldtype"+ls_return+ls_return
ls_export_txt +=ls_var_tabla+ls_space+"="+ls_space+"CREATE"+ls_space+ls_objeto_tabla+ls_return
ls_export_txt +="ls_fieldtype = "+ls_var_tabla+".of_GetFieldType(as_column)"+ls_return+ls_return
ls_export_txt +="CHOOSE CASE ls_fieldtype"+ls_return
ls_export_txt +=ls_tab+"CASE "+char(34)+"money"+char(34)+", "+char(34)+"smallmoney"+char(34)+", "+char(34)+"decimal"+char(34)+", "+char(34)+"float"+char(34)+ls_Return
ls_export_txt +=ls_tab+ls_tab+"ls_field = string("+ls_var_tabla+".of_GetItemDecimal"+trim(ls_argumentos_sin)+", "+char(34)+"##,###,##0.00"+char(34)+")"+ls_return
ls_export_txt +=ls_tab+"CASE "+char(34)+"numeric"+char(34)+", "+char(34)+"int"+char(34)+", "+char(34)+"smallint"+char(34)+", "+char(34)+"bigint"+char(34)+", "+char(34)+"tinyint"+char(34)+ls_Return
ls_export_txt +=ls_tab+ls_tab+"ls_field = string("+ls_var_tabla+".of_GetItemNumber"+trim(ls_argumentos_sin)+", "+char(34)+"##,###,##0"+char(34)+")"+ls_return
ls_export_txt +=ls_tab+"CASE "+char(34)+"text"+char(34)+", "+char(34)+"varchar"+char(34)+", "+char(34)+"nchar"+char(34)+", "+char(34)+"char"+char(34)+ls_Return
ls_export_txt +=ls_tab+ls_tab+"ls_field = "+ls_var_tabla+".of_GetItemString"+trim(ls_argumentos_sin)+""+ls_return
ls_export_txt +=ls_tab+"CASE "+char(34)+"datetime"+char(34)+", "+char(34)+"smalldatetime"+char(34)+ls_Return
ls_export_txt +=ls_tab+ls_tab+"ls_field = string("+ls_var_tabla+".of_GetItemDateTime"+trim(ls_argumentos_sin)+", "+char(34)+"dd-mm-yy"+char(34)+")"+ls_return
ls_export_txt +=ls_tab+"CASE ELSE"+ls_Return
ls_export_txt +=ls_tab+ls_tab+"ls_field = "+char(34)+char(34)+ls_Return
ls_export_txt +="END CHOOSE"+ls_Return+ls_Return 
ls_export_txt +="DESTROY"+ls_space+ls_var_tabla+ls_Return 
ls_export_txt +="RETURN ls_field"+ls_return+ls_Return
ls_export_txt +=ls_end_function


// set instance variable
is_str_syntax = ls_export_txt

// set mle text
mle_object_syntax.text = ls_export_txt

return 1

end function

public subroutine wf_connect ();//Connect to Database
SQLCA.DBMS = ProfileString("Setting.ini", "Setup", "DBMS", "") 
SQLCA.ServerName = ProfileString("Setting.ini", "Setup", "ServerName", "")
SQLCA.LogId = ProfileString("Setting.ini", "Setup", "LogId", "")
SQLCA.LogPass = ProfileString("Setting.ini", "Setup", "LogPass", "")
				
if ProfileString("Setting.ini", "Setup", "AutoCommit", "False") = "True" then
	SQLCA.AutoCommit = True
else
	SQLCA.AutoCommit = False
end if
SQLCA.DBParm = ProfileString("Setting.ini", "Setup", "DBParm", "") 


// DataBase Connect
Connect Using SQLCA;

If SQLCA.SQLCode <> 0  Then
	MessageBox ("Error "+string(SQLCA.SQLCode), SQLCA.SQLErrText)
End If
end subroutine

public subroutine wf_version ();String ls_version, ls_platform
environment env
integer rtn

rtn = GetEnvironment(env)

IF rtn <> 1 THEN 
	ls_version = string(year(today()))
	ls_platform="32"
ELSE
	ls_version = "20"+ string(env.pbmajorrevision)+ "." + string(env.pbbuildnumber)
	ls_platform=string(env.ProcessBitness)
END IF

ls_platform += " Bits"

st_myversion.text=ls_version
st_platform.text=ls_platform

end subroutine

private subroutine wf_set_new ();// this function is called to set up everything for a new datawindow selection
string ls_colname[]
string ls_coltype[]
string ls_colcomment
string ls_syntax
int   li_i, li_count

// get datawindow syntax
ls_syntax = wf_build_dw_syntax()
if ls_syntax = "" THEN
	RETURN
end if

// set object name
is_export_name = is_Table

// set prefix for object
is_prefix = sle_prefix.text

// parse datawindow for column names
li_count = gf_parse_obj_string ( dw_new, ls_colname, "column", "*" )
if li_count < 1 THEN
	RETURN
end if

// loop thru and get data types
dw_datatype.Reset()

for li_i=1 to li_count
	ls_coltype[li_i] = dw_new.describe(ls_colname[li_i]+".coltype")
	dw_datatype.object.colname[li_i] = ls_colname[li_i]
	dw_datatype.object.coltype[li_i] = ls_coltype[li_i]
next

RETURN
end subroutine

on w_main.create
this.st_info=create st_info
this.st_10=create st_10
this.st_9=create st_9
this.st_7=create st_7
this.st_platform=create st_platform
this.st_myversion=create st_myversion
this.p_2=create p_2
this.st_3=create st_3
this.rb_gffun=create rb_gffun
this.rb_datawindow=create rb_datawindow
this.st_8=create st_8
this.sle_filename=create sle_filename
this.mle_object_syntax=create mle_object_syntax
this.st_6=create st_6
this.mle_comment=create mle_comment
this.sle_prefix=create sle_prefix
this.st_5=create st_5
this.rb_structure=create rb_structure
this.rb_autonvo=create rb_autonvo
this.dw_datatype=create dw_datatype
this.cbx_1=create cbx_1
this.mle_sql_syntax=create mle_sql_syntax
this.st_1=create st_1
this.st_2=create st_2
this.dw_tables=create dw_tables
this.dw_columns=create dw_columns
this.st_4=create st_4
this.gb_3=create gb_3
this.dw_new=create dw_new
this.cb_close=create cb_close
this.cb_create=create cb_create
this.cb_createsyntax=create cb_createsyntax
this.cb_savesyntax=create cb_savesyntax
this.r_2=create r_2
this.Control[]={this.st_info,&
this.st_10,&
this.st_9,&
this.st_7,&
this.st_platform,&
this.st_myversion,&
this.p_2,&
this.st_3,&
this.rb_gffun,&
this.rb_datawindow,&
this.st_8,&
this.sle_filename,&
this.mle_object_syntax,&
this.st_6,&
this.mle_comment,&
this.sle_prefix,&
this.st_5,&
this.rb_structure,&
this.rb_autonvo,&
this.dw_datatype,&
this.cbx_1,&
this.mle_sql_syntax,&
this.st_1,&
this.st_2,&
this.dw_tables,&
this.dw_columns,&
this.st_4,&
this.gb_3,&
this.dw_new,&
this.cb_close,&
this.cb_create,&
this.cb_createsyntax,&
this.cb_savesyntax,&
this.r_2}
end on

on w_main.destroy
destroy(this.st_info)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_7)
destroy(this.st_platform)
destroy(this.st_myversion)
destroy(this.p_2)
destroy(this.st_3)
destroy(this.rb_gffun)
destroy(this.rb_datawindow)
destroy(this.st_8)
destroy(this.sle_filename)
destroy(this.mle_object_syntax)
destroy(this.st_6)
destroy(this.mle_comment)
destroy(this.sle_prefix)
destroy(this.st_5)
destroy(this.rb_structure)
destroy(this.rb_autonvo)
destroy(this.dw_datatype)
destroy(this.cbx_1)
destroy(this.mle_sql_syntax)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_tables)
destroy(this.dw_columns)
destroy(this.st_4)
destroy(this.gb_3)
destroy(this.dw_new)
destroy(this.cb_close)
destroy(this.cb_create)
destroy(this.cb_createsyntax)
destroy(this.cb_savesyntax)
destroy(this.r_2)
end on

event open;long	ll_ret

// For new datawindows, the default units will be inches, the default
is_report_type =  "grid"

wf_version()

//Connect to Database
wf_connect()

dw_columns.SetTransObject(SQLCA)
dw_tables.SetTransObject(SQLCA)

// gf_set_table_select is a user function to modify the select used by
// the table selection data window, based on which DBMS we're connected
// to; This function adjusts to the differences in catalog structures
// between the DBMS's

IF gf_set_table_select(dw_tables) < 0 THEN
	MessageBox("Error", &
					"Unable to set SQL select statement for tables list", &
					StopSign!)
	this.TriggerEvent(Close!)
END IF

ll_ret = dw_tables.Retrieve( )

IF ll_ret < 1 THEN
	MessageBox ("Retrieve return code is:", ll_ret)
END IF


end event

type st_info from statictext within w_main
integer x = 3447
integer y = 3084
integer width = 1289
integer height = 52
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 553648127
string text = "Copyright © Ramón San Félix Ramón  rsrsystem.soft@gmail.com"
boolean focusrectangle = false
end type

type st_10 from statictext within w_main
integer x = 1815
integer y = 616
integer width = 398
integer height = 64
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 41943040
long backcolor = 553648127
string text = "Object Syntax"
end type

type st_9 from statictext within w_main
integer x = 741
integer y = 616
integer width = 503
integer height = 68
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 41943040
long backcolor = 553648127
string text = "Columns Datatypes"
end type

type st_7 from statictext within w_main
integer x = 731
integer y = 280
integer width = 503
integer height = 68
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 41943040
long backcolor = 553648127
string text = "SQL Syntax"
end type

type st_platform from statictext within w_main
integer x = 4242
integer y = 144
integer width = 489
integer height = 84
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Bits"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_myversion from statictext within w_main
integer x = 4242
integer y = 56
integer width = 489
integer height = 84
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Versión"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_2 from picture within w_main
integer x = 5
integer y = 4
integer width = 1253
integer height = 248
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type st_3 from statictext within w_main
integer x = 3456
integer y = 2352
integer width = 471
integer height = 48
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Comentario:"
end type

type rb_gffun from radiobutton within w_main
integer x = 2839
integer y = 2536
integer width = 526
integer height = 76
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Funcion global"
end type

event clicked;is_prefix = "gf_"
is_file_ext=".srf"

sle_prefix.text = is_prefix

end event

type rb_datawindow from radiobutton within w_main
integer x = 2839
integer y = 2608
integer width = 526
integer height = 76
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Datawindow"
end type

event clicked;is_prefix = "dw_"
is_file_ext=".srd"

sle_prefix.text = is_prefix

end event

type st_8 from statictext within w_main
integer x = 2359
integer y = 2700
integer width = 471
integer height = 48
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Nombre del Fichero:"
end type

type sle_filename from singlelineedit within w_main
integer x = 2354
integer y = 2764
integer width = 2299
integer height = 80
integer taborder = 90
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
end type

type mle_object_syntax from multilineedit within w_main
integer x = 1797
integer y = 684
integer width = 2917
integer height = 1620
integer taborder = 60
integer textsize = -8
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_main
integer x = 1897
integer y = 1540
integer width = 288
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "Comentarios:"
end type

type mle_comment from multilineedit within w_main
integer x = 3451
integer y = 2412
integer width = 1184
integer height = 300
integer taborder = 60
integer textsize = -8
string facename = "Tahoma"
long textcolor = 33554432
boolean autovscroll = true
end type

type sle_prefix from singlelineedit within w_main
integer x = 2139
integer y = 2760
integer width = 197
integer height = 80
integer taborder = 90
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "str_"
boolean autohscroll = false
end type

event modified;is_prefix = this.text
end event

type st_5 from statictext within w_main
integer x = 2135
integer y = 2700
integer width = 155
integer height = 60
integer textsize = -8
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Prefijo:"
end type

type rb_structure from radiobutton within w_main
integer x = 2834
integer y = 2392
integer width = 320
integer height = 76
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Estructura"
boolean checked = true
end type

event clicked;is_prefix = "str_"
is_file_ext=".srs"

sle_prefix.text = is_prefix

end event

type rb_autonvo from radiobutton within w_main
integer x = 2839
integer y = 2464
integer width = 526
integer height = 76
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Instancia NVO"
end type

event clicked;is_prefix = "n_cst_"
is_file_ext=".sru"

sle_prefix.text = is_prefix

end event

type dw_datatype from datawindow within w_main
integer x = 741
integer y = 688
integer width = 1033
integer height = 1620
integer taborder = 80
string dataobject = "d_datatype"
boolean vscrollbar = true
end type

type cbx_1 from checkbox within w_main
integer x = 50
integer y = 2328
integer width = 402
integer height = 84
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Select ALL"
boolean checked = true
end type

event clicked;Long ll_Row, ll_RowCount
Boolean lb_select

ll_RowCount= dw_columns.RowCount()

lb_select = this.checked

FOR ll_Row= 1 TO ll_RowCount
	dw_columns.SelectRow (ll_Row, lb_select )
NEXT

//update the multilineedit to display the updated syntax
mle_sql_syntax.text = wf_build_sql_syntax()

IF lb_select THEN
	cb_create.triggerevent(clicked!)
ELSE
	dw_datatype.Reset()
END IF	
end event

type mle_sql_syntax from multilineedit within w_main
integer x = 727
integer y = 348
integer width = 3986
integer height = 232
integer taborder = 80
integer textsize = -8
string facename = "Tahoma"
string pointer = "arrow!"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_main
integer x = 114
integer y = 276
integer width = 503
integer height = 68
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 41943040
long backcolor = 553648127
string text = "Select a Table"
alignment alignment = center!
end type

type st_2 from statictext within w_main
integer x = 41
integer y = 1368
integer width = 613
integer height = 80
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 41943040
long backcolor = 553648127
string text = "Select Columns"
alignment alignment = center!
end type

type dw_tables from datawindow within w_main
event key pbm_dwnkey
integer x = 32
integer y = 348
integer width = 658
integer height = 952
integer taborder = 10
string dataobject = "d_table_list"
boolean vscrollbar = true
end type

event key;string ls_string=""
integer iFila=0
integer row_inicial
integer i, contarfilas

choose case key
       case keyq!
            ls_string = "q"
       case keyw!
            ls_string = "w"
       case keye!
           ls_string = "e"
       case keyr!
           ls_string = "r"
       case keyt!
           ls_string = "t"
	  case keyy!
           ls_string = "y"
	  case keyu!
           ls_string = "u"
       case keyi!
           ls_string = "i"
       case keyo!
           ls_string = "o"
	  case keyp!
           ls_string = "p"
	  case keya!
            ls_string = "a"
       case keys!
            ls_string = "s"
       case keyd!
           ls_string = "d"
       case keyf!
           ls_string = "f"
	   case keyg!
           ls_string = "g"
	   case keyh!
           ls_string = "h"
	   case keyj!
           ls_string = "j"
		case keyk!
             ls_string = "k"
		case keyl!
             ls_string = "l"
		// case keyñ!
        //  ls_string = "ñ"
     	case keyz!
            ls_string = "z"
         case keyx!
            ls_string = "x"
         case keyc!
           ls_string = "c"
          case keyv!
           ls_string = "v"
	     case keyb!
           ls_string = "b"
	      case keyn!
           ls_string = "n"
	      case keym!
           ls_string = "m"
		 
      case KeyUpArrow!
			 ls_string = "up"
			ifila=this.GetSelectedRow(0)
			if ifila > 0 then
				this.SelectRow(0, false)
					this.ScrollToRow(iFila - 1)
				this.SelectRow(iFila - 1, true)
			end if	
       case keydownArrow!
			 ls_string = "down"
			ifila=this.GetSelectedRow(0)
			if ifila > 0 then
				this.SelectRow(0, false)
					this.ScrollToRow(iFila + 1)
				this.SelectRow(iFila + 1, true)
			end if	 
end choose


if ls_string <> "" and  ls_string<>"up" and  ls_string<>"down"then
		if ls_string= old_string then
			row_inicial=old_fila+1
		else
			row_inicial=1
		end if

iFila= this.Find("tname like '" + ls_string + "%'", row_inicial, this.RowCount())	
if iFila > 0 then
	
	this.SelectRow(0, false)
	this.ScrollToRow(iFila)
	this.SelectRow(iFila, true)
//	gf_mensaje("variables","ls_string "+ls_string+" old_string "+old_string+" row_inicial "+string(row_inicial)+" iFila "+string(ifila)) 
	old_string=ls_string
	old_fila=iFila
end if
end if

if iFila > 0 then
	dw_columns.Reset()
	is_Table = dw_tables.GetItemString(iFila, 1)
	If gf_set_column_select(dw_columns,is_Table) < 0 Then
	MessageBox("Error", &
					"Unable to Set SQL Select statement For Columns list", &
					StopSign!)
	Return
	End If
	dw_columns.Retrieve( )	  									  
	contarfilas=dw_columns.RowCount()

	if cbx_1.checked = true then
		cbx_1.triggerevent(clicked!)
		for i = 1 to contarfilas
			dw_columns.SelectRow (i, TRUE )
		next	
	end if
end if



end event

event clicked;Long ll_Row, ll_RowCount
wf_aspecto()

///////////////////////////////////////////////////////////////////////////////////////////////////////
//Clicked script for dw_tables
///////////////////////////////////////////////////////////////////////////////////////////////////////

// if user clicks on no row do not continue processing
If row = 0 Then Return	
dw_columns.Reset()
// Select the clicked row
dw_tables.SelectRow(0, False)
dw_tables.SelectRow(row, True)

// gf_set_column_select is a user function to modify the select used by
// the column selection data window, based on which DBMS we're connected
// to; This function adjusts to the differences in catalog structures
// between the DBMS's

is_Table = dw_tables.GetItemString(row, 1)

If gf_set_column_select(dw_columns,is_table) < 0 Then
	MessageBox("Error", &
					"Unable to Set SQL Select statement For Columns list", &
					StopSign!)
	Return
End If

ll_RowCount= dw_columns.Retrieve( )	  /* Note:  No Retrieve argument is used, 
									  since GF_SET_COLUMN_SELECT inserts
									  the proper table name */
									  
//Select all the columns									  
IF cbx_1.checked = TRUE THEN
	cbx_1.triggerevent(clicked!)
	for ll_Row = 1 to ll_RowCount
		dw_columns.SelectRow(ll_Row, TRUE)
	next	
END IF

cb_create.triggerevent(clicked!)

end event

type dw_columns from datawindow within w_main
integer x = 37
integer y = 1464
integer width = 658
integer height = 848
integer taborder = 10
string dataobject = "d_column_list"
boolean vscrollbar = true
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////
//Clicked script for dw_columns
//////////////////////////////////////////////////////////////////////////////////////////////////////////

wf_aspecto()
// If user clicks on no row do not continue processing
If row = 0 Then Return	

// As a column is selected, add it to the list in the select
//If already selected, turn off selection
If dw_columns.IsSelected(row) then
	dw_columns.SelectRow(row, False)
	cbx_1.checked=false
Else
	dw_columns.SelectRow(row, True)
	if long(dw_columns.describe("evaluate('sum( if(isselected(), 1, 0) for all)',1)")) = dw_columns.RowCount() then cbx_1.checked=true
End If


//update the multilineedit to display the updated syntax
mle_sql_syntax.text = wf_build_sql_syntax()

if mle_sql_syntax.text <> "" then cb_create.triggerevent(clicked!)
end event

type st_4 from statictext within w_main
boolean visible = false
integer x = 27
integer y = 668
integer width = 357
integer textsize = -9
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "DataWindow:"
end type

type gb_3 from groupbox within w_main
integer x = 2816
integer y = 2328
integer width = 558
integer height = 364
integer taborder = 50
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Tipo de Objeto "
end type

type dw_new from datawindow within w_main
boolean visible = false
integer x = 2203
integer y = 976
integer width = 1435
integer height = 768
integer taborder = 80
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;This.SelectRow(0, false)
This.SelectRow(row, true)
end event

event clicked;This.SelectRow(0, false)
end event

type cb_close from commandbutton within w_main
integer x = 4206
integer y = 2876
integer width = 494
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
boolean cancel = true
end type

event clicked;Close(parent)
end event

type cb_create from commandbutton within w_main
boolean visible = false
integer x = 2715
integer y = 2876
integer width = 494
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Create Datatypes"
end type

event clicked;//Clicked script for cb_syntax
string 	ls_sql_syntax, ls_style, ls_dw_syntax, ls_dw_err

// Recreate the DW from the syntax; first, be sure there's 
// something there.
if mle_sql_syntax.text = "" then
	MessageBox("Sorry!", "No Syntax Exists. Enter valid SQL or " &
	+ "DataWindow Syntax or Select Table and Columns and then click Create")
	Return
end if

// Construct the style options
ls_style = "style(type=" + is_report_type + ")"

// Create a datawindow from the MLE. If it displays SQL Syntax, then build
// datawindow from SQL syntax. If it displays DW Syntax, then build 
// from the datawindow syntax.
ls_sql_syntax = mle_sql_syntax.text
ls_dw_err = ""
ls_dw_syntax = SyntaxFromSQL(sqlca, ls_sql_syntax, ls_style, ls_dw_err)
If ls_dw_err <> "" Then
	MessageBox("Sorry!", ls_dw_err)
	Return
End If
dw_new.Create(ls_dw_syntax)

//Retrieve into the new datawindow
dw_new.SetTransObject(SQLCA)

dw_new.setredraw(false)
dw_new.Retrieve( )
dw_new.setredraw(true)	
wf_set_new()

end event

type cb_createsyntax from commandbutton within w_main
integer x = 3209
integer y = 2876
integer width = 494
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Crear Sintaxis"
end type

event clicked;string		ls_filename
mle_object_syntax.text=""
is_str_syntax=""

cb_create.triggerevent(clicked!)

// set output filename
if rb_gffun.checked THEN
	ls_filename = is_prefix+"get_column_"+is_export_name+is_file_ext
else	
	ls_filename = is_prefix+is_export_name+is_file_ext
end if
// set filename sle
sle_filename.text = ls_filename

is_comment = mle_comment.text

//check the type of sysntax to create
if rb_structure.checked THEN	wf_create_structure_export ( )
if rb_autonvo.checked THEN wf_create_auto_nvo_export ( )
if rb_datawindow.checked THEN wf_create_datawindow_export ( )
if rb_gffun.checked THEN wf_create_global_fun_export ( )



// Tamaño de la ventana
//parent.width = 2975
end event

type cb_savesyntax from commandbutton within w_main
integer x = 3707
integer y = 2876
integer width = 494
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar Sintaxis"
end type

event clicked;Integer li_result

li_result=wf_save_syntax()

if li_result=1 then wf_aspecto()



end event

type r_2 from rectangle within w_main
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 33521664
integer width = 4768
integer height = 260
end type

