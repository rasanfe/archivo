$PBExportHeader$vs_htb_master.sru
forward
global type vs_htb_master from htrackbar
end type
end forward

global type vs_htb_master from htrackbar
integer width = 622
integer height = 136
integer maxposition = 100
integer tickfrequency = 10
end type
global vs_htb_master vs_htb_master

type variables
Private:
Long il_position
end variables

forward prototypes
public subroutine of_set_position (long al_position)
public function long of_get_position ()
end prototypes

public subroutine of_set_position (long al_position);il_position = al_position

this.event moved(il_position)
end subroutine

public function long of_get_position ();RETURN il_position
end function

on vs_htb_master.create
end on

on vs_htb_master.destroy
end on

event pageleft;il_position=this.position

this.event moved(il_position)
end event

event pageright;il_position=this.position

this.event moved(il_position)
end event

event lineleft;il_position=this.position

this.event moved(il_position)
end event

event lineright;il_position=this.position

this.event moved(il_position)
end event

event constructor;il_position=this.position
end event

event moved;il_position=scrollpos
end event

