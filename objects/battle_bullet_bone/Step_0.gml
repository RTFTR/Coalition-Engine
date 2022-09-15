if place_meeting(x,y,obj_battle_soul) and image_alpha >= 1
{
	var collision = true;
	if type != 0 and type != 3
	{
		collision = (floor(obj_battle_soul.x) != floor(obj_battle_soul.xprevious) 
				  or floor(obj_battle_soul.y) != floor(obj_battle_soul.yprevious));
		collision = (type == 1 ? collision : !collision);
	}
	if collision
		Soul_Hurt();
}

if timer > 0
    timer--

image_angle += rotate

if lenable
{
    len_dir += len_dir_move;
    len += len_speed;
    x = len_x + lengthdir_x(len,len_dir);  
    y = len_y + lengthdir_y(len,len_dir);
    if (len_angle)
        image_angle += len_dir_move;
}
else if mode != 0
{
	if mode == 1 y = (obj_battle_board.y - obj_battle_board.up) + (length / 2);
	if mode == 2 y = (obj_battle_board.y + obj_battle_board.down) - (length / 2);
	if mode == 3 x = (obj_battle_board.x - obj_battle_board.left) + (length / 2);
	if mode == 4 x = (obj_battle_board.x + obj_battle_board.right) - (length / 2);
}
