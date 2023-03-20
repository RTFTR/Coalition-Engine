
menu_state = 0;
battle_state = 0;
battle_turn = 0;
menu_button_choice = 0;
menu_choice = [0, 0, 0, 0] // Fight - Act - Item - Mercy
activate_turn = [1, 0, 0, 1];
activate_heal = [0, 0, 0, 0];
begin_at_turn = false;
last_choice = 0;

global.kr_activation = true;
global.kr = 0;
global.hp = global.hp_max;
max_kr = 40;

#region Fight Aiming Functions
Target = 
{
	Count			: global.bar_count,
	state			: 0,
	side			: choose(-1,1),
	time			: 0,
	xscale			: 1,
	yscale			: 1,
	frame			: 0,
	alpha			: 1,
	buffer			: 0,
	retract_method	: choose(0, 1),
	WaitTime		: -1,
}
Aim =
{
	scale	: 1,
	angle	: 0,
	color	: c_white,
	retract : choose(-1, 1),
}
#endregion
#region Menu Dialog Funtions
menu_text = "Just a basic test that's\n  long enough for a functional\n  typist test.[delay,3000][/page]* This is a test if the\n  page function is functional[delay,3000]![/page]* Another test if this is\n  functional and good to go!"
default_menu_text = menu_text;
menu_text_typist = scribble_typist()
	.in(0.5, 0)
	.sound_per_char(snd_txtTyper, 1, 1, " ^!.?,:/\\|*")

Battle_SetMenuDialog(menu_text);

#endregion
#region KR Functions
kr_timer = 0;
hp_previous = global.hp;
#endregion
#region Button Functions
button_spr			= [sprButtonFight, sprButtonAct, sprButtonItem, sprButtonMercy];
button_pos			= [[87, 453], [240, 453], [400, 453], [555, 453]];
button_alpha		= [0.25, 0.25, 0.25, 0.25];
button_scale		= [1, 1, 1, 1];
button_color		= [[242, 101, 34], [242, 101, 34], [242, 101, 34], [242, 101, 34]];
button_alpha_target = [0.25, 1];
button_scale_target = [1, 1.2];
button_color_target = [
					[[242, 101, 34], [255, 255, 0]],
					[[242, 101, 34], [255, 255, 0]],
					[[242, 101, 34], [255, 255, 0]],
					[[242, 101, 34], [255, 255, 0]]
					];
button_override_alpha = [1, 1, 1, 1];
button_background_cover = false;
#endregion
#region UI Functions
debug = false;
debug_alpha = 0;
ca = 0;
ui_x = 275;
ui_y = 400;
ui_alpha = 1;
//Name, LV, HP Icon, HP Bar, KR Text, HP Text
ui_override_alpha = [1, 1, 1, 1, 1, 1];
hp = global.hp;
hp_max = global.hp_max;
kr = global.kr;
refill_speed = 0.2;
hp_predict = 0;
board_cover_hp_bar = false;
board_cover_button = false;
board_full_cover = false;
item_scroll_type = ITEM_SCROLL.VERTICAL;
item_scroll_alpha = [.5, .5, .5];
item_lerp_y = 0;
item_desc_x = 420;
item_desc_alpha = 0;
#endregion
#region Flee
allow_run = true;
FleeText = [
	"I have better things to do.",
	"flee text 2"
]
FleeTextNum = irandom(array_length(FleeText) - 1);
FleeState = 0;
#endregion
#region Dialog Stuff
dialog_is_end = 0;
#endregion
#region Results
Result =
{
	Exp : 0,
	Gold : 0,
}
#endregion
#region Effects in battle
Effect = 
{
	SeaTea : false,
	SeaTeaTurns : 4,
};
#endregion
#region Debug
allow_debug = false;
allow_debug = 1;
#endregion

function dialog_start() {
	oEnemyParent.state = 1;
	battle_state = 1;
	Battle_SetSoulPos(320, 320, 0);
}
