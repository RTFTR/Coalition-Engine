function Bullet_Platform(X,Y,HSPEED,VSPEED,LENGTH,OUT = 0,ANGLE = 0,STICKY = true)
{

	var DEPTH = -600;
	if instance_exists(obj_battle_board)
	{
		DEPTH = obj_battle_board.depth
		
		if OUT DEPTH -= 1
		else DEPTH += 1
	}
	
	var platform = instance_create_depth(X, Y, DEPTH, battle_platform)
	with platform
	{
		x = X;
		y = Y;
		hspeed = HSPEED;
		vspeed = VSPEED;
		image_angle = ANGLE;
		
		length = LENGTH;
		sticky = STICKY;
	}
	return platform;
}
