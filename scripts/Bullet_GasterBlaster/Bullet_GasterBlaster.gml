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

