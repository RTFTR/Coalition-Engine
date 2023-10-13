//feather ignore all
/**
	@desc Creates a Blaster with given parameters
	@param {real} x				The x position of the blaster when created
	@param {real} y				The y position of the blaster when created
	@param {real} target_x		The target x position of the blaster
	@param {real} target_y		The target y position of the blaster
	@param {real} init_angle	The inital angle of the blaster (Default +- 180 of the taget angle)
	@param {real} target_angle	The target angle of the blaster
	@param {real} scale_x		The x scale of the blaster
	@param {real} scale_y		The y scale of the blaster
	@param {real} move			The move time of the blaster
	@param {real} pause			The pause time of the blaster before it shoots after it finished moving
	@param {real} duration		The duration of the blast
	@param {real} color			The color of the blaster (Default 0)
	@param {bool} blur			Whether the blaster blurs the screen upon firing (Default false)
	@param {bool} create_sound	Whether the creation sound plays (Default true)
	@param {bool} release_sound	Whether the firing sound plays (Default true)
*/
function CreateBlaster(x, y, t_x, t_y, i_angle = t_angle + choose(180, -180), t_angle, s_x, s_y, move, pause, dur, col = 0, blur = false, c_sound = true, r_sound = true) {
	var blaster = instance_create_depth(x, y, -1000, oGB);
	with blaster
	{
		image_xscale = s_y;
		image_yscale = s_x;
		image_angle = i_angle;
		
		target_x = t_x;
		target_y = t_y;
		target_angle = t_angle;
		
		time_move = move;
		time_pause = pause;
		timer_blast = dur;
		type = col;
		blurring = blur;
		charge_sound = c_sound;
		release_sound = r_sound;
	}
	return blaster;
}

