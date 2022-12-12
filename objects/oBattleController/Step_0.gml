var input_horizontal = input_check_pressed("right") - input_check_pressed("left"),
	input_vertical = input_check_pressed("down") - input_check_pressed("up"),
	input_confirm = input_check_pressed("confirm"),
	input_cancel = input_check_pressed("cancel");

//Check for empty slots of enemy
for (var i = 0, ncontains_enemy = 0, no_enemy_pos = [2]; i < 2; i++) {
	if enemy[i] == noone {
		ncontains_enemy++;
		no_enemy_pos[array_length(no_enemy_pos) - 1] = i;
	}
	else continue;
}
var target_option = menu_choice[0] + (menu_choice[0] >= no_enemy_pos[0] ? ncontains_enemy : 0);

switch battle_state {
	case BATTLE_STATE.MENU:
		switch menu_state {
			case MENU_STATE.BUTTON_SELECTION:
			var _button_len = array_length(button_spr),
				_button_pos = button_pos,
				_button_slot = menu_button_choice;

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
			break
			case MENU_STATE.FIGHT:
			case MENU_STATE.ACT:
			case MENU_STATE.MERCY:
			var coord = menu_choice[0],
				len = 1;
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

					Target.buffer = 3;
					Target.state = 1;
					Target.side = choose(-1, 1);
					Target.time = 0;
					Target.xscale = 1;
					Target.yscale = 1;
					Target.frame = 0;
					Target.alpha = 1;
					Target.retract_method = choose(0, 1);
					Aim.scale = 1;
					Aim.angle = 0;
					Aim.color = c_white;
					Aim.retract = choose(-1, 1);

					//Code that makes soul invincible
					if instance_exists(oBulletParents) oBulletParents.can_hurt = 0;
				}
				if menu_state == 2 menu_state = 6; // Act Selection
				if menu_state == 4 {
					menu_state = 7 + coord; // Spare or Flee
				}
			}

			oSoul.x += (72 - oSoul.x) / 3;
			oSoul.y += (288 + floor(coord) * 32 - oSoul.y) / 3;
			break
			case MENU_STATE.ITEM:
			case MENU_STATE.ACT_SELECT:
			var choice = menu_choice[6 / menu_state],
				len = 0;
			if menu_state == 3 {
				for (var i = 0, n = array_length(global.item); i < n; i++)
					if global.item[i] != 0 len++;
			} else {
				for (var i = 0; i < 6; i++)
					if enemy_act[target_option, i] != ""
				len++;
			}
			if len > 1 {
				if menu_state == 6 {
					if input_horizontal != 0 {
						choice = Posmod(choice + input_horizontal, len);
						menu_choice[6 / menu_state] = choice;
						Move_Noise();
					}
					if input_vertical != 0 {
						choice = Posmod(choice + (input_vertical * 2), len);
						menu_choice[6 / menu_state] = choice;
						Move_Noise();
					}
				}
				else switch item_scroll_type {
					case ITEM_SCROLL.DEFAULT:
						if input_horizontal != 0 {
						choice = Posmod(choice + input_horizontal, len);
						menu_choice[6 / menu_state] = choice;
						Move_Noise();
					}
					if input_vertical != 0 {
						choice = Posmod(choice + (input_vertical * 2), len);
						menu_choice[6 / menu_state] = choice;
						Move_Noise();
					}
					break

					case ITEM_SCROLL.VERTICAL:
						if input_vertical != 0 {
						choice = Posmod(choice + input_vertical, len + 1);
						menu_choice[6 / menu_state] = choice;
						Move_Noise();
					}
					break

					case ITEM_SCROLL.CIRCLE:
						if input_horizontal != 0 {
						choice = Posmod(choice + input_horizontal, len + 3);
						menu_choice[6 / menu_state] = choice;
						Move_Noise();
					}
					break
				}
			}

			if menu_state == MENU_STATE.ITEM {
				switch item_scroll_type {
					case ITEM_SCROLL.DEFAULT:
					oSoul.x += ((72 + (256 * (choice % 2))) - oSoul.x) / 3;
					oSoul.y += ((288 + ((floor(choice / 2) % 2) * 32)) - oSoul.y) / 3;
					break

					case ITEM_SCROLL.VERTICAL:
					oSoul.x += (72 - oSoul.x) / 3;
					oSoul.y += ((288 + ((choice % 3) * 32)) - oSoul.y) / 3;
					break

					case ITEM_SCROLL.CIRCLE:
					oSoul.x += (190 + (130 * (choice % 3)) - oSoul.x) / 3;
					oSoul.y += (310 - (40 * (abs((choice % 3) - 1))) - oSoul.y) / 3;
					break
				}
			} else {
				oSoul.x += ((72 + (256 * (choice % 2))) - oSoul.x) / 3;
				oSoul.y += ((288 + ((floor(choice / 2)) * 32)) - oSoul.y) / 3;
			}

			if input_confirm {
				oSoul.visible = false;
				Confirm_Noise();
				if menu_state == MENU_STATE.ITEM Item_Use(global.item[choice]); // Item-consuming code
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
				if menu_state == MENU_STATE.ITEM {
					menu_choice[2] = 0;
					menu_state = 0;
				} // Reset back to button choice
				else {
					menu_choice[1] = 0;
					menu_state = 2;
				} // Reset back to Act
			}
			break
			case MENU_STATE.MERCY_END:
			begin_spare(activate_turn[3]);
			break
			case MENU_STATE.FLEE:
			if FleeState == 0 {
				with oSoul {
					sprite_index = sprSoulFlee;
					image_speed = 0.5;
					hspeed = -1.5;
					image_angle = 0;
					allow_outside = true;
					audio_play(snd_flee);
				}
				FleeState++;
			}
			break

			var target_soul_angle = 0;
			if (menu_state == 1 or
				menu_state == 2 or
				(menu_state == 3 and item_scroll_type != ITEM_SCROLL.CIRCLE) or
				menu_state == 4 or
				menu_state == 6)
				target_soul_angle = 90;
			oSoul.image_angle += (target_soul_angle - oSoul.image_angle) / 9;
		}
	break
	case BATTLE_STATE.DIALOG:
	menu_text_typist.reset();
	if menu_text_typist.get_paused() = false
		menu_text_typist.pause();
	break
	case BATTLE_STATE.IN_TURN:
	menu_text_typist.reset();
	if menu_text_typist.get_paused() = false
		menu_text_typist.pause();
	oSoul.visible = true;
	break
}
if Target.buffer > -1 Target.buffer--;
if Target.WaitTime Target.WaitTime--
if Target.WaitTime == 0 {
	Target.state = 3;
	oSoul.visible = true;
	Target.WaitTime = -1;
}
