///@desc Top layer
switch OverWorld_ID
{
	case OVERWORLD.CORRIDOR:
	var scrollspeed = 2;
	if (camera_get_view_x(view_camera[0]) >= 0)
	var xx = (200 + floor((camera_get_view_x(view_camera[0]) - (camera_get_view_x(view_camera[0]) * scrollspeed))))
	var gg = (room_width - (oGlobal.camera_view_width / oGlobal.camera_scale_x))
	if (camera_get_view_x(view_camera[0]) >= gg)
		xx = (200 + floor((gg - (gg * scrollspeed))))
	
	for (var i = 0; i < 9; i++)
	{
		draw_sprite(sprPillar, 0, xx + (230 * i), 0)
		if (i == 5)
		    draw_sprite(sprPillar, 0, xx + (230 * i) + 110, 0)
	}
	break
}