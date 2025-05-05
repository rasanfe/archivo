$PBExportHeader$vs_dw_master.sru
forward
global type vs_dw_master from datawindow
end type
end forward

global type vs_dw_master from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_retrieve ( )
event key pbm_dwnkey
event ue_aceptar_texto ( )
end type
global vs_dw_master vs_dw_master

type variables
private long il_last_clicked_row = 0
private String is_click_style
protected Boolean dw_has_focus = false


 n_dwresize_service	inv_Resize
end variables
forward prototypes
public function long of_retrieve (transaction a_sql, any a_args[])
public subroutine of_set_resize (boolean ab_switch)
end prototypes

event ue_Retrieve();//
end event

event key;//Para utilizar en descendientes
end event

event ue_aceptar_texto();IF dw_has_focus = false THEN
	this.accepttext( )
END IF
end event

public function long of_retrieve (transaction a_sql, any a_args[]);Long ll_RowCount, ll_args 
DataWindowChild ldc_2, ldc_1
Integer li_result

this.Reset()

ll_args=UpperBound(a_args[])

This.SetTransObject(a_sql)
	
CHOOSE CASE ll_args
	CASE 0
		ll_RowCount = THIS.Retrieve()
	CASE 1
		ll_RowCount = THIS.Retrieve(a_args[1])
	CASE 2
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2])
	CASE 3
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3])
	CASE 4
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4]) 
		CASE 5
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5])
	CASE 6
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5], a_args[6])
	CASE 7
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5], a_args[6], a_args[7])
	CASE 8
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5], a_args[6], a_args[7], a_args[8])
	CASE 9
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5], a_args[6], a_args[7], a_args[8], a_args[9])
	CASE 10
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5], a_args[6], a_args[7], a_args[8], a_args[9], a_args[10]) 
	CASE 11
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5], a_args[6], a_args[7], a_args[8], a_args[9], a_args[10], a_args[11]) 
	CASE 12
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5], a_args[6], a_args[7], a_args[8], a_args[9], a_args[10], a_args[11], a_args[12]) 	
	CASE 13
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5], a_args[6], a_args[7], a_args[8], a_args[9], a_args[10], a_args[11], a_args[12], a_args[13]) 	
	CASE 14
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5], a_args[6], a_args[7], a_args[8], a_args[9], a_args[10], a_args[11], a_args[12], a_args[13], a_args[14]) 	
	CASE 15
		ll_RowCount = THIS.Retrieve(a_args[1], a_args[2], a_args[3], a_args[4], a_args[5], a_args[6], a_args[7], a_args[8], a_args[9], a_args[10], a_args[11], a_args[12], a_args[13], a_args[14], a_args[15]) 	
	CASE ELSE
		ll_RowCount = 0
		messagebox("Atención", "¡ El Nº Máximo de Argumentos es 15 !", exclamation!)
END CHOOSE		

RETURN ll_RowCount

end function

public subroutine of_set_resize (boolean ab_switch);// Check arguments
if IsNull(ab_switch) then return

if ab_Switch then
	if IsNull(inv_Resize) or not IsValid (inv_Resize) then
		inv_Resize = Create n_dwresize_service
		inv_Resize.of_SetRequestor ( this )
		inv_Resize.of_SetOrigSize (this.Width, this.Height)
		return 
	end if
else 
	if IsValid (inv_Resize) then
		Destroy inv_Resize
		return 
	end if	
end if

return 
	
end subroutine

on vs_dw_master.create
end on

on vs_dw_master.destroy
end on

event getfocus;dw_has_focus = true
end event

event losefocus;dw_has_focus = false
this.event  post ue_aceptar_texto( )
end event

event itemerror;//Return Values
//------------------------------------------------------------------------------
//Set the return code to affect the outcome of the event:
//0 (Default) Reject the data value and show an error message box
//1 Reject the data value with no message box
//2 Accept the data value
//3 Reject the data value but allow focus to change
//-------------------------------------------------------------------------------

string ls_colname, ls_datatype

ls_colname = dwo.Name
ls_datatype = dwo.ColType

messagebox("Atención", "En la columna "+ls_colname+char(13)+" el tipo de dato esperado es "+ls_datatype+"."+char(13)+char(13)+"¡ Introduzca un Valor correcto !", exclamation!)

// Set value to null if blank
CHOOSE CASE LEFT(ls_datatype, 5)
		CASE  "Char"
		string null_string
		SetNull(null_string)
		This.SetItem(row, ls_colname, null_string)
			
		CASE "date "
		date null_date
		SetNull(null_date)
		This.SetItem(row, ls_colname, null_date)
			
		CASE "datet"
		datetime null_datetime
		SetNull(null_datetime)
		This.SetItem(row, ls_colname, null_datetime)
			
		CASE  "decim"
		dec null_decimal
		SetNull(null_decimal)
		This.SetItem(row, ls_colname, null_decimal)
				
		CASE  "numbe", "long"
		integer null_integer
		SetNull(null_integer)
		This.SetItem(row, ls_colname, null_integer)
	
		case "time "
		time null_time
		SetNull(null_time)
		This.SetItem(row, ls_colname, null_time)
					// Additional cases for other datatypes
		//Real
		//Timestamp
		//ULong
		//	INT
END CHOOSE
	RETURN 1
end event

event dbError;messagebox("Error SQL "+string(sqldbcode), sqlerrtext , exclamation!)
return 1
end event

event resize;If IsValid (inv_Resize) then inv_Resize.Event pfc_Resize (sizetype, This.Width, This.Height)
end event

