var angle = image_angle % 360
angle = round(angle / 90);
switch angle
{
	case 0: destroydir = DIR.DOWN;	break
	case 1: destroydir = DIR.RIGHT; break
	case 2: destroydir = DIR.UP;	break
	case 3: destroydir = DIR.LEFT;	break
}