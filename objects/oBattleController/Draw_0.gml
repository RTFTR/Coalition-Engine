var input_horizontal = PRESS_HORIZONTAL,
	input_vertical = PRESS_VERTICAL,
	input_confirm = PRESS_CONFIRM,
	input_cancel = PRESS_CANCEL,
	LangText = global.AllLanguageTexts[global.Language],
	DefaultFont = LangText[LANGUAGE_TEXTS.FONT],
	DefaultFontNB = LangText[LANGUAGE_TEXTS.FONT_NO_BRACKET];
// Text Functions
if battle_state == BATTLE_STATE.MENU {
	for (var i = 0, ncontains_enemy = 0, no_enemy_pos = [2]; i < 2; i++) {
		if enemy[i] == noone {
			ncontains_enemy++;
			no_enemy_pos[array_length(no_enemy_pos) - 1] = i;
		}
		else continue;
	}
	var target_option = menu_choice[0] + (menu_choice[0] >= no_enemy_pos[0] ? ncontains_enemy : 0);

	if menu_state == MENU_STATE.BUTTON_SELECTION or menu_state == -1 {
		__text_writer.starting_format(DefaultFontNB, c_white)
		__text_writer.draw(52, 272, menu_text_typist)


		if input_cancel and global.TextSkipEnabled
		{
			__text_writer.page(__text_writer.get_page_count() - 1);
			menu_text_typist.skip();
		}
		if menu_text_typist.get_state() == 1 and __text_writer.get_page() < (__text_writer.get_page_count() - 1)
			__text_writer.page(__text_writer.get_page() + 1)
		if menu_state == -1 and menu_text_typist.get_state() == 1 {
			if input_confirm begin_turn();
		}
	}

	if is_val(menu_state, MENU_STATE.FIGHT, MENU_STATE.ACT) // Fight - Act
	{
		var decrease_y = 0, i = 0;
		repeat(array_length(enemy_name)) // Draw enemy hp bar in Fight state
		{
			var _enemy_name = string(enemy_name[i]) + enemy_name_extra[i];
			if instance_exists(enemy[i]) // Check if the enemy slot is valid before name drawing
			{
				var spare_col = "[c_white]";
				if enemy[i].enemy_is_spareable spare_col = global.SpareTextColor;
					draw_text_scribble(96, 272 + (32 * i) - decrease_y, spare_col + DefaultFont + "* " + _enemy_name);
				var xwrite = 450;
				if menu_state == MENU_STATE.FIGHT and enemy_draw_hp_bar[i] == 1 {
					decrease_y -= 32;
					draw_set_color(c_red);
					var lineheight = 32,
						y_start = 247,
						remaining_hp_width = xwrite + ((enemy_hp[i] / enemy_hp_max[i]) * 100);
					//Background
					draw_rectangle(remaining_hp_width, y_start + (i * lineheight) - decrease_y, xwrite + 100, y_start + (i * lineheight) + 17 - decrease_y, false);
					//Remaining HP
					draw_set_color(c_lime);
					draw_rectangle(xwrite, y_start + (i * lineheight) - decrease_y, remaining_hp_width, y_start + (i * lineheight) + 17 - decrease_y, false);
					draw_set_color(c_white);
					decrease_y += 32;
				}
			} else decrease_y += 32;
			i++;
		}
	}
	if menu_state == MENU_STATE.ITEM // Item list
	{
		Item_Info_Load();
		var coord = menu_choice[2],
			c_div = floor(coord / 4),
			itm_ln = item_space,
			_coord = c_div * 4;
		switch item_scroll_type
		{
			case ITEM_SCROLL.DEFAULT:
			for (var i = 0, n = min(4, itm_ln - _coord); i < n; ++i) {
				var xx = (64 + ((i % 2) * 256)) + 32,
					yy = 272 + (floor(i / 2) * 32);
				draw_text_scribble(xx, yy, DefaultFont + "* " + item_name[i + _coord]);
			}
			// Heal text and Page
			draw_text_scribble(128, 341, DefaultFont + "[c_lime](+" + string(item_heal[coord]) + ")");
			draw_text_scribble(384, 341, DefaultFont + LangText[LANGUAGE_TEXTS.PAGE0] + string(c_div + 1) + LangText[LANGUAGE_TEXTS.PAGE1]);
			break
			
			case ITEM_SCROLL.VERTICAL:
			c_div = coord;
			_coord = c_div;
			Battle_Masking_Start(true);
			for (var i = 0; i < itm_ln; ++i)
			{	
				var xx = item_lerp_x[i],
					yy = item_lerp_y[0] + (32 * (i));
				draw_set_font(asset_get_index(DefaultFontNB));
				var color = merge_color(c_black, c_white, item_lerp_color_amount[i]);
				draw_set_color(color);
				draw_text(xx, yy, "* " + item_name[i]);
				//Item description
				draw_set_alpha(item_desc_alpha);
				draw_set_color(c_gray);
				if i == c_div draw_text(item_desc_x, yy, item_battle_desc[coord]);
				draw_set_alpha(1);
				draw_set_color(c_white);
			}	
			Battle_Masking_End();
			break
			
			case ITEM_SCROLL.CIRCLE:
			c_div = floor(coord / 3);
			_coord = c_div * 2;
			for (var i = -1, n = min(3, itm_ln - _coord); i < n - 1; ++i) {
				var ItemTxtAlTar = (((menu_choice[2] % 3) == i + 1) ? 1 : 0.5),
					xx = 320 + i * 130,
					yy = 320 - abs(i * 40);
				item_scroll_alpha[i + 1] += (ItemTxtAlTar - item_scroll_alpha[i + 1]) / 6;
				var ItemTxtAl = "[alpha," + string(item_scroll_alpha[i + 1]) +"]";
				draw_text_scribble(xx, yy, DefaultFont+ "[fa_center]" + ItemTxtAl + "* " + item_name[i + 1 + _coord])
			}
			break
		}
	}
	if menu_state == MENU_STATE.MERCY {
		// Sets the color of Spare
		i = 0;
		var spare_col = "[c_white]";
		repeat(array_length(enemy)) {
			if enemy[i] != noone
				if enemy[i].enemy_is_spareable
					spare_col = global.SpareTextColor;
			i++;
		}
		draw_text_scribble(96, 272, spare_col + DefaultFont + LangText[LANGUAGE_TEXTS.SPARE] + (allow_run ? "[c_white]\n" + LangText[LANGUAGE_TEXTS.FLEE] : ""));
	}
	if menu_state == MENU_STATE.ACT_SELECT // Draw Act Texts
	{
		var i = 0, enemy_check_texts = "", n = array_length(enemy_act[target_option]);
		repeat n
		{
			var assign_act_text = enemy_act[target_option, i];
			if assign_act_text != ""
				enemy_check_texts += "* " + assign_act_text;
			if (i % 2) enemy_check_texts += "\n";
			else
				repeat(14 - string_length(enemy_act[target_option, i]))
					enemy_check_texts += " ";
			++i;
		}
		draw_text_scribble(96, 272, DefaultFont + enemy_check_texts);
	}

	if menu_state == MENU_STATE.FIGHT_AIM //Fight Anim
	{
		if Target.Count == 1 //If only 1 bar is used
		{
			var _target_state =		Target.state,
				_aim_scale =		Aim.scale[0],
				_aim_angle =		Aim.angle,
				_aim_color = 		Aim.color[0],
				_aim_retract =		Aim.retract;
		
			if _target_state > 0 {
				var _target_side =				Target.side[0],
					_target_time =				Target.time[0],
					_target_xscale =			Target.xscale,
					_target_yscale =			Target.yscale,
					_target_frame =				Target.frame,
					_target_alpha =				Target.alpha,
					_target_retract_method =	Target.retract_method,

					_aim_target_x = 320 - (_target_side * (290 - _target_time));
			
				if _target_state < 3 {
					if _target_state == 1 {
						_target_time += 6.4;
						var _aim_distance = abs(320 - _aim_target_x);
						_aim_color = make_color_rgb(255, 255, clamp(_aim_distance, 0, 255));
						
						if _target_time >= 575 {
							menu_state = 0;
							_target_state = 3;
							battle_state = 0;
						}
						else if input_confirm and Target.buffer < 0 {
							battle_turn++;
							Target.buffer = 3;
							_target_state = 2;
							if _aim_distance < 15
							{
								if !global.CompatibilityMode
									Blur_Screen(45, 25 - _aim_distance);
							}
						
							Target.WaitTime = 60;

							var strike_target_x = 160 * (target_option + 1);
							enemy[target_option].is_being_attacked = true;
							Calculate_MenuDamage(_aim_distance, target_option);
							instance_create_depth(strike_target_x, 160, -10, oStrike);
							audio_play_sound(snd_slice, 50, false);
						}
					}
					else _target_frame += 0.2;
				}
				else {
					_target_alpha -= 0.04;
					if _target_retract_method == 0 _target_xscale -= 0.03;
					if _target_retract_method == 0 _target_xscale -= 0.03;
					else _target_yscale -= 0.03;

					if _aim_scale > 0 _aim_scale -= 0.075;
					else _aim_scale = 0;
					_aim_angle += _aim_retract * 3;

					if _target_xscale < 0.08 or _target_yscale < 0.08 {
						_target_state = 0;
						dialog_start();
						menu_state = -1;
					}
				}

				draw_sprite_ext(sprTargetBG, 0, 320, 320, _target_xscale, _target_yscale, 0, c_white, _target_alpha);
				draw_sprite_ext(sprTargetAim, _target_frame, _aim_target_x, 320, _aim_scale, _aim_scale, _aim_angle, _aim_color, 1);

				Target.side[0] = _target_side;
				Target.time[0] = _target_time;
				Target.xscale = _target_xscale;
				Target.yscale = _target_yscale;
				Target.frame = _target_frame;
				Target.alpha = _target_alpha;
			}
			
			Target.state = _target_state;

			Aim.scale[0] = _aim_scale;
			Aim.angle = _aim_angle;
			Aim.color[0] = _aim_color;
		}
		else //If multiple bars are being used
		{
			var _target_state =		Target.state,
				_aim_scale =		Aim.scale,
				_aim_color = 		Aim.color,
				_aim_alpha = 		Aim.Alpha;
			
			if _target_state > 0 {
				var _target_side =				Target.side,
					_target_time =				Target.time,
					_target_xscale =			Target.xscale,
					_target_yscale =			Target.yscale,
					_target_frame =				Target.frame,
					_target_alpha =				Target.alpha,
					_target_retract_method =	Target.retract_method,
					_attack_confirm =			input_check_pressed("confirm"),
					_aim_time =					Aim.Time;
				
				draw_sprite_ext(sprTargetBG, 0, 320, 320, _target_xscale, _target_yscale, 0, c_white, _target_alpha);
				
				//Drawing
				var _aim_force_index = false;
				for (var i = 0; i < Target.Count; ++i) {
					_aim_time[i]++;
					
					if _target_state == 1 _target_time[i] += Aim.Hspeed[i];
					var _aim_target_x = Aim.ForceCenter[i] ? 320
										: Aim.InitialX[i] - (Target.side[i] * _target_time[i]),
						_aim_index = 1,
						distance = floor(320 - _aim_target_x);
					//Multiply the distance by -1 if the bar comes form the other side
					if Aim.InitialX[i] > 320 distance *= -1;
					
					if !Aim.HasBeenPressed[i] and !_aim_force_index
					{
						_aim_index = 0;
						_aim_force_index = true;
					}
					
					if Aim.Fade[i]
					{
						if _aim_alpha[i] > 0
							_aim_alpha[i] -= 0.08;
						else Aim.Faded[i] = 1;
						Aim.Sprite[i] = sprTargetAim;
					}
					
					if Aim.Expand[i]
					{
						if _aim_alpha[i] > 0
							_aim_alpha[i] -= 0.08;
						_aim_scale[i] += 0.06;
						//Color switch if max crit
						if Aim.ForceCenter[i]
						{
							_aim_color[i] = (_aim_time[i] % 5) < 2 ? c_aqua : c_yellow;
						}
					}
					//Only draw if bar is inside board
					if distance <= 280
						draw_sprite_ext(Aim.Sprite[i], _aim_index, _aim_target_x, 320, _aim_scale[i], _aim_scale[i], 0, _aim_color[i], _aim_alpha[i]);
				
					//Input
					if distance > 273 //Prevent input already registered
						continue
				
					_aim_target_x = Aim.InitialX[i] - (Target.side[i] * _target_time[i]);
					
					if _attack_confirm
					{
						if !Aim.HasBeenPressed[i] and !Aim.Fade[i]
						{
							_attack_confirm = false;
							Aim.HasBeenPressed[i] = true;
							Aim.Expand[i] = true;
							Aim.Sprite[i] = sprMultiTargetAim;
							Aim.HitCount++;
							var attack_sound = -1;
								
							//Damage process
							if distance <= 20 //Perfect
							{
								//Force set to middle
								Aim.ForceCenter[i] = true;
								//Set bar color to yellow
								_aim_color[i] = c_yellow;
								attack_sound = snd_multi_crit;
								Aim.Attack.CritAmount++;
								Aim.Attack.Distance += distance / Aim.Hspeed[i];
							}
							else if distance <= Aim.Hspeed[i] * 20
							{
								//Set bar color to aqua
								_aim_color[i] = c_aqua;
								attack_sound = snd_multi_hit;
								Aim.Attack.Distance += distance / Aim.Hspeed[i];
							}
							else
							{
								//Set bar color to red
								_aim_color[i] = c_red;
								Aim.HitCount--;
								Aim.Miss++;
							}
							Aim.Hspeed[i] = 0;
							
							if attack_sound != -1
								audio_play(attack_sound);
						}
					}
						
					if Aim.HitCount + Aim.Miss == Target.Count and _target_state == 1
					{
						_target_state = 2;
						battle_turn++;
						//Only execute if any bars are hit
						if Aim.HitCount > 0
						{
							Aim.Attack.Distance /= Target.Count;
							Calculate_MenuDamage(Aim.Attack.Distance, target_option, Aim.Attack.CritAmount);
							var strike_target_x = 160 * (target_option + 1);
							enemy[target_option].is_being_attacked = true;
							Aim.Attack.Sprite = global.MultiBarAttackSprite;
							if Aim.Attack.CritAmount == Target.Count
							{
								Aim.Attack.Crit = true;
								Aim.Attack.Color = merge_color(c_white, c_yellow, 0.5);
							}
						}
						else
						{
							with enemy_instance[menu_choice[0]]
							{
								is_miss = true;
								is_being_attacked = true;
								draw_damage = true;
								damage_color = c_ltgray;
								damage = "MISS";
							}
						}
					}
					if distance < -28 and !Aim.Fade[i]
					{
						Aim.Fade[i] = true;
						Aim.Miss++;
					}
				}
				
				if _target_state < 3 {
					if _target_state == 2
					{
						var scale_x = 2, scale_y = 2,
						_time = Aim.Attack.Time,
						_alpha = Aim.Attack.Alpha,
						_sprite = Aim.Attack.Sprite,
						_index = Aim.Attack.Index,
						_color = Aim.Attack.Color;
						function DrawMultibarAttackStar(sprite)
						{
							var size, _time = Aim.Attack.Time;
							switch sprite
							{
								default:
								case sprFrypanStar:
									size = 1.5;
									_time += 7;
								break;
								case sprGunStar:
									size = 0.75;
								break;
							}
							for (var i = 0; i < 8; ++i) {
								var _star_data = Aim.Attack.StarData[i];
								var _star_speed = _star_data[4] - _star_data[5] * _time;
								//Position changing
								_star_data[3] += _star_speed;
								var _star_x = 320 + dcos(i * 45) * _star_data[3],
									_star_y = Aim.Attack.EnemyY - dsin(i * 45) * _star_data[3];
								//Fading
								if _star_speed < 5
								{
									_star_data[1] -= 0.025;
									if _star_data[2] > 1 _star_data[2] -= 0.25;
								}
								_star_data[0] += _star_data[2];
								draw_sprite_ext(sprite, 0, _star_x, _star_y, size, size, _star_data[0], Aim.Attack.Color, _star_data[1]);
								Aim.Attack.StarData[i] = _star_data;
							}
						}
						function DrawMultiAttackMain(sprite)
						{
							var size = 1, _time = Aim.Attack.Time, _alpha = Aim.Attack.Alpha;
							if sprite = sprGunCircle _time -= 9;
							var size_increase, max_size, size_reduction;
							switch sprite
							{
								case sprFrypanAttack:
									size_increase = 0.3;
									max_size = 2.8;
									size_reduction = 0.6;
								break
								case sprGunCircle:
									size_increase = 0.5;
									max_size = 3.5;
									size_reduction = 0.3;
								break
							}
							var time_before_fully_expand = round((max_size - size) / size_increase);
							if _time < time_before_fully_expand
								size += size_increase * _time;
							else 
							{
								size = max(0, max_size - size_reduction * (_time - time_before_fully_expand));
								_alpha -= 0.2;
							}
							draw_sprite_ext(sprite, posmod(_time / 2, 2), 320, Aim.Attack.EnemyY, size, size, _time * Aim.Attack.Angle, Aim.Attack.Color, _alpha);
						}
						switch global.MultiBarAttackSprite
						{
							//If weapon is notebook
							case sprNotebookAttack:
								if _time < 15
									scale_x = cos(_time / 4) * 2;
								if _time == 15
								{
									audio_play(snd_punchstrong);
									if Aim.Attack.Crit audio_play(global.MultiBarCritSound);
									scale_x = 0.5;
									scale_y = 0.5;
									_sprite = sprFrypanAttack;
								}
								if _time > 15
								{
									_index = posmod(_index + 1, 2);
									scale_x = 0.5 + (_time - 15) * 0.25;
									scale_y = scale_x;
									if scale_x > 2 _alpha -= 0.1;
									if _alpha < 0.1 _target_state = 3;
								}
								draw_sprite_ext(_sprite, _index, 320, Aim.Attack.EnemyY, scale_x, scale_y, 0, _color, _alpha);
							break
							case sprFrypanAttack:
								if _time == 0
								{
									audio_play(global.MultiBarOverrideSound);
									if Aim.Attack.Crit audio_play(global.MultiBarCritSound);
									Aim.Attack.Angle = 3 * choose(1, -1);
								}
								//Star
								DrawMultibarAttackStar(sprFrypanStar);
								//Actual pan
								if _time < 70
									DrawMultiAttackMain(sprFrypanAttack);
								if _time = 70
									_target_state = 3;
							break
							case sprGunStar:
								if _time == 0
									audio_play(snd_gunshot);
								if _time < 5
									draw_sprite_ext(sprGunStar, posmod(_time / 2, 2), 320, Aim.Attack.EnemyY, 2, 2, 0, _color, 1);
								if _time > 7
									DrawMultibarAttackStar(sprGunStar);
								if _time > 9 and _time < 60
									DrawMultiAttackMain(sprGunCircle);
								if _time = 10
									if Aim.Attack.Crit
										audio_play(snd_multi_crit);
								if _time = 60 _target_state = 3;
							break
						}
						_time++;
						
						//Reset variables
						Aim.Attack.Time = _time;
						Aim.Attack.Alpha = _alpha;
						Aim.Attack.Sprite = _sprite;
						Aim.Attack.Index = _index;
					}
					//None of the bars are hit
					for (var i = 0, k = 0, n = Target.Count; i < n; ++i) {
						if Aim.Faded[i] k++;
					}
					if k == n
					{
						menu_state = 0;
						_target_state = 3;
						battle_state = 0;
					}
				}
				else {
					_target_alpha -= 0.04;
					if _target_retract_method == 0 _target_xscale -= 0.03;
					else _target_yscale -= 0.03;
					
					if _target_xscale < 0.08 or _target_yscale < 0.08 {
						_target_state = 0;
						dialog_start();
						menu_state = -1;
					}
				}
				
				Target.side = _target_side;
				Target.time = _target_time;
				Target.xscale = _target_xscale;
				Target.yscale = _target_yscale;
				Target.frame = _target_frame;
				Target.alpha = _target_alpha;
			}
			
			Target.state = _target_state;

			Aim.scale = _aim_scale;
			Aim.color = _aim_color;
			Aim.Time = _aim_time;
		}
	}
	if menu_state = MENU_STATE.FLEE
	{
		draw_text_scribble(96, 272, DefaultFont + "* " + FleeText[FleeTextNum]);
		if oSoul.x <= 10 and FleeState == 1
		{
			Fader_Fade(0, 1, 30);
			FleeState++;
		}
		if FleeState == 2 and oGlobal.fader_alpha == 1
		{
			//Event after fight ends
			game_restart();
		}
	}
}
if battle_state == BATTLE_STATE.RESULT {
	if !global.BossFight {
		battle_end_text_writer.starting_format(DefaultFontNB, c_white)
		battle_end_text_writer.draw(52, 272, battle_end_text_typist)

		if input_cancel {
			battle_end_text_writer.page(battle_end_text_writer.get_page_count() - 1);
			battle_end_text_typist.skip();
		}
		if battle_end_text_typist.get_state() == 1 and battle_end_text_writer.get_page() < (battle_end_text_writer.get_page_count() - 1)
		battle_end_text_writer.page(battle_end_text_writer.get_page() + 1)
		if battle_end_text_typist.get_state() == 1 {
			if input_confirm
				game_restart();
		}
	}
	else if oGlobal.fader_alpha == 1 game_restart();
}

#region Debug
DrawDebugUI();
#endregion

#region Buttons 
// Credits to Scarm for the base code
var _button_spr =	Button.Sprites,
	_button_pos =	Button.Position,
	_button_alpha = Button.Alpha,
	_button_scale = Button.Scale,
	_button_color = Button.Color,
	_button_angle = Button.Angle,
	_state =		menu_state,
	_menu =			menu_button_choice;
	i = 0;

repeat(array_length(_button_spr)) // Button initialize
{
	// Check if the button is chosen
	var select = (_menu == i) and _state >= 0;

	// Draw the button by array order
	if Button.BackgroundCover
	{
		shader_set(shdBlackMask); //Prevent background covers the buttons
		draw_sprite_ext(_button_spr[i], select, _button_pos[i][0], _button_pos[i][1], _button_scale[i], _button_scale[i], _button_angle[i], c_white, .5 - _button_alpha[i] / 2);
		shader_reset();
	}
	draw_sprite_ext(_button_spr[i], select, _button_pos[i][0], _button_pos[i][1], _button_scale[i], _button_scale[i], _button_angle[i], _button_color[i], _button_alpha[i]);

	// Animation - Color updating in real-time because yes
	if (_state >= 0) {
		if _menu == i // The chosen button
		{
			_button_scale[_menu] += (Button.ScaleTarget[1] - _button_scale[_menu]) / 6;
			_button_alpha[_menu] += (Button.AlphaTarget[1] - _button_alpha[_menu]) / 6;
		}
		else // Other buttons if they aren't chosen
		{
			_button_scale[i] += (Button.ScaleTarget[0] - _button_scale[i]) / 6;
			_button_alpha[i] += (Button.AlphaTarget[0] - _button_alpha[i]) / 6;
		}
	}
	else // If the menu state is over
	{
		var final_alpha = min(Button.AlphaTarget[1], Button.OverrideAlpha[i]);
		_button_scale[i] += (Button.ScaleTarget[0] - _button_scale[i]) / 6;
		_button_alpha[i] += (final_alpha - _button_alpha[i]) / 6;
	}
	++i;
}
if board_cover_button {
	Battle_Masking_Start(true);
	var board = oBoard;
	if !(board.left + board.right >= 640 and board.up + board.down >= 480 and board_full_cover)
		draw_rectangle_color(23, 432, 640, 480, c_black, c_black, c_black, c_black, 0);
	Battle_Masking_End();
}
#endregion

#region UI (Name - Lv - Hp - Kr)
	// Credits to Scarm for all the help and this epico code!
	var hp_x =				ui_x - global.kr_activation * 20,
		hp_y =				ui_y,
		name_x =			ui_x - 245,
		name_y =			ui_y,
		name =				global.data.name,
		default_col =		c_white,//make_color_rgb(27, 25, 26),
		name_col =			c_white,
		lv_col =			c_white,
		lv_counter_col =	c_white,//make_color_rgb(27, 25, 26),
		hp_max_col =		c_red,//merge_color(c_red, c_maroon, 0.5),
		hp_col =			c_yellow,
		kr_col =			c_fuchsia,
		krr_col =			c_white,//make_color_rgb(27, 25, 26),
		hp_pre_col =		c_lime,//merge_color(c_lime, c_white, 0.25),
		bar_multiplier =	1.2, //Default multiplier from UNDERTALE
		hp_text =			"HP",
		kr_text =			"KR",
		_alpha =			ui_alpha;
		
		//name_col =		make_color_rgb(27, 25, 26);
		//lv_col =			make_color_rgb(27, 25, 26);
		//hp_max_col =		make_color_rgb(100, 100, 100);
		//hp_col =			make_color_rgb(47, 47, 47);
		//kr_col =			make_color_rgb(27, 25, 26);

	// Linear health updating / higher refill_speed = faster refill / max refill_speed is 1
	hp += (global.hp - hp) * refill_speed;
	hp_max += (global.hp_max - hp_max) * refill_speed;
	kr += (global.kr - kr) * refill_speed;
	hp = clamp(hp, 0, global.hp_max);
	hp_max = clamp(hp_max, 0, global.hp_max);
	kr = clamp(kr, 0, max_kr);
	var _hp = hp * bar_multiplier,
		_hp_max = hp_max * bar_multiplier,
		_kr = kr * bar_multiplier;
	//Prevent long decimals
	if abs(hp - global.hp) < .1 hp = global.hp;
	if abs(kr - global.kr) < .1 kr = global.kr;

	draw_set_font(fnt_mnc); // Name - LV Font
	// Name
	var f_alpha = min(ui_override_alpha[0], _alpha);
	if f_alpha > 0
		draw_text_color(name_x, name_y, name, name_col, name_col, name_col, name_col, f_alpha);
	if debug_alpha > 0
	{
		var col = make_color_hsv(global.timer % 255, 255, 255)
		draw_text_color(name_x, name_y, name, col, col, col, col, debug_alpha);
	}
	// LV Icon
	f_alpha = min(ui_override_alpha[1], _alpha);
	if f_alpha > 0
	{
		draw_text_color(name_x + string_width(name), name_y, "   LV ", lv_col, lv_col, lv_col, lv_col, f_alpha);
		// LV Counter
		draw_text_color(name_x + string_width(name + "   LV "), name_y, string(global.data.lv), lv_counter_col, lv_counter_col, lv_counter_col, lv_counter_col, f_alpha);
	}

	draw_set_font(fnt_uicon); // Icon Font
	// HP Icon
	f_alpha = min(ui_override_alpha[2], _alpha);
	if f_alpha > 0
		draw_text_color((hp_x - 31), hp_y + 5, hp_text, default_col, default_col, default_col, default_col, f_alpha);

	// Background bar
	f_alpha = min(ui_override_alpha[3], _alpha);
	if f_alpha > 0
	{
		draw_set_alpha(f_alpha);
		draw_rectangle_color(hp_x, hp_y, hp_x + _hp_max, hp_y + 20, hp_max_col, hp_max_col, hp_max_col, hp_max_col, false);
		// HP bar
		draw_rectangle_color(hp_x, hp_y, hp_x + _hp, hp_y + 20, hp_col, hp_col, hp_col, hp_col, false);
	}

	if menu_state == MENU_STATE.ITEM {
		switch item_scroll_type
		{
			case ITEM_SCROLL.DEFAULT:
			case ITEM_SCROLL.VERTICAL:
				hp_predict += (item_heal[coord] - hp_predict) * refill_speed;
				//Healing Prediction
				draw_set_alpha(abs(dsin(global.timer * 2) * .5) + .2);
				draw_rectangle_color(hp_x + _hp, hp_y, hp_x + min(hp + hp_predict, hp_max) * bar_multiplier, hp_y + 20, hp_pre_col, hp_pre_col, hp_pre_col, hp_pre_col, false);
				draw_set_alpha(1);
			break
		}
	}

	// KR bar
	if global.kr_activation {
		krr_col = (round(kr) ? kr_col : krr_col);
		
		// Draw icon
		f_alpha = min(ui_override_alpha[4], _alpha);
		draw_set_alpha(f_alpha);
		// Draw the bar
		if round(kr)
			draw_rectangle_color(hp_x + _hp + 1, hp_y, max(hp_x + _hp - _kr, hp_x), hp_y + 20, krr_col, krr_col, krr_col, krr_col, false);

		draw_text_color((hp_x + 10) + _hp_max, hp_y + 5, kr_text, krr_col, krr_col, krr_col, krr_col, f_alpha);
	}
	draw_set_alpha(ui_alpha);

	// Zeropadding
	var hp_counter = string(round(hp)),
		hp_max_counter = string(round(hp_max));
	if round(hp) < 10 hp_counter = "0" + hp_counter;
	if round(hp_max) < 10 hp_max_counter = "0" + hp_max_counter;

	// This line below supports multiple digits for Zeropadding, but I just personally don't like it. 
	// var hp_counter = string_replace_all(string_format(round(hp), string_length(string(hp_max)), 0), " ", "0");

	// Draw the health counter
	f_alpha = min(ui_override_alpha[5], _alpha);
	draw_set_alpha(f_alpha);
	draw_set_color(krr_col);
	draw_set_font(fnt_mnc); // Counter Font
	var offset = global.kr_activation ? (20 + string_width(kr_text)) : 15;
	draw_text(hp_x + offset + _hp_max, hp_y, hp_counter + " / " + hp_max_counter);

draw_set_color(c_white);
draw_set_alpha(1);
#endregion

if board_cover_hp_bar {
	Battle_Masking_Start(true);
	var board = oBoard;
	if !(board.left + board.right >= 640 and board.up + board.down >= 480 and board_full_cover)
		draw_rectangle_color(0, hp_y, 640, hp_y + 20, c_black, c_black, c_black, c_black, 0);
	Battle_Masking_End();
}