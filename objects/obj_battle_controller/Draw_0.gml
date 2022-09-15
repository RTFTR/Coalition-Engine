// Text Functions
if battle_state == 0
{	
	var ncontains_enemy = 0;
	for (var i = 0; i < 3; i++)
	ncontains_enemy += (enemy[| i] = noone);
	var target_option = menu_choice[0] + ncontains_enemy;
	
	if menu_state == 0 or menu_state == -1
	{
		text_writer.starting_format("font_dt_mono",c_white)
		text_writer.draw(52, 272, menu_text_typist)
		
		
		if input_check_pressed("cancel")
		{
			text_writer.page(text_writer.get_page_count() - 1);
			menu_text_typist.skip();
		}
		if menu_text_typist.get_state() == 1 and text_writer.get_page() < (text_writer.get_page_count() - 1)
			text_writer.page(text_writer.get_page() + 1)
		if menu_state == -1 and menu_text_typist.get_state() == 1
		{
			if input_check_pressed("confirm")
				begin_turn();
		}
	}
	
	if menu_state == 1 or menu_state == 2 // Fight - Act
	{	
		var decrease_y = 0;
		for (var i = 0; i < ds_list_size(enemy_name); i++) // Draw enemy hp bar in Fight state
		{
			var _enemy_name = enemy_name[| i];
			if instance_exists(enemy[| i]) // Check if the enemy slot is valid before name drawing
			{
				var spare_col = "[c_white]";
				if enemy[| i].enemy_is_spareable
				spare_col = global.SpareTextColor;
				draw_text_scribble(96,272+(32*i)-decrease_y, spare_col + "[font_dt_mono]* " + _enemy_name);
				var xwrite = 450;
				if menu_state == 1 and enemy_draw_hp_bar[| i] == 1
				{
					decrease_y -= 32;
					draw_set_color(c_red);
					var lineheight = 32;
					var y_start = 247;
					draw_rectangle(xwrite, y_start + (i * lineheight) - decrease_y, xwrite + 100, y_start + (i * lineheight) + 17 - decrease_y, false);
					draw_set_color(c_lime);
					draw_rectangle(xwrite, y_start + (i * lineheight) - decrease_y, xwrite + ((enemy_hp[| i] / enemy_hp_max[| i]) * 100), y_start + (i * lineheight) + 17 - decrease_y, false);
					draw_set_color(c_white);
					decrease_y += 32;
				}
			}
			else decrease_y += 32;
		}
	}
	if menu_state == 3 // Item list
	{
		var coord = menu_choice[2];
		var c_div = floor(coord / 4);
		var itm_ln = Item_Space();
		Item_Info_Load();
	
		for (var i = 0; i < min(4, itm_ln - (c_div * 4)); ++i)
		{
			var xx = (64 + ((i % 2) * 256)) + 32
			var yy = 272 + (floor(i / 2) * 32)
		
			draw_text_scribble(xx, yy, "[font_dt_mono]* " + item_name[i + (c_div * 4)])
		}
		
		// Heal text and Page
		draw_text_scribble(128, 341, "[font_dt_mono][c_lime](+" + string(item_heal[coord]) + ")")
		draw_text_scribble(384, 341, "[font_dt_mono]PAGE " + string(c_div + 1))
	}
	if menu_state == 4
	{
		// Sets the color of Spare
		var spare_col = "[c_white]";
		for (var i = 0; i < ds_list_size(enemy); i++)
		{
			if enemy[| i] != noone
			if enemy[| i].enemy_is_spareable
			spare_col = global.SpareTextColor;
		}
		draw_text_scribble(96, 272, spare_col+"[font_dt_mono]* Spare" + (allow_run ? "[c_white]\n* Flee" : ""));
	}
	if menu_state == 6		// Draw Act Texts
	{
		var enemy_check_texts = "";
		var act_num = array_length(enemy_act[target_option]);
		for (var i = 0; i < act_num; ++i)
		{
			var assign_act_text = enemy_act[target_option, i];
			if assign_act_text != "" enemy_check_texts += "* " + assign_act_text;
			if (i % 2) enemy_check_texts += "\n";
			else for (var ii = 14; ii > string_length(enemy_act[target_option, i]); --ii)
				enemy_check_texts += " ";
		}
		draw_text_scribble(96, 272, "[font_dt_mono]" + enemy_check_texts)
	}
	
	if menu_state == 5 //Fight Anim
	{
		var _target_state = target_state;
		var _aim_scale = aim_scale;
		var _aim_angle = aim_angle;
		var _aim_color = aim_color;
		var _aim_retract = aim_retract;
		if _target_state > 0
		{	
			var _target_side = target_side;
			var _target_time = target_time;
			var _target_xscale = target_xscale;
			var _target_yscale = target_yscale;
			var _target_frame = target_frame;
			var _target_alpha = target_alpha;
			var _target_retract_method = target_retract_method;
			
			var _aim_target_x = 320 - (_target_side * (290 - _target_time));
			
			if _target_state < 3
			{
				if _target_state == 1
				{
					_target_time += 6.4;
					var _aim_distance = abs(320 - _aim_target_x);
					_aim_color = make_color_rgb(255, 255, clamp(_aim_distance, 0, 255));
					if input_check_pressed("confirm") and target_buffer < 0
					{
						battle_turn++;
						target_buffer = 3;
						_target_state = 2;
						if _aim_distance < 15
						Blur_Screen(45, (15 - _aim_distance) / 2);
						alarm[0] = 60
						
						var strike_target_x = 160 * (target_option + 1);
						enemy_under_attack(target_option);
						Calculate_MenuDamage(_aim_distance, target_option);
						instance_create_depth(strike_target_x, 160, -10, obj_strike);
						audio_play_sound(snd_slice, 50, false);
					}
					if _target_time >= 575 {  menu_state = 0; _target_state = 3; battle_state = 0;}
				}
				else _target_frame += 0.2;
			}
			else
			{
				_target_alpha -= 0.04;
				if _target_retract_method == 0
				_target_xscale -= 0.03;
				else _target_yscale -= 0.03;
				
				if _aim_scale > 0
				_aim_scale -= 0.075;
				else _aim_scale = 0;
				_aim_angle += _aim_retract * 3;
				
				if _target_xscale < 0.08 or _target_yscale < 0.08
				{
					_target_state = 0;
					dialog_start();
					menu_state = -1;
				}
			}
			
			draw_sprite_ext(spr_target_bg, 0, 320, 320, _target_xscale, _target_yscale, 0, c_white, _target_alpha);
			draw_sprite_ext(spr_target_aim, _target_frame, _aim_target_x, 320, _aim_scale, _aim_scale, _aim_angle, _aim_color, 1);
	
			target_side = _target_side;
			target_time = _target_time;
			target_xscale = _target_xscale;
			target_yscale = _target_yscale;
			target_frame = _target_frame;
			target_alpha = _target_alpha;
		}
		target_state = _target_state;
		
		aim_scale = _aim_scale;
		aim_angle = _aim_angle;
		aim_color = _aim_color;
	}
}
if battle_state == 3
{
	battle_end_text_writer.starting_format("font_dt_mono",c_white)
	battle_end_text_writer.draw(52, 272, battle_end_text_typist)
		
		
	if input_check_pressed("cancel")
	{
		battle_end_text_writer.page(battle_end_text_writer.get_page_count() - 1);
		battle_end_text_typist.skip();
	}
	if battle_end_text_typist.get_state() == 1 and battle_end_text_writer.get_page() < (battle_end_text_writer.get_page_count() - 1)
		battle_end_text_writer.page(battle_end_text_writer.get_page() + 1)
	if battle_end_text_typist.get_state() == 1
	{
		if input_check_pressed("confirm")
			game_restart();
	}
}
// Buttons 
{
	// Credits to Scarm for the base code
	var _button_spr = button_spr;
	var _button_pos = button_pos;
	var _button_alpha = button_alpha;
	var _button_scale = button_scale;
	var _button_color = button_color; 
	var _state = menu_state;
	var _menu = menu_button_choice; 

	for (var i = 0; i < array_length(_button_spr); ++i) // Button initialize
	{	
		// If no item left then item button commit gray
		if global.item[0] <= 0 and i == 2 button_color_target[2] = [ [54,54,54],[54,54,54] ];
		
		// Check if the button is chosen
		var select = (_menu == i) and _state >= 0 and _state != -1 
		
		// Draw the button by array order
		draw_sprite_ext(_button_spr[i], select, _button_pos[i][0], _button_pos[i][1], _button_scale[i], _button_scale[i], 0, make_color_rgb(_button_color[i][0],_button_color[i][1],_button_color[i][2]), _button_alpha[i]);
	
		// Animation - Color updating in real-time because fuck yes
		if (_state >= 0 and _state != -1) 
		{
			if _menu == i // The chosen button
			{
				_button_scale[_menu] += (button_scale_target[1] - _button_scale[_menu]) / 6;
				_button_alpha[_menu] += (button_alpha_target[1] - _button_alpha[_menu]) / 6;
				_button_color[_menu][0] += (button_color_target[_menu][1][0] - _button_color[_menu][0]) / 6;
				_button_color[_menu][1] += (button_color_target[_menu][1][1] - _button_color[_menu][1]) / 6;
				_button_color[_menu][2] += (button_color_target[_menu][1][2] - _button_color[_menu][2]) / 6;
			}
			else // Other buttons if they aren't chosen
			{
				_button_scale[i] += (button_scale_target[0] - _button_scale[i]) / 6;
				_button_alpha[i] += (button_alpha_target[0] - _button_alpha[i]) / 6;
				_button_color[i][0] += ((button_color_target[i][0][0]) - (_button_color[i][0])) / 6;
				_button_color[i][1] += ((button_color_target[i][0][1]) - (_button_color[i][1])) / 6;
				_button_color[i][2] += ((button_color_target[i][0][2]) - (_button_color[i][2])) / 6;
			}
		}
		else // If the menu state is over
		{
			_button_scale[i] += (button_scale_target[0] - _button_scale[i]) / 6;
			_button_alpha[i] += (button_alpha_target[0] - _button_alpha[i]) / 6;
			_button_color[i][0] += ((button_color_target[i][0][0]) - (_button_color[i][0])) / 6;
			_button_color[i][1] += ((button_color_target[i][0][1]) - (_button_color[i][1])) / 6;
			_button_color[i][2] += ((button_color_target[i][0][2]) - (_button_color[i][2])) / 6;
		}
	}
}

// UI (Name - Lv - Hp - Kr)
{
	time++;
	// Credits to Scarm for all the help and this epico code!
	var hp_x = global.kr_activation != true ? ui_x : (ui_x - 20);
	var hp_y = ui_y;
	var name_x = ui_x - 245;
	var name_y = ui_y;
	var name = global.name;
	var default_col = c_white;
	var name_col = c_white;
	var lv_col = c_white;
	var lv_counter_col = c_white;
	var hp_max_col = merge_color(c_red, c_maroon, 0.5);
	var hp_col = c_yellow;
	var kr_col = c_fuchsia;
	var krr_col = c_white;
	var bar_multiplier = 1.2; //Default multiplier from UNDERTALE
	var hp_text = "HP";
	var kr_text = "KR";

	// Linear health updating / higher refill_speed = faster refill / max refill_speed is 1
	hp += (global.hp - hp) * refill_speed;
	hp_max += (global.hp_max - hp_max) * refill_speed;
	kr += (global.kr - kr) * refill_speed;
	hp = clamp(hp, 0, global.hp_max);
	hp_max = clamp(hp_max, 0, global.hp_max);
	kr = clamp(kr, 0, max_kr);
	//Prevent long decimals
	if abs(hp - global.hp) < 1 hp = global.hp;
	if abs(kr - global.kr) < 1 kr = global.kr;
	
	draw_set_font(font_mnc); // Name - LV Font
	// Name
	draw_text_color(name_x, name_y, name, name_col, name_col, name_col, name_col, ui_alpha);
	// LV Icon
	draw_text_color(name_x + string_width(name), name_y, "   LV ", lv_col, lv_col, lv_col, lv_col, ui_alpha);
	// LV Counter
	draw_text_color(name_x + string_width(name + "   LV "), name_y, string(global.lv), lv_counter_col, lv_counter_col, lv_counter_col, lv_counter_col, ui_alpha);

	draw_set_font(font_uicon); // Icon Font
	// HP Icon
	draw_text_color((hp_x - 31), hp_y + 5, hp_text, default_col, default_col, default_col, default_col, ui_alpha);

	// Background bar
	draw_rectangle_color(hp_x, hp_y, hp_x + (hp_max * bar_multiplier), hp_y + 20, hp_max_col, hp_max_col, hp_max_col, hp_max_col, false);
	// HP bar
	draw_rectangle_color(hp_x, hp_y, hp_x + (hp * bar_multiplier), hp_y + 20, hp_col, hp_col, hp_col, hp_col, false);
	
	if menu_state == 3
	{
		hp_predict += (item_heal[coord] - hp_predict) * refill_speed;
		//Healing thing
		draw_set_alpha(abs(sin(time / 40) * 0.4) + 0.1);
		draw_rectangle_color(hp_x + hp * bar_multiplier, hp_y, hp_x + min(hp + hp_predict, hp_max) * bar_multiplier, hp_y + 20, c_lime, c_lime, c_lime, c_lime, false);
		draw_set_alpha(1);
	}
	
	// KR bar
	if global.kr_activation = true
	{
		if round(kr) > 0 krr_col = kr_col;
		else krr_col = c_white;
	
		global.kr = clamp(global.kr, 0, min(max_kr, global.hp_max - global.hp));
	
		// Draw the bar
		if round(kr) > 0
		draw_rectangle_color(hp_x + (hp * bar_multiplier) + 1, hp_y, max((hp_x + ((hp * bar_multiplier) - (kr * bar_multiplier))), hp_x), hp_y + 20, krr_col, krr_col, krr_col, krr_col, false);
	
		// Draw icon
		draw_text_color((hp_x + 10) + (hp_max * bar_multiplier), hp_y + 5, kr_text, krr_col, krr_col, krr_col, krr_col, ui_alpha);
	}

	// Zeropadding
	var hp_counter = string(round(hp));
	var hp_max_counter = string(round(hp_max));
	if round(hp) < 10 hp_counter = "0" + string(round(hp));
	if round(hp_max) < 10 hp_max_counter = "0" + string(round(hp_max));

	// This line below supports multiple digits for Zeropadding, but I just personally don't like it. 
	// var hp_counter = string_replace_all(string_format(round(hp), string_length(string(hp_max)), 0), " ", "0");

	// Draw the health counter
	draw_set_color(krr_col);
	draw_set_font(font_mnc); // Counter Font
	var offset = global.kr_activation = false ? 15 : (20 + string_width(kr_text));
	draw_text((hp_x + offset) + (hp_max * bar_multiplier), hp_y, hp_counter + " / " + hp_max_counter);
}

draw_set_color(c_white);
draw_set_alpha(1);

