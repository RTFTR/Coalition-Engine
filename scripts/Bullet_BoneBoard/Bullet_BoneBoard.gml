///@desc Creates a bone at the Top of the board
///@param {real} x			The x position of the bone
///@param {real} length		The length of the bone (In pixels)
///@param {real} hspeed		The hspeed of the bone
///@param {real} type		The color of the bone (Macros supported, Default White)
///@param {real} out		Whether the bone appears outside the board (Default 0)
///@param {real} rotate		The rotation of the bone (Default 0)
///@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
///@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
function Bullet_BoneTop(X,LENGTH,HSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var Y = (oBoard.y - oBoard.up) + (LENGTH / 2);
	var VSPEED = 0;
	var ANGLE = 90;
	var MODE = 0;
	var bone = Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE,OUT,MODE,ANGLE,ROTATE,DESTROYABLE,DURATION);
	return bone;
}

///@desc Creates a bone at the Bottom of the board
///@param {real} x			The x position of the bone
///@param {real} length		The length of the bone (In pixels)
///@param {real} hspeed		The hspeed of the bone
///@param {real} type		The color of the bone (Macros supported, Default White)
///@param {real} out		Whether the bone appears outside the board (Default 0)
///@param {real} rotate		The rotation of the bone (Default 0)
///@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
///@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
function Bullet_BoneBottom(X,LENGTH,HSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var Y = (oBoard.y + oBoard.down) - (LENGTH / 2);
	var VSPEED = 0;
	var ANGLE = 90;
	var MODE = 0;
	var bone = Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE,OUT,MODE,ANGLE,ROTATE,DESTROYABLE,DURATION);
	return bone;
}

///@desc Creates a bone at the Left of the board
///@param {real} y			The y position of the bone
///@param {real} length		The length of the bone (In pixels)
///@param {real} vspeed		The vspeed of the bone
///@param {real} type		The color of the bone (Macros supported, Default White)
///@param {real} out		Whether the bone appears outside the board (Default 0)
///@param {real} rotate		The rotation of the bone (Default 0)
///@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
///@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
function Bullet_BoneLeft(Y,LENGTH,VSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var X = (oBoard.x - oBoard.left) + (LENGTH / 2);
	var HSPEED = 0;
	var ANGLE = 0;
	var MODE = 0;
	var bone = Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE,OUT,MODE,ANGLE,ROTATE,DESTROYABLE,DURATION);
	return bone;
}

///@desc Creates a bone at the Right of the board
///@param {real} y			The y position of the bone
///@param {real} length		The length of the bone (In pixels)
///@param {real} vspeed		The vspeed of the bone
///@param {real} type		The color of the bone (Macros supported, Default White)
///@param {real} out		Whether the bone appears outside the board (Default 0)
///@param {real} rotate		The rotation of the bone (Default 0)
///@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
///@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
function Bullet_BoneRight(Y,LENGTH,VSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var X = (oBoard.x + oBoard.right) - (LENGTH / 2);
	var HSPEED = 0;
	var ANGLE = 0;
	var MODE = 0;
	var bone = Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE,OUT,MODE,ANGLE,ROTATE,DESTROYABLE,DURATION);
	return bone;
}

///@desc Makes a Vertical Bone that is the length of the board
function Bullet_BoneFullV(X, SPEED, TYPE = 0, OUT = 0, ROTATE = 0, DESTROYABLE = true, DURATION = -1)
{
	return Bullet_BoneBottom(X, oBoard.up + oBoard.down, SPEED, TYPE, OUT, ROTATE, DESTROYABLE, DURATION);
}

///@desc Makes a Horizontal Bone that is the length of the board
function Bullet_BoneFullH(Y, SPEED, TYPE = 0, OUT = 0, ROTATE = 0, DESTROYABLE = true, DURATION = -1)
{
	return Bullet_BoneLeft(Y, oBoard.left + oBoard.right, SPEED, TYPE, OUT, ROTATE, DESTROYABLE, DURATION);
}

