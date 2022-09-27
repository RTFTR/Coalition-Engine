///@desc Creates a Blaster
///@param {real} x				Initial x position of the Blaster
///@param {real} y				Initial y position of the Blaster
///@param {real} angle			Initial angle of the Blaster
///@param {real} xscale		The xscale of the Blaster (Makes it wider/skinnier)
///@param {real} yscale		The yscale of the Blaster
///@param {real} ideal_x		Target x position of the Blaster
///@param {real} ideal_y		Target y position of the Blaster
///@param {real} ideal_angle	Target angle of the Blaster
///@param {real} pause			The delay between moving to the target and firing
///@param {real} duration		The blast duration
///@param {real} move			The time taken to move from Init pos to Target pos
///@param {real} type			The color of the Blaster (Default 0)
///@param {bool} blur			Whether the screen blurs when the blaster fires (Default Flase)
///@param {real} c_sound		Whether the creation sound plays when created (Default 1)
///@param {real} r_sound		Whether the releasing sound plays when firing (Default 1)
function Bullet_GasterBlaster(X,Y,ANGLE,XSCALE,YSCALE,IDEALX,IDEALY,IDEALROT,PAUSE,BLAST,DURATION,TYPE = 0,BLUR = false,C_SOUND = 1,R_SOUND = 1) 
{	
	var DEPTH = -1000;
	
	var blaster = instance_create_depth(X,Y,DEPTH,battle_bullet_gb);
	with blaster
	{
		image_angle = ANGLE;
		
		image_xscale = XSCALE;
		image_yscale = YSCALE;
		
		target_x = IDEALX;
		target_y = IDEALY;
		target_angle = IDEALROT;
		
		time_pause = PAUSE;
		time_blast = BLAST;
		time_move = DURATION;
		
		type = TYPE;
		
		charge_sound = C_SOUND;
		release_sound = R_SOUND;
		blurring = BLUR;
	}

	return blaster;
}

///@desc Makes a blaster circle
///@param {real} Target_x			The x target of the Circle
///@param {real} Target_y			The y target of the Circle
///@param {real} Begin_Distance		The initial distance between the GB and the Center of the Circle
///@param {real} End_Distance		The target distance between the GB and the Center of the Circle
///@param {real} Direction_Start	The Init direction of the GB in the circle
///@param {real} Direction_End		The Target direction of the GB in the circle
///@param {real} Angle_Start		The Initial angle of the GB
///@param {real} Angle_End			The Target angle of the GB
///@param {real} Xscale				The Xscale fo the GB
///@param {real} Yscale				The Yscale fo the GB
///@param {real} Move				The Moving time of the GB
///@param {real} Delay				The Delay time of the GB
///@param {real} Duration			The Duration of the GB
///@param {real} Color				The color of the GB (Default White)
function Blaster_Circle(aim_x, aim_y, len_start, len_end, dir_s, dir_e, angle_s, angle_e, scx, scy, m, de, du, col = 0)
{
	var begin_x = lengthdir_x(len_start, dir_s) + aim_x;
	var begin_y = lengthdir_y(len_start, dir_s) + aim_y;
	var end_x = lengthdir_x(len_end, dir_e) + aim_x;
	var end_y = lengthdir_y(len_end, dir_e) + aim_y;
	return Bullet_GasterBlaster(begin_x, begin_y, angle_s, scx, scy, end_x, end_y, angle_e, de, du, m, col);
}
