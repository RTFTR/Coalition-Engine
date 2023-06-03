#region // Menu lerping
if instance_exists(oOWPlayer)
{
	var CamPos = [camera_get_view_x(view_camera[0]),  camera_get_view_y(view_camera[0])],
		menu_at_top = oOWPlayer.y < CamPos[1] + camera_get_view_height(view_camera[0]) / 2 + 10;
}

menu_ui_x = lerp(menu_ui_x, menu ? 32 : -640, 0.16);

for (var i = 1; i <= 3; ++i)
{
	var item_state = (menu_state == MENU_MODE.ITEM) or (menu_state == MENU_MODE.ITEM_INTERACTING);
	
	if item_state
		menu_ui_y[MENU_MODE.ITEM] = lerp(menu_ui_y[MENU_MODE.ITEM], 52, 0.16);
	else if menu_state == i
		menu_ui_y[menu_state] = lerp(menu_ui_y[menu_state], 52, 0.16);
	else
		menu_ui_y[i] = lerp(menu_ui_y[i], -480, 0.16);
}
#endregion

#region // Input to navigate through menu 
var	menu_soul_target = [-606, 205 + (36 * menu_choice[MENU_MODE.IDLE])],
	menu_soul_alpha_target = 1;

if menu and global.interact_state == INTERACT_STATE.MENU // If menu is open
{
	// Input check, horizontal and vertical using vector method
	var input_horizontal = input_check_pressed("right") - input_check_pressed("left"),
		input_vertical =   input_check_pressed("down") - input_check_pressed("up"),
		input_confirm =    input_check_pressed("confirm"),
		input_cancel =     input_check_pressed("cancel"),
		input_menu =       input_check_pressed("menu");
	
	// Switching between ITEM - STAT - CELL and confirm input
	if menu_state == MENU_MODE.IDLE
	{
		var exist_check = 3;
		
		// Soul positioning and lerping
		var	menu_soul_target = [menu_ui_x + 34, 205 + (36 * menu_choice[MENU_MODE.IDLE])];
		
		if input_vertical != 0
		{
			menu_choice[MENU_MODE.IDLE] = posmod(menu_choice[MENU_MODE.IDLE] + input_vertical, exist_check);
			audio_play(snd_menu_switch);
		}
		if input_confirm
		{
			menu_state = menu_choice[0] + 1;
			audio_play(snd_menu_confirm);
			
			if menu_state == MENU_MODE.ITEM and global.item[0] == 0
			{
				menu_state = MENU_MODE.IDLE;
				audio_stop_sound(snd_menu_confirm);
			}
		}
		if input_menu // This closes the menu
		{
			menu = false;
			global.interact_state = INTERACT_STATE.IDLE;
			oOWPlayer.moveable = true;
			var i = 0;
			repeat(array_length(menu_choice) - 1)
			{
				menu_choice[i] = 0;
				++i;
			}
			audio_play(snd_menu_cancel);
		}
	}
	else if menu_state == MENU_MODE.ITEM or menu_state == MENU_MODE.ITEM_INTERACTING or menu_state == MENU_MODE.ITEM_DONE
	{
		if menu_state == MENU_MODE.ITEM
		{
			// Soul positioning and lerping
			var	menu_soul_target = [217, 97 + (32 * menu_choice[MENU_MODE.ITEM]) ],
				len = Item_Count();
		
			if input_vertical != 0 // Choosing item
			{
				menu_choice[MENU_MODE.ITEM] = posmod(menu_choice[MENU_MODE.ITEM] + input_vertical, len);
				audio_play(snd_menu_switch);
			}
			if input_confirm // Choosing what to do with the item
			{
				menu_state = MENU_MODE.ITEM_INTERACTING;
				audio_play(snd_menu_confirm);
			}
			if input_cancel // Go back to menu idle mode
			{
				menu_state = MENU_MODE.IDLE;
				menu_choice[MENU_MODE.ITEM] = 0; // Reset the choice
				audio_play(snd_menu_cancel);
			}
		}
		else if menu_state == MENU_MODE.ITEM_INTERACTING
		{
			var len = 3,
				gap = [217, 315, 429],
				menu_soul_target = [gap[menu_choice[MENU_MODE.ITEM_INTERACTING]] , 377];
			
			if input_horizontal != 0
			{
				menu_choice[MENU_MODE.ITEM_INTERACTING] = posmod(menu_choice[MENU_MODE.ITEM_INTERACTING] + input_horizontal, len);
				audio_play(snd_menu_switch);
			}
			if input_confirm
			{
				Item_Info_Load();
				if input_confirm
				{
					menu_state = MENU_MODE.ITEM_DONE;
					healing_text = "";
					if menu_choice[MENU_MODE.ITEM_INTERACTING] == 0 // USE
						Item_Use(global.item[menu_choice[MENU_MODE.ITEM]]);
					if menu_choice[MENU_MODE.ITEM_INTERACTING] == 2 // DROP
					{
						Item_Remove(menu_choice[MENU_MODE.ITEM]);
						audio_play(snd_menu_confirm);
					}
					
					var item_use_text = [healing_text, item_desc[menu_choice[MENU_MODE.ITEM]], item_throw_txt[menu_choice[MENU_MODE.ITEM]]];
					OW_Dialog(item_use_text[menu_choice[MENU_MODE.ITEM_INTERACTING]], "fnt_dt_mono", snd_txtTyper, !menu_at_top);
				}
			}
			if input_cancel
			{
				menu_state = MENU_MODE.ITEM;
				menu_choice[MENU_MODE.ITEM_INTERACTING] = 0;
			}
		}
		else if menu_state == MENU_MODE.ITEM_DONE
		{
			if !dialog_exists
			{
				menu_choice[MENU_MODE.ITEM_INTERACTING] = 0;
				menu_state = MENU_MODE.ITEM;
			}
		}
	}
	else if menu_state == MENU_MODE.STAT
	{	
		menu_soul_alpha_target = 0;
		menu_soul_target = [menu_ui_x + 34, 241]
		if input_cancel // Go back to menu idle mode
		{
			menu_state = MENU_MODE.IDLE;
			menu_choice[MENU_MODE.ITEM] = 0; // Reset the choice
			audio_play(snd_menu_cancel);
		}
	}
	else if menu_state == MENU_MODE.CELL or menu_state == MENU_MODE.CELL_DONE or menu_state == MENU_MODE.BOX_MODE
	{
		if menu_state == MENU_MODE.CELL
		{
			// Soul positioning and lerping
			var	menu_soul_target = [ 217, 97 + (32 * menu_choice[MENU_MODE.CELL]) ],
				len = Cell_Count();
			if input_vertical != 0 // Choosing option
			{
				menu_choice[MENU_MODE.CELL] = posmod(menu_choice[MENU_MODE.CELL] + input_vertical, len);
				audio_play(snd_menu_switch);
			}
			if input_confirm // Confirming the option in CELL state
			{
				if !Is_CellABox(menu_choice[MENU_MODE.CELL]) // If the option isn't a box
				{
					menu_state = MENU_MODE.CELL_DONE;
					var Text  = Cell_GetText(menu_choice[MENU_MODE.CELL]);
					OW_Dialog(Text, "fnt_dt_mono", snd_txtTyper, !menu_at_top);
					audio_play(snd_phone_call);
				}
				else // If it is a box
				{
					menu_state = MENU_MODE.BOX_MODE;
					box_mode = true;
					Box_ID = Cell_GetBoxID(menu_choice[MENU_MODE.CELL]);
					audio_play(snd_phone_box);
				}
			}
			if input_cancel // Go back to menu idle mode
			{
				menu_state = MENU_MODE.IDLE;
				menu_choice[MENU_MODE.CELL] = 0; // Reset the choice
				audio_play(snd_menu_cancel);
			}
		}
		else if menu_state == MENU_MODE.CELL_DONE
		{
			if !Is_CellABox(menu_choice[MENU_MODE.CELL]) // Check if the phone call dialog is still ongoing or not
			{
				var menu_soul_alpha_target = 0,
					menu_soul_target = [menu_ui_x + 34, 209];
				if !dialog_exists // Close the menu and reset all the states
				{
					menu_state = MENU_MODE.CELL;
					global.interact_state = INTERACT_STATE.MENU;
				}
			}
		}
		else if menu_state == MENU_MODE.BOX_MODE
		{
			if input_horizontal != 0 // Moving between 2 side during box mode
				box_state = (box_state == BOX_STATE.INVENTORY) ? BOX_STATE.BOX : BOX_STATE.INVENTORY;
			if input_vertical != 0
			{
				var len = [8, 10];
				box_choice[box_state] = posmod(box_choice[box_state] + input_vertical, len[box_state]); 
			}
			
			if input_cancel // When the box is no longer real
			{
				box_mode = false;
				box_choice = [0, 0]; // Reset box option
				menu_state = MENU_MODE.CELL;
				global.interact_state = INTERACT_STATE.MENU;
			}
		}
	}
}



menu_soul_pos[0] = lerp(menu_soul_pos[0], menu_soul_target[0], 0.16);
menu_soul_pos[1] = lerp(menu_soul_pos[1], menu_soul_target[1], 0.16);
menu_soul_alpha = lerp(menu_soul_alpha, menu_soul_alpha_target, 0.2);
#endregion




