function Bullet_Bone_Wall(DIRECTION,HEIGHT,DELAY,HOLD,TYPE = 0,MOVE = 5,WARN_SOUND = true){
	var DEPTH = -10
	if instance_exists(obj_battle_board) 
		DEPTH = obj_battle_board.depth + 1
	
	var wall = instance_create_depth(0,0,DEPTH,battle_bullet_bone_wall)
	with wall
	{
		dir = DIRECTION;
		height = HEIGHT;
		time_warn = DELAY;
		time_stay = HOLD;
		time_move = MOVE;
		type = TYPE;
		sound_warn = WARN_SOUND;
	}
	
	return wall;
}
