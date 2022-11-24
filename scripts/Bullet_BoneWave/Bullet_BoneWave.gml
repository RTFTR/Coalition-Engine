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
	var board = oBoard;
	var board_x = board.x;
	var board_margin = [board.left, board.right];
	var SIN = 0;
	var LENGTH = (X_GAP - (board_x - board_margin[0]) - 14);
	
	for (var i = 0; i < AMOUNT; ++i)
	{
		SIN += (UDS * 0.3);
		LENGTH = (LENGTH + ((cos(SIN) * UDF) * 4));
		if HSPEED > 0 Y -= ((SPACE * HSPEED) / 4);
		else Y += (((SPACE * HSPEED) * -1) / 4);
		
		var GAP_R = (((board_margin[0] + board_margin[1]) - LENGTH) - GAP);
		var DURATION = (((640 + (SPACE * i)) / abs(HSPEED)) * 2);
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
	var board = oBoard;
	var board_y = board.y;
	var board_margin = [board.up, board.down];
	var SIN = 0;
	var LENGTH = (Y_GAP - (board_y - board_margin[0]) - 14);
	
	for (var i = 0; i < AMOUNT; ++i)
	{
		SIN += (UDS * 0.3);
		LENGTH = (LENGTH + ((cos(SIN) * UDF) * 4));
		if VSPEED > 0 X -= ((SPACE * VSPEED) / 4);
		else X += (((SPACE * VSPEED) * -1) / 4);
		
		var GAP_B = (((board_margin[0] + board_margin[1]) - LENGTH) - GAP);
		var DURATION = (((480 + (SPACE * i)) / abs(VSPEED)) * 2);
		
		Bullet_BoneTop(X,LENGTH,VSPEED,TYPE,OUT,0,false,DURATION);
		Bullet_BoneBottom(X,GAP_B,VSPEED,TYPE,OUT,0,false,DURATION);
	}
}

