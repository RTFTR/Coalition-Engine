texturegroup_load("texoverworld");
Fader_Fade(1, 0, 15);
OverWorld_ID = OVERWORLD.CORRIDOR; // The Overworld ID (For room changing and stuff)

enum INTERACT_STATE
{
	IDLE,
	MENU,
}
global.interact_state = INTERACT_STATE.IDLE;

#region // Dialog properties 
dialog_exists = false;
dialog_option = false;
#endregion

#region // Menu properties
enum MENU_MODE
{
	IDLE,
	ITEM,
	STAT,
	CELL,
	ITEM_INTERACTING,
	ITEM_DONE,
	CELL_DONE,
	BOX_MODE,
}

menu_disable = 0;

menu = false;
menu_state = MENU_MODE.IDLE;
menu_choice = array_create(8, 0); // Works respectively based on enum MENU_MODE
menu_buffer = 2;

menu_ui_x = -640;
menu_ui_y = array_create(4, -480);

menu_soul_pos = [-606, 211];
menu_soul_alpha = 1;
#endregion

#region // Box properties
enum BOX_STATE
{
	INVENTORY,
	BOX,
}
box_mode = false;
box_state = BOX_STATE.INVENTORY;
box_choice = [0, 0];
Box_ID = 0;
#endregion

Saving = false;
is_saving = false;
Saved = 0;
Choice = 0;
WaitTime = 0;

#region // Debug properties
debug = false;
debug_alpha = 0;
#endregion