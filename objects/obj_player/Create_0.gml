global.zoom_level = 2;
global.cam_target = id;
char_moveable = true;
dir_sprite = [char_frisk_up,  char_frisk_down, char_frisk_left];
last_sprite = -1
last_dir = 1;
sprite_index = dir_sprite[2];
dir = DIR.DOWN;
image_speed = 0;
allow_run = true

pause = false;
pauseSurf = surface_create(640, 480);
pauseSurfBuffer = buffer_create(640 * 480 * 4, buffer_fixed, 1);

OW_Dialog("overworld text");


function Is_Dialog(){return obj_overworld_controller.is_dialog;}
