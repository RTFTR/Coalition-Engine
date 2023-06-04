oGlobal.camera_target = id;
Camera_Scale(2, 2);
moveable = true;
dir_sprite = [sprFriskUp,  sprFriskDown, sprFriskLeft];
last_sprite = -1
last_dir = 1;
sprite_index = dir_sprite[2];
dir = DIR.DOWN;
image_speed = 0;
allow_run = true;
speed_multiplier = 1;

Dialog_BeginOption("test option question", ["ans 1", "ans 2", "ans 3"],
[function(){game_restart()}, function(){game_end()}, function() {show_message("functioning")}]);
//OW_Dialog("Welcome to the\n  Underg- Overworld!");

encounter_state = 0;
encounter_time = 0;
encounter_draw = [0, 0, 0];