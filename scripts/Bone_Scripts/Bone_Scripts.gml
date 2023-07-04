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
///@param {Constant.Color} Base_Color	The color of the bone
function Bullet_Bone(X,Y,LENGTH,HSPEED,VSPEED,TYPE = 0,OUT = 0,MODE = 0,ANGLE = 90,ROTATE = 0,DESTROYABLE = true,DURATION = -1,base_col = oEnemyParent.base_bone_col){
	var DEPTH = -10
	if instance_exists(obj_Board)
	{
		DEPTH = obj_Board.depth
		
		if OUT DEPTH -= 1
	}
	
	var bone = instance_create_depth(X,Y,DEPTH,obj_BulletBone,
	{
		hspeed : HSPEED,
		vspeed : VSPEED,
	});
	with bone
	{
		image_angle = ANGLE;
		
		length = LENGTH;
		rotate = ROTATE;
		type = TYPE;
		duration = DURATION;
		mode = MODE;
		
		destroyable = DESTROYABLE;
		base_color = base_col;
	}
	return bone;
}


///@desc Creates a bone at the Top of the board
///@param {real} x			The x position of the bone
///@param {real} length		The length of the bone (In pixels)
///@param {real} hspeed		The hspeed of the bone
///@param {real} type		The color of the bone (Macros supported, Default White)
///@param {real} out		Whether the bone appears outside the board (Default 0)
///@param {real} rotate		The rotation of the bone (Default 0)
///@param {bool} destroy	Whether the bullets destroys when offscreen (Default True)
///@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
function Bullet_BoneTop(X,LENGTH,HSPEED,TYPE = 0,OUT = 0,ROTATE = 0,DESTROYABLE = true,DURATION = -1)
{
	var Y = (obj_Board.y - obj_Board.up) + (LENGTH / 2),
		bone = Bullet_Bone(X,Y,LENGTH,HSPEED,0,TYPE,OUT,0,90,ROTATE,DESTROYABLE,DURATION);
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
	var Y = (obj_Board.y + obj_Board.down) - (LENGTH / 2),
		bone = Bullet_Bone(X,Y,LENGTH,HSPEED,0,TYPE,OUT,0,90,ROTATE,DESTROYABLE,DURATION);
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
	var X = (obj_Board.x - obj_Board.left) + (LENGTH / 2),
		bone = Bullet_Bone(X,Y,LENGTH,0,VSPEED,TYPE,OUT,0,0,ROTATE,DESTROYABLE,DURATION);
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
	var X = (obj_Board.x + obj_Board.right) - (LENGTH / 2),
		bone = Bullet_Bone(X,Y,LENGTH,0,VSPEED,TYPE,OUT,0,0,ROTATE,DESTROYABLE,DURATION);
	return bone;
}

///@desc Makes a Vertical Bone that is the length of the board
function Bullet_BoneFullV(X, SPEED, TYPE = 0, OUT = 0, ROTATE = 0, DESTROYABLE = true, DURATION = -1)
{
	return Bullet_BoneBottom(X, obj_Board.up + obj_Board.down, SPEED, TYPE, OUT, ROTATE, DESTROYABLE, DURATION);
}

///@desc Makes a Horizontal Bone that is the length of the board
function Bullet_BoneFullH(Y, SPEED, TYPE = 0, OUT = 0, ROTATE = 0, DESTROYABLE = true, DURATION = -1)
{
	return Bullet_BoneLeft(Y, obj_Board.left + obj_Board.right, SPEED, TYPE, OUT, ROTATE, DESTROYABLE, DURATION);
}

//@desc Creates Two Horizontal bones that Makes A Gap In Between Them
///@param {real} x			The x position of the bones
///@param {real} y			The y position of the bones
///@param {real} vspeed		The vspeed of the bones
///@param {real} gap		The size of the gap (In pixels)
///@param {real} color		The color of the bones (Marcos supported, Default White)
///@param {real} out		Whether the bones are outisde the board (Default 0)
///@param {real} destroy	Whether the bones destroy themselves when offscreen (Default 0)
///@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
function Bullet_BoneGapH(X,Y,VSPEED,X_GAP,TYPE = 0, OUT = 0,DESTROYABLE = 0,DURATION = -1)
{
	var board = obj_Board,
		board_y = board.y,
		board_margin = new Vector2(board.left, board.right),
		GAP = X_GAP / 2,
		LENGTH_L = X - board_y + board_margin.x - GAP,
		LENGTH_R = board_y + board_margin.y - GAP - X;
	
	Bullet_BoneLeft(Y,LENGTH_L,VSPEED,TYPE,OUT,0,DESTROYABLE,DURATION);
	Bullet_BoneRight(Y,LENGTH_R,VSPEED,TYPE,OUT,0,DESTROYABLE,DURATION);
}

//@desc Creates Two Vertical bones that Makes A Gap In Between Them
///@param {real} x			The x position of the bones
///@param {real} y			The y position of the bones
///@param {real} hspeed		The hspeed of the bones
///@param {real} gap		The size of the gap (In pixels)
///@param {real} color		The color of the bones (Marcos supported, Default White)
///@param {real} out		Whether the bones are outisde the board (Default 0)
///@param {real} destroy	Whether the bones destroy themselves when offscreen (Default 0)
///@param {real} duration	The amount of time the bone exists before destroying itself (Default -1)
function Bullet_BoneGapV(X,Y,HSPEED,Y_GAP,TYPE = 0, OUT = 0,DESTROYABLE = 0,DURATION = -1)
{
	var board = obj_Board,
		board_y = board.y,
		board_margin = new Vector2(board.up, board.down),
		GAP = Y_GAP / 2,
		LENGTH_T = Y - board_y + board_margin.x - GAP,
		LENGTH_B = board_y + board_margin.y - GAP - Y;

	bone_top = Bullet_BoneTop(X,LENGTH_T,HSPEED,TYPE,OUT,0,DESTROYABLE,DURATION);
	bone_bottom = Bullet_BoneBottom(X,LENGTH_B,HSPEED,TYPE,OUT,0,DESTROYABLE,DURATION);
}


/// @desc  Creates a bone wall on a chosen side of the board
/// @param {real} direction		The direction of the bone wall (Macros supported, i.e. DIR.UP)
/// @param {real} height		The height of the bone wall (In pixels)
/// @param {real} delay			The Warning duration
/// @param {real} duration		The duration that the bone wall exists
/// @param {real} color			The color of the bones (Default White)
/// @param {real} move			The speed the bone wall moves In and Out of the board (Default 5)
/// @param {bool} warn_sound	Whether the warning sound plays (Default True)
/// @param {bool} create_sound	Whether the create sound plays (Default True)
function Bullet_BoneWall(DIRECTION,HEIGHT,DELAY,HOLD,TYPE = 0,MOVE = 5,WARN_SOUND = true, CRE_SOUND = true){
	var DEPTH = -10
	if instance_exists(obj_Board) 
		DEPTH = obj_Board.depth + 1
	DIRECTION = posmod(DIRECTION,360);
	var wall = instance_create_depth(0,0,DEPTH,obj_BulletBoneWall)
	with wall
	{
		dir = DIRECTION;
		height = HEIGHT;
		time_warn = DELAY;
		time_stay = HOLD;
		time_move = MOVE;
		type = TYPE;
		sound_warn = WARN_SOUND;
		sound_create = CRE_SOUND;
	}
	
	return wall;
}

/// @desc Creates a Vertical Bone Wave
/// @param {real} y			The y position of the first bone
/// @param {real} length	The length of the first bone
/// @param {real} hspeed	The hspeed of the bones
/// @param {real} space		The space between bones
/// @param {real} amount	The amount of bones
/// @param {real} gap		The size of the bone gap
/// @param {real} udf		Sine wave multiplier
/// @param {real} uds		Sine wave intensity
/// @param {real} type		Color of the bones (Default White)
/// @param {real} out		Whether the bones are outside the board (Default 0)
function Bullet_BoneWaveH(Y,X_GAP,HSPEED,SPACE,AMOUNT,GAP,UDF,UDS,TYPE = 0,OUT = 0)
{
	var board = obj_Board,
		board_x = board.x,
		board_margin = [board.left, board.right],
		SIN = 0,
		LENGTH = (X_GAP - (board_x - board_margin[0]) - 14);
	
	for (var i = 0; i < AMOUNT; ++i)
	{
		SIN += (UDS * 0.3);
		LENGTH += ((cos(SIN) * UDF) * 4);
		Y += (((SPACE * HSPEED) * sign(-HSPEED)) / 4);
		
		var GAP_R = (((board_margin[0] + board_margin[1]) - LENGTH) - GAP),
			DURATION = (((640 + (SPACE * i)) / abs(HSPEED)) * 2);
		Bullet_BoneLeft(Y,LENGTH,HSPEED,TYPE,OUT,0,false,DURATION);
		Bullet_BoneRight(Y,GAP_R,HSPEED,TYPE,OUT,0,false,DURATION);
	}
}

/// @desc Creates a Horizontal Bone Wave
/// @param {real} x			The x position of the first bone
/// @param {real} length	The length of the first bone
/// @param {real} vspeed	The vspeed of the bones
/// @param {real} space		The space between bones
/// @param {real} amount	The amount of bones
/// @param {real} gap		The size of the bone gap
/// @param {real} udf		Sine wave multiplier
/// @param {real} uds		Sine wave intensity
/// @param {real} type		Color of the bones (Default White)
/// @param {real} out		Whether the bones are outside the board (Default 0)
function Bullet_BoneWaveV(X,Y_GAP,VSPEED,SPACE,AMOUNT,GAP,UDF,UDS,TYPE = 0,OUT = 0)
{
	var board = obj_Board,
		board_y = board.y,
		board_margin = [board.up, board.down],
		SIN = 0,
		LENGTH = (Y_GAP - (board_y - board_margin[0]) - 14);
	
	for (var i = 0; i < AMOUNT; ++i)
	{
		SIN += (UDS * 0.3);
		LENGTH += ((cos(SIN) * UDF) * 4);
		X += (((SPACE * VSPEED) * sign(-VSPEED)) / 4);
		
		var GAP_B = (((board_margin[0] + board_margin[1]) - LENGTH) - GAP),
			DURATION = (((480 + (SPACE * i)) / abs(VSPEED)) * 2);
		
		Bullet_BoneTop(X,LENGTH,VSPEED,TYPE,OUT,0,false,DURATION);
		Bullet_BoneBottom(X,GAP_B,VSPEED,TYPE,OUT,0,false,DURATION);
	}
}

///@desc Creates a Bone Cube
///@param {Array} Position			The x and y position of the cube
///@param {Array} Angles			The xyz angles of the cube
///@param {Array} Rotate_Speeds		The angle rotations of the cube
///@param {real} Scales				The xyzscale of the cube
///@param {real} Anim_Time			The time of the scaling animation (Default 0 - Instant)
///@param {function} Easing			The easing of the scaling animation (Default EaseLinear)
function Battle_BoneCube(pos, ans, rots, scale, anim_time = 0, ease = EaseLinear)
{
	var inst = instance_create_depth(pos[0], pos[1], -2, oBoneCube)
	with inst
	{
		angles = ans;
		angleAdd = rots;
		scalex = scale[0];
		scaley = scale[1];
		scalez = scale[2];
		if anim_time
		{
			TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, anim_time, "scalex", 0, scale[0]);
			TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, anim_time, "scaley", 0, scale[1]);
			TweenFire(id, ease, TWEEN_MODE_ONCE, false, 0, anim_time, "scalez", 0, scale[2]);
		}
	}
	return inst;
}