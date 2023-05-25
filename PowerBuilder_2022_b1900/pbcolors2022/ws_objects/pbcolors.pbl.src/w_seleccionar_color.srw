$PBExportHeader$w_seleccionar_color.srw
forward
global type w_seleccionar_color from w_popup
end type
type st_5 from statictext within w_seleccionar_color
end type
type r_2 from rectangle within w_seleccionar_color
end type
type st_platform from statictext within w_seleccionar_color
end type
type st_myversion from statictext within w_seleccionar_color
end type
type p_2 from picture within w_seleccionar_color
end type
type st_html from vs_st_master within w_seleccionar_color
end type
type em_html from vuo_em_string within w_seleccionar_color
end type
type cb_1 from vuo_cb_cancelar within w_seleccionar_color
end type
type cb_aceptar from vuo_cb_aceptar within w_seleccionar_color
end type
type st_custom9 from vuo_st_color within w_seleccionar_color
end type
type st_custom10 from vuo_st_color within w_seleccionar_color
end type
type em_color from vuo_em_number within w_seleccionar_color
end type
type st_custom1 from vuo_st_color within w_seleccionar_color
end type
type st_custom2 from vuo_st_color within w_seleccionar_color
end type
type st_custom3 from vuo_st_color within w_seleccionar_color
end type
type st_custom4 from vuo_st_color within w_seleccionar_color
end type
type st_custom5 from vuo_st_color within w_seleccionar_color
end type
type st_custom6 from vuo_st_color within w_seleccionar_color
end type
type st_custom7 from vuo_st_color within w_seleccionar_color
end type
type st_custom8 from vuo_st_color within w_seleccionar_color
end type
type st_green from vuo_st_color within w_seleccionar_color
end type
type st_olive from vuo_st_color within w_seleccionar_color
end type
type st_navy from vuo_st_color within w_seleccionar_color
end type
type st_teal from vuo_st_color within w_seleccionar_color
end type
type st_gray from vuo_st_color within w_seleccionar_color
end type
type st_silver from vuo_st_color within w_seleccionar_color
end type
type st_mint from vuo_st_color within w_seleccionar_color
end type
type st_sky from vuo_st_color within w_seleccionar_color
end type
type st_cream from vuo_st_color within w_seleccionar_color
end type
type st_medium_gray from vuo_st_color within w_seleccionar_color
end type
type st_purple from vuo_st_color within w_seleccionar_color
end type
type st_blue from vuo_st_color within w_seleccionar_color
end type
type st_aqua from vuo_st_color within w_seleccionar_color
end type
type st_maroon from vuo_st_color within w_seleccionar_color
end type
type st_fuchsia from vuo_st_color within w_seleccionar_color
end type
type st_lime from vuo_st_color within w_seleccionar_color
end type
type st_yellow from vuo_st_color within w_seleccionar_color
end type
type st_red from vuo_st_color within w_seleccionar_color
end type
type st_white from vuo_st_color within w_seleccionar_color
end type
type st_black from vuo_st_color within w_seleccionar_color
end type
type r_colores from rectangle within w_seleccionar_color
end type
type st_ejemplo from vs_st_master within w_seleccionar_color
end type
type st_rojo from vs_st_master within w_seleccionar_color
end type
type st_verde from vs_st_master within w_seleccionar_color
end type
type st_color from vs_st_master within w_seleccionar_color
end type
type htb_rojo from vuo_htb_color within w_seleccionar_color
end type
type htb_verde from vuo_htb_color within w_seleccionar_color
end type
type htb_azul from vuo_htb_color within w_seleccionar_color
end type
type em_azul from vuo_em_rgb_number within w_seleccionar_color
end type
type em_verde from vuo_em_rgb_number within w_seleccionar_color
end type
type r_ejemplo from rectangle within w_seleccionar_color
end type
type em_rojo from vuo_em_rgb_number within w_seleccionar_color
end type
type st_azul from vs_st_master within w_seleccionar_color
end type
end forward

global type w_seleccionar_color from w_popup
integer width = 2240
integer height = 1692
string title = "Seleccionar Color"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = main!
long backcolor = 1073741824
st_5 st_5
r_2 r_2
st_platform st_platform
st_myversion st_myversion
p_2 p_2
st_html st_html
em_html em_html
cb_1 cb_1
cb_aceptar cb_aceptar
st_custom9 st_custom9
st_custom10 st_custom10
em_color em_color
st_custom1 st_custom1
st_custom2 st_custom2
st_custom3 st_custom3
st_custom4 st_custom4
st_custom5 st_custom5
st_custom6 st_custom6
st_custom7 st_custom7
st_custom8 st_custom8
st_green st_green
st_olive st_olive
st_navy st_navy
st_teal st_teal
st_gray st_gray
st_silver st_silver
st_mint st_mint
st_sky st_sky
st_cream st_cream
st_medium_gray st_medium_gray
st_purple st_purple
st_blue st_blue
st_aqua st_aqua
st_maroon st_maroon
st_fuchsia st_fuchsia
st_lime st_lime
st_yellow st_yellow
st_red st_red
st_white st_white
st_black st_black
r_colores r_colores
st_ejemplo st_ejemplo
st_rojo st_rojo
st_verde st_verde
st_color st_color
htb_rojo htb_rojo
htb_verde htb_verde
htb_azul htb_azul
em_azul em_azul
em_verde em_verde
r_ejemplo r_ejemplo
em_rojo em_rojo
st_azul st_azul
end type
global w_seleccionar_color w_seleccionar_color

forward prototypes
private function long wf_hex_to_long (string as_hex)
private function long wf_rgb_to_long (integer r, integer g, integer b)
private function string wf_long_to_hex (long al_number, integer ai_digit)
public subroutine wf_setcolor (integer r, integer g, integer b)
private function str_rgb wf_long_to_rgb (long al_color)
private function string wf_rgb_to_hex (integer r, integer g, integer b)
public subroutine wf_version (statictext ast_version, statictext ast_patform)
end prototypes

private function long wf_hex_to_long (string as_hex);/*						FUNCTION = fn_Hex2Long  ---------> wf_hex_to_long

  Author:		 		Chris Pollach	- November, 2004

  Description:		This Function can executed from anywhere in the application as required.
						  
  Arguments:		String			Hexadecimal value
  Returns:			Long			Number

  Behavior:			This code will attempt to convert an hexadecimal value in a String 
  						format to a Long number.

  Note: 				None

==================================  Notice   ======================================
	This routine is a port of the Foundation Class code originally written by
	Chris Pollach for "PowerBuilder®". The code has been adapted for use
	in Appeon.
==================================  Revisions  =====================================

1.0   Initial version																			-	November, 2004
2.0   Renamed																				-  27-10-2019
*/

String 	ls_hex																			// Work Var
Integer 	li_loop,li_length																	// Loop var.
Long 		ll_result = 0																		// Return Work Var

li_length 		= len(as_hex)																// Get input length
ls_hex 		= Upper(as_hex)															// Convert to Upper Case

FOR li_loop = 1 to li_length																// Loop thru input
   ll_result += ( Pos ( '123456789ABCDEF', mid ( ls_hex, li_loop, 1 ) ) * &
						( 16 ^  ( li_length - li_loop ) ) )										// Convert 2 No
NEXT																							// Continue loop

RETURN ll_result																			// Return 2 caller
end function

private function long wf_rgb_to_long (integer r, integer g, integer b);Long ll_color

ll_color = rgb(R,G,B) //R + (256 * G) + (65536 * B)

RETURN ll_color
end function

private function string wf_long_to_hex (long al_number, integer ai_digit);/*						FUNCTION = fn_long2hex -------------------------------->wf_long_to_hex

  Author:		 		Chris Pollach
  Date:				November, 2004

  Description:		This Function executed from the EAS Famework Menus.
						  
  Arguments:		String		Hexadecimal value
  Returns:			Long			Number

  Behavior:			This code will attempt to convert a long numeric value into a 
  						Hexadecimal string

  Note: 				None

==================================  Notice   ======================================
	This routine is a port of the Foundation Class code originally written by
	Chris Pollach for "PowerBuilder®". The code has been adapted for use
	in Appeon.
==================================  Revisions  =====================================

1.0   Initial version																				-	November, 2004
2.0   Renamed																			     	-  27-10-2019
*/

long ll_temp0, ll_temp1																		// Work Var
char lc_ret																						// Work var

IF ai_digit > 0 THEN																			// Valid No?
   ll_temp0 = abs(al_number / (16 ^ (ai_digit - 1 ) ) )	 								// YES=>Get 1st No
   ll_temp1 = ll_temp0 * (16 ^ (ai_digit - 1 ) )											// Get 2nd No
   IF ll_temp0 > 9 THEN																			// > single digit?
      lc_ret = char ( ll_temp0 + 55 )																// YES=>Add offset
   ELSE
      lc_ret = char ( ll_temp0 + 48 )																// No=>Add offset
   END IF
   RETURN lc_ret + wf_long_to_hex( al_number - ll_temp1 , ai_digit - 1)				// Return Hex String
else
	RETURN ""																						// NO=>Return "empty"
END IF

end function

public subroutine wf_setcolor (integer r, integer g, integer b);
em_rojo.text=string(R)
em_verde.text=string(G)
em_azul.text=string(B)

htb_rojo.position = R
htb_verde.position = G
htb_azul.position = B

r_ejemplo.fillcolor = rgb(R, G, B)
st_ejemplo.backcolor = r_ejemplo.fillcolor

em_color.text = string(wf_rgb_to_long(R,G,B))

em_html.text=wf_rgb_to_hex(R,G,B)


st_color.textcolor=RGB(R,G,B)
st_html.textcolor=RGB(R,G,B)

IF  R< 50 AND G < 50 AND B < 50 THEN
	st_ejemplo.textcolor=167772015
ELSE
	st_ejemplo.textcolor=0
END IF	
end subroutine

private function str_rgb wf_long_to_rgb (long al_color);Str_rgb lstr_rgb

Long  ll_rgb

ll_rgb=rgb(0,1,0)

lstr_rgb.R = Mod(al_color, ll_rgb)
al_color = al_color / ll_rgb

lstr_rgb.G = Mod(al_color, ll_rgb)
al_color = al_color / ll_rgb

lstr_rgb.B = Mod(al_color, ll_rgb)

RETURN lstr_rgb
end function

private function string wf_rgb_to_hex (integer r, integer g, integer b);String ls_r, ls_g, ls_b

ls_r=wf_long_to_hex(R, 2)
ls_g=wf_long_to_hex(G, 2)
ls_b=wf_long_to_hex(B, 2)
	
if isnull(ls_r) THEN ls_r="" 	
if isnull(ls_g) THEN ls_g="" 	
if isnull(ls_b) THEN ls_b="" 	

RETURN "#"+ ls_r + ls_g + ls_b
end function

public subroutine wf_version (statictext ast_version, statictext ast_patform);String ls_version, ls_platform
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

ast_version.text=ls_version
ast_patform.text=ls_platform

end subroutine

on w_seleccionar_color.create
int iCurrent
call super::create
this.st_5=create st_5
this.r_2=create r_2
this.st_platform=create st_platform
this.st_myversion=create st_myversion
this.p_2=create p_2
this.st_html=create st_html
this.em_html=create em_html
this.cb_1=create cb_1
this.cb_aceptar=create cb_aceptar
this.st_custom9=create st_custom9
this.st_custom10=create st_custom10
this.em_color=create em_color
this.st_custom1=create st_custom1
this.st_custom2=create st_custom2
this.st_custom3=create st_custom3
this.st_custom4=create st_custom4
this.st_custom5=create st_custom5
this.st_custom6=create st_custom6
this.st_custom7=create st_custom7
this.st_custom8=create st_custom8
this.st_green=create st_green
this.st_olive=create st_olive
this.st_navy=create st_navy
this.st_teal=create st_teal
this.st_gray=create st_gray
this.st_silver=create st_silver
this.st_mint=create st_mint
this.st_sky=create st_sky
this.st_cream=create st_cream
this.st_medium_gray=create st_medium_gray
this.st_purple=create st_purple
this.st_blue=create st_blue
this.st_aqua=create st_aqua
this.st_maroon=create st_maroon
this.st_fuchsia=create st_fuchsia
this.st_lime=create st_lime
this.st_yellow=create st_yellow
this.st_red=create st_red
this.st_white=create st_white
this.st_black=create st_black
this.r_colores=create r_colores
this.st_ejemplo=create st_ejemplo
this.st_rojo=create st_rojo
this.st_verde=create st_verde
this.st_color=create st_color
this.htb_rojo=create htb_rojo
this.htb_verde=create htb_verde
this.htb_azul=create htb_azul
this.em_azul=create em_azul
this.em_verde=create em_verde
this.r_ejemplo=create r_ejemplo
this.em_rojo=create em_rojo
this.st_azul=create st_azul
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.r_2
this.Control[iCurrent+3]=this.st_platform
this.Control[iCurrent+4]=this.st_myversion
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.st_html
this.Control[iCurrent+7]=this.em_html
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_aceptar
this.Control[iCurrent+10]=this.st_custom9
this.Control[iCurrent+11]=this.st_custom10
this.Control[iCurrent+12]=this.em_color
this.Control[iCurrent+13]=this.st_custom1
this.Control[iCurrent+14]=this.st_custom2
this.Control[iCurrent+15]=this.st_custom3
this.Control[iCurrent+16]=this.st_custom4
this.Control[iCurrent+17]=this.st_custom5
this.Control[iCurrent+18]=this.st_custom6
this.Control[iCurrent+19]=this.st_custom7
this.Control[iCurrent+20]=this.st_custom8
this.Control[iCurrent+21]=this.st_green
this.Control[iCurrent+22]=this.st_olive
this.Control[iCurrent+23]=this.st_navy
this.Control[iCurrent+24]=this.st_teal
this.Control[iCurrent+25]=this.st_gray
this.Control[iCurrent+26]=this.st_silver
this.Control[iCurrent+27]=this.st_mint
this.Control[iCurrent+28]=this.st_sky
this.Control[iCurrent+29]=this.st_cream
this.Control[iCurrent+30]=this.st_medium_gray
this.Control[iCurrent+31]=this.st_purple
this.Control[iCurrent+32]=this.st_blue
this.Control[iCurrent+33]=this.st_aqua
this.Control[iCurrent+34]=this.st_maroon
this.Control[iCurrent+35]=this.st_fuchsia
this.Control[iCurrent+36]=this.st_lime
this.Control[iCurrent+37]=this.st_yellow
this.Control[iCurrent+38]=this.st_red
this.Control[iCurrent+39]=this.st_white
this.Control[iCurrent+40]=this.st_black
this.Control[iCurrent+41]=this.r_colores
this.Control[iCurrent+42]=this.st_ejemplo
this.Control[iCurrent+43]=this.st_rojo
this.Control[iCurrent+44]=this.st_verde
this.Control[iCurrent+45]=this.st_color
this.Control[iCurrent+46]=this.htb_rojo
this.Control[iCurrent+47]=this.htb_verde
this.Control[iCurrent+48]=this.htb_azul
this.Control[iCurrent+49]=this.em_azul
this.Control[iCurrent+50]=this.em_verde
this.Control[iCurrent+51]=this.r_ejemplo
this.Control[iCurrent+52]=this.em_rojo
this.Control[iCurrent+53]=this.st_azul
end on

on w_seleccionar_color.destroy
call super::destroy
destroy(this.st_5)
destroy(this.r_2)
destroy(this.st_platform)
destroy(this.st_myversion)
destroy(this.p_2)
destroy(this.st_html)
destroy(this.em_html)
destroy(this.cb_1)
destroy(this.cb_aceptar)
destroy(this.st_custom9)
destroy(this.st_custom10)
destroy(this.em_color)
destroy(this.st_custom1)
destroy(this.st_custom2)
destroy(this.st_custom3)
destroy(this.st_custom4)
destroy(this.st_custom5)
destroy(this.st_custom6)
destroy(this.st_custom7)
destroy(this.st_custom8)
destroy(this.st_green)
destroy(this.st_olive)
destroy(this.st_navy)
destroy(this.st_teal)
destroy(this.st_gray)
destroy(this.st_silver)
destroy(this.st_mint)
destroy(this.st_sky)
destroy(this.st_cream)
destroy(this.st_medium_gray)
destroy(this.st_purple)
destroy(this.st_blue)
destroy(this.st_aqua)
destroy(this.st_maroon)
destroy(this.st_fuchsia)
destroy(this.st_lime)
destroy(this.st_yellow)
destroy(this.st_red)
destroy(this.st_white)
destroy(this.st_black)
destroy(this.r_colores)
destroy(this.st_ejemplo)
destroy(this.st_rojo)
destroy(this.st_verde)
destroy(this.st_color)
destroy(this.htb_rojo)
destroy(this.htb_verde)
destroy(this.htb_azul)
destroy(this.em_azul)
destroy(this.em_verde)
destroy(this.r_ejemplo)
destroy(this.em_rojo)
destroy(this.st_azul)
end on

event open;call super::open;wf_version(st_myversion, st_platform)
end event

type st_5 from statictext within w_seleccionar_color
integer x = 933
integer y = 1556
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

type r_2 from rectangle within w_seleccionar_color
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 33521664
integer width = 2501
integer height = 260
end type

type st_platform from statictext within w_seleccionar_color
integer x = 1664
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

type st_myversion from statictext within w_seleccionar_color
integer x = 1664
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

type p_2 from picture within w_seleccionar_color
integer x = 5
integer y = 4
integer width = 1253
integer height = 248
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type st_html from vs_st_master within w_seleccionar_color
integer x = 1509
integer y = 1236
integer width = 197
integer height = 60
boolean bringtotop = true
integer weight = 700
string text = "Html"
alignment alignment = right!
long bordercolor = 1073741824
end type

type em_html from vuo_em_string within w_seleccionar_color
integer x = 1714
integer y = 1220
integer taborder = 70
string text = "#000000"
string minmax = "~~"
end type

event modified;String ls_hex
Integer  li_len
Long ll_color
Str_rgb lstr_rgb

li_len=len(this.text)
ls_hex=this.text

IF li_len <> 7 or left(this.text, 1)<>"#" THEN
	messagebox("Error", "Formato Hexadecimal: #000000 ")
	this.text=wf_rgb_to_hex(integer(em_rojo.text), integer(em_verde.text), integer(em_azul.text))
	RETURN
END IF	

ll_color  = wf_hex_to_long(ls_hex)

lstr_rgb=wf_long_to_rgb(ll_color)

//Hay que hacer una pequeña trampa para que funcione, por lo visto al pasar de hex a long se invierte el rojo por el azul.
//He visto algunas web en que el color long es el contrario (en terminos de RGB) que en powerbuilder.
wf_SetColor(lstr_rgb.B, lstr_rgb.G, lstr_rgb.R)



end event

type cb_1 from vuo_cb_cancelar within w_seleccionar_color
integer x = 1198
integer y = 1372
integer taborder = 60
end type

event clicked;call super::clicked;Close(Parent)


end event

type cb_aceptar from vuo_cb_aceptar within w_seleccionar_color
integer x = 718
integer y = 1372
integer taborder = 50
end type

event clicked;call super::clicked;long ll_Color

ll_Color = wf_rgb_to_long(integer(em_rojo.text), integer(em_verde.text), integer(em_azul.text))
clipboard(string(ll_color))

Close(Parent)

end event

type st_custom9 from vuo_st_color within w_seleccionar_color
integer x = 1394
integer y = 516
long textcolor = 27384063
long backcolor = 27384063
end type

event clicked;wf_SetColor(255, 216, 161)
end event

type st_custom10 from vuo_st_color within w_seleccionar_color
integer x = 1481
integer y = 516
long textcolor = 23255245
long backcolor = 23255245
end type

event clicked;wf_SetColor(205, 216, 98)
end event

type em_color from vuo_em_number within w_seleccionar_color
integer x = 1714
integer y = 1120
integer taborder = 40
string text = "0"
string minmax = "0~~"
end type

event modified;Long ll_color
Str_rgb lstr_rgb

ll_color = long(this.text)
lstr_rgb=wf_long_to_rgb(ll_color)

wf_SetColor(lstr_rgb.R, lstr_rgb.G, lstr_rgb.B)
end event

type st_custom1 from vuo_st_color within w_seleccionar_color
integer x = 677
integer y = 516
long backcolor = 33521664
end type

event clicked;wf_SetColor(0, 128, 255)
end event

type st_custom2 from vuo_st_color within w_seleccionar_color
integer x = 759
integer y = 516
long backcolor = 33088728
end type

event clicked;wf_SetColor(216, 228, 248)
end event

type st_custom3 from vuo_st_color within w_seleccionar_color
integer x = 846
integer y = 516
long backcolor = 31915481
end type

event clicked;wf_SetColor(217, 253, 230)
end event

type st_custom4 from vuo_st_color within w_seleccionar_color
integer x = 937
integer y = 516
long backcolor = 23501568
end type

event clicked;wf_SetColor(0, 155, 102)
end event

type st_custom5 from vuo_st_color within w_seleccionar_color
integer x = 1029
integer y = 516
long textcolor = 23392765
long backcolor = 23392765
end type

event clicked;wf_SetColor(253, 241, 100)
end event

type st_custom6 from vuo_st_color within w_seleccionar_color
integer x = 1120
integer y = 516
long backcolor = 26869759
end type

event clicked;wf_SetColor(255, 255, 153)
end event

type st_custom7 from vuo_st_color within w_seleccionar_color
integer x = 1211
integer y = 516
long backcolor = 18416874
end type

event clicked;wf_SetColor(234, 4, 25)
end event

type st_custom8 from vuo_st_color within w_seleccionar_color
integer x = 1303
integer y = 516
long backcolor = 16802559
end type

event clicked;wf_SetColor(255, 98, 0)
end event

type st_green from vuo_st_color within w_seleccionar_color
integer x = 672
integer y = 440
long backcolor = 32768
end type

event clicked;wf_SetColor(0, 128, 0)
end event

type st_olive from vuo_st_color within w_seleccionar_color
integer x = 759
integer y = 440
long backcolor = 32896
end type

event clicked;wf_SetColor(128, 128, 0)
end event

type st_navy from vuo_st_color within w_seleccionar_color
integer x = 846
integer y = 440
long backcolor = 8388608
end type

event clicked;wf_SetColor(0, 0, 128)
end event

type st_teal from vuo_st_color within w_seleccionar_color
integer x = 937
integer y = 440
long backcolor = 8421376
end type

event clicked;wf_SetColor(0, 128, 128)
end event

type st_gray from vuo_st_color within w_seleccionar_color
integer x = 1029
integer y = 440
long backcolor = 8421504
end type

event clicked;wf_SetColor(128, 128, 128)
end event

type st_silver from vuo_st_color within w_seleccionar_color
integer x = 1120
integer y = 440
long backcolor = 12632256
end type

event clicked;wf_SetColor(192, 192, 192)
end event

type st_mint from vuo_st_color within w_seleccionar_color
integer x = 1211
integer y = 440
long backcolor = 12639424
end type

event clicked;wf_SetColor(192, 220, 192)
end event

type st_sky from vuo_st_color within w_seleccionar_color
integer x = 1303
integer y = 440
long backcolor = 15780518
end type

event clicked;wf_SetColor(166, 202, 240)
end event

type st_cream from vuo_st_color within w_seleccionar_color
integer x = 1394
integer y = 440
long backcolor = 15793151
end type

event clicked;wf_SetColor(255, 251, 240)
end event

type st_medium_gray from vuo_st_color within w_seleccionar_color
integer x = 1481
integer y = 440
long backcolor = 10789024
end type

event clicked;wf_SetColor(160, 160, 164)
end event

type st_purple from vuo_st_color within w_seleccionar_color
integer x = 1481
integer y = 364
long backcolor = 8388736
end type

event clicked;wf_SetColor(128, 0, 128)
end event

type st_blue from vuo_st_color within w_seleccionar_color
integer x = 1211
integer y = 364
long backcolor = 16711680
end type

event clicked;wf_SetColor(0,0,255)
end event

type st_aqua from vuo_st_color within w_seleccionar_color
integer x = 1303
integer y = 364
long backcolor = 16776960
end type

event clicked;wf_SetColor(0, 255, 255)
end event

type st_maroon from vuo_st_color within w_seleccionar_color
integer x = 1390
integer y = 364
long textcolor = 128
long backcolor = 128
end type

event clicked;wf_SetColor(128, 0, 0)
end event

type st_fuchsia from vuo_st_color within w_seleccionar_color
integer x = 937
integer y = 364
long backcolor = 16711935
end type

event clicked;wf_SetColor(255, 0, 255)
end event

type st_lime from vuo_st_color within w_seleccionar_color
integer x = 1029
integer y = 364
long backcolor = 65280
end type

event clicked;wf_SetColor(0, 255, 0)
end event

type st_yellow from vuo_st_color within w_seleccionar_color
integer x = 1120
integer y = 364
long backcolor = 65535
end type

event clicked;wf_SetColor(255, 255, 0)
end event

type st_red from vuo_st_color within w_seleccionar_color
integer x = 846
integer y = 364
long backcolor = 255
end type

event clicked;wf_SetColor(255, 0, 0)
end event

type st_white from vuo_st_color within w_seleccionar_color
integer x = 759
integer y = 364
end type

event clicked;wf_SetColor(255, 255, 255)
end event

type st_black from vuo_st_color within w_seleccionar_color
integer x = 672
integer y = 364
long backcolor = 0
end type

event clicked;wf_SetColor(0, 0, 0)

end event

type r_colores from rectangle within w_seleccionar_color
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 1073741824
integer x = 640
integer y = 340
integer width = 951
integer height = 264
end type

type st_ejemplo from vs_st_master within w_seleccionar_color
integer x = 901
integer y = 1164
integer width = 462
integer height = 56
boolean bringtotop = true
integer weight = 700
long textcolor = 16777215
long backcolor = 0
string text = "Ejemplo de texto"
alignment alignment = center!
end type

type st_rojo from vs_st_master within w_seleccionar_color
integer x = 238
integer y = 664
integer width = 197
integer height = 60
boolean bringtotop = true
integer weight = 700
long textcolor = 255
string text = "Rojo"
alignment alignment = center!
long bordercolor = 1073741824
end type

type st_verde from vs_st_master within w_seleccionar_color
integer x = 238
integer y = 816
integer width = 197
integer height = 60
boolean bringtotop = true
integer weight = 700
long textcolor = 32768
string text = "Verde"
alignment alignment = center!
long bordercolor = 1073741824
end type

type st_color from vs_st_master within w_seleccionar_color
integer x = 1509
integer y = 1136
integer width = 197
integer height = 60
boolean bringtotop = true
integer weight = 700
string text = "Color"
alignment alignment = right!
long bordercolor = 1073741824
end type

type htb_rojo from vuo_htb_color within w_seleccionar_color
integer x = 434
integer y = 640
boolean bringtotop = true
end type

event moved;em_rojo.text = string(scrollpos)
wf_SetColor(integer(em_rojo.text), integer(em_verde.text), integer(em_azul.text))

end event

type htb_verde from vuo_htb_color within w_seleccionar_color
integer x = 434
integer y = 792
boolean bringtotop = true
end type

event moved;em_verde.text = string(scrollpos)
wf_SetColor(integer(em_rojo.text), integer(em_verde.text), integer(em_azul.text))

end event

type htb_azul from vuo_htb_color within w_seleccionar_color
integer x = 434
integer y = 940
boolean bringtotop = true
end type

event moved;em_azul.text = string(scrollpos)
wf_SetColor(integer(em_rojo.text), integer(em_verde.text), integer(em_azul.text))

end event

type em_azul from vuo_em_rgb_number within w_seleccionar_color
integer x = 1824
integer y = 964
integer taborder = 30
string text = "0"
end type

event modified;
wf_SetColor(integer(em_rojo.text), integer(em_verde.text), integer(em_azul.text))

end event

type em_verde from vuo_em_rgb_number within w_seleccionar_color
integer x = 1824
integer y = 816
integer taborder = 20
string text = "0"
end type

event modified;
wf_SetColor(integer(em_rojo.text), integer(em_verde.text), integer(em_azul.text))

end event

type r_ejemplo from rectangle within w_seleccionar_color
long linecolor = 12632256
integer linethickness = 4
integer x = 827
integer y = 1120
integer width = 608
integer height = 140
end type

type em_rojo from vuo_em_rgb_number within w_seleccionar_color
integer x = 1824
integer y = 664
integer taborder = 10
string text = "0"
end type

event modified;
wf_SetColor(integer(em_rojo.text), integer(em_verde.text), integer(em_azul.text))

end event

type st_azul from vs_st_master within w_seleccionar_color
integer x = 242
integer y = 964
integer width = 197
integer height = 60
integer weight = 700
long textcolor = 8388608
string text = "Azul"
alignment alignment = center!
long bordercolor = 1073741824
end type

