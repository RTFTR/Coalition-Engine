function Bullet_Bone_Top(X,LENGTH,HSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var Y = (obj_battle_board.y - obj_battle_board.up) + (LENGTH / 2);
	var VSPEED = 0;
	var ANGLE = 90;
	var MODE = 0;
	var bone = Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE,OUT,MODE,ANGLE,ROTATE,DESTROYABLE,DURATION);
	return bone;
}

function Bullet_Bone_Bottom(X,LENGTH,HSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){	var Y = (obj_battle_board.y + obj_battle_board.down) - (LENGTH / 2);
	var VSPEED = 0;
	var ANGLE = 90;
	var MODE = 0;
	var bone = Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE,OUT,MODE,ANGLE,ROTATE,DESTROYABLE,DURATION);
	return bone;
}

function Bullet_Bone_Left(Y,LENGTH,VSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var X = (obj_battle_board.x - obj_battle_board.left) + (LENGTH / 2);
	var HSPEED = 0;
	var ANGLE = 0;
	var MODE = 0;
	var bone = Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE,OUT,MODE,ANGLE,ROTATE,DESTROYABLE,DURATION);
	return bone;
}

function Bullet_Bone_Right(Y,LENGTH,VSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1){
	var X = (obj_battle_board.x + obj_battle_board.right) - (LENGTH / 2);
	var HSPEED = 0;
	var ANGLE = 0;
	var MODE = 0;
	var bone = Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE,OUT,MODE,ANGLE,ROTATE,DESTROYABLE,DURATION);
	return bone;
}

