len_step();
axis_step();
var _color = sticky ? c_lime : c_fuchsia,
	_sprite = sprPlatform,
	_angle = image_angle,
	_alpha = image_alpha,
	_length = length / 4;

image_xscale = _length;
image_yscale = 1;

var _image_xscale = image_xscale,
	_image_yscale = image_yscale;


var _x = x,
	_y = y;

Battle_Masking_Start(true);

draw_sprite_ext(_sprite,0,_x,_y,_image_xscale,_image_yscale,_angle,c_white,_alpha);
draw_sprite_ext(_sprite,1,_x,_y,_image_xscale,_image_yscale,_angle,_color,_alpha);

Battle_Masking_End();

if effect
{
	if effect == 1
		effect = 2;
	if effect == 2
	{
		audio_play(snd_ding);
		effect_xscale = _image_xscale;
		effect_yscale = _image_yscale;
		effect_alpha = 1;
		effect_x = x;
		effect_y = y;
		effect = 3;
	}
	if effect == 3
	{
		effect_xscale += 0.6;
		effect_yscale += 0.15;
		if effect_alpha > 0
			effect_alpha -= 0.035;
		else effect = false;
	}
	var _xscale = effect_xscale,
		_yscale = effect_yscale;
	_alpha = effect_alpha;
	 _color = image_blend;
	_x = effect_x;
	_y = effect_y;
	draw_sprite_ext(_sprite,0,_x,_y,_xscale,_yscale,_angle,c_white,_alpha);
	draw_sprite_ext(_sprite,1,_x,_y,_xscale,_yscale,_angle,_color,_alpha);
}

show_hitbox(c_lime)

