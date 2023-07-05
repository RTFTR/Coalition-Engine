if !audio_group_is_loaded(audiogroup_battle)
	audio_group_load(audiogroup_battle);
	
#region Local Functions
function scr_enemy_choice()
{
	for (var i = 0, n = 0; i < 2; ++i)
		if instance_exists(enemy[i]) n++;
	return n;
}


function scr_enemy_num()
{
	for (var i = 0, n = 0; i < 2; i++)
		if enemy[i] != noone
			n++;
	return n;
}

function Calculate_MenuDamage(distance_to_center, enemy_under_attack, crit_amount = 0)
{
	var damage = global.player_base_atk + global.player_attack + global.player_attack_boost,
		target = enemy[enemy_under_attack],
		enemy_def = target.enemy_defense;
	if target.enemy_is_spareable enemy_def *= -30; //Check if enemy is spareable -> reduce the DEF
	damage -= enemy_def;
	damage *= 2;
	if distance_to_center > 15
		damage *= (1 - distance_to_center / 273);
	damage *= random_range(0.9, 1.1); //Sets damage to be random of the actual damage (idk what im saying)
	//For multibar attack
	if crit_amount > 0
	{
		var average_damage = damage / global.bar_count;
		damage = 0;
		for (var i = 0; i < global.bar_count; ++i) {
			var multiplier = i < crit_amount ? 2 : 1;
			damage += average_damage * multiplier;
		}
	}
	damage = max(round(damage), 1);
	Enemy_SetDamage(target, damage);
}


function begin_turn() {
	if activate_turn[last_choice]
	{
		battle_state = 2;
		obj_ParentEnemy.state = 2;
		obj_Soul.image_angle = 0;
		Battle_SetSoulPos(320, 320, 0);
	}
	else
	{
		menu_choice = array_create(4, 0);
		if activate_heal[last_choice]
		{
			with obj_ParentEnemy
			{
				TurnData.IsHeal = true;
				TurnData.HealNum = irandom(array_length(TurnData.HealAttacks) - 1);
			}
		}
		else
		{
			menu_text_typist.reset();
			battle_state = 0;
			menu_state = 0;
			var end_turn_text = battle_turn - 1;
			end_turn_text = min(0, battle_turn);
			Battle_SetMenuDialog(obj_ParentEnemy.end_turn_menu_text[end_turn_text]);
		}
		last_choice = 0;
	}
}

function gameover() {
	global.soul_x = obj_Soul.x;
	global.soul_y = obj_Soul.y;
	audio_stop_all();
	room_goto(room_gameover);
	// Insert file saving and events if needed
}

function begin_spare(activate_the_turn) {
	obj_ParentEnemy.is_being_spared = true;
	obj_ParentEnemy.spare_end_begin_turn = activate_the_turn;
	if !activate_the_turn {
		menu_state = -1;
		battle_state = -1;
	}
}

function end_battle() {
	battle_state = 3;
	if !global.BossFight {
		battle_end_text = "You WON![delay,333]\n* You earned " + string(Result.Exp) + " XP and " + string(Result.Gold) + " gold.";
		if global.data.Exp + Result.Exp >= Player_GetExpNext() {
			var maxhp = false;
			global.data.lv++;
			if global.hp == global.hp_max maxhp = true;
			global.hp_max = (global.data.lv = 20 ? 99 : global.data.lv * 4 + 16);
			if maxhp global.hp = global.hp_max
				battle_end_text += "\n You LOVE increased!";
			audio_play(snd_level_up);
		}
		battle_end_text_writer = scribble("* " + battle_end_text);
		if battle_end_text_writer.get_page() != 0
			battle_end_text_writer.page(0);
		battle_end_text_typist = scribble_typist()
			.in(0.5, 0)
			.sound_per_char(snd_txtTyper, 1, 1, " ^!.?,:/\\|*")
	}
	else {
		fader_fade(0, 1, 40, 0, c_black);
	}
}
#endregion
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
var target_option = menu_choice[0];
if menu_choice[0] >= no_enemy_pos[0] target_option += ncontains_enemy;

switch battle_state {
	case BATTLE_STATE.MENU:
		switch menu_state {
			case BATTLE_MENU_STATE.BUTTON_SELECTION:
				var _button_len = array_length(button_spr),
					_button_pos = button_pos,
					_button_slot = menu_button_choice;

				if input_horizontal != 0 {
					_button_slot = posmod(_button_slot + input_horizontal, _button_len);
					menu_button_choice = _button_slot;
					audio_play(snd_menu_switch);
				}
			
				with obj_Soul
				{
					visible = true;
					x += ((_button_pos[_button_slot][0] - 47) - x) / 3;
					y += ((_button_pos[_button_slot][1] + 1) - y) / 3;
				}

				if input_confirm {
					audio_play(snd_menu_confirm);
					menu_state = _button_slot + 1;

					if menu_state == BATTLE_MENU_STATE.ITEM and Item_Space() == 0 {
						menu_state = BATTLE_MENU_STATE.BUTTON_SELECTION;
						
						if item_scroll_type == ITEM_SCROLL.VERTICAL menu_choice[BATTLE_MENU_STATE.ITEM] = 0;
						
						audio_stop_sound(snd_menu_confirm);
					}
				}
			break
			case BATTLE_MENU_STATE.FIGHT:
			case BATTLE_MENU_STATE.ACT:
			case BATTLE_MENU_STATE.MERCY:
				var coord = menu_choice[0],
					len = 1,
					FightOrAct = is_val(menu_state, BATTLE_MENU_STATE.FIGHT, BATTLE_MENU_STATE.ACT);
				if FightOrAct len = no_enemy_pos[0];
				else {
					coord = menu_choice[3];
					len = 1 + allow_run;
				}

				if len > 1 {
					if input_vertical != 0 {
						coord = posmod(coord + input_vertical, len);
						menu_choice[FightOrAct ? 0 : 3] = coord;
						audio_play(snd_menu_switch);
					}
				}
			
				if input_cancel {
					menu_choice[0] = 0;
					menu_state = BATTLE_MENU_STATE.BUTTON_SELECTION;
				}
				if input_confirm {
					audio_play(snd_menu_confirm);
					if menu_state == BATTLE_MENU_STATE.FIGHT {
						menu_state = BATTLE_MENU_STATE.FIGHT_AIM; // Fight Aiming
						
						ResetFightAim();

						//Code that makes soul invincible
						if instance_exists(obj_ParentBullet) obj_ParentBullet.can_hurt = 0;
					}
					if menu_state == BATTLE_MENU_STATE.ACT menu_state = BATTLE_MENU_STATE.ACT_SELECT; // Act Selection
					if menu_state == BATTLE_MENU_STATE.MERCY {
						menu_state = BATTLE_MENU_STATE.MERCY_END + coord; // Spare or Flee
					}
				}

				obj_Soul.x += (72 - obj_Soul.x) / 3;
				obj_Soul.y += (288 + floor(coord) * 32 - obj_Soul.y) / 3;
			break
			case BATTLE_MENU_STATE.ITEM:
			case BATTLE_MENU_STATE.ACT_SELECT:
				var choice = menu_choice[6 / menu_state],
					len = 0;
				if menu_state == 3 {
					var i = 0;
					repeat(array_length(global.item))
					{
						if global.item[i] != 0 len++;
						i++;
					}
				}
				else
				{
					for (var i = 0, n = min(6, array_length(enemy_act[target_option])); i < n; i++)
						if enemy_act[target_option, i] != ""
							len++;
				}
				if len > 1 {
					if menu_state == 6 {
						if input_horizontal != 0 {
							choice = posmod(choice + input_horizontal, len);
							menu_choice[1] = choice;
							audio_play(snd_menu_switch);
						}
						if input_vertical != 0 {
							choice = posmod(choice + (input_vertical * 2), len);
							menu_choice[1] = choice;
							audio_play(snd_menu_switch);
						}
					}
					else switch item_scroll_type {
						case ITEM_SCROLL.DEFAULT:
							if input_horizontal != 0 {
								choice = posmod(choice + input_horizontal, len);
								menu_choice[2] = choice;
								audio_play(snd_menu_switch);
							}
							if input_vertical != 0 {
									choice = posmod(choice + (input_vertical * 2), len);
									menu_choice[2] = choice;
									audio_play(snd_menu_switch);
							}
						break

						case ITEM_SCROLL.VERTICAL:
							if input_vertical != 0
							{
								choice = posmod(choice + input_vertical, len);
								menu_choice[2] = choice;
								audio_play(snd_menu_switch);
								item_desc_x = 360;
								item_desc_alpha = 0;
							}
						break

						case ITEM_SCROLL.CIRCLE:
							if input_horizontal != 0 {
								choice = posmod(choice + input_horizontal, len + 3);
								menu_choice[2] = choice;
								audio_play(snd_menu_switch);
						}
						break

					}
				}

				if menu_state == BATTLE_MENU_STATE.ITEM {
					switch item_scroll_type {
						case ITEM_SCROLL.DEFAULT:
							obj_Soul.x += ((72 + (256 * (choice % 2))) - obj_Soul.x) / 3;
							obj_Soul.y += ((288 + ((floor(choice / 2) % 2) * 32)) - obj_Soul.y) / 3;
						break

						case ITEM_SCROLL.VERTICAL:							
							obj_Soul.x += (72 - obj_Soul.x) / 3;
							obj_Soul.y += (320 - obj_Soul.y) / 3;
							item_lerp_y[0] = lerp(item_lerp_y[0], 304 - (32 * choice), 1/3);
							item_desc_alpha = lerp(item_desc_alpha, 1, 1/3);
							for (var i = 0, n = Item_Space(); i < n; ++i)
							{
								item_lerp_x_target = 96 + 10 * (abs(choice - i));
								item_lerp_x[i] = lerp(item_lerp_x[i], item_lerp_x_target, 1/3);
								if i == choice
									item_lerp_color_amount_target[i] = 1;
								else if abs(i - choice) == 1
									item_lerp_color_amount_target[i] = 0.5;
								else item_lerp_color_amount_target[i] = 16 / 255;
								item_lerp_color_amount[i] = lerp(item_lerp_color_amount[i], item_lerp_color_amount_target[i], 0.12);
							}
							
						break

						case ITEM_SCROLL.CIRCLE:
							obj_Soul.x += (190 + (130 * (choice % 3)) - obj_Soul.x) / 3;
							obj_Soul.y += (310 - (40 * (abs((choice % 3) - 1))) - obj_Soul.y) / 3;
						break

					}
				} else {
					item_desc_alpha = lerp(item_desc_alpha, 0, 1/3);
					obj_Soul.x += ((72 + (256 * (choice % 2))) - obj_Soul.x) / 3;
					obj_Soul.y += ((288 + ((floor(choice / 2)) * 32)) - obj_Soul.y) / 3;
				}

				if input_confirm {
					obj_Soul.visible = false;
					audio_play(snd_menu_confirm);
					if menu_state == BATTLE_MENU_STATE.ITEM // Item-consuming code
					{
						var ItemID = choice;
						if item_scroll_type == ITEM_SCROLL.CIRCLE
							ItemID *= 8/12
						Item_Use(global.item[ceil(ItemID)]);
						last_choice = 2;
					}
					else // Action-executing code
					{
						menu_text_typist.reset();
						text_writer = scribble("* " + enemy_act_text[target_option, choice]);
						if text_writer.get_page() != 0 text_writer.page(0);
						menu_state = -1;
						if enemy_act_function[target_option, choice] != -1
							enemy_act_function[target_option, choice]();
						last_choice = 1;
					}
				}
				if input_cancel {
					choice = 0;
					if menu_state == BATTLE_MENU_STATE.ITEM {
						menu_choice[2] = 0;
						menu_state = BATTLE_MENU_STATE.BUTTON_SELECTION;
					} // Reset back to button choice
					else {
						menu_choice[1] = 0;
						menu_state = BATTLE_MENU_STATE.ACT;
					} // Reset back to Act
				}
			break
			case BATTLE_MENU_STATE.MERCY_END:
				begin_spare(activate_turn[3]);
			break
			case BATTLE_MENU_STATE.FLEE:
				if FleeState == 0 {
					with obj_Soul {
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
		}
		var target_soul_angle = 0;
		if (menu_state == BATTLE_MENU_STATE.FIGHT or
			menu_state == BATTLE_MENU_STATE.ACT or
			(menu_state == BATTLE_MENU_STATE.ITEM and item_scroll_type != ITEM_SCROLL.CIRCLE
								and item_scroll_type != ITEM_SCROLL.HORIZONTAL) or
			menu_state == BATTLE_MENU_STATE.MERCY or
			menu_state == BATTLE_MENU_STATE.ACT_SELECT)
			target_soul_angle = 90;
		obj_Soul.image_angle += (target_soul_angle - obj_Soul.image_angle) / 9;
	break
	case BATTLE_STATE.DIALOG:
		menu_text_typist.reset();
		if !menu_text_typist.get_paused()
			menu_text_typist.pause();
	break
	case BATTLE_STATE.IN_TURN:
		menu_text_typist.reset();
		if !menu_text_typist.get_paused()
			menu_text_typist.pause();
		obj_Soul.visible = true;
	break
}
if Target.buffer > -1 Target.buffer--;
if Target.WaitTime Target.WaitTime--
if Target.WaitTime == 0 {
	Target.state = 3;
	obj_Soul.visible = true;
	Target.WaitTime = -1;
}

//Debug
//if debug {
//	if keyboard_check(vk_rshift) {
//		if room_speed > 5 {
//			room_speed += 5 * input_horizontal;
//		}
//	if keyboard_check(ord("R")) room_speed = 60;
//	if keyboard_check(ord("F")) room_speed = 600;
//	}
//	if battle_state == 0 and keyboard_check(vk_control) {
//		battle_turn += input_horizontal;
//		battle_turn = max(0, battle_turn);
//	}
//	if global.hp <= 1 {
//		global.hp = global.hp_max;
//		audio_play(snd_item_heal);
//	}
//}