//@desc True creation
active = true;
state = 1;
var board = obj_Board,
	board_x = board.x,
	board_y = board.y,
	board_u = board_y - board.up,
	board_d = board_y + board.down,
	board_l = board_x - board.left,
	board_r = board_x + board.right;
if dir == DIR.UP or dir == DIR.DOWN
{
	x = board_x;
	y = (dir == DIR.UP) ? board_u - height : board_d + height;
}
if dir == DIR.LEFT or dir == DIR.RIGHT
{
	y = board_y;
	x = (dir == DIR.LEFT) ? board_l - height : board_r + height;
}

target_x = x;
target_y = y;

if sound_warn
{
	audio_play(snd_warning, true);
	sound_warn = false;
}
