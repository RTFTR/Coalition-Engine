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
	var board = oBoard;
	var board_x = board.y;
	var board_margin = [board.left, board.right];
	var GAP = X_GAP / 2;
	var LENGTH_L = X - board_x + board_margin[0] - GAP;
	var LENGTH_R = board_x + board_margin[1] - GAP - X;
	
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
	var board = oBoard;
	var board_y = board.y;
	var board_margin = [board.up, board.down];
	var GAP = Y_GAP / 2;
	var LENGTH_T = Y - board_y + board_margin[0] - GAP;
	var LENGTH_B = board_y + board_margin[1] - GAP - Y;

	bone_top = Bullet_BoneTop(X,LENGTH_T,HSPEED,TYPE,OUT,0,DESTROYABLE,DURATION);
	bone_bottom = Bullet_BoneBottom(X,LENGTH_B,HSPEED,TYPE,OUT,0,DESTROYABLE,DURATION);
}


