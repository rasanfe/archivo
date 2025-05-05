$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_11 from statictext within w_main
end type
type cb_stamp_pdf from commandbutton within w_main
end type
type pb_show_datastore from picturebutton within w_main
end type
type st_10 from statictext within w_main
end type
type st_9 from statictext within w_main
end type
type st_8 from statictext within w_main
end type
type st_7 from statictext within w_main
end type
type st_6 from statictext within w_main
end type
type st_5 from statictext within w_main
end type
type st_4 from statictext within w_main
end type
type st_3 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type cb_docs from commandbutton within w_main
end type
type cb_add_image from commandbutton within w_main
end type
type cbx_auto from checkbox within w_main
end type
type st_bruce from statictext within w_main
end type
type st_powertalks from statictext within w_main
end type
type st_platform from statictext within w_main
end type
type st_myversion from statictext within w_main
end type
type p_2 from picture within w_main
end type
type st_info from statictext within w_main
end type
type cb_settings from commandbutton within w_main
end type
type cb_add_page from commandbutton within w_main
end type
type cb_compress from commandbutton within w_main
end type
type ddlb_compression from dropdownlistbox within w_main
end type
type cb_attach_file from commandbutton within w_main
end type
type cb_set_watermark_text from commandbutton within w_main
end type
type cb_set_watermark_image from commandbutton within w_main
end type
type cb_merge_pdf from commandbutton within w_main
end type
type cb_import_datastore from commandbutton within w_main
end type
type cb_import_pdf from commandbutton within w_main
end type
type wb_1 from webbrowser within w_main
end type
type r_2 from rectangle within w_main
end type
type cb_create_fillable_form from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 4338
integer height = 2768
boolean titlebar = true
string title = "PDFBuilder Demo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_11 st_11
cb_stamp_pdf cb_stamp_pdf
pb_show_datastore pb_show_datastore
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_docs cb_docs
cb_add_image cb_add_image
cbx_auto cbx_auto
st_bruce st_bruce
st_powertalks st_powertalks
st_platform st_platform
st_myversion st_myversion
p_2 p_2
st_info st_info
cb_settings cb_settings
cb_add_page cb_add_page
cb_compress cb_compress
ddlb_compression ddlb_compression
cb_attach_file cb_attach_file
cb_set_watermark_text cb_set_watermark_text
cb_set_watermark_image cb_set_watermark_image
cb_merge_pdf cb_merge_pdf
cb_import_datastore cb_import_datastore
cb_import_pdf cb_import_pdf
wb_1 wb_1
r_2 r_2
cb_create_fillable_form cb_create_fillable_form
end type
global w_main w_main

type variables
end variables

forward prototypes
public subroutine wf_version (statictext ast_version, statictext ast_patform)
public subroutine wf_save_and_display_pdf (pdfdocument a_pdfdoc)
end prototypes

public subroutine wf_version (statictext ast_version, statictext ast_patform);String ls_version, ls_platform
environment env
integer li_rtn

li_rtn = GetEnvironment(env)

IF li_rtn <> 1 THEN 
	ls_version = string(year(today()))
	ls_platform="32"
ELSE
	ls_version = "20"+ string(env.pbmajorrevision)+ "." + string(env.pbbuildnumber)
	ls_platform=string(env.ProcessBitness)
END IF

ls_platform += " Bits"

ast_version.text=ls_version
ast_patform.text=ls_platform

end subroutine

public subroutine wf_save_and_display_pdf (pdfdocument a_pdfdoc);string		ls_PathName
string		ls_FileName

ls_PathName = gs_appdir + "\test.pdf"
ls_FileName = "test.pdf"

IF cbx_auto.Checked = FALSE THEN
	IF GetFileSaveName ("PDF File to Save", ls_PathName, ls_FileName, 'PDF', "PDF Files (*.pdf),*.pdf") < 1 THEN Return
END IF

a_pdfdoc.Save(ls_PathName)

wb_1.Navigate(ls_PathName)
end subroutine

on w_main.create
this.st_11=create st_11
this.cb_stamp_pdf=create cb_stamp_pdf
this.pb_show_datastore=create pb_show_datastore
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_docs=create cb_docs
this.cb_add_image=create cb_add_image
this.cbx_auto=create cbx_auto
this.st_bruce=create st_bruce
this.st_powertalks=create st_powertalks
this.st_platform=create st_platform
this.st_myversion=create st_myversion
this.p_2=create p_2
this.st_info=create st_info
this.cb_settings=create cb_settings
this.cb_add_page=create cb_add_page
this.cb_compress=create cb_compress
this.ddlb_compression=create ddlb_compression
this.cb_attach_file=create cb_attach_file
this.cb_set_watermark_text=create cb_set_watermark_text
this.cb_set_watermark_image=create cb_set_watermark_image
this.cb_merge_pdf=create cb_merge_pdf
this.cb_import_datastore=create cb_import_datastore
this.cb_import_pdf=create cb_import_pdf
this.wb_1=create wb_1
this.r_2=create r_2
this.cb_create_fillable_form=create cb_create_fillable_form
this.Control[]={this.st_11,&
this.cb_stamp_pdf,&
this.pb_show_datastore,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_docs,&
this.cb_add_image,&
this.cbx_auto,&
this.st_bruce,&
this.st_powertalks,&
this.st_platform,&
this.st_myversion,&
this.p_2,&
this.st_info,&
this.cb_settings,&
this.cb_add_page,&
this.cb_compress,&
this.ddlb_compression,&
this.cb_attach_file,&
this.cb_set_watermark_text,&
this.cb_set_watermark_image,&
this.cb_merge_pdf,&
this.cb_import_datastore,&
this.cb_import_pdf,&
this.wb_1,&
this.r_2,&
this.cb_create_fillable_form}
end on

on w_main.destroy
destroy(this.st_11)
destroy(this.cb_stamp_pdf)
destroy(this.pb_show_datastore)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_docs)
destroy(this.cb_add_image)
destroy(this.cbx_auto)
destroy(this.st_bruce)
destroy(this.st_powertalks)
destroy(this.st_platform)
destroy(this.st_myversion)
destroy(this.p_2)
destroy(this.st_info)
destroy(this.cb_settings)
destroy(this.cb_add_page)
destroy(this.cb_compress)
destroy(this.ddlb_compression)
destroy(this.cb_attach_file)
destroy(this.cb_set_watermark_text)
destroy(this.cb_set_watermark_image)
destroy(this.cb_merge_pdf)
destroy(this.cb_import_datastore)
destroy(this.cb_import_pdf)
destroy(this.wb_1)
destroy(this.r_2)
destroy(this.cb_create_fillable_form)
end on

event open;wf_version(st_myversion, st_platform)

gs_appdir = GetCurrentDirectory()

//Marcamos el Valor por defecto en la Compresión que es 6 (0 - 9)
ddlb_compression.selectitem(7)
end event

event resize;wb_1.Resize (newwidth - 750, newheight - wb_1.y - 100)
r_2.width = newwidth
st_myversion.x = newwidth - st_myversion.width -20
st_platform.x = newwidth - st_myversion.width -20
st_info.x = newwidth - st_info.width -20
st_info.y = newheight - st_info.height  - 20
st_bruce.y = newheight - st_bruce.height  - 20
st_powertalks.x = (st_myversion.x - p_2.width) /2  +  st_powertalks.width/2     //(newwidth - p_2.width -  st_myversion.width)/2 - st_powertalks.width/2
cbx_auto.y = newheight - cbx_auto.height  - 200

end event

event activate;if isvalid(w_datastore) then close(w_datastore)
end event

type st_11 from statictext within w_main
integer y = 2056
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "11"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type cb_stamp_pdf from commandbutton within w_main
integer x = 101
integer y = 2032
integer width = 585
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Stamp all Pages"
end type

event clicked;//Con el ejemplo Adpage vamos a separar un Documento PDF en multiples PDF de una página.
PDFpage lpdf_page
PDFImage lpdf_image 
PDFdocument lpdf_doc
String ls_pdfpathname, ls_pdf, ls_ImagePathName, ls_Image
long ll_pagecount, ll_page


//Creamos el Objetos
lpdf_doc = CREATE PDFdocument

IF GetFileOpenName ("Archivo PDF", ls_pdfpathname, ls_pdf, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el Primer PDF Seleccionado
lpdf_doc.ImportPdf(ls_pdfpathname)

ll_pagecount = lpdf_doc.GetPageCount()

//Mostramos el PDF en Pantalla.
wb_1.Navigate (ls_pdfpathname)

//bmp, j2k, jp2, jpeg, jpf, jpg, jpx, png, svg, tif, and tiff. 
IF GetFileOpenName ("Imagen", ls_ImagePathName, ls_Image, "PNG", "PNG Files (*.png),*.png") < 1 THEN Return


FOR ll_page = 1 to ll_pagecount
	lpdf_image = CREATE PDFImage
	//Obtenemos la primera página
	lpdf_page = lpdf_doc.GetPage(ll_page)
	
	//Creamos la Imagen en el Objeto PdfImage
	lpdf_image.FileName = ls_ImagePathName
	lpdf_image.x=150
	lpdf_image.y=700
	lpdf_image.height=250
	lpdf_image.width=250
	//lpdf_image.FitMethod = PDFImageFitmethod_Clip!  //Ajustar la imagen con recorte.
	//lpdf_image.FitMethod = PDFImageFitmethod_Entire!  //Ajustar la imagen sin recorte.
	lpdf_image.FitMethod = PDFImageFitmethod_Meet!  //Ajustar la imagen con cambio de tamaño proporcional.
	
	
	//Añadimos la Imagen Creada al Objeto PdfPage
	lpdf_page.AddContent(lpdf_image)
		
	//Importamos la Pagina con la Imagen al Objeto PDFDocument
	lpdf_doc.AddPage(lpdf_page)
destroy lpdf_image
next
	
//Guardamos y Visualizamos.	
wf_save_and_display_pdf(lpdf_doc) 



end event

type pb_show_datastore from picturebutton within w_main
integer x = 91
integer y = 488
integer width = 114
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Find1!"
alignment htextalign = right!
string powertiptext = "Sow Datastore"
end type

event clicked;Open(w_datastore)
end event

type st_10 from statictext within w_main
integer y = 1896
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "10"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type st_9 from statictext within w_main
integer y = 1724
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "9"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type st_8 from statictext within w_main
integer y = 1544
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "8"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type st_7 from statictext within w_main
integer y = 1368
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "7"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type st_6 from statictext within w_main
integer y = 1208
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "6"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type st_5 from statictext within w_main
integer y = 1028
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "5"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type st_4 from statictext within w_main
integer y = 860
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "4"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type st_3 from statictext within w_main
integer y = 700
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "3"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer y = 508
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "2"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer y = 340
integer width = 82
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "1"
alignment alignment = right!
long bordercolor = 128
boolean focusrectangle = false
end type

type cb_docs from commandbutton within w_main
integer x = 512
integer y = 1692
integer width = 178
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Docs"
end type

event clicked;String ls_ItemList, ls_ImagePath
String ls_docs[]
long ll_pos
Integer li_image, li_TotalImages
PDFdocument lpdf_doc
PDFpage lpdf_page
PDFImage lpdf_image 

Open(w_docs)

ls_ItemList = Message.StringParm	

//Cargo la Lista de Documentos en una Array
ll_pos = pos(ls_ItemList, ",")
 do while ll_pos > 0
	ls_docs[UpperBound(ls_docs) + 1] = left(ls_ItemList, ll_pos - 1)
	ls_ItemList = right(ls_ItemList, len(ls_ItemList) + 1 - (ll_pos + len(",")))
	ll_pos = pos(ls_ItemList, ",")
loop
if len(ls_ItemList) > 0 then ls_docs[UpperBound(ls_docs) + 1] = ls_ItemList
 
li_TotalImages = UpperBound(ls_docs)

If li_TotalImages = 0 Then Return 

//Creamos Objetos
lpdf_page = Create PDFpage
lpdf_doc = Create PDFdocument

//Agregamos Cada Imagen al PDF	
For li_image = 1 To li_TotalImages	
	
	ls_ImagePath = ls_docs[li_image]
	
	//Creamos la Imagen en el Objeto PdfImage
	lpdf_image = Create PDFImage
	lpdf_image.FileName = ls_ImagePath
	
	//Determinamos las Propiedades del Objeto PDFImage
	lpdf_image.x=30
	//En función del nº de Imagen Recibida ajustamos su Cordenada Y
	If li_image = 1 Then
		lpdf_image.y=30
	Else
		lpdf_image.y=30 + (200 * (li_image -1))
	End If	
	lpdf_image.height=200
	lpdf_image.width=540
	lpdf_image.FitMethod = PDFImageFitmethod_Meet!  //Ajuste de Imagen Proporcional al Cambio de Tamaño.
		
	//Añadimos la Imagen Creada al Objeto PdfPage
	lpdf_page.AddContent(lpdf_image)
	Destroy lpdf_image	
Next

//Importamos la Página con la Imagen al Objeto PDFDocument en la primera poición
lpdf_doc.InsertPage(lpdf_page, 1)	

//Guardamos y Visualizamos.	
wf_save_and_display_pdf(lpdf_doc) 
	







end event

type cb_add_image from commandbutton within w_main
integer x = 101
integer y = 1692
integer width = 411
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Add Image"
end type

event clicked;//Con el ejemplo Adpage vamos a separar un Documento PDF en multiples PDF de una página.
PDFpage lpdf_page
PDFImage lpdf_image 
PDFdocument lpdf_doc
String ls_pdfpathname, ls_pdf, ls_ImagePathName, ls_Image


//Creamos el Objetos
lpdf_image = CREATE PDFImage
lpdf_doc = CREATE PDFdocument

IF GetFileOpenName ("Archivo PDF", ls_pdfpathname, ls_pdf, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el Primer PDF Seleccionado
lpdf_doc.ImportPdf(ls_pdfpathname)

//Mostramos el PDF en Pantalla.
wb_1.Navigate (ls_pdfpathname)

//bmp, j2k, jp2, jpeg, jpf, jpg, jpx, png, svg, tif, and tiff. 
IF GetFileOpenName ("Imagen", ls_ImagePathName, ls_Image, "PNG", "PNG Files (*.png),*.png") < 1 THEN Return

//Obtenemos la primera página
lpdf_page = lpdf_doc.GetPage(1)

//Creamos la Imagen en el Objeto PdfImage
lpdf_image.FileName = ls_ImagePathName
lpdf_image.x=330
lpdf_image.y=10
lpdf_image.height=100
lpdf_image.width=100
//lpdf_image.FitMethod = PDFImageFitmethod_Clip!  //Ajustar la imagen con recorte.
//lpdf_image.FitMethod = PDFImageFitmethod_Entire!  //Ajustar la imagen sin recorte.
lpdf_image.FitMethod = PDFImageFitmethod_Meet!  //Ajustar la imagen con cambio de tamaño proporcional.


//Añadimos la Imagen Creada al Objeto PdfPage
lpdf_page.AddContent(lpdf_image)
	
//Importamos la Pagina con la Imagen al Objeto PDFDocument
lpdf_doc.InsertPage(lpdf_page, 1)
	
//Guardamos y Visualizamos.	
wf_save_and_display_pdf(lpdf_doc) 



end event

type cbx_auto from checkbox within w_main
integer x = 73
integer y = 2468
integer width = 608
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Auto-Save: Test.pdf"
boolean checked = true
end type

type st_bruce from statictext within w_main
integer x = 9
integer y = 2604
integer width = 1582
integer height = 52
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 553648127
string text = "From Bruce Armstrong Presentation: What~'s New in PowerBuilder 2022 R2 - Part 1"
boolean focusrectangle = false
end type

type st_powertalks from statictext within w_main
integer x = 1861
integer y = 32
integer width = 1257
integer height = 168
integer textsize = -28
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "ITC Avant Garde Std Bk Cn"
long textcolor = 16777215
long backcolor = 33520896
string text = "PowerTalks 2024"
boolean focusrectangle = false
end type

type st_platform from statictext within w_main
integer x = 3813
integer y = 156
integer width = 379
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
integer x = 3813
integer y = 68
integer width = 379
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
integer x = 14
integer y = 8
integer width = 1253
integer height = 248
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type st_info from statictext within w_main
integer x = 2971
integer y = 2588
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

type cb_settings from commandbutton within w_main
integer x = 101
integer y = 1868
integer width = 585
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Settings..."
end type

event clicked;PDFDocument lpdf_doc
String ls_PathName, ls_FileName

//Creamos el Objeto PDFDocument
lpdf_doc = CREATE PDFDocument

IF GetFileOpenName ("PDF File", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el Primer PDF Seleccionado
lpdf_doc.ImportPdf(ls_PathName)

//Copiamos las propiedades del documento.
lpdf_doc.ImportPdfdocinformation(ls_PathName, PDFDocInfo_All!)

//PDFDocInfo_All! --> Importa tanto las propiedades del documento como la configuración de seguridad.

//PDFDocInfo_Properties! --> Sólo importa las propiedades del documento.

//PDFDocInfo_Security! --> Sólo importa la configuración de seguridad del documento.


//Abrimos ventana con las Propiedades del Documento
OpenWithParm (w_settings, lpdf_doc) 

//Recuperamos Nuveas Propiedades
lpdf_doc = message.PowerObjectParm

//Guardamos y Visualizamos.
wf_save_and_display_pdf (lpdf_doc)
end event

type cb_add_page from commandbutton within w_main
integer x = 101
integer y = 1524
integer width = 585
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Add Page"
end type

event clicked;PDFDocument 	lpdf_doc1, lpdf_doc2
PDFPage lpdf_pdfpage1, lpdf_pdfpage2
String ls_PathName, ls_FileName
Integer li_rc

//Creamos el Objeto PDFDocument
lpdf_doc1 = CREATE PDFDocument

IF GetFileOpenName ("Primer Archivo PDF", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el Primer PDF Seleccionado
lpdf_doc1.ImportPdf(ls_PathName)

//Creamos un Seguno Objeto PDFDocument Con el PDF del que queremos capturar su página.
lpdf_doc2 = CREATE PDFDocument

IF GetFileOpenName ("Segundo Archivo PDF", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el Segundo PDF Seleccionado
lpdf_doc2.ImportPdf(ls_PathName)

//Con el Objeto PdfPage Referenciamos la Página 1
lpdf_pdfpage2 = lpdf_doc2.GetPage(1)

//Clonamos el Objeto PdfPage 
lpdf_pdfpage1 = lpdf_pdfpage2.Clone()

//Añadimos la página Clonada al Primer Documeto abierto.
li_rc = lpdf_doc1.AddPage(lpdf_pdfpage1)

////Insertar la página Clonada en 2ª posición
//li_rc = lpdf_doc1.InsertPage(lpdf_pdfpage1, 2)

wf_save_and_display_pdf (lpdf_doc1)


////SPLIT PDF
//// 1 - Con el ejemplo Adpage vamos a separar un Documento PDF en multiples PDF de una página.
//PDFDocument lpdf_doc1, lpdf_doc2
//PDFPage	lpdf_page1, lpdf_page2
//String ls_PathName, ls_FileName, ls_outputFile
//long ll_page, ll_pageCount
//Integer li_rc
//Boolean lb_result=TRUE
//
////Creamos el Objeto PDFDocument
//lpdf_doc1 = CREATE PDFDocument
//
//IF GetFileOpenName ("Archivo PDF", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return
//
////Importamos el Primer PDF Seleccionado
//lpdf_doc1.ImportPdf(ls_PathName)
//
////Guardamos y Mostramos el PDF de Orgien.
//wf_save_and_display_pdf (lpdf_doc1)
//
////Obtenemos el nº de Páginas.
//ll_pageCount = lpdf_doc1.GetPageCount()
//
////Recorremos todas la páginas del PDF
//FOR ll_page = 1 TO ll_pageCount
//	
//	//Por Cada Página Creamos un Nuevo Documento
//	lpdf_doc2 = CREATE PDFDocument
//	
//	//Obtenemos la Página del Contador de Primer Documento
//	lpdf_page1 = lpdf_doc1.GetPage(ll_page)
//	
//	//Clonamos la Página en Un nuevo Objeto PDFPage
//	lpdf_page2 = lpdf_page1.Clone()
//	
//	//Insertamos la Página en un Segundo Documento
//	li_rc = lpdf_doc2.AddPage(lpdf_page2)
//		
//	IF li_rc = 1 THEN
//		ls_outputFile= "test_"+string(ll_page)+".pdf"
//		//Guardamos El Documento.
//		lpdf_doc2.Save(ls_outputFile)
//		Destroy lpdf_doc2
//	ELSE
//		lb_result =FALSE
//		EXIT
//	END IF
//NEXT	
//
//IF lb_result THEN
//	Messagebox("Result", string(ll_pageCount)+" PDF documents have been created.")
//ELSE
//	Messagebox("Error", "Split Error", Exclamation!)
//END IF	
//
//
end event

type cb_compress from commandbutton within w_main
integer x = 101
integer y = 1352
integer width = 389
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Compress"
end type

event clicked;PDFDocument 	lpdf_doc
String ls_PathName, ls_FileName
Long	ll_Compression

//Creamos el Objeto PDFDocument
lpdf_doc = CREATE PDFDocument

IF GetFileOpenName ("Archivo PDF", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el Primer PDF Seleccionado
lpdf_doc.ImportPdf(ls_PathName)

//Establecemos el Nivel de Compresión
//Hay 10 niveles de compresión, del 0 al 9, desde ninguna compresión hasta la compresión más alta.
//6 es el valor predeterminado.
ll_Compression = Integer(ddlb_compression.Text)
lpdf_doc.CompressionLevel = ll_Compression

//Guardamos y Visualizamos.
wf_save_and_display_pdf (lpdf_doc)
end event

type ddlb_compression from dropdownlistbox within w_main
integer x = 503
integer y = 1360
integer width = 169
integer height = 776
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
long textcolor = 33554432
boolean allowedit = true
boolean vscrollbar = true
string item[] = {"0","1","2","3","4","5","6","7","8","9"}
borderstyle borderstyle = stylelowered!
end type

type cb_attach_file from commandbutton within w_main
integer x = 101
integer y = 1180
integer width = 585
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Attach File"
end type

event clicked;PDFDocument lpdf_doc
String ls_PathName, ls_FileName

//Creamos el Objeto PDFDocument
lpdf_doc = CREATE PDFDocument

IF GetFileOpenName ("Archivo PDF", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el Primer PDF Seleccionado
lpdf_doc.ImportPdf(ls_PathName)

IF GetFileOpenName ("Archivo a Adjuntar", ls_PathName, ls_FileName, "", "All Files (*.*),*.*") < 1 THEN Return

//Adjuntamos el Archivo Seleccionado
lpdf_doc.Attachment.AddFile(ls_PathName)

//Guardamos y Visualizamos.
wf_save_and_display_pdf (lpdf_doc)
end event

type cb_set_watermark_text from commandbutton within w_main
integer x = 101
integer y = 1012
integer width = 585
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Watermark Text"
end type

event clicked;PDFDocument lpdf_doc
String ls_PathName, ls_FileName

//Creamos el Objeto PDFDocument
lpdf_doc = CREATE PDFDocument

IF GetFileOpenName ("Archivo PDF", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el Primer PDF Seleccionado
lpdf_doc.ImportPdf(ls_PathName)

//Añadimos el Texto como Marca de Agua y Fijamos sus propiedades. 
lpdf_doc.Watermark.Text.Content = "COPIA"
lpdf_doc.Watermark.Text.Font.FontName="Arial"
lpdf_doc.Watermark.Text.Font.FontSize = 48
lpdf_doc.Watermark.Text.Font.Bold = True
lpdf_doc.Watermark.Text.TextColor.RGB = rgb(166,202,240)

//Otras Propiedades de la Marca de Agua 
lpdf_doc.Watermark.Transparency = 50
lpdf_doc.Watermark.Rotate = 30

//Guardamos y Visualizamos.
wf_save_and_display_pdf (lpdf_doc)


//Notación Por Objetos 

//PDFDocument lpdf_doc
//PDFFont lpdf_font
//PDFColor lpdf_color
//PDFWatermark lpdf_wm
//String ls_PathName, ls_FileName
//
////Creamos el Objeto PDFDocument
//lpdf_doc = CREATE PDFDocument
//
//IF GetFileOpenName ("Archivo PDF", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return
//
////Importamos el Primer PDF Seleccionado
//lpdf_doc.ImportPdf(ls_PathName)
//
// lpdf_wm = CREATE PDFWatermark
//
////Añadimos el Texto como Marca de Agua y Fijamos sus propiedades. 
//lpdf_wm.Text.Content = "PowerTalks 2024"
//
////Creamos Objeto para Manjejar Propiedades de la Marca de Agua
//
////Establecemos la pripiedades de Tipo de Letra
//lpdf_font = CREATE PDFFont
//lpdf_font.FontName="Arial"
//lpdf_font.FontSize = 36
//lpdf_font.Bold = True
//
////Establecemos el Color, dos Formas Alternativas:
//lpdf_color = CREATE PDFColor
//lpdf_color.rgb = rgb(166,202,240)
//
////Ponemos las propiedades de Color y la Fuente en la Marca de Agua
//lpdf_wm.Text.TextColor= lpdf_color
//lpdf_wm.Text.Font= lpdf_font
//
////Otras Propiedades de la Marca de Agua 
//lpdf_wm.transparency = 50
//lpdf_wm.rotate = 30
//
////Asignamos la Marca de Agua al objeto PdfDocument
//lpdf_doc.WaterMark = lpdf_wm
//
////Guardamos y Visualizamos.
//wf_save_and_display_pdf (lpdf_doc)
end event

type cb_set_watermark_image from commandbutton within w_main
integer x = 101
integer y = 836
integer width = 585
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Watermark Image"
end type

event clicked;PDFDocument lpdf_doc
String ls_PdfPathName, ls_pdf, ls_image, ls_ImagePathName

//Creamos el Objeto PDFDocument
lpdf_doc = CREATE PDFDocument

//Abrimos un PDF
IF GetFileOpenName ("Archivo PDF", ls_PdfPathName, ls_pdf, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Lo mostramos en pantalla
wb_1.Navigate (ls_PdfPathName)

//Importamos el Primer PDF Seleccionado
lpdf_doc.ImportPdf(ls_PdfPathName)

//Abrimos la Imagen
IF GetFileOpenName ("Abrir Imagen", ls_ImagePathName, ls_image, "PNG", "PNG Files (*.png),*.png") < 1 THEN Return

//Añadimos la Imagen como Marca de Agua y Fijamos sus propiedades. 
lpdf_doc.Watermark.Image.FileName = ls_ImagePathName
lpdf_doc.Watermark.Transparency = 50
lpdf_doc.Watermark.Scale = 25
lpdf_doc.Watermark.Rotate = 45

//Guardamos y Visualizamos.
wf_save_and_display_pdf (lpdf_doc)
end event

type cb_merge_pdf from commandbutton within w_main
integer x = 101
integer y = 668
integer width = 585
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Merge PDF"
end type

event clicked;PDFDocument lpdf_doc
String ls_PathName, ls_FileName

//Creamos el Objeto PDFDocument
lpdf_doc = CREATE PDFDocument

IF GetFileOpenName ("Primer Archivo PDF", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el Primer PDF Seleccionado
lpdf_doc.ImportPdf(ls_PathName)

IF GetFileOpenName ("Segundo Archivo PDF", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el Segundo PDF Seleccionado
lpdf_doc.ImportPdf (ls_PathName)

//Guardamos y Visualizamos.
wf_save_and_display_pdf(lpdf_doc)
end event

type cb_import_datastore from commandbutton within w_main
integer x = 206
integer y = 488
integer width = 480
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Import DataStore"
end type

event clicked;PDFDocument lpdf_doc
DataStore l_ds

//Creamos Un Datastore
l_ds = CREATE Datastore
l_ds.DataObject = "d_grafico_2valores"

//Importamos un Archivo CSV para alimentar el DataStore
l_ds.ImportFile(CSV!, "d_grafico_2valores.csv")

//Creamos el Objeto PDFDocument e importamos el DataStore
lpdf_doc = CREATE PDFDocument
lpdf_doc.ImportDatawindow(l_ds)

//Guardamos y Visualizamos.
wf_save_and_display_pdf (lpdf_doc)


end event

type cb_import_pdf from commandbutton within w_main
integer x = 101
integer y = 312
integer width = 585
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Hyperlink!"
string text = "Import PDF"
end type

event clicked;PDFDocument lpdf_doc
String ls_PathName, ls_FileName

//Creamos el Objeto PDFDocument
lpdf_doc = CREATE PDFDocument

IF GetFileOpenName ("Archivo PDF a Importar", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return

//Importamos el PDF Seleccionado
lpdf_doc.ImportPdf(ls_PathName)

//Guardamos y Visualizamos.
wf_save_and_display_pdf(lpdf_doc)


////SPLIT PDF
//// Con el ejemplo ImportPdf vamos a separar un Documento PDF en multiples PDF de una página.
//
//String ls_PathName, ls_FileName, ls_outputfile
//Long ll_rtn
//long ll_page, ll_pageCount
//PDFDocument lpdf_doc
//Boolean lb_result=TRUE
//
////Creamos el Objeto PDFDocument
//lpdf_doc = CREATE PDFDocument
//
//IF GetFileOpenName ("Archivo PDF a Importar", ls_PathName, ls_FileName, "PDF", "PDF Files (*.pdf),*.pdf") < 1 THEN Return
//
////Importamos el PDF Seleccionado
//lpdf_doc.ImportPdf(ls_PathName)
//
////Guardamos y Mostramos el PDF de Orgien.
//wf_save_and_display_pdf(lpdf_doc)
//
////Obtenemos el nº de Páginas.
//ll_pageCount = lpdf_doc.GetPageCount()
//
////Destruimos el Objeto Creado
//DESTROY lpdf_doc
//
//FOR ll_page = 1 TO ll_pageCount
//	//Por Cada Página Creamos un Nuevo Documento
//	lpdf_doc =  CREATE PDFDocument
//	
//	//Importamos la página en la Posción 1.
//	ll_rtn = lpdf_doc.ImportPdf(ls_PathName, ll_page, ll_page, 1)
//	
//	IF ll_rtn = 1 THEN
//		ls_outputFile= "test_"+string(ll_page)+".pdf"
//		//Guardamos El Documento.
//		ll_rtn = lpdf_doc.Save(ls_outputFile)
//		DESTROY lpdf_doc
//	ELSE
//		lb_result =FALSE
//		EXIT
//	END IF
//NEXT	
//
//IF lb_result THEN
//	Messagebox("Result", string(ll_pageCount)+" PDF documents have been created.")
//ELSE
//	Messagebox("Error", "Split Error", Exclamation!)
//END IF	
//
//
//
end event

type wb_1 from webbrowser within w_main
integer x = 741
integer y = 276
integer width = 3515
integer height = 2288
end type

type r_2 from rectangle within w_main
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 33521664
integer y = 4
integer width = 4352
integer height = 260
end type

type cb_create_fillable_form from commandbutton within w_main
boolean visible = false
integer x = 59
integer y = 1856
integer width = 635
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Hyperlink!"
string text = "Create Fillable Form"
end type

event clicked;PDFdocument lpdf_doc
PDFpage lpdf_page
PDFtext lpdf_sle
PDFMultilineText lpdf_mle
//PDFRichText lpdf_rte

lpdf_doc = CREATE PDFdocument
lpdf_page = CREATE PDFpage
lpdf_sle = CREATE PDFtext
lpdf_mle = CREATE PDFMultilineText
//lpdf_rte = CREATE PDFRichText

lpdf_sle.content = "Nombre"
lpdf_sle.textcolor.rgb = rgb(255,0,0)
lpdf_sle.x = 100
lpdf_sle.y = 100
lpdf_sle.name = "Nombre"

lpdf_mle.content = "Apellidos"
lpdf_mle.textcolor.rgb = rgb (0,0,0)
lpdf_mle.x = 100
lpdf_mle.y = 200
lpdf_mle.name = "Apellidos"
lpdf_mle.setsize(200, 200)

lpdf_page.addcontent(lpdf_sle)
lpdf_page.addcontent(lpdf_mle)
//lpdf_page.addcontent(lpdf_rte)

lpdf_doc.addpage(lpdf_page)

lpdf_doc.security.allowforms = true
lpdf_doc.security.allowmodify = true

//Guardamos y Visualizamos.
wf_save_and_display_pdf (lpdf_doc)
end event

