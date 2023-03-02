var board = oBoard;
if timer timer--;
DurationTimer++;
len_step();
axis_step();

image_angle += rotate;

if !lenable
{
	switch mode
	{
		case 1:
			y = board.y - board.up + (length / 2);
		break
		case 2:
			y = board.y + board.down - (length / 2);
		break
		case 3:
			x = board.x - board.left + (length / 2);
		break
		case 4:
			x = board.x + board.right - (length / 2);
		break
	}
}

if (at_turn_end and length < 11) or (duration != -1 and DurationTimer >= duration)
	instance_destroy();

