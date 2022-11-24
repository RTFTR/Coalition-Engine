// Check if other enemies are dying
for (var i = 0, n = instance_number(oEnemyParent); i < n; ++i) {
	var enemy_find;
	enemy_find[i] = instance_find(oEnemyParent, i);
	if enemy_find[i].is_dying
	state = 0.6;
}
if state > 0.5 and state < 1
state += 0.1
//The dialog thing
if state == 1 and!died and!is_spared {
	if dialog_text[oBattleController.battle_turn - 1] == ""
	{
		oBattleController.end_dialog();
		exit;
	}
	var spike_spr = spr_speechbubble_spike;
	var spike_width = sprite_get_width(spike_spr);
	var spike_height = sprite_get_height(spike_spr);
	var corner_spr = spr_speechbubble_corner;
	var corner_width = sprite_get_width(corner_spr);
	var corner_height = sprite_get_height(corner_spr);
	var e_height = enemy_total_height - dialog_y_from_top;
	//Top Left, Top Right, Bottom Left, Bottom Right
	var top_pos = y - e_height - dialog_size[0];
	var down_pos = y - e_height + dialog_size[1];
	var left_pos = x + 35 + dialog_size[2] + corner_width;
	var right_pos = left_pos + dialog_size[3];
	draw_sprite_ext(corner_spr, 0, left_pos, top_pos, 1, 1, 0, c_white, 1);
	draw_sprite_ext(corner_spr, 0, right_pos, top_pos, -1, 1, 0, c_white, 1);
	draw_sprite_ext(corner_spr, 0, left_pos, down_pos, 1, -1, 0, c_white, 1);
	draw_sprite_ext(corner_spr, 0, right_pos, down_pos, -1, -1, 0, c_white, 1);
	draw_set_color(c_black);
	draw_line_width(left_pos + corner_width - 1, top_pos, right_pos - corner_width, top_pos, 1);
	draw_line_width(left_pos + corner_width - 1, down_pos - 1, right_pos - corner_width - 1, down_pos - 1, 1);
	draw_line_width(left_pos, top_pos + corner_height - 1, left_pos, down_pos - corner_height, 1);
	draw_line_width(right_pos - 1, top_pos + corner_height - 1, right_pos - 1, down_pos - corner_height - 1, 1);
	draw_set_color(c_white);
	var spike_pos = [
		[right_pos, down_pos - spike_height - 10],
		[left_pos + spike_width + 10, top_pos],
		[left_pos, down_pos - spike_height - 10],
		[right_pos - spike_width - 10, down_pos],
	]
	var spike_scan = [
		[-1, 1, 0],
		[-1, 1, 90],
		[1, 1, 0],
		[1, 1, 90],
	]
	var fin_dir = dialog_dir / 90;
	draw_sprite_ext(spike_spr, 0, spike_pos[fin_dir, 0], spike_pos[fin_dir, 1], spike_scan[fin_dir, 0], spike_scan[fin_dir, 1], spike_scan[fin_dir, 2], c_white, 1);
	//Fill ins
	draw_set_color(c_white);
	draw_rectangle(left_pos + corner_width, top_pos + 1, right_pos - corner_width, down_pos - 2, 0);
	draw_rectangle(left_pos + 1, top_pos + corner_height, right_pos - 2, down_pos - corner_height, 0);

	//Text
	text_writer.starting_format("fnt_sans", c_white)
	text_writer.draw(left_pos + corner_width, top_pos + corner_height, dialog_text_typist)


	if input_check_pressed("cancel") dialog_text_typist.skip();
	if dialog_text_typist.get_state() == 1 and text_writer.get_page() < (text_writer.get_page_count() - 1)
	text_writer.page(text_writer.get_page() + 1)
	if dialog_text_typist.get_state() == 1 {
		if input_check_pressed("confirm") {
			oBattleController.end_dialog();
			dialog_text_typist.reset();
			var text = oBattleController.battle_turn < array_length(dialog_text) ?
				dialog_text[oBattleController.battle_turn] : ""
			dialog_init(text);
		}
	}
}

if !died and!is_spared
if is_being_attacked {
	if is_dodge // The movement for dodge
	{
		draw_damage = true;
		damage_color = c_ltgray;
		damage = "MISS";
		if !attack_time {
			TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 20, "damage_y", damage_y, damage_y - 30);
			TweenFire(id, EaseInQuad, TWEEN_MODE_ONCE, false, 20, 20, "damage_y", damage_y - 30, damage_y);
			TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 25, "x", x, x - dodge_to);
			TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 35, 25, "x", x - dodge_to, x);
		}
		attack_time++;
	} else {
		if !instance_exists(oStrike) {
			if attack_time == 0 {
				sfx_play(snd_damage);
				_enemy_hp = enemy_hp;
				enemy_hp -= damage;
				draw_damage = true;
				TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 40, "_enemy_hp", _enemy_hp, enemy_hp);
				damage_color = c_red;
				TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 20, "damage_y", damage_y, damage_y - 30);
				TweenFire(id, EaseInQuad, TWEEN_MODE_ONCE, false, 20, 20, "damage_y", damage_y - 30, damage_y);
			}
			attack_time++;
			if attack_time < attack_end_time
			x = random_range(xstart - 3, xstart + 3);
			else x = xstart;
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
			draw_rectangle(xstart - bar_width / 2, y - enemy_total_height + 10 + dialog_y_from_top, xstart + bar_width / 2, y - enemy_total_height + 30 + dialog_y_from_top, 0);
			draw_set_color(c_lime);
			draw_rectangle(xstart - bar_width / 2, y - enemy_total_height + 10 + dialog_y_from_top, max(xstart - bar_width / 2 + (_enemy_hp / enemy_hp_max) * bar_width, xstart - bar_width / 2 - 1), y - enemy_total_height + 30 + dialog_y_from_top, 0);
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
	}

	if enemy_hp > 0 // Check if the enemy is going to die
	{
		if attack_time == attack_end_time {
			attack_time = 0;
			is_being_attacked = false
		}
	} else {
		//If is gonna die
		is_dying = true;
		death_time++;
		if death_time = 1 + attack_end_time {
			//Play sound and stop damage display
			draw_damage = false;
			sfx_play(snd_vaporize);
		}
		if death_time = 1 + attack_end_time + dust_speed + 60 {
			//Set enemy is throughly dead when dust is gone
			is_dying = false;
			died = true
			is_being_attacked = false;
			enemy_in_battle = false;
			global.Kills++;
			//Remove enemy
			if instance_exists(oBattleController)
				with(oBattleController) {
					var enemy_slot = other.x / 160 - 1;
					enemy[enemy_slot] = noone;
					enemy_draw_hp_bar[enemy_slot] = 0;
				}
		}
	}
}

if is_being_spared {
	if !died and!is_spared
		if enemy_is_spareable {
			wiggle = false;
			//Add Reward
			oBattleController.Total_Gold += Gold_Give;
			oBattleController.Total_Exp += Exp_Give;
			is_spared = true;
			sfx_play(snd_vaporize);
			TweenFire(id, EaseLinear, TWEEN_MODE_ONCE, false, 0, 30, "image_alpha", image_alpha, 0.5);
		}
	//Check for any un-spared enemies, if yes then resume battle
	var continue_battle = false;
	for (var i = 0, n = instance_number(oEnemyParent); i < n; ++i) {
		var enemy_find;
		enemy_find[i] = instance_find(oEnemyParent, i);
		if !enemy_find[i].is_spared continue_battle = true;
	}
	if !continue_battle
	oBattleController.end_battle();
	else {
		if spare_end_begin_turn {
			//Begins turn if it's set to be
			if !is_spared {
				oBattleController.dialog_start();
			}
		}
	}

	is_being_spared = false
}
if is_spared and image_alpha == 0.5 {
	//Remove enemy
	enemy_in_battle = false;
	if instance_exists(oBattleController)
		with(oBattleController) {
			var enemy_slot = other.x / 160 - 1;
			enemy[enemy_slot] = noone;
			enemy_draw_hp_bar[enemy_slot] = 0;
		}
}

//Dusting
var total_height = enemy_total_height;
if !died {
	if !is_dying or(is_dying and death_time < 1 + attack_end_time) {
		//If not dying then normal drawing
		event_user(0);
	}
	else
	if death_time >= 1 + attack_end_time {
		//Dust height adding
		if dust_height < total_height {
			var Height_decrease = total_height / dust_speed;
			dust_height += Height_decrease * 6;
		}
		//Main dust drawing
		for (var i = 0; i < dust_height * dust_amount / total_height; i += 6) {
			if dust_alpha[i] > 1 / dust_life[i] {
				draw_set_alpha(dust_alpha[i]);
				draw_sprite(spr_pixel, 0, dust_pos[i, 0], dust_pos[i, 1]);
				dust_pos[i, 0] += dust_displace[i, 0];
				dust_pos[i, 1] += dust_displace[i, 1];
				dust_alpha[i] -= 1 / dust_life[i];
				dust_being_drawn = true;
			}
			else dust_being_drawn = false;
		}
		draw_set_alpha(1);

		//Make the enemy sprite fade from top to bottom by surface because
		//draw_sprite_part_ext takes too much math and i dont have a brain
		if !surface_exists(dust_surface) dust_surface = surface_create(640, 480);
		surface_set_target(dust_surface);
		draw_clear_alpha(c_black, 0);
		event_user(0);
		surface_reset_target();
		var Drawing_Height = dust_height * 480 / dust_speed;
		draw_surface_part(dust_surface, 0, Drawing_Height, 640, 480 - Drawing_Height, 0, Drawing_Height);
	}
}
if state == 2 {
	draw_set_halign(fa_right);
	draw_set_color(c_white);
	var turn = oBattleController.battle_turn - 1;
	if oBattleController.debug
		if array_length(turn_time) > turn
			draw_text(640, 10, "Time: " + string(time) + " / " + string(turn_time[turn]));
	draw_set_halign(fa_left);
}
