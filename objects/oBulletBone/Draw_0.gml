//Bone coloring
var _color;
switch type
{
	case 0: _color = base_color;	break;
	case 1: _color = c_aqua;		break;
	case 2: _color = c_orange;		break;
}
var _x = x,
	_y = y,
	//Add angle from normal angle and special calculations
	_angle = image_angle + Axis.angle + Len.angle_extra,
	_alpha = image_alpha,
	_length = length / 14,
	LengthX = length / 2 * dcos(_angle),
	LengthY = length / 2 * -dsin(_angle);

image_xscale = _length;

var _xscale = _length,
	_yscale = 1,
	_color_outline = _color;

//Mask the bone inside the board
Battle_Masking_Start(true);
//Using image_index in case you are using several indexes for several types of bones
draw_sprite_ext(sprite_index, image_index, _x, _y, _xscale, _yscale, _angle, _color, _alpha);
draw_sprite_ext(sprite_index, image_index + 1, _x, _y, _xscale, _yscale, _angle, _color_outline, _alpha);

	
Battle_Masking_End();

if global.show_hitbox
{
	draw_set_color(c_red);
	draw_line_width(x + LengthX, y + LengthY, x - LengthX, y - LengthY, 5)
	draw_set_color(c_white);
}

//Collision
for(var i = -2.5; i < 2.5; i++)
{
	if image_alpha < 1 continue;
	if collision_line(x + LengthX + lengthdir_x(i, image_angle + 90), y + LengthY + lengthdir_y(i, image_angle + 90), x - LengthX + lengthdir_x(i, image_angle + 90), y - LengthY + lengthdir_y(i, image_angle + 90), oSoul, 0, 0)
	{
		var collision = true;
		if type != 0 and type != 3
		{
			collision = IsSoulMoving();
			collision = (type == 1 ? collision : !collision);
		}
		if collision Soul_Hurt(damage);
	}
}