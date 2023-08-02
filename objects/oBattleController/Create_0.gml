texturegroup_load("texbattle");
Fader_Fade(1, 0, 20);
menu_state = 0;
battle_state = 0;
battle_turn = 0;
menu_button_choice = 0;
menu_choice = array_create(4, 0); // Fight - Act - Item - Mercy
activate_turn = [1, 0, 0, 1];
activate_heal = [0, 0, 0, 0];
begin_at_turn = false;
last_choice = 0;

global.kr_activation = true;
global.hp = global.hp_max;
max_kr = 40;

#region Fight Aiming Functions
Target = 
{
	Count			: global.bar_count,
	state			: 0,
	side			: [choose(1, -1)],
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
function ResetFightAim()
{
	var __f = function()
	{
		var _f = function() {
			return choose(1, -1);
		}
		return array_create_ext(Target.Count, _f);
	}
	Target.buffer = 3;
	Target.state = 1;
	Target.side = __f();
	Target.xscale = 1;
	Target.yscale = 1;
	Target.frame = 0;
	Target.alpha = 1;
	Target.retract_method = choose(0, 1);
	Aim.scale = array_create(Target.Count, 1);
	Aim.angle = 0;
	Aim.color = array_create(Target.Count, c_white);
	Aim.retract = choose(-1, 1);
	var interval = irandom_range(60, 120), hspd = 4 + random(3);
	for (var i = 0; i < Target.Count; ++i) {
		Target.time[i] = 0;
		Aim.InitialX[i] = 320 + (Target.side[i] * (290 + interval));
		Aim.Alpha[i] = 1;
		Aim.HasBeenPressed[i] = false;
		Aim.Sprite[i] = sprTargetAim;
		Aim.Fade[i] = false;
		Aim.Hspeed[i] = hspd;
		Aim.ForceCenter[i] = false;
		Aim.Expand[i] = false;
		Aim.Time[i] = 0;
		Aim.Faded[i] = 0;
		
		interval += irandom_range(60, 120);
	}
	if Target.Count > 1
	{
		Aim.HitCount = 0;
		Aim.Miss = 0;
		Aim.Attack = {};
		Aim.Attack.CritAmount = 0;
		Aim.Attack.Crit = false;
		Aim.Attack.Color = c_white;
		Aim.Attack.EnemyY = enemy_instance[menu_choice[0]].y - 50;
		Aim.Attack.Sprite = -1;
		Aim.Attack.Index = 0;
		Aim.Attack.Angle = 0;
		Aim.Attack.Alpha = 1;
		//star angle, alpha, angle change, distance, speed, friction
		Aim.Attack.StarData = array_create(8, [0, 1, 12.25, 0, 8, 0.34]);
		Aim.Attack.Time = 0;
		Aim.Attack.Distance = 0;
	}
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
button_alpha		= array_create(4, 0.25);
button_scale		= array_create(4, 1);
button_color		= array_create(4, [242, 101, 34]); //rgb
button_angle		= array_create(4, 0);
button_alpha_target = [0.25, 1];
button_scale_target = [1, 1.2];
button_color_target = array_create(4, [[242, 101, 34], [255, 255, 0]]);
button_override_alpha = array_create(4, 1);
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
ui_override_alpha = array_create(6, 1);
hp = global.hp;
hp_max = global.hp_max;
kr = global.kr;
refill_speed = 0.2;
hp_predict = 0;
board_cover_hp_bar = false;
board_cover_button = false;
board_full_cover = false;
item_scroll_type = ITEM_SCROLL.VERTICAL;
item_scroll_alpha = array_create(3, 0.5);

item_lerp_y = array_create(8, 0);
item_lerp_x = array_create(8, 0);
item_space = Item_Space();

for (var i = 0; i < 8; ++i)
{
	item_lerp_color[i] = c_dkgray; 
}

item_lerp_x_target = 0;
item_lerp_y_target = 0;
item_lerp_color_target_values =  [ [16,16,16] , [128,128,128] , [255,255,255] ]; // c_gray - c_white
item_lerp_color_amount = array_create(8, 16 / 255);
item_lerp_color_amount_target = array_create(8, 16 / 255);
item_desc_x = 360;
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

function dialog_start() {
	oEnemyParent.state = 1;
	battle_state = 1;
	Battle_SetSoulPos(320, 320, 0);
}


