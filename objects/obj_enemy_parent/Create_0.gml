//Data
enemy_name = "";
enemy_act = ["","","","",""];
enemy_act_text = ["","","","",""];
enemy_hp_max = 100;
enemy_hp = 100;
_enemy_hp = 100;
enemy_draw_hp_bar = 1;
enemy_defense = 1;
enemy_in_battle = true;

//Temp var
enemy_total_height = 100;

//Dialogs
is_dialog = 0;
dialog_size = [20, 65, 0, 190]; // UDLR
dialog_size[3] = 80;
dialog_dir = DIR.LEFT;
function dialog_init()
{
	dialog = "[c_black][/f][font_sans]";
	dialog += "ashivbudk wfbl;kjfzsh jfdbf kkasjbd.[delay,1000][shake]idk shake[/shake]";
	text_writer = scribble(dialog)
		.wrap(dialog_size[2]+dialog_size[3]-10, dialog_size[0]+dialog_size[1]-10)
	if text_writer.get_page() != 0 text_writer.page(0);
}
dialog_init();
dialog_text_typist = scribble_typist()
	.in(0.5, 0)
	.sound_per_char(snd_text_voice_sans, 1, 1," ^!.?,:/\\|*")

//Under Attack
is_being_attacked = false;
is_dodge = false;
dodge_to = choose(-150, 150);
attack_time = 0;
attack_end_time = 60;
draw_damage = false;
damage_y = y - enemy_total_height - 20;
damage = 49;
damage_color = c_red;
bar_width = 120;
bar_retract_speed = 0.6;

//Death
death_time = 0;
is_dying = false;
died = false;

//Spare
enemy_is_spareable = true;
is_being_spared = false;
spare_end_begin_turn = false;
is_spared = false;

//Functions
function Enemy_SetStats(max_hp, current_hp = max_hp, draw_hp_bar = 1)
{
	enemy_hp_max = max_hp;
	enemy_hp = current_hp;
	_enemy_hp = enemy_hp;
	enemy_draw_hp_bar = draw_hp_bar;
}
function Enemy_SetDamage(damage){ damage = damage;}

function Enemy_SetSpareable(spareable){ enemy_is_spareable = spareable;}

