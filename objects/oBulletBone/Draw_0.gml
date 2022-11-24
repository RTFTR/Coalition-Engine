var _color = c_white;
if type == 1 _color = c_aqua;
if type == 2 _color = c_orange;
len_step();
axis_step();
length = max(14, length);
var _x = x;
var _y = y;

if angle_to_direction
image_angle = direction;
var _angle = image_angle + axis_angle + len_angle_extra;
var _alpha = image_alpha;
var _length = length / 14;

image_xscale = _length;
image_yscale = 1;

var _xscale = image_xscale;
var _yscale = image_yscale;

var _color_outline = _color;

Battle_Masking_Start(true);

draw_sprite_ext(sprite_index,image_index,_x,_y,_xscale,_yscale,_angle,_color,_alpha);
draw_sprite_ext(sprite_index,image_index + 1,_x,_y,_xscale,_yscale,_angle,_color_outline,_alpha);

	
Battle_Masking_End();

var ldx = lengthdir_x(length/2, _angle);
var ldy = lengthdir_y(length/2, _angle);
if collision_line(x + ldx, y + ldy, x-ldx,y-ldy, oSoul, 0, 0)
and image_alpha >= 1
{
	var collision = true;
	if type != 0 and type != 3
	{
		collision = (floor(oSoul.x) != floor(oSoul.xprevious) 
				  or floor(oSoul.y) != floor(oSoul.yprevious));
		collision = (type == 1 ? collision : !collision);
	}
	if collision Soul_Hurt(damage);
}


if global.show_hitbox
{
	draw_set_color(c_red)
	draw_line_width(x + ldx, y + ldy, x-ldx,y-ldy, 5)
	draw_set_color(c_white)
}





