$PBExportHeader$w_encrypting.srw
forward
global type w_encrypting from w_base
end type
type cbx_hexencrypt from checkbox within w_encrypting
end type
type ddlb_encrypt_algorithm from dropdownlistbox within w_encrypting
end type
type st_4 from statictext within w_encrypting
end type
type st_3 from statictext within w_encrypting
end type
type mle_3 from multilineedit within w_encrypting
end type
type mle_1 from multilineedit within w_encrypting
end type
type st_2 from statictext within w_encrypting
end type
type st_1 from statictext within w_encrypting
end type
type cb_3 from commandbutton within w_encrypting
end type
type mle_2 from multilineedit within w_encrypting
end type
type cb_1 from commandbutton within w_encrypting
end type
type gb_option from groupbox within w_encrypting
end type
end forward

global type w_encrypting from w_base
integer width = 4315
integer height = 1608
string title = "Demo - Encoding"
cbx_hexencrypt cbx_hexencrypt
ddlb_encrypt_algorithm ddlb_encrypt_algorithm
st_4 st_4
st_3 st_3
mle_3 mle_3
mle_1 mle_1
st_2 st_2
st_1 st_1
cb_3 cb_3
mle_2 mle_2
cb_1 cb_1
gb_option gb_option
end type
global w_encrypting w_encrypting

type variables
String is_privkey
end variables

on w_encrypting.create
int iCurrent
call super::create
this.cbx_hexencrypt=create cbx_hexencrypt
this.ddlb_encrypt_algorithm=create ddlb_encrypt_algorithm
this.st_4=create st_4
this.st_3=create st_3
this.mle_3=create mle_3
this.mle_1=create mle_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_3=create cb_3
this.mle_2=create mle_2
this.cb_1=create cb_1
this.gb_option=create gb_option
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_hexencrypt
this.Control[iCurrent+2]=this.ddlb_encrypt_algorithm
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.mle_3
this.Control[iCurrent+6]=this.mle_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.mle_2
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.gb_option
end on

on w_encrypting.destroy
call super::destroy
destroy(this.cbx_hexencrypt)
destroy(this.ddlb_encrypt_algorithm)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.mle_3)
destroy(this.mle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.mle_2)
destroy(this.cb_1)
destroy(this.gb_option)
end on

event open;call super::open;ddlb_encrypt_algorithm.SelectItem(1)
end event

type cbx_hexencrypt from checkbox within w_encrypting
integer x = 1838
integer y = 1144
integer width = 558
integer height = 96
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Encrypt to Hex"
end type

type ddlb_encrypt_algorithm from dropdownlistbox within w_encrypting
integer x = 1842
integer y = 1248
integer width = 549
integer height = 400
integer taborder = 110
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
string item[] = {"AES128","AES256","DES","RC2","RC4","3DES","3DES_112"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_encrypting
integer x = 1554
integer y = 944
integer width = 1193
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Elapsed Time:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_encrypting
integer x = 1554
integer y = 856
integer width = 1193
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bytes:"
boolean focusrectangle = false
end type

type mle_3 from multilineedit within w_encrypting
integer x = 3031
integer y = 176
integer width = 1189
integer height = 672
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type mle_1 from multilineedit within w_encrypting
integer x = 50
integer y = 172
integer width = 1189
integer height = 672
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "PowerBuilder 12.6 es un entorno de desarrollo de aplicaciones empresariales centrado en DWs."
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_encrypting
integer x = 3387
integer y = 52
integer width = 457
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Decrypt"
boolean focusrectangle = false
end type

type st_1 from statictext within w_encrypting
integer x = 1897
integer y = 64
integer width = 448
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Encrypt"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_encrypting
integer x = 2761
integer y = 368
integer width = 224
integer height = 112
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = ">>"
end type

event clicked;String ls_data, ls_decrypted, ls_Algorithm
String ls_password
n_cryptoapi lnv_crypterobject

st_4.Text = "Elapsed Time: "
mle_3.Text = ""
ls_data = mle_2.Text
ls_password  ="PBMyKey012345678"
ls_Algorithm = ddlb_encrypt_algorithm.text


SetPointer(HourGlass!)
idbl_start = wf_PerfStart()

If cbx_hexencrypt.Checked Then
	ls_decrypted = lnv_crypterobject.of_DecryptHex(ls_Algorithm, ls_data, ls_password)
Else
	ls_decrypted = lnv_crypterobject.of_Decrypt(ls_Algorithm, ls_data, ls_password)
End IF	

mle_3.Text = ls_decrypted
idbl_elapsed = wf_PerfStop(idbl_start)
st_4.Text = "Elapsed Time: "+ String(idbl_elapsed, "#,##0.0000") + " seconds"
















end event

type mle_2 from multilineedit within w_encrypting
integer x = 1550
integer y = 172
integer width = 1189
integer height = 672
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_encrypting
integer x = 1289
integer y = 380
integer width = 224
integer height = 112
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = ">>"
end type

event clicked;String ls_data, ls_encrypted, ls_Algorithm
String ls_password
n_cryptoapi lnv_crypterobject

mle_2.Text =""
mle_3.Text =""
st_3.Text = "Bytes: "
st_4.Text = "Elapsed Time: "

ls_data = mle_1.Text
ls_password  = "PBMyKey012345678"
ls_Algorithm = ddlb_encrypt_algorithm.text

SetPointer(HourGlass!)
idbl_start = wf_PerfStart()


If cbx_hexencrypt.Checked Then
	ls_encrypted = lnv_crypterobject.of_EncryptHex(ls_Algorithm, ls_data, ls_password)
else
	ls_encrypted = lnv_crypterobject.of_Encrypt(ls_Algorithm, ls_data, ls_password)
End if	
	
mle_2.Text = ls_encrypted 


mle_2.Text = ls_encrypted
SetPointer(Arrow!)
st_3.Text = "Bytes: "+ String(Len(ls_encrypted))
idbl_elapsed = wf_PerfStop(idbl_start)
st_4.Text = "Elapsed Time: "+ String(idbl_elapsed, "#,##0.0000") + " seconds"




end event

type gb_option from groupbox within w_encrypting
integer x = 1746
integer y = 1068
integer width = 759
integer height = 304
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Encrypt Options"
end type

