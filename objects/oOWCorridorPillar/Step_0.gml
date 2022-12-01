if (camera_get_view_x(view_camera[0]) >= 0)
    x = (200 + floor((camera_get_view_x(view_camera[0]) - (camera_get_view_x(view_camera[0]) * scrollspeed))))
var gg = (room_width - (oGlobal.camera_view_width / oGlobal.camera_scale_x))
if (camera_get_view_x(view_camera[0]) >= gg)
    x = (200 + floor((gg - (gg * scrollspeed))))
	