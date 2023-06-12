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

// Items
enum ITEM
{
	PIE = 1,
	INOODLES = 2,
	STEAK = 3,
	SNOWP = 4,
	LHERO = 5,
	SEATEA = 6,
}

#macro ITEM_COUNT 6 // This value relies on the amount of enum ITEM above

// Item Scroll types
enum ITEM_SCROLL
{
	DEFAULT = 0,
	VERTICAL = 1,
	CIRCLE = 2,
	HORIZONTAL = 3,
}
// Overworld Room ID
enum OVERWORLD
{
	CORRIDOR = 0,
}

// Batle and Menu States
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
enum INTRO_MENU_STATE
{
	LOGO,
	SETTINGS,
	FIRST_TIME, // First time ever open the game
	NAMING,
	NAME_CHECKING,
	NAME_CONFIRM,
	NAME_CHOSEN, // Name changing locked after first time naming ever
	MENU,
}

enum FADE
{
	DEFAULT = 0,
	CIRCLE = 1,
	LINES = 2
}

enum FILE
{
	DATA,
	SETTINGS,
	SAVE,
}
