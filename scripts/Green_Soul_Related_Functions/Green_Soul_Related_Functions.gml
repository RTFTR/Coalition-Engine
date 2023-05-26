///@desc Creates a Green Soul Arrow with given params
///@param {real} time	The time (in frames) taken for the arrow to reach the soul
///@param {real} speed	The speed of the arrow
///@param {real} direction	The direction of the Arrow
///@param {real} mode	The mode of the arrow (Macros provided by ARROW_MODE)
///@param {real} color	The color of the arrow (Default 0)
function Bullet_Arrow(Time, Spd, Dir, Mode = 0, color = 0)
{
	if Dir < 90 Dir *= 90;
	var arrow = instance_create_depth(0, 0, -2, oGreenArr)
	with arrow
	{
		spd = Spd;
		mode = Mode;
		dir = Dir;
		if mode == 1 or mode == 3
			dir -= 180;
		len = Time * spd;
		index += color * 4;
		Color = color;
	}
	return arrow;
}

///@desc Creates multiple arrows that comes like a rhythm game
///@param {real} delay	The delay of the whole barrage
///@param {real} beat	The interaval of the arrows
///@param {real} speed	The speed of the arrows
///@param {array} tags	The entire barrage of arrows, "/" for empty and "R" for random direction, "$X" for the arrow to come in the respective direction
///@param {array} *func_name	The name of the functions
///@param {array} *functions	The functions that will be called when you put it in the tags, similar to scrrible_typists_add_event
function CreateArrows(delay, beat, spd, tags, func_name = -1, functions = -1)
{
	var dir = 1, fire = true, i = 0;
	repeat(array_length(tags))
	{
		var tag = [], mode = 0, col = 0;
		
		for(var ii = 1, nn = string_length(tags[0]); ii <= nn; ++ii)
			array_push(tag, string_char_at(tags[0], ii));
		nn = array_length(tags);
		var First = string_char_at(tags[0], 1);
		
		if (tags[0] == "/") fire = false;
		else if (First == "R")
		{
			dir = irandom(3);
			if (nn > 1) col = tags[1];
			if (nn > 2) mode = tags[2];
		}
		else if (First == "$")
		{
			dir = real(tag[1]);
			if (nn > 2) col = tags[2];
			if (nn > 3) mode = tags[3];
		}
		else
		{
			if (is_array(func_name) && is_array(functions))
				for(var ii = 0, nn = array_length(func_name); ii < nn; ++ii)
				{
					if (tags[0] == func_name[ii])
					{
						var _handle = call_later(delay + i * beat, time_source_units_frames, functions[ii]);
					}
				}
		}
		if fire
			Bullet_Arrow(delay + i * beat, spd, dir);
		fire = true;
		array_delete(tags, 0, 1);
		i++;
	}
}



enum ARROW_TYPE
{
	NORMAL = 0,
	FLIP = 1,
	DIAGONAL = 2,
	DIAGONAL_FLIP = 3,
}