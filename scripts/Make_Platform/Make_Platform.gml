///@desc Creates a platform
///@param {real} x		The x position
///@param {real} y		The y position
///@param {real} hspeed	The hspeed of the platform
///@param {real} vspeed	The vspeed of the platform
///@param {real} length	The size of the platform (In pixels)
///@param {real} out	Whether the platforms is outside the board (Defalut 0)
///@param {real} angle	The angle of the platform (Default 0)
///@param {bool} sticky	Whether the platform will move the soul with it or not (Default true)
function Make_Platform(X,Y,HSPEED,VSPEED,LENGTH,OUT = 0,ANGLE = 0,STICKY = true)
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
