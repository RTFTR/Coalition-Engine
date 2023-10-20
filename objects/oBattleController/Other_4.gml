///@desc Battle Instances
MainBoard = instance_create_depth(320, 320, -1, oBoard);
MainSoul = instance_create_depth(48, 454, -1, oSoul);
Enemy_Function_Load();
if ALLOW_DEBUG
	global.debug = false;
oGlobal.camera_target = noone;

check_contain_enemy();
show_message(ncontains_enemy);
show_message(no_enemy_pos);
