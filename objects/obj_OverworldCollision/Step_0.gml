var input_confirm = input_check_pressed("confirm"),
	collide = place_meeting(x, y, obj_OverworldCharMain);
//Properties of Save (INCOMPLETE)
switch sprite_index
{
	case sprOWSave:
		depth = obj_OverworldCharMain.depth + 9;
		image_speed = .15;
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