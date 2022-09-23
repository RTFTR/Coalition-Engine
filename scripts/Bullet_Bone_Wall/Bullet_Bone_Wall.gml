/// @desc  Creates a bone wall on a chosen side of the board
/// @param {real} direction		The direction of the bone wall (Macros supported, i.e. DIR.UP)
/// @param {real} height		The height of the bone wall (In pixels)
/// @param {real} delay			The Warning duration
/// @param {real} duration		The duration that the bone wall exists
/// @param {real} color			The color of the bones (Default White)
/// @param {real} move			The speed the bone wall moves In and Out of the board (Default 5)
/// @param {bool} warn_sound	Whether the warning sound plays (Default True)
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
