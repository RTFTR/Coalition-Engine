var board = target_board;
if timer timer--;
DurationTimer++;

len_step();
axis_step();

length = max(14, length);
if angle_to_direction
	image_angle = direction;

image_angle += rotate;

if !Len.activate
{
	var half_len = length / 2;
	switch mode
	{
		case 1:
			y = board.y - board.up + half_len;
		break
		case 2:
			y = board.y + board.down - half_len;
		break
		case 3:
			x = board.x - board.left + half_len;
		break
		case 4:
			x = board.x + board.right - half_len;
		break
	}
}

if (at_turn_end and length < 11) or (duration != -1 and DurationTimer >= duration)
	instance_destroy();

