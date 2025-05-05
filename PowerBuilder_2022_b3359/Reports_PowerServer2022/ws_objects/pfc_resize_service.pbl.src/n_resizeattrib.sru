$PBExportHeader$n_resizeattrib.sru
$PBExportComments$Resize attributes
forward
global type n_resizeattrib from nonvisualobject
end type
end forward

global type n_resizeattrib from nonvisualobject autoinstantiate
end type

type variables
Public:
graphicobject		wo_control
string		s_classname
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
integer		i_widthmin
integer		i_heightmin
integer		i_movex
integer		i_movey
integer		i_scalewidth
integer		i_scaleheight
end variables

on n_resizeattrib.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_resizeattrib.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

