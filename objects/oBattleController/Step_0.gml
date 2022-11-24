var input_horizontal = input_check_pressed("right") - input_check_pressed("left");
var input_vertical = input_check_pressed("down") - input_check_pressed("up");
var input_confirm = input_check_pressed("confirm");
var input_cancel = input_check_pressed("cancel");

//Check for empty slots of enemy
var ncontains_enemy = 0;
var no_enemy_pos = [2];
for (var i = 0; i < 2; i++) {
	if enemy[i] == noone {
		ncontains_enemy++;
		no_enemy_pos[array_length(no_enemy_pos) - 1] = i;
	}
	else continue;
}
var target_option = menu_choice[0] + (menu_choice[0] >= no_enemy_pos[0] ? ncontains_enemy : 0);

if battle_state = 0 // Menu
{
	if menu_state = 0 // Button selection
	{
		var _button_len = array_length(button_spr);
		var _button_pos = button_pos;
		var _button_slot = menu_button_choice;

		if input_horizontal != 0 {
			_button_slot = Posmod(_button_slot + input_horizontal, _button_len);
			menu_button_choice = _button_slot;
			Move_Noise();
		}

		oSoul.visible = true;
		oSoul.x += ((_button_pos[_button_slot][0] - 47) - oSoul.x) / 3;
		oSoul.y += ((_button_pos[_button_slot][1] + 1) - oSoul.y) / 3;

		if input_confirm {
			Confirm_Noise();
			menu_state = _button_slot + 1;

			if menu_state == 3 and global.item[0] = 0 {
				menu_state = 0;
				audio_stop_sound(snd_menu_confirm);
			}
		}
	} else if is_val(menu_state, 1, 2, 4) // Fight - Act - Mercy
	{
		var coord = menu_choice[0];
		var len = 1;
		if is_val(menu_state, 1, 2) len = no_enemy_pos[0];
		else {
			coord = menu_choice[3];
			len = 1 + allow_run;
		}

		if len > 1 {
			if input_vertical != 0 {
				coord = Posmod(coord + input_vertical, len);
				menu_choice[is_val(menu_state, 1, 2) ? 0 : 3] = coord;
				Move_Noise();
			}
		}
		if input_cancel {
			menu_choice[0] = 0;
			menu_state = 0;
		}
		if input_confirm {
			Confirm_Noise();
			if menu_state == 1 {
				menu_state = 5; // Fight Aiming

				target_buffer = 3;
				target_state = 1;
				target_side = choose(-1, 1);
				target_time = 0;
				target_xscale = 1;
				target_yscale = 1;
				target_frame = 0;
				target_alpha = 1;
				target_retract_method = choose(0, 1);
				aim_scale = 1;
				aim_angle = 0;
				aim_color = c_white;
				aim_retract = choose(-1, 1);

				// Insert code that makes soul invincible
				{
					if instance_exists(oBulletParents) oBulletParents.can_hurt = 0;
				}
			}
			if menu_state == 2 menu_state = 6; // Act Selection
			if menu_state == 4 menu_state = 7; // Spare
		}

		oSoul.x += (72 - oSoul.x) / 3;
		oSoul.y += (288 + floor(coord) * 32 - oSoul.y) / 3;
	} else if is_val(menu_state, 3, 6) // Items - Act Selection
	{
		var choice = 0;
		var len = 0;
		choice = menu_choice[6 / menu_state];
		if menu_state == 3 {
			for (var i = 0, n = array_length(global.item); i < n; i++)
				if global.item[i] != 0 len++;
		}
		else {
			len = 0;
			for (var i = 0; i < 6; i++) {
				if enemy_act[target_option, i] != ""
				len++;
			}
		}
		if len > 1 {
			if input_horizontal != 0 {
				choice = Posmod(choice + input_horizontal, len);
				menu_choice[6 / menu_state] = choice;
				Move_Noise();
			}
			if input_vertical != 0 {
				choice = Posmod(choice + (input_vertical * 2), len);
				menu_choice[6 / menu_state] = choice;
				Move_Noise()
			}
		}

		if menu_state == 3 {
			oSoul.x += ((72 + (256 * (choice % 2))) - oSoul.x) / 3;
			oSoul.y += ((288 + ((floor(choice / 2) % 2) * 32)) - oSoul.y) / 3;
		}
		else {
			oSoul.x += ((72 + (256 * (choice % 2))) - oSoul.x) / 3;
			oSoul.y += ((288 + ((floor(choice / 2)) * 32)) - oSoul.y) / 3;
		}

		if input_confirm {
			oSoul.visible = false;
			Confirm_Noise()
			if menu_state == 3 Item_Use(global.item[choice]); // Item-consuming code
			else // Action-executing code
			{
				menu_text_typist.reset();
				text_writer = scribble("* " + enemy_act_text[target_option, choice]);
				if text_writer.get_page() != 0 text_writer.page(0);
				menu_state = -1;
			}
		}
		if input_cancel {
			choice = 0;
			if menu_state == 3 {
				menu_choice[2] = 0;
				menu_state = 0;
			} // Reset back to button choice
			else {
				menu_choice[1] = 0;
				menu_state = 2;
			} // Reset back to Act
		}
	} else if menu_state == 7 // Mercy End
	{
		begin_spare(activate_turn[3]);
	}

	var target_soul_angle = 0;
	if menu_state == 1 or
	menu_state == 2 or
	menu_state == 3 or
	menu_state == 4 or
	menu_state == 6
	target_soul_angle = 90;
	oSoul.image_angle += (target_soul_angle - oSoul.image_angle) / 9;
} else if battle_state == 1 // Dialog
{
	menu_text_typist.reset();
	if menu_text_typist.get_paused() = false
		menu_text_typist.pause();
} else if battle_state == 2 // In-Turn
{
	menu_text_typist.reset();
	if menu_text_typist.get_paused() = false
		menu_text_typist.pause();
	oSoul.visible = true;
}
if target_buffer > -1 target_buffer--;
