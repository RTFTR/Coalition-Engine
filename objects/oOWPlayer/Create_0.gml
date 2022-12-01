oGlobal.camera_target = id;
Camera_Scale(2, 2);
char_moveable = true;
dir_sprite = [char_frisk_up,  char_frisk_down, char_frisk_left];
last_sprite = -1
last_dir = 1;
sprite_index = dir_sprite[2];
dir = DIR.DOWN;
image_speed = 0;
allow_run = true;
speed_multiplier = 1;

draw_menu = false;
menu_choice = [0, 0, 0, 0, 0, 0, 0, 0, 0];
menu_state = 0;
soul_target = [(x - camera_get_view_x(view_camera[0])) * oGlobal.camera_scale_x,
				(y - camera_get_view_y(view_camera[0]) - sprite_get_height(sprite_index)/2) * oGlobal.camera_scale_y
				];

Dialog_SetOptionName(false, "option 1", "option 2");
OW_Dialog("Welcome to the\n  Underg- Overworld!");

encounter_state = 0;
encounter_time = 0;
encounter_draw = [0, 0, 0];

function Is_Dialog() {return oOWController.is_dialog;}
function Is_Boxing() {return oOWController.is_boxing;}
function Move_Noise() { audio_play(snd_menu_switch);};
function Confirm_Noise() { audio_play(snd_menu_confirm);};
function Encounter_Begin(exclaim = 1, move = 1)
{
	encounter_soul_x = 	(x - camera_get_view_x(view_camera[0])) * oGlobal.camera_scale_x;
	encounter_soul_y = 	(y - camera_get_view_y(view_camera[0]) - sprite_height / 2) * oGlobal.camera_scale_y;
	encounter_state = 3 - move - exclaim;
	if encounter_state == 1 audio_play(snd_exclamation)
}

debug = 0;
debug_alpha = 0;