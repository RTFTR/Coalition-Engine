if instance_exists(obj_battle_board)
	depth = obj_battle_board.depth - obj_battle_controller.depth - 1;
image_speed = 0;
image_blend = c_red;

dir = DIR.DOWN;

follow_board = false;
global.inv = 0;
global.assign_inv = 60;		// Sets the inv time for soul
global.deadable = true;

mode = SOUL_MODE.RED;

move_x = 0;
move_y = 0;

fall_spd = 0;
fall_grav = 0;

on_ground = false;
on_ceil = false;
on_platform = false;

slam = false;

moveable = true;

effect = false;
effect_xscale = 1;
effect_yscale = 1;
effect_alpha = 1;
effect_angle = image_angle;
effect_x = x;
effect_y = y;

