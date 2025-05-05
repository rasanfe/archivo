$PBExportHeader$n_dwresizeattrib.sru
$PBExportComments$PFC DataWindow Resize attributes
forward
global type n_dwresizeattrib from nonvisualobject
end type
end forward

global type n_dwresizeattrib from nonvisualobject autoinstantiate
end type

type variables
Public:
string		s_control
string		s_typeof
boolean		b_scale
boolean		b_movex
boolean		b_movey
boolean		b_scalewidth
boolean		b_scaleheight
real		r_x
real		r_y
real		r_width
real		r_height
integer		i_movex
integer		i_movey
integer		i_scalewidth
integer		i_scaleheight
end variables

on n_dwresizeattrib.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_dwresizeattrib.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

