///@desc Creates a bone as a bullet
///@param {real} x			The x position of the bone
///@param {real} y			The y position of the bone
///@param {real} length		The length of the bone (In pixels)
///@param {real} hspeed		The hspeed of the bone
///@param {real} vspeed		The vspeed of the bone
///@param {real} type		The color of the bone (Macros supported, Default White)
///@param {real} out		Whether the bone appears outside the board (Default 0)
///@param {real} mode		The direction of the board the bone sticks onto (Default 0)
///@param {real} angle		The angle of the bone (Default 90)
///@param {real} rotate		The rotation of the bone (Default 0)
///@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
///@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
function Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE = 0,OUT = 0,MODE = 0,ANGLE = 90,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var DEPTH = -10
	if instance_exists(oBoard)
	{
		DEPTH = oBoard.depth
		
		if OUT DEPTH -= 1
	}
	
	var bone = instance_create_depth(X,Y,DEPTH,oBulletBone);
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


