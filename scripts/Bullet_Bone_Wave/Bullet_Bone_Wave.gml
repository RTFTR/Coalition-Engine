function Bullet_Bone_Wave_H(Y,X_GAP,HSPEED,SPACE,AMOUNT,GAP,UDF,UDS,TYPE = 0,OUT = 0)
{
	var board = obj_battle_board;
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
		Bullet_Bone_Left(Y,LENGTH,HSPEED,TYPE,OUT,0,false,DURATION);
		Bullet_Bone_Right(Y,GAP_R,HSPEED,TYPE,OUT,0,false,DURATION);
	}
}

function Bullet_Bone_Wave_V(X,Y_GAP,VSPEED,SPACE,AMOUNT,GAP,UDF,UDS,TYPE = 0,OUT = 0)
{
	var board = obj_battle_board;
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
		
		Bullet_Bone_Top(X,LENGTH,VSPEED,TYPE,OUT,0,false,DURATION);
		Bullet_Bone_Bottom(X,GAP_B,VSPEED,TYPE,OUT,0,false,DURATION);
	}
}

