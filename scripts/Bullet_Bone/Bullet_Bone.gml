function Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE = 0,OUT = 0,MODE = 0,ANGLE = 90,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var DEPTH = -10
	if instance_exists(obj_battle_board)
	{
		DEPTH = obj_battle_board.depth
		
		if OUT DEPTH -= 1
		else DEPTH += 1
	}
	
	var bone = instance_create_depth(X,Y,DEPTH,battle_bullet_bone);
	with bone
	{
		x = X;
		y = Y;
		hspeed = HSPEED;
		vspeed = VSPEED;
		image_angle = ANGLE;
		
		length = LENGTH;
		rotate = ROTATE;
		type = TYPE;
		duration = DURATION;
		mode = MODE;
		
		destroyable = DESTROYABLE;
	}
	return bone;
}

		

