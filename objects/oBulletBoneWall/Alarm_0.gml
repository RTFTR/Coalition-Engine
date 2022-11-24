active = true;
state = 1;
var board = oBoard;
var board_x = board.x;
var board_y = board.y;
var board_margin = [board.up, board.down, board.left, board.right];

var board_u = board_y - board_margin[0];
var board_d = board_y + board_margin[1];
var board_l = board_x - board_margin[2];
var board_r = board_x + board_margin[3];
if dir == DIR.UP or dir == DIR.DOWN
{
	x = board_x;
	
	if dir == DIR.UP   y = board_u - height + 2;
	if dir == DIR.DOWN y = board_d + height - 2;
}
if dir == DIR.LEFT or dir == DIR.RIGHT
{
	y = board_y;
	
	if dir == DIR.LEFT  x = board_l - height + 4;
	if dir == DIR.RIGHT x = board_r + height - 4;
	
}

target_x = x;
target_y = y;

if sound_warn
{
	audio_stop_sound(snd_warning);
	audio_play_sound(snd_warning, 50, false);
	sound_warn = false;
}
