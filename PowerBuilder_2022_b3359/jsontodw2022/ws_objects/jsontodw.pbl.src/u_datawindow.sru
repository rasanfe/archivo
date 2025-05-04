$PBExportHeader$u_datawindow.sru
forward
global type u_datawindow from datawindow
end type
end forward

global type u_datawindow from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global u_datawindow u_datawindow

forward prototypes
public function long of_cargar_json (string as_json)
private subroutine of_format ()
end prototypes

public function long of_cargar_json (string as_json);u_datastore ds_data
Blob lblb_data
Long ll_rv, ll_RowCount

This.Reset()
This.Dataobject=""

ds_data = Create u_datastore

ll_RowCount = ds_data.of_cargar_json(as_json)

If ll_RowCount < 0 Then Return -1


ll_rv = ds_data.GetFullState(lblb_data)
			
IF ll_rv = -1 THEN
	gf_mensaje("Error", "¡ GetFullState failed !")
	Return -1
END IF
			
ll_rv = This.SetFullState(lblb_data)
			
IF ll_rv = -1 THEN
	gf_mensaje("Error", "¡ SetFullState failed !")
	Return -1
END IF

Destroy ds_data

//Formateamos el Datawindow
of_format()

Return ll_RowCount


end function

private subroutine of_format ();int li_start_pos = 1
int li_tab_pos
string ls_obj_list, ls_obj_name

This.Object.DataWindow.Detail.Color = "1073741824~tif(Mod(GetRow(), 2) = 0, RGB(220, 220, 220), RGB(255, 255, 255))"

ls_obj_list = This.Describe("DataWindow.Objects")
li_tab_pos = Pos(ls_obj_list, "~t", li_start_pos)

Do While li_tab_pos > 0
   ls_obj_name = Mid(ls_obj_list, li_start_pos, (li_tab_pos - li_start_pos))
	  
	 If This.Describe(ls_obj_name+".band") = "header" Then
		Modify("Datawindow.Header.Height=80")
		Modify("Datawindow.Header.Color='16367753'" ) 
		Modify (ls_obj_name + ".color= '0'" ) 
		Modify (ls_obj_name + ".Font.face='Arial'") 
		Modify (ls_obj_name + ".Font.height='-8'") 
		Modify (ls_obj_name + ".y='4'") 
		Modify (ls_obj_name + ".height='60'")				
	End If	

   li_start_pos = li_tab_pos + 1
   li_tab_pos = Pos(ls_obj_list, "~t", li_start_pos)		
Loop
end subroutine

on u_datawindow.create
end on

on u_datawindow.destroy
end on

