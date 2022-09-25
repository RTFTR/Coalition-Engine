if place_meeting(x,y,obj_battle_soul) and image_alpha >= 1
{
	var collision = true;
	if type != 0 and type != 3
	{
		collision = (floor(obj_battle_soul.x) != floor(obj_battle_soul.xprevious) 
				  or floor(obj_battle_soul.y) != floor(obj_battle_soul.yprevious));
		collision = (type == 1 ? collision : !collision);
	}
	if collision Soul_Hurt();
}

var board = obj_battle_board;
if timer timer--;

image_angle += rotate;

len_step()

if mode and !lenable
{
	if mode == 1 y = (board.y - board.up) + (length / 2);
	if mode == 2 y = (board.y + board.down) - (length / 2);
	if mode == 3 x = (board.x - board.left) + (length / 2);
	if mode == 4 x = (board.x + board.right) - (length / 2);
}

axis_step();
