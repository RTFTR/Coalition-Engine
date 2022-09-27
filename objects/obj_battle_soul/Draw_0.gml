var STATE = obj_battle_controller.battle_state;
var MENU = obj_battle_controller.menu_state;
if (STATE = 0 or STATE = 2) and (MENU != 5)
	draw_self();

if mode = SOUL_MODE.GREEN
	if Battle_GetState() == 2
	{
		draw_circle_colour(x, y, 30, c_green, c_green, 1);
		_x = lengthdir_x(ShieldLen, ShieldDrawAngle) + x;
		_y = lengthdir_y(ShieldLen, ShieldDrawAngle) + y;
		draw_sprite_ext(spr_GreenShield, ShieldIndex, _x, _y, 1, 1, ShieldDrawAngle - 90, c_white, 1);
		
		_x = lengthdir_x(ShieldLen + 13, ShieldDrawAngle) + x + lengthdir_x(30, ShieldDrawAngle + 90);
		_y = lengthdir_y(ShieldLen + 6, ShieldDrawAngle) + y + lengthdir_y(30, ShieldDrawAngle + 90);
		var __x = lengthdir_x(ShieldLen + 13, ShieldDrawAngle) + x - lengthdir_x(30, ShieldDrawAngle + 90);
		var __y = lengthdir_y(ShieldLen + 16, ShieldDrawAngle) + y - lengthdir_y(30, ShieldDrawAngle + 90);
		with(obj_battle_bullet_parents)
			with(other)
				if collision_line(_x, _y, __x, __y, other, false, false)
				{
					sfx_play(snd_ding);
					ShieldIndex = 2;
					instance_destroy(other);
				}
	}

if effect
{
	var _sprite = sprite_index;
	var _xscale = effect_xscale;
	var _yscale = effect_yscale;
	var _alpha = effect_alpha;
	var _angle = effect_angle;
	var _color = image_blend;
	var _x = effect_x;
	var _y = effect_y;
	draw_sprite_ext(_sprite,0,_x,_y,_xscale,_yscale,_angle,_color,_alpha);
}

show_hitbox()
