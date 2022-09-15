var _color = c_white;
if type == 1 _color = c_aqua;
if type == 2 _color = c_orange;

var _x = x;
var _y = y;

var _angle = image_angle;
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





