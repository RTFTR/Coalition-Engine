#macro ENGINE_VERSION "Beta v4.7.3"

enum FONTS {
	GAMEOVER,
	DAMAGE,
	COT,
	DTMONO,
	DTSANS,
	LOGO,
	MNC,
	SANS,
	UI,
}
function LoadFonts() {
	static loaded = false;
	if !loaded
	{
		global.__CoalitionFonts = [
			font_add("Fonts/8-BIT WONDER.TTF", 36, false, false, 32, 128),
			font_add("Fonts/Hachicro.ttf", 30, false, false, 32, 128),
			font_add("Fonts/crypt of tomorrow.ttf", 9, false, false, 32, 128),
			font_add("Fonts/Determination Mono.otf", 20, false, false, 32, 128),
			font_add("Fonts/Determination Sans.otf", 20, false, false, 32, 128),
			font_add("Fonts/Monster Friend Fore.otf", 36, false, false, 32, 128),
			font_add("Fonts/Mars Needs Cunnilingus.ttf", 18, false, false, 32, 128),
			font_add("Fonts/Comic Sans UT.ttf", 12, false, false, 32, 128),
			font_add("Fonts/UT Hp Font.ttf", 7.5, false, false, 32, 128),
		];
		//#macro fnt_8bitwonder global.__CoalitionFonts[0]
		//font_enable_sdf(fnt_8bitwonder, true);
		//#macro fnt_dmg global.__CoalitionFonts[1]
		//font_enable_sdf(fnt_dmg, true);
		//#macro fnt_cot global.__CoalitionFonts[2]
		//font_enable_sdf(fnt_cot, true);
		//#macro fnt_dt_mono global.__CoalitionFonts[3]
		//font_enable_sdf(fnt_dt_mono, true);
		//#macro fnt_dt_sans global.__CoalitionFonts[4]
		//font_enable_sdf(fnt_dt_sans, true);
		//#macro fnt_logo global.__CoalitionFonts[5]
		//font_enable_sdf(fnt_logo, true);
		//#macro fnt_mnc global.__CoalitionFonts[6]
		//font_enable_sdf(fnt_mnc, true);
		//#macro fnt_sans global.__CoalitionFonts[7]
		//font_enable_sdf(fnt_sans, true);
		//#macro fnt_uicon global.__CoalitionFonts[8]
		//font_enable_sdf(fnt_uicon, true);
		loaded = true;
	}
}

function UnloadFonts() {
	var i = 0;
	repeat array_length(global.__CoalitionFonts)
	{
		if font_exists(global.__CoalitionFonts[i])
			font_delete(global.__CoalitionFonts[i]);
		++i;
	}
}

//Input
enum INPUT
{
	UP,
	DOWN,
	LEFT,
	RIGHT,
	CONFIRM,
	CANCEL,
	MENU
};
enum INPUT_TYPE
{
	CHECK,
	PRESS,
	RELEASE,
};

//Soul
enum SOUL_MODE
{
	RED = 1,
	BLUE = 2,
	ORANGE = 3,
	YELLOW = 4,
	GREEN = 5,
	PURPLE = 6,
	CYAN = 7,
	FREEBLUE = 8,
}

//Direction
enum DIR
{
	UP = 90,
	DOWN = 270,
	LEFT = 180,
	RIGHT = 0,
}

//Optional, just for better coding experience for idiots like me (Eden)
//Items
enum ITEM
{
	PIE = 1,
	INOODLES = 2,
	STEAK = 3,
	SNOWP = 4,
	LHERO = 5,
	SEATEA = 6,
}
//Change this value when more items are added
#macro ITEM_COUNT 6
//Item Scroll types
enum ITEM_SCROLL
{
	DEFAULT = 0,
	VERTICAL = 1,
	CIRCLE = 2,
	HORIZONTAL = 3,
}
//Overworld Room ID
enum OVERWORLD
{
	CORRIDOR = 0,
}

// Batle or Menu States
enum BATTLE_STATE
{
	MENU = 0,
	DIALOG = 1,
	IN_TURN = 2,
	RESULT = 3
}
enum MENU_STATE
{
	BUTTON_SELECTION = 0,
	FIGHT = 1,
	ACT = 2,
	ITEM = 3,
	MERCY = 4,
	FIGHT_AIM = 5,
	ACT_SELECT = 6,
	MERCY_END = 7,
	FLEE = 8
}

enum FADE
{
	DEFAULT = 0,
	CIRCLE = 1,
	LINES = 2
}