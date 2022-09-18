function Bullet_Bone_Gap_H(X,Y,VSPEED,X_GAP,TYPE = 0, OUT = 0,DESTROYABLE = 0,DURATION = -1)
{
	var board = obj_battle_board;
	var board_x = board.y;
	var board_margin = [board.left, board.right];
	var GAP = X_GAP / 2;
	var LENGTH_L = X - board_x + board_margin[0] - GAP;
	var LENGTH_R = board_x + board_margin[1] - GAP - X;
	
	Bullet_Bone_Left(Y,LENGTH_L,VSPEED,TYPE,OUT,0,DESTROYABLE,DURATION);
	Bullet_Bone_Right(Y,LENGTH_R,VSPEED,TYPE,OUT,0,DESTROYABLE,DURATION);	
}

function Bullet_Bone_Gap_V(X,Y,HSPEED,Y_GAP,TYPE = 0, OUT = 0,DESTROYABLE = 0,DURATION = -1)
{
	var board = obj_battle_board;
	var board_y = board.y;
	var board_margin = [board.up, board.down];
	var GAP = Y_GAP / 2;
	var LENGTH_T = Y - board_y + board_margin[0] - GAP;
	var LENGTH_B = board_y + board_margin[1] - GAP - Y;

	Bullet_Bone_Top(X,LENGTH_T,HSPEED,TYPE,OUT,0,DESTROYABLE,DURATION);
	Bullet_Bone_Bottom(X,LENGTH_B,HSPEED,TYPE,OUT,0,DESTROYABLE,DURATION);
}


