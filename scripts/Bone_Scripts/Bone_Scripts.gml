/**
	Creates a bone as a bullet
	@param {real} x			The x position of the bone
	@param {real} y			The y position of the bone
	@param {real} length	The length of the bone (In pixels)
	@param {real} hspeed	The hspeed of the bone
	@param {real} vspeed	The vspeed of the bone
	@param {real} type		The color of the bone (Macros supported, Default White)
	@param {real} out		Whether the bone appears outside the board (Default 0)
	@param {real} mode		The direction of the board the bone sticks onto (Default 0)
	@param {real} angle		The angle of the bone (Default 90)
	@param {real} rotate	The rotation of the bone (Default 0)
	@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
	@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
	@param {Constant.Color} Base_Color	The color of the bone
*/
function Bullet_Bone(x, y, length, hspd, vspd, type = 0, out = 0, mode = 0, angle = 90, rotate = 0, destroyable = true, duration = -1, base_col = oEnemyParent.base_bone_col){
	var DEPTH = -10;
	if instance_exists(oBoard)
	{
		DEPTH = oBoard.depth;
		if out DEPTH--;
	}
	
	var bone = instance_create_depth(x, y, DEPTH, oBulletBone,
	{
		hspeed : hspd,
		vspeed : vspd,
	});
	with bone
	{
		target_board = BattleBoardList[TargetBoard];
		image_angle = angle;
		
		id.length = length;
		id.rotate = rotate;
		id.type = type;
		id.duration = duration;
		id.mode = mode;
		
		id.destroyable = destroyable;
		base_color = base_col;
	}
	return bone;
}


/**
	Creates a bone at the Top of the board
	@param {real} x			The x position of the bone
	@param {real} length	The length of the bone (In pixels)
	@param {real} hspeed	The hspeed of the bone
	@param {real} type		The color of the bone (Macros supported, Default White)
	@param {real} out		Whether the bone appears outside the board (Default 0)
	@param {real} rotate	The rotation of the bone (Default 0)
	@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
	@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
*/
function Bullet_BoneTop(x, length, hspd, type = 0, out = 0, rotate = 0, destroyable = true, duration = -1)
{
	return Bullet_Bone(x, Board.GetUpPos() + length / 2, length, hspd, 0, type, out, 0, 90, rotate, destroyable, duration);
}

/**
	Creates a bone at the Bottom of the board
	@param {real} x			The x position of the bone
	@param {real} length		The length of the bone (In pixels)
	@param {real} hspeed		The hspeed of the bone
	@param {real} type		The color of the bone (Macros supported, Default White)
	@param {real} out		Whether the bone appears outside the board (Default 0)
	@param {real} rotate		The rotation of the bone (Default 0)
	@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
	@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
*/
function Bullet_BoneBottom(x, length, hspd, type = 0, out = 0, rotate = 0, destroyable = true, duration = -1){
	return Bullet_Bone(x, Board.GetDownPos() - length / 2, length, hspd, 0, type, out, 0, 90, rotate, destroyable, duration);
}

/**
	Creates a bone at the Left of the board
	@param {real} y			The y position of the bone
	@param {real} length		The length of the bone (In pixels)
	@param {real} vspeed		The vspeed of the bone
	@param {real} type		The color of the bone (Macros supported, Default White)
	@param {real} out		Whether the bone appears outside the board (Default 0)
	@param {real} rotate		The rotation of the bone (Default 0)
	@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
	@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
*/
function Bullet_BoneLeft(y, length, vspd, type = 0, out = 0, rotate = 0, destroyable = true, duration = -1)
{
	return Bullet_Bone(Board.GetLeftPos() + length / 2, y, length, 0, vspd, type, out, 0, 0, rotate, destroyable, duration);
}

/**
	Creates a bone at the Right of the board
	@param {real} y			The y position of the bone
	@param {real} length		The length of the bone (In pixels)
	@param {real} vspeed		The vspeed of the bone
	@param {real} type		The color of the bone (Macros supported, Default White)
	@param {real} out		Whether the bone appears outside the board (Default 0)
	@param {real} rotate		The rotation of the bone (Default 0)
	@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
	@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
*/
function Bullet_BoneRight(y, length, vspd, type = 0, out = 0, rotate = 0, destroyable = true, duration = -1)
{
	return Bullet_Bone(Board.GetRightPos() - length / 2, y, length, 0, vspd, type, out, 0, 0, rotate, destroyable, duration);
}

/**
	Makes a Vertical Bone that is the length of the board
	@param {real} x			The x position of the bone
	@param {real} speed		The speed of the bone
	@param {real} type		The color of the bone (Macros supported, Default White)
	@param {real} out		Whether the bone appears outside the board (Default 0)
	@param {real} rotate	The rotation of the bone (Default 0)
	@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
	@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
*/
function Bullet_BoneFullV(x, spd, type = 0, out = 0, rotate = 0, destroyable = true, duration = -1)
{
	return Bullet_BoneBottom(x, Board.GetHeight(), spd, type, out, rotate, destroyable, duration);
}

/**
	Makes a Horizontal Bone that is the length of the board
	@param {real} y			The y position of the bone
	@param {real} speed		The speed of the bone
	@param {real} type		The color of the bone (Macros supported, Default White)
	@param {real} out		Whether the bone appears outside the board (Default 0)
	@param {real} rotate	The rotation of the bone (Default 0)
	@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
	@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
*/
function Bullet_BoneFullH(y, spd, type = 0, out = 0, rotate = 0, destroyable = true, duration = -1)
{
	return Bullet_BoneLeft(y, Board.GetWidth(), spd, type, out, rotate, destroyable, duration);
}

/**
	Creates Two Horizontal bones that Makes A Gap In Between Them
	@param {real} x			The x position of the gap of the bones
	@param {real} y			The y position of the bones
	@param {real} vspeed	The vspeed of the bones
	@param {real} gap		The size of the gap (In pixels)
	@param {real} color		The color of the bones (Marcos supported, Default White)
	@param {real} out		Whether the bones are outisde the board (Default 0)
	@param {real} destroy	Whether the bones destroy themselves when offscreen (Default 0)
	@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
*/
function Bullet_BoneGapH(x, y, vspd, gap, type = 0, out = 0, destroyable = 0, duration = -1)
{
	Bullet_BoneLeft(y, x - Board.GetLeftPos() - gap / 2, vspd, type, out, 0, destroyable, duration);
	Bullet_BoneRight(y, Board.GetRightPos()- gap / 2 - x, vspd, type, out, 0, destroyable, duration);
}

/**
	Creates Two Vertical bones that Makes A Gap In Between Them
	@param {real} x			The x position of the bones
	@param {real} y			The y position of the gap of the bones
	@param {real} vspeed	The vspeed of the bones
	@param {real} gap		The size of the gap (In pixels)
	@param {real} color		The color of the bones (Marcos supported, Default White)
	@param {real} out		Whether the bones are outisde the board (Default 0)
	@param {real} destroy	Whether the bones destroy themselves when offscreen (Default 0)
	@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
*/
function Bullet_BoneGapV(x, y, vspd, gap, type = 0, out = 0, destroyable = 0, duration = -1)
{
	Bullet_BoneTop(x, y - Board.GetUpPos() - gap / 2, vspd, type, out, 0, destroyable, duration);
	Bullet_BoneBottom(x, Board.GetDownPos()- gap / 2 - y, vspd, type, out, 0, destroyable, duration);
}

/**
	Creates a bone wall on a chosen side of the board
	@param {real} direction		The direction of the bone wall (Macros supported, i.e. DIR.UP)
	@param {real} height		The height of the bone wall (In pixels)
	@param {real} delay			The Warning duration
	@param {real} duration		The duration that the bone wall exists
	@param {real} color			The color of the bones (Default White)
	@param {real} move			The speed the bone wall moves In and Out of the board (Default 5)
	@param {bool} warn_sound	Whether the warning sound plays (Default True)
	@param {bool} create_sound	Whether the create sound plays (Default True)
*/
function Bullet_BoneWall(dir, height, delay, duration, type = 0, move = 5, warn_sound = true, cre_sound = true){
	var DEPTH = -10;
	if instance_exists(oBoard)  DEPTH = oBoard.depth + 1;
	dir = posmod(dir, 360);
	var wall = instance_create_depth(0, 0, DEPTH, oBulletBoneWall);
	with wall
	{
		target_board = BattleBoardList[TargetBoard];
		id.dir = dir;
		id.height = height;
		time_warn = delay;
		time_stay = duration;
		time_move = move;
		id.type = type;
		sound_warn = warn_sound;
		sound_create = cre_sound;
	}
	return wall;
}

/**
	Creates a Vertical Bone Wave
	@param {real} y			The y position of the first bone
	@param {real} length	The length of the first bone
	@param {real} hspeed	The hspeed of the bones
	@param {real} space		The space between bones
	@param {real} amount	The amount of bones
	@param {real} gap		The size of the bone gap
	@param {real} udf		Sine wave multiplier
	@param {real} uds		Sine wave intensity
	@param {real} type		Color of the bones (Default White)
	@param {real} out		Whether the bones are outside the board (Default 0)
*/
function Bullet_BoneWaveH(yy, length, hspd, space, amount, gap, udf, uds, type = 0, out = 0)
{
	var SIN = 0, LENGTH = (length - Board.GetLeftPos() - 14), i = 0;
	for (; i < amount; ++i)
	{
		SIN += uds * 0.3;
		LENGTH += cos(SIN) * udf * 4;
		yy += space * hspd * sign(-hspd) / 4;
		
		var DURATION = (((640 + (space * i)) / abs(hspd)) * 2);
		Bullet_BoneLeft(yy, LENGTH, hspd, type, out, 0, false, DURATION);
		Bullet_BoneRight(yy, Board.GetWidth() - LENGTH - gap, hspd, type, out, 0, false, DURATION);
	}
}

/**
	Creates a Horizontal Bone Wave
	@param {real} x			The x position of the first bone
	@param {real} length	The length of the first bone
	@param {real} hspeed	The hspeed of the bones
	@param {real} space		The space between bones
	@param {real} amount	The amount of bones
	@param {real} gap		The size of the bone gap
	@param {real} udf		Sine wave multiplier
	@param {real} uds		Sine wave intensity
	@param {real} type		Color of the bones (Default White)
	@param {real} out		Whether the bones are outside the board (Default 0)
*/
function Bullet_BoneWaveV(xx, length, vspd, space, amount, gap, udf, uds, type = 0, out = 0)
{
	var SIN = 0, LENGTH = (length - Board.GetUpPos() - 14), i = 0;
	for (; i < amount; ++i)
	{
		SIN += uds * 0.3;
		LENGTH += cos(SIN) * udf * 4;
		xx += space * vspd * sign(-vspd) / 4;
		
		var DURATION = (((480 + (space * i)) / abs(vspd)) * 2);
		Bullet_BoneTop(xx, LENGTH, vspd, type, out, 0, false, DURATION);
		Bullet_BoneBottom(xx, Board.GetHeight() - LENGTH - gap, vspd, type, out, 0, false, DURATION);
	}
}

/**
	Creates a Bone Cube
	@param {real} x					The x position of the cube
	@param {real} y					The x position of the cube
	@param {real} Angle_X			The x angle of the cube
	@param {real} Angle_Y			The y angle of the cube
	@param {real} Angle_Z			The z angle of the cube
	@param {real} Rotate_X			The x angle rotation of the cube
	@param {real} Rotate_Y			The y angle rotation of the cube
	@param {real} Rotate_Z			The z angle rotation of the cube
	@param {real} Scale_X			The x scale of the cube
	@param {real} Scale_Y			The y scale of the cube
	@param {real} Scale_Z			The z scale of the cube
	@param {real} Anim_Time			The time of the scaling animation (Default 0 - Instant)
	@param {function} Easing		The easing of the scaling animation (Default EaseLinear)
*/
function Battle_BoneCube(x, y, angle_x, angle_y, angle_z, rot_x, rot_y, rot_z, scale_x, scale_y, scale_z, anim_time = 0, ease = EaseLinear)
{
	var inst = instance_create_depth(x, y, -2, o3DBone);
	with inst
	{
		angles = [angle_x, angle_y, angle_z];
		angleAdd = [rot_x, rot_y, rot_z];
		scalex = scale_x;
		scaley = scale_y;
		scalez = scale_z;
		if anim_time
		{
			TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, anim_time, "scalex", 0, scale_x
			, "scaley", 0, scale_y, "scalez", 0, scale_z);
		}
	}
	return inst;
}