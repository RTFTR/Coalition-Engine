#region Functions
function RemoveEnemy()
{
	instance_destroy();
	if instance_exists(oBattleController)
		with oBattleController {
			var enemy_slot = other.x / 160 - 1;
			enemy[enemy_slot] = noone;
			enemy_draw_hp_bar[enemy_slot] = 0;
			array_delete(enemy_instance, menu_choice[0], 1);
		}
}
#endregion
// Check if other enemies are dying
for (var i = 0, n = instance_number(oEnemyParent), enemy_find; i < n; ++i) {
	enemy_find[i] = instance_find(oEnemyParent, i);
	if enemy_find[i].is_dying
		state = 0.6;
}
var _turn = oBattleController.battle_turn - 1;
if state > 0.5 and state < 1
	state += 0.1


//Dusting
var total_height = enemy_total_height;
if !died {
	if !is_dying or(is_dying and death_time < 1 + attack_end_time) {
		//If not dying then normal drawing
		event_user(0);
	}
	else
	if death_time >= 1 + attack_end_time {
		if ContainsDust
		{
			//Dust height adding
			if dust_height < total_height {
				var Height_decrease = total_height / dust_speed;
				dust_height += Height_decrease * 6;
			}
			//Main dust drawing
			dust_being_drawn = false;
			for (var i = 0; i < dust_height * dust_amount / total_height; i++) {
				if dust_alpha[i] > 1 / dust_life[i] {
					draw_sprite_ext(sprPixel, 0, dust_pos[i, 0], dust_pos[i, 1], 1.5, 1.5, 0, c_white, dust_alpha[i]);
					dust_pos[i, 0] += dust_displace[i, 0];
					dust_pos[i, 1] += dust_displace[i, 1];
					dust_alpha[i] -= 1 / dust_life[i];
					if !dust_being_drawn dust_being_drawn = true;
				}
			}
		}
		draw_set_alpha(1);
		
		if ContainsDust
		{
			//Make the enemy sprite fade from top to bottom by surface because
			//draw_sprite_part_ext takes too much math and i dont have a brain
			surface_set_target(dust_surface);
			draw_clear_alpha(c_black, 0);
			event_user(0);
			surface_reset_target();
			var DrawingHeight = dust_height * 480 / dust_speed;
			draw_surface_part(dust_surface, 0, DrawingHeight, 640, 480 - DrawingHeight, 0, DrawingHeight);
		}
	}
}

//The dialog thing
if state == 1 or (state == 2 and dialog_at_mid_turn) and !died and !is_spared
{
	if dialog_at_mid_turn time--;
	if _turn < 0 _turn = 0
	if dialog_text[_turn] == ""
	{
		oBattleController.begin_turn();
		exit;
	}
	var SpikeSprite = sprSpeechBubbleSpike,
		SpikeWidth = sprite_get_width(SpikeSprite),
		SpikeHeight = sprite_get_height(SpikeSprite),
		CornerSprite = sprSpeechBubbleCorner,
		CornerWidth = sprite_get_width(CornerSprite),
		CornerHeight = sprite_get_height(CornerSprite),
		e_height = enemy_total_height - dialog_y_from_top,
		CornerPosition;
		//Top Left, Top Right, Bottom Left, Bottom Right
		CornerPosition = [
			y - e_height - dialog_size[0],
			y - e_height + dialog_size[1],
			x + 35 + dialog_size[2] + CornerWidth,
		];
		CornerPosition[3] = CornerPosition[2] + dialog_size[3];
	for (var i = 0; i < 4; ++i) {
		draw_sprite_ext(CornerSprite, 0, CornerPosition[2 + (i % 2)], CornerPosition[i >= 2],
							(i % 2 ? -1 : 1), (i < 2 ? 1 : -1), 0, dialog_box_color, 1);
	}
	draw_set_color(c_black);
	draw_line_width(CornerPosition[2] + CornerWidth - 1, CornerPosition[0],
					CornerPosition[3] - CornerWidth, CornerPosition[0], 1);
	draw_line_width(CornerPosition[2] + CornerWidth - 1, CornerPosition[1] - 1,
					CornerPosition[3] - CornerWidth - 1, CornerPosition[1] - 1, 1);
	draw_line_width(CornerPosition[2], CornerPosition[0] + CornerHeight - 1,
					CornerPosition[2], CornerPosition[1] - CornerHeight, 1);
	draw_line_width(CornerPosition[3] - 1, CornerPosition[0] + CornerHeight - 1,
					CornerPosition[3] - 1, CornerPosition[1] - CornerHeight - 1, 1);
	draw_set_color(dialog_box_color);
	var SpikePosition = [
		[CornerPosition[3], CornerPosition[1] - SpikeHeight - 10],
		[CornerPosition[2] + SpikeWidth + 10, CornerPosition[0]],
		[CornerPosition[2], CornerPosition[1] - SpikeHeight - 10],
		[CornerPosition[3] - SpikeWidth - 10, CornerPosition[1]],
	],
	SpikeScaleAngle = [
		[-1, 1, 0],
		[-1, 1, 90],
		[1, 1, 0],
		[1, 1, 90],
	],
	FinalDirection = dialog_dir / 90;
	draw_sprite_ext(SpikeSprite, 0, SpikePosition[FinalDirection, 0], SpikePosition[FinalDirection, 1],
					SpikeScaleAngle[FinalDirection, 0], SpikeScaleAngle[FinalDirection, 1],
					SpikeScaleAngle[FinalDirection, 2], dialog_box_color, 1);
	//Fill ins
	draw_set_color(dialog_box_color);
	draw_rectangle(CornerPosition[2] + CornerWidth, CornerPosition[0] + 1,
					CornerPosition[3] - CornerWidth, CornerPosition[1] - 2, 0);
	draw_rectangle(CornerPosition[2] + 1, CornerPosition[0] + CornerHeight,
					CornerPosition[3] - 2, CornerPosition[1] - CornerHeight, 0);
	draw_set_color(c_white);

	//Text
	text_writer.starting_format("fnt_sans", c_white)
	text_writer.draw(CornerPosition[2] + CornerWidth, CornerPosition[0] + CornerHeight, dialog_text_typist)


	if input_check_pressed("cancel") and global.TextSkipEnabled
		dialog_text_typist.skip_to_pause();
		
	if dialog_text_typist.get_paused() and input_check_pressed("confirm")
		dialog_text_typist.unpause();
		
	if dialog_text_typist.get_state() == 1 and
		text_writer.get_page() < (text_writer.get_page_count() - 1)
		text_writer.page(text_writer.get_page() + 1);
		
	if dialog_text_typist.get_state() == 1 {
		if input_check_pressed("confirm") {
			if dialog_at_mid_turn dialog_at_mid_turn = false;
			dialog_text_typist.reset();
			var text = (oBattleController.battle_turn < array_length(dialog_text) and state == 1) ?
				dialog_text[oBattleController.battle_turn] : "";
			dialog_init(text, true);
			if state == 1
				oBattleController.begin_turn();
		}
	}
}

if !died and !is_spared
	if is_being_attacked {
		if is_dodge // The movement for dodge
		{
			draw_damage = true;
			damage_color = c_ltgray;
			damage = "MISS";
			if !attack_time and !is_miss {
				dodge_method();
			}
			attack_time++;
		}
		else
		{
			if !instance_exists(oStrike) {
				if attack_time == 0 {
					audio_play(snd_damage);
					_enemy_hp = enemy_hp;
					damage_color = c_ltgray;
					if is_real(damage)
					{
						enemy_hp -= damage;
						damage_color = c_red;
					}
					draw_damage = true;
					TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 40, "_enemy_hp", _enemy_hp, enemy_hp);
					TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 20, "damage_y", damage_y, damage_y - 30);
					TweenFire(id, EaseInQuad, TWEEN_MODE_ONCE, false, 20, 20, "damage_y", damage_y - 30, damage_y);
				}
				attack_time++;
				if is_real(damage)
					x = (attack_time < attack_end_time) ? random_range(xstart - 3, xstart + 3) : xstart;
				//The is_real(damage) checks whether it's a solid hit
			}
		}

		if draw_damage {
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(fnt_dmg);
			draw_set_color(damage_color);
			draw_text(xstart, damage_y, string(damage));
			// Bar retract speed thing idk
			if is_string(damage) == false {
				draw_set_color(c_dkgray);
				var TLX = xstart - bar_width / 2,
					TLY = y - enemy_total_height / 2 - 40,
					BRY = TLY + 20;
				draw_rectangle(TLX, TLY, xstart + bar_width / 2, BRY, 0);
				draw_set_color(c_lime);
				draw_rectangle(TLX, TLY, max(xstart - bar_width / 2 + (_enemy_hp / enemy_hp_max) * bar_width, xstart - bar_width / 2 - 1), BRY, 0);
			}
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_color(c_white);
		}

		if enemy_hp > 0 // Check if the enemy is going to die
		{
			if attack_time == attack_end_time {
				//Reset variables
				attack_time = 0;
				is_being_attacked = false;
				is_miss = false;
			}
		}
		else
		{
			//If is gonna die
			is_dying = true;
			death_time++;
			if death_time = 1 + attack_end_time {
				//Play sound and stop damage display
				draw_damage = false;
				audio_play(snd_vaporize);
			}
			if death_time = 1 + attack_end_time + dust_speed + 60 {
				//Set enemy is throughly dead when dust is gone
				is_dying = false;
				died = true;
				is_being_attacked = false;
				enemy_in_battle = false;
				global.data.Kills++;
				RemoveEnemy();
				if array_length(oBattleController.enemy_instance) == 0 oBattleController.end_battle();
			}
		}
	}

if is_being_spared {
	if !died and!is_spared
		if enemy_is_spareable {
			if spare_function == -1
			{
				wiggle = false;
				//Add Reward
				oBattleController.Result.Gold += Gold_Give;
				oBattleController.Result.Exp += Exp_Give;
				is_spared = true;
				audio_play(snd_vaporize);
				TweenFire(id, EaseLinear, TWEEN_MODE_ONCE, false, 0, 30, "image_alpha", image_alpha, 0.5);
			}
			else spare_function();
		}
	//Check for any un-spared enemies, if yes then resume battle
	for (var i = 0, n = instance_number(oEnemyParent), continue_battle = false, enemy_find; i < n; ++i) {
		enemy_find[i] = instance_find(oEnemyParent, i);
		if !enemy_find[i].is_spared continue_battle = true;
	}
	if !continue_battle
		oBattleController.end_battle();
	else
	{
		if spare_end_begin_turn {
			//Begins turn if it's set to be
			if !is_spared {
				oBattleController.dialog_start();
			}
		}
	}

	is_being_spared = false;
}
if is_spared and image_alpha == 0.5 {
	//Remove enemy
	enemy_in_battle = false;
	if array_length(oBattleController.enemy_instance) == 0 RemoveEnemy();
}

if state == 2 {
	draw_set_halign(fa_right);
	draw_set_color(c_white);
	if oBattleController.debug
		if array_length(turn_time) > _turn
			draw_text(640, 10, "Time: " + string(time) + " / " + string(turn_time[_turn]));
	draw_set_halign(fa_left);
}
