$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_copyright from statictext within w_main
end type
type p_displayname from picture within w_main
end type
type p_project_type from picture within w_main
end type
type st_url from statictext within w_main
end type
type pb_print from picturebutton within w_main
end type
type st_4 from statictext within w_main
end type
type cb_retrieve from commandbutton within w_main
end type
type dw_1 from datawindow within w_main
end type
type dw_report from datawindow within w_main
end type
type st_background from statictext within w_main
end type
end forward

global type w_main from window
integer width = 5221
integer height = 2944
boolean titlebar = true
string title = "Facturas Clientes"
boolean controlmenu = true
boolean minbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_copyright st_copyright
p_displayname p_displayname
p_project_type p_project_type
st_url st_url
pb_print pb_print
st_4 st_4
cb_retrieve cb_retrieve
dw_1 dw_1
dw_report dw_report
st_background st_background
end type
global w_main w_main

type prototypes

end prototypes

type variables

end variables

forward prototypes
public function long wf_retrieve (string as_filename)
public function long wf_report (string as_filename1, string as_filename2)
private function string wf_load_json (string as_filename)
private subroutine wf_set_args (datawindowchild adw, string as_argnames[], string as_argdatatypes[], any aa_argvalues[])
end prototypes

public function long wf_retrieve (string as_filename);Long ll_RowCount
String ls_Json
Integer li_result

ls_Json = wf_load_json(as_FileName)

dw_1.reset()
ll_RowCount = dw_1.ImportJson(ls_Json)

dw_1.Event Retrieveend(ll_RowCount)

Return ll_RowCount
end function

public function long wf_report (string as_filename1, string as_filename2);Long ll_RowCount
String ls_Json1, ls_json2
Integer li_result
DataWindowChild dwc_Nested
String ls_DwProcessing
String ls_Argnames[], ls_Argdatatypes[], l_values[]
Datastore ds_aux
string ls_header, ls_objname, ls_library
String ls_syntax_original, ls_syntax_new, ErrorBuffer, ls_data_new, ls_data_original
integer li_rtncode

yield()
SetPointer (Hourglass!)

ls_objname ="report_cabecera"
ls_library = gf_getlibraryfromdatawindow(ls_objname) 

If gb_isPBIDE Then
	ls_library = gf_replaceall(ls_library, gs_dir, "")
End If

ls_json1 = wf_load_json(as_FileName1)
ls_json2 = wf_load_json(as_FileName2)

//Create Helper Datastore to Import Nested Report Data
ds_aux = Create Datastore

ds_aux.DataObject =ls_objname

//Import Json
ds_aux.Reset()

//Get Original Data
ls_data_original =ds_aux.Describe("DataWindow.Syntax.Data")
If ls_data_original = "data() " Then ls_data_original = ""

//Import Json With Data
ds_aux.ImportJson(ls_json1)

//Get String With Data
ls_data_new = ds_aux.Describe("DataWindow.Syntax.Data") //wf_ds_to_data(ds_aux)

//Export Syntax of NestedReport
IF gb_isPBIDE Then
	ls_syntax_original = LibraryExport ( ls_library, ls_objname, ExportDataWindow! )
Else
	ls_header = "$PBExportHeader$" + ls_objname + ".srd"
	ls_syntax_original = ls_header +"~r~n"+ ds_aux.Describe("DataWindow.Syntax") 
End IF

//Replacing Data in the Datastore Syntax
ls_syntax_new=ls_syntax_original+"~r~n"+ls_data_new

//Import New Datawindow with Data
li_rtncode = LibraryImport(ls_library, ls_objname, ImportDataWindow!, ls_syntax_new, ErrorBuffer, "")
destroy ds_aux

//Import Json to Base Datawindow
dw_report.Reset()
ll_RowCount = dw_report.ImportJson(ls_json2)


//Remplace Arguments In Nested Repor for Them Values.
If ll_RowCount > 0 Then
			
	ls_DwProcessing = dw_report.Describe("Datawindow.Processing")
	If ls_DwProcessing <> "5" Then dw_report.Modify ("Datawindow.Processing=5")
	
	li_result =dw_Report.GetChild("dw_cabecera", dwc_Nested)
	
	If li_Result <> 1 Then
		gf_mensaje("Error", "¡ Error Tomando Refrencia a Nested Report !")
		Return -1
	End IF
		
	ls_Argnames[1]="arg_empresa"
	ls_Argdatatypes[1]="string"
	l_values[1] = "2" 
	wf_set_args(dwc_Nested, ls_Argnames[], ls_Argdatatypes[], l_values[])
	dw_report.groupcalc()

	If ls_DwProcessing <> "5" Then dw_report.Modify ("Datawindow.Processing="+ls_DwProcessing)
End If	

//Restore Original Report
ls_syntax_original=ls_syntax_original+"~r~n"+ls_data_original

li_rtncode = LibraryImport(ls_library, ls_objname, ImportDataWindow!, ls_syntax_original, ErrorBuffer, "")

SetPointer (Arrow!)
dw_report.Event Retrieveend(ll_RowCount)

Return ll_RowCount
end function

private function string wf_load_json (string as_filename);String ls_Json
JsonGenerator lnv_JsonGenerator
lnv_JsonGenerator = Create JsonGenerator

lnv_JsonGenerator.ImportFile(as_FileName)

ls_Json = lnv_JsonGenerator.GetJsonString()

Destroy  lnv_JsonGenerator

Return ls_Json
end function

private subroutine wf_set_args (datawindowchild adw, string as_argnames[], string as_argdatatypes[], any aa_argvalues[]);string      ls_object, ls_objects, ls_type, ls_expression
string      ls_value, ls_aux
integer     li_len, li_to, li_from, li_x, li_pos

// Obtenemos la colección de objetos de ds.
ls_objects = adw.describe('datawindow.objects')

// Recorremos los todos objetos.
li_len = len(ls_objects)

If li_len > 0 Then
   // Inicializamos la variable necesaria desde la que buscamos el siguiente objeto.
   li_from = 1
   
   // Recorremos todos los objetos.
   Do
      li_to = pos(ls_objects, "~t", li_from)
      
      // Obtenemos el nombre del objeto.
      If li_to = 0 Then
         ls_object = mid(ls_objects, li_from)
      Else
         ls_object = mid(ls_objects, li_from, li_to - li_from)
      End If
      
      If len(ls_object) > 0 Then
         // Obtenemos el tipo del objeto.
         ls_type = adw.describe(ls_object + '.type')
         
         // Solo si es computado comprobamos si su expresión contiene "retrieval arguments".
         If ls_type = "compute" Then
            ls_expression = adw.describe(ls_object + '.expression')
            
            // Para cada objeto miramos todos los "retrieval arguments".
            For li_x = 1 To upperBound(as_argNames)      
               // Solo tratamos argumentos que no sean array.
               If right(as_argDataTypes[li_x], 4) = 'list' Then
                  Continue
               Else
                  li_pos = pos(ls_expression, as_argNames[li_x])
   
                  Do While li_pos > 0 
                     // Comprobamos que no sea otro identificador distinto, para lo que
                     // el carácter que lo precede y el que le sigue debe ser distinto
                     // de letra o número. (si buscamos 'numeropi' que no tome 'numeropista')                  
                     If ((li_pos = 1) Or match(mid(ls_expression, li_pos -1, 1), '[^A-Z^a-z^0-9]')) And &
                        ((li_pos + len(as_argNames[li_x]) - 1 = len(ls_expression)) Or match(mid(ls_expression, li_pos + len(as_argNames[li_x]), 1), '[^A-Z^a-z^0-9]')) Then
   
                     
					// Hay que tratar los argumentos Nulos.
					IF isnull(aa_argValues[li_x]) THEN
						Choose Case as_argDataTypes[li_x]
							Case 'number'
								 ls_value ="0"
							Case 'string'
								ls_value = ""                        
							Case 'date'
								ls_value = "1900-01-01"
							Case 'time'
								ls_value="00:00:00"
							Case 'datetime'
								ls_value = "1900-01-01 00:00:00"
							Case Else
									// En un computado no podría aparecer otro tipo.
							End Choose	
					ELSE	
						   ls_value = string(aa_argValues[li_x])
					END IF			
					                        
                        // Obtenemos la nueva expresión para el computado en base al tipo de dato.
                        Choose Case as_argDataTypes[li_x]
                           Case 'number'
                              ls_aux = ls_value
                           Case 'string'
                              ls_aux = "'" + ls_value + "'"                           
                           Case 'date'
                              ls_aux = "date('" + ls_value + "')"
                           Case 'time'
                              ls_aux = "time('" + ls_value + "')"
                           Case 'datetime'
                              ls_aux = "datetime(date(left('" + ls_value + "', 10)), time(mid('" + ls_value + "', 12, 8)))"
                           Case Else
                              // En un computado no podría aparecer otro tipo.
                        End Choose
                        
                        ls_expression = replace(ls_expression, li_pos, len(as_argNames[li_x]), ls_aux)
                     End If
                        
                     // Buscamos si la misma ocurrencia aparece otra vez.
                     li_pos = pos(ls_expression, as_argNames[li_x])
                  Loop
               End If
            Next
            
            // Si se modifico la expresión para el compute la sustituimos con la nueva.
            If ls_expression <> adw.describe(ls_object + '.expression') Then

               // Antes de hacer el modify, hay que añadir delante de las comillas dobles la virgulilla.
               li_pos = pos(ls_expression, '"')
               do while li_pos > 0
                  ls_expression = replace(ls_expression, li_pos, 0, "~~")
                  li_pos = pos(ls_expression, '"', li_pos + 2)
               Loop
               
               ls_aux = adw.Modify(ls_object + ".expression=~"" + ls_expression + "~"")
               
            End If
         End If
      End If
      
      li_from = li_to + 1
   Loop While (li_to > 0)
End If
end subroutine

on w_main.create
this.st_copyright=create st_copyright
this.p_displayname=create p_displayname
this.p_project_type=create p_project_type
this.st_url=create st_url
this.pb_print=create pb_print
this.st_4=create st_4
this.cb_retrieve=create cb_retrieve
this.dw_1=create dw_1
this.dw_report=create dw_report
this.st_background=create st_background
this.Control[]={this.st_copyright,&
this.p_displayname,&
this.p_project_type,&
this.st_url,&
this.pb_print,&
this.st_4,&
this.cb_retrieve,&
this.dw_1,&
this.dw_report,&
this.st_background}
end on

on w_main.destroy
destroy(this.st_copyright)
destroy(this.p_displayname)
destroy(this.p_project_type)
destroy(this.st_url)
destroy(this.pb_print)
destroy(this.st_4)
destroy(this.cb_retrieve)
destroy(this.dw_1)
destroy(this.dw_report)
destroy(this.st_background)
end on

event open;Timer(1)
end event

event timer;String ls_hora
Datetime ldt_hora

ldt_hora=datetime(today(), now())
ls_hora = String(ldt_hora, "dd/mm/yyyy  hh:mm:ss")

st_url.text = ls_hora 
end event

type st_copyright from statictext within w_main
integer x = 1362
integer y = 132
integer width = 101
integer height = 84
boolean bringtotop = true
integer textsize = -12
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 553648127
string text = "©"
end type

type p_displayname from picture within w_main
integer x = 361
integer y = 24
integer width = 1019
integer height = 208
string picturename = "imagenes\logo.png"
boolean focusrectangle = false
end type

type p_project_type from picture within w_main
integer x = 46
integer y = 16
integer width = 288
integer height = 216
string picturename = "imagenes\PowerServerApp.png"
boolean focusrectangle = false
end type

type st_url from statictext within w_main
integer x = 55
integer y = 2720
integer width = 5115
integer height = 128
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type pb_print from picturebutton within w_main
integer x = 5015
integer y = 448
integer width = 137
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "PrintDataWindow!"
alignment htextalign = left!
string powertiptext = "Print"
end type

event clicked;String ls_FileName1, ls_FileName2

ls_FileName1 = ".\nested.json"
ls_FileName2 =".\data.json"

wf_report(ls_FileName1, ls_FileName2)
dw_report.visible=true
dw_1.visible=false
end event

type st_4 from statictext within w_main
integer x = 1938
integer y = 72
integer width = 1509
integer height = 152
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
string text = "Nested Report Example"
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_main
integer x = 4603
integer y = 448
integer width = 402
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;String ls_FileName

ls_FileName =".\data.json"

wf_retrieve(ls_FileName)

dw_1.visible=true
dw_report.visible=false
end event

type dw_1 from datawindow within w_main
integer x = 55
integer y = 572
integer width = 5115
integer height = 2116
integer taborder = 60
string dataobject = "dw_con_listado_venfac_obra"
boolean vscrollbar = true
end type

event constructor;call super::constructor;String ls_cebra

//Parametrización de Colores
ls_cebra = "1073741824~tif(Mod(GetRow(), 2) = 0, RGB(220, 220, 220), RGB(255, 255, 255))"

// Efecto cebra
Object.DataWindow.Detail.Color = ls_cebra




end event

type dw_report from datawindow within w_main
integer x = 55
integer y = 572
integer width = 5115
integer height = 2116
integer taborder = 70
string dataobject = "report_con_listado_venfac_obra"
boolean vscrollbar = true
end type

type st_background from statictext within w_main
integer width = 5221
integer height = 280
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 33521664
boolean focusrectangle = false
end type

