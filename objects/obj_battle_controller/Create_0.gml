Enemy_Function_Load(global.battle_encounter);
menu_state = 0;
battle_state = 0;
battle_turn = 0;
menu_button_choice = 0;
menu_choice = [0, 0, 0, 0] // Fight - Act - Item - Mercy
activate_turn = [1, 0, 0, 1];

time = 0;


global.kr_activation = true;
global.kr = 0;
global.hp = global.hp_max;
max_kr = 40;

// Fight Aiming Functions
{
	
target_state = 0;
target_side = 0;
target_time = 0;
target_xscale = 1;
target_yscale = 1;
target_frame = 0;
target_alpha = 1;
target_buffer = 0;
target_retract_method = choose(0, 1);

aim_scale = 1;
aim_angle = 0;
aim_color = c_white;
aim_retract = choose(-1, 1);

}

//Menu Dialog Funtions
{
menu_text = "Just a basic test that's\n  long enough for a functional\n  typist test.[delay,3000][/page]* This is a test if the\n  page function is functional[delay,3000]![/page]* Another test if this is\n  functional and good to go!"
default_menu_text = menu_text;
menu_text_typist = scribble_typist()
	.in(0.5, 0)
	.sound_per_char(snd_txtTyper, 1, 1," ^!.?,:/\\|*")

//text_writer = scribble("* " + menu_text);
//if text_writer.get_page() != 0 text_writer.page(0);
Battle_SetMenuDialog(menu_text);

}
//KR Functions
kr_timer = 0
hp_previous = global.hp;

//Button Functions
{
button_spr = [spr_button_fight,spr_button_act,spr_button_item,spr_button_mercy];
button_pos = [ [87,453], [240,453], [400,453], [555,453] ];
button_alpha = [0.25, 0.25, 0.25, 0.25];
button_scale = [1, 1, 1, 1];
button_color = [ [242,101,34], [242,101,34], [242,101,34], [242,101,34] ];
button_alpha_target = [0.25, 1];
button_scale_target = [1, 1.2];
button_color_target = [ [ [242,101,34], [255,255,0] ],
						[ [242,101,34], [255,255,0] ],
						[ [242,101,34], [255,255,0] ],
						[ [242,101,34], [255,255,0] ] 
					  ];
}

//UI Functions
{
ui_x = 275;
ui_y = 400;
ui_alpha = 1;
hp = global.hp;
hp_max = global.hp_max;
kr = global.kr;
refill_speed = 0.2;
hp_predict = 0;
}

allow_run = 0;

//Dialog Stuff
{
dialog_is_end = 0;
}

//Battle Variables
Total_Exp = 0;
Total_Gold = 0;


function Move_Noise() { audio_play(snd_menu_switch); };
function Confirm_Noise() { audio_play(snd_menu_confirm); };
function scr_enemy_choice()
{
	for (var i = 0, n = 0; i < 2; ++i)
		if instance_exists(enemy[| i]) n++
	
	return n;
}

function scr_enemy_num()
{
	for (var i = 0, n = 0; i < 2; i++)
		if enemy[| i] != noone
		n++
	
	return n + 1;
}

function enemy_under_attack(enemy_number){enemy[| enemy_number].is_being_attacked = true; }

function Calculate_MenuDamage(distance_to_center, enemy_under_attack)
{
	var damage = global.player_attack + global.player_attack_boost;
	var target = enemy[| enemy_under_attack];
	var enemy_def = target.enemy_defense;
	if target.enemy_is_spareable enemy_def *= -30; //Check if enemy is spareable -> reduce the DEF
	damage -= enemy_def;
	damage *= 2;
	if distance_to_center > 15
	damage *= (1 - distance_to_center/273);
	damage *= random_range(0.9, 1.1); //Sets damage to be random of the actual damage (idk what im saying)
	damage = clamp(round(damage), 1, infinity);
	target.damage = damage;
}

function dialog_start(){ obj_enemy_parent.is_dialog = 1; battle_state = 1;}

function end_dialog(){ obj_enemy_parent.is_dialog = 0; begin_turn();}

function begin_turn() { battle_state = 2; instance_create_depth(0, 0, 0, obj_turn_parent); obj_battle_soul.image_angle = 0;}

function gameover()
{
	global.soul_x = obj_battle_soul.x;
	global.soul_y = obj_battle_soul.y;
	audio_stop_all();
	room_goto(room_gameover);
	// Insert file saving and events
}
function begin_spare(activate_the_turn)
{
	obj_enemy_parent.is_being_spared = true;
	obj_enemy_parent.spare_end_begin_turn = activate_the_turn;
	if !activate_the_turn { menu_state = -1; battle_state = -1;}
}

function end_battle()
{
	battle_state = 3;
	if !global.BossFight
	{
		battle_end_text = "You WON![delay,333]\n* You earned "+string(Total_Exp)+" XP and "+string(Total_Gold)+" gold.";
		battle_end_text_writer = scribble("* " + battle_end_text);
		if battle_end_text_writer.get_page() != 0 battle_end_text_writer.page(0);
		battle_end_text_typist = scribble_typist()
			.in(0.5, 0)
			.sound_per_char(snd_txtTyper, 1, 1," ^!.?,:/\\|*")
	}
	else
	{
		Fader_Fade(0, 1, 40, 0, c_black);
	}
}
