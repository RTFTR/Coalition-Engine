///@desc Creates a bone at the Top of the board
///@param {real} x			The x position of the bone
///@param {real} length		The length of the bone (In pixels)
///@param {real} hspeed		The hspeed of the bone
///@param {real} type		The color of the bone (Macros supported, Default White)
///@param {real} out		Whether the bone appears outside the board (Default 0)
///@param {real} rotate		The rotation of the bone (Default 0)
///@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
///@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
function Bullet_Bone_Top(X,LENGTH,HSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var Y = (obj_battle_board.y - obj_battle_board.up) + (LENGTH / 2);
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
function Bullet_Bone_Bottom(X,LENGTH,HSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){	var Y = (obj_battle_board.y + obj_battle_board.down) - (LENGTH / 2);
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
function Bullet_Bone_Left(Y,LENGTH,VSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var X = (obj_battle_board.x - obj_battle_board.left) + (LENGTH / 2);
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
function Bullet_Bone_Right(Y,LENGTH,VSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var X = (obj_battle_board.x + obj_battle_board.right) - (LENGTH / 2);
	var HSPEED = 0;
	var ANGLE = 0;
	var MODE = 0;
	var bone = Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE,OUT,MODE,ANGLE,ROTATE,DESTROYABLE,DURATION);
	return bone;
}

