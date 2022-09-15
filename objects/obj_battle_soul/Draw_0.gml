var STATE = obj_battle_controller.battle_state;//if (STATE == BATTLE_STATE.IN_TURN or STATE == BATTLE_STATE.TURN_PREPARATION or (STATE == BATTLE_STATE.MENU and MENU != BATTLE_MENU.FIGHT_AIM and MENU != BATTLE_MENU.FIGHT_ANIM and MENU != BATTLE_MENU.FIGHT_DAMAGE))
var MENU = obj_battle_controller.menu_state;
if (STATE = 0 or STATE = 2) and (MENU != 5)
	draw_self();

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
