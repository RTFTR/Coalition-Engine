var input_confirm = oOWController.menu_state == INTERACT_STATE.IDLE and PRESS_CONFIRM,
	collide = place_meeting(x, y, oOWPlayer);
//Properties of Save (INCOMPLETE)
switch sprite_index
{
	case sprOWSave:
	break
	case sprPixel:
		if collide and !Collided
		{	
			if Event != -1 and is_method(Event)
			{
				Collided = true;
				Event();
			}
		}
		else if collide and Collided
		{
			Collided = 2;
		}
		if !collide and Collided == 2 Collided = false;
	break
}