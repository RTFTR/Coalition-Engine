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

