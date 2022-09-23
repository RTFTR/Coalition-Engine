global.camera_scale_x = 2
global.camera_scale_y = 2
global.camera_target = id;
char_moveable = true;
dir_sprite = [char_frisk_up,  char_frisk_down, char_frisk_left];
last_sprite = -1
last_dir = 1;
sprite_index = dir_sprite[2];
dir = DIR.DOWN;
image_speed = 0;
allow_run = true

draw_menu = false;
menu_choice = [0, 0, 0, 0, 0, 0, 0, 0, 0];
menu_state = 0;
soul_target = [(x - camera_get_view_x(view_camera[0])) * global.camera_scale_x,
				(y - camera_get_view_y(view_camera[0]) - sprite_get_height(sprite_index)/2) * global.camera_scale_y
				];

OW_Dialog("Welcome to the\n  Underg- Overworld!");


function Is_Dialog(){return obj_overworld_controller.is_dialog;}
function Is_Boxing(){return obj_overworld_controller.is_boxing;}
function Move_Noise() { audio_play(snd_menu_switch); };
function Confirm_Noise() { audio_play(snd_menu_confirm); };
