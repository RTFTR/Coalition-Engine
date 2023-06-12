var reveal_states = (menu_state == INTRO_MENU_STATE.SETTINGS)   or 
					(menu_state == INTRO_MENU_STATE.FIRST_TIME) or
					(menu_state == INTRO_MENU_STATE.MENU);

if reveal_states
{
	var default_halign = draw_get_halign(),
		default_valign = draw_get_valign(),
		default_font = draw_get_font(),
		credit_text = "UNDERTALE (C) TOBY FOX 2015-" + string(current_year);
		credit_text += "\nCoalition Engine " + ENGINE_VERSION + " by Cheetos Bakery";
	
	draw_set_color(c_gray);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_font(fnt_cot);
	draw_text(320, 476, credit_text);
	
	draw_set_color(c_white);
	draw_set_halign(default_halign);
	draw_set_valign(default_valign);
	draw_set_font(default_font);
}
