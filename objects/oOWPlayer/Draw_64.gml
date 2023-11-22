///@desc Encounter begin drawing
var _camScaleX = oGlobal.camera_scale_x, _camScaleY = oGlobal.camera_scale_y;
if encounter_draw[0] draw_clear(c_black);
if encounter_draw[1] draw_sprite_ext(sprite_index, image_index,
					(x - camera_get_view_x(view_camera[0])) * _camScaleX,
					(y - camera_get_view_y(view_camera[0]) - sprite_get_height(sprite_index) / 2) * _camScaleY,
					_camScaleX, _camScaleY, image_angle, c_white, 1);
if encounter_draw[2] draw_sprite_ext(sprSoul, 0 , encounter_soul_x, encounter_soul_y, 1, 1, 0, c_red, 1);