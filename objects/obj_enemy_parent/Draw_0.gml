#region Enemy Status
// Check if other enemies are dying
for (var i = 0, n = instance_number(obj_enemy_parent); i < n; ++i)
{
	var enemy_find;
	enemy_find[i] = instance_find(obj_enemy_parent, i);
	if enemy_find[i].is_dying
	is_dialog = 0.6;
}
if is_dialog > 0.5 and is_dialog < 1
is_dialog += 0.1
//The dialog thing
if is_dialog == 1 and !died and !is_spared
{
	var spike_spr = spr_speechbubble_spike;
	var spike_width = sprite_get_width(spike_spr);
	var spike_height = sprite_get_height(spike_spr);
	var corner_spr = spr_speechbubble_corner;
	var corner_width = sprite_get_width(corner_spr);
	var corner_height = sprite_get_height(corner_spr);
	var e_height = enemy_total_height;
	//Top Left, Top Right, Bottom Left, Bottom Right
	var top_pos = y-e_height-dialog_size[0];
	var down_pos = y-e_height+dialog_size[1];
	var left_pos = x+25+dialog_size[2]+corner_width;
	var right_pos = left_pos + dialog_size[3];
	draw_sprite_ext(corner_spr,0,left_pos,top_pos,1,1,0,c_white,1);
	draw_sprite_ext(corner_spr,0,right_pos,top_pos,-1,1,0,c_white,1);
	draw_sprite_ext(corner_spr,0,left_pos,down_pos,1,-1,0,c_white,1);
	draw_sprite_ext(corner_spr,0,right_pos,down_pos,-1,-1,0,c_white,1);
	draw_set_color(c_black);
	draw_line_width(left_pos+corner_width-1,top_pos,right_pos-corner_width,top_pos,1);
	draw_line_width(left_pos+corner_width-1,down_pos-1,right_pos-corner_width-1,down_pos-1,1);
	draw_line_width(left_pos,top_pos+corner_height-1,left_pos,down_pos-corner_height,1);
	draw_line_width(right_pos-1,top_pos+corner_height-1,right_pos-1,down_pos-corner_height-1,1);
	draw_set_color(c_white);
	var spike_pos=
	[
		[right_pos, down_pos-spike_height-10],
		[left_pos + spike_width + 10, top_pos],
		[left_pos, down_pos-spike_height-10],
		[right_pos - spike_width - 10, down_pos],
	]
	var spike_scan=
	[
		[-1, 1, 0],
		[-1, 1, 90],
		[1, 1, 0],
		[1, 1, 90],
	]
	var fin_dir = dialog_dir / 90;
	draw_sprite_ext(spike_spr,0,spike_pos[fin_dir, 0],spike_pos[fin_dir, 1],spike_scan[fin_dir, 0],spike_scan[fin_dir, 1],spike_scan[fin_dir, 2],c_white,1);
	//Fill ins
	draw_set_color(c_white);
	draw_rectangle(left_pos+corner_width,top_pos+1,right_pos-corner_width,down_pos-2,0);
	draw_rectangle(left_pos+1,top_pos+corner_height,right_pos-2,down_pos-corner_height,0);
	
	//Text
	text_writer.starting_format("font_sans",c_white)
	text_writer.draw(left_pos+corner_width, top_pos+corner_height, dialog_text_typist)
		
		
	if input_check_pressed("cancel") dialog_text_typist.skip();
	if dialog_text_typist.get_state() == 1 and text_writer.get_page() < (text_writer.get_page_count() - 1)
		text_writer.page(text_writer.get_page() + 1)
	if dialog_text_typist.get_state() == 1
	{
		if input_check_pressed("confirm")
		{
			obj_battle_controller.end_dialog();
			dialog_text_typist.reset();
			dialog_init();
		}
	}
}

//When the enemy is under attack
if !died and !is_spared
if is_being_attacked
{
	if is_dodge
	{
		draw_damage = true;
		damage_color = c_ltgray;
		damage = "MISS";
		if !attack_time
		{
			TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 25, "x", x, x - dodge_to);
			TweenFire(id, EaseOutQuad, TWEEN_MODE_ONCE, false, 35, 25, "x", x - dodge_to, x);
		}
		attack_time++;
	}
	else
	{
		if !instance_exists(obj_strike)
		{
			if attack_time == 0
			{
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
	
	if draw_damage
	{
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		draw_set_font(font_dmg);
		draw_set_color(damage_color);
		draw_text(xstart, damage_y, string(damage));
		// Bar retract speed thing idk
		if is_string(damage) == false
		{
			draw_set_color(c_dkgray);
			draw_rectangle(xstart - bar_width / 2, y - enemy_total_height + 10, xstart + bar_width / 2, y - enemy_total_height + 30, 0);
			draw_set_color(c_lime);
			draw_rectangle(xstart - bar_width / 2, y - enemy_total_height + 10, max(xstart - bar_width / 2 + (_enemy_hp / enemy_hp_max) * bar_width, xstart - bar_width / 2 - 1), y - enemy_total_height + 30, 0);
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
	}
	
	if enemy_hp > 0
	{
		if attack_time == attack_end_time
		{
			attack_time = 0;
			is_being_attacked = false
		}
	}
	else
	{
		is_dying = true;
		death_time++;
		if death_time = 1 + attack_end_time
		{
			draw_damage = false;
			sfx_play(snd_vaporize);
			TweenFire(id, EaseLinear, TWEEN_MODE_ONCE, false, 0, 30, "image_alpha", image_alpha, 0);
		}
		if death_time = 31 + attack_end_time
		{
			is_dying = false;
			died = true
			is_being_attacked = false;
			//instance_destroy();
			enemy_in_battle = false;
			if instance_exists(obj_battle_controller)
				with(obj_battle_controller)
				{
					var enemy_slot = other.x / 160 - 1;
					enemy[| enemy_slot] = noone;
					enemy_draw_hp_bar[| enemy_slot] = 0;
				}
		}
	}
}

//When being spared
if is_being_spared
{
	if !died and !is_spared
		if enemy_is_spareable
		{
			obj_battle_controller.Total_Gold += Gold_Give;
			obj_battle_controller.Total_Exp += Exp_Give;
			is_spared = true;
			sfx_play(snd_vaporize);
			TweenFire(id, EaseLinear, TWEEN_MODE_ONCE, false, 0, 30, "image_alpha", image_alpha, 0.5);
		}
	//Check for any un-spared enemies
	var continue_battle = false;
	for (var i = 0; i < instance_number(obj_enemy_parent); ++i)
	{
		var enemy_find;
		enemy_find[i] = instance_find(obj_enemy_parent, i);
		if enemy_find[i].is_spared == false	continue_battle = true;
	}
	if !continue_battle
		obj_battle_controller.end_battle();
	else
	{
		if spare_end_begin_turn
		{
			if !is_spared {obj_battle_controller.dialog_start();}
		}
	}
	
	is_being_spared = false
}
if is_spared and image_alpha == 0.5
{
	enemy_in_battle = false;
	if instance_exists(obj_battle_controller)
		with(obj_battle_controller)
		{
			var enemy_slot = other.x / 160 - 1;
			enemy[| enemy_slot] = noone;
			enemy_draw_hp_bar[| enemy_slot] = 0;
		}
}
#endregion

//Here you draw the enemy sprite
draw_set_alpha(image_alpha);
draw_rectangle(x-20,y-20,x+20,y,0)
draw_set_alpha(1);
