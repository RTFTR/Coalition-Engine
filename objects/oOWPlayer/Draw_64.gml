//Encounter begin drawing
var CamPos = [camera_get_view_x(view_camera[0]),  camera_get_view_y(view_camera[0])],
	relative_pos = [
		(x - CamPos[0]) * oGlobal.camera_scale_x,
		(y - CamPos[1] - sprite_get_height(sprite_index)/2) * oGlobal.camera_scale_y
	];
if encounter_draw[0] draw_clear(c_black);
if encounter_draw[1] draw_sprite_ext(sprite_index, image_index, relative_pos[0], relative_pos[1],
					oGlobal.camera_scale_x, oGlobal.camera_scale_y, image_angle, c_white, 1);
if encounter_draw[2] draw_sprite_ext(sprSoul, 0 , encounter_soul_x, encounter_soul_y, 1, 1, 0, c_red, 1);