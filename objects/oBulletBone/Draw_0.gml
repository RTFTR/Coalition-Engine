var _color = base_color;
if type == 1 _color = c_aqua;
if type == 2 _color = c_orange;
var _x = x,
	_y = y;

var _angle = image_angle + axis_angle + len_angle_extra,
	_alpha = image_alpha,
	_length = length / 14,
	LengthX = length / 2 * dcos(_angle),
	LengthY = length / 2 * -dsin(_angle);

image_xscale = _length;
image_yscale = 1;

var _xscale = image_xscale,
	_yscale = image_yscale,
	_color_outline = _color;

Battle_Masking_Start(true);

draw_sprite_ext(sprite_index,image_index,_x,_y,_xscale,_yscale,_angle,_color,_alpha);
draw_sprite_ext(sprite_index,image_index + 1,_x,_y,_xscale,_yscale,_angle,_color_outline,_alpha);

	
Battle_Masking_End();

if global.show_hitbox
{
	draw_set_color(c_red);
	draw_line_width(x + LengthX, y + LengthY, x - LengthX, y - LengthY, 5)
	draw_set_color(c_white);
}

//Collision
if collision_line(x + LengthX, y + LengthY, x - LengthX,y - LengthY, oSoul, 0, 0)
and image_alpha >= 1
{
	var collision = true;
	if type != 0 and type != 3
	{
		collision = IsSoulMoving();
		collision = (type == 1 ? collision : !collision);
	}
	if collision Soul_Hurt(damage);
}
