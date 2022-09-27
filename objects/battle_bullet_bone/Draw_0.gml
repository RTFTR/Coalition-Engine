var _color = c_white;
if type == 1 _color = c_aqua;
if type == 2 _color = c_orange;

var _x = x;
var _y = y;

var _angle = image_angle + axis_angle + len_angle_extra;
var _alpha = image_alpha;
var _length = length / 14;

image_xscale = _length;
image_yscale = 1;

var _xscale = image_xscale;
var _yscale = image_yscale;

var _color_outline = c_white;
//if instance_exists(battle_enemy_toxin) _color_outline = c_lime;

Battle_Masking_Start(true);

draw_sprite_ext(spr_bone,0,_x,_y,_xscale,_yscale,_angle,_color,_alpha);
draw_sprite_ext(spr_bone,1,_x,_y,_xscale,_yscale,_angle,_color_outline,_alpha);

	
Battle_Masking_End();

var ldx = lengthdir_x(length/2, _angle);
var ldy = lengthdir_y(length/2, _angle);
if collision_line(x + ldx, y + ldy, x-ldx,y-ldy, obj_battle_soul, 0, 0)
and image_alpha >= 1
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


if global.show_hitbox
{
	draw_set_color(c_red)
	draw_line_width(x + ldx, y + ldy, x-ldx,y-ldy, 5)
	draw_set_color(c_white)
}





