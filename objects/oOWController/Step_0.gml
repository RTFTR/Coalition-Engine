if !audio_group_is_loaded(audgrpoverworld)
	audio_group_load(audgrpoverworld);
#region Culling
CullObject(oOWCollision);
ProcessCulls();
#endregion

#region Overworld Camera Lock
var target_x = oOWPlayer.x - camera_get_view_width(view_camera[0]) / 2,
	target_y = oOWPlayer.y - camera_get_view_height(view_camera[0]) / 2,
	half_rwidth = room_width / 2;
//Entire room clamping
target_x = clamp(target_x, half_rwidth - sprite_get_width(OverworldSprite) / 2, half_rwidth + sprite_get_width(other.OverworldSprite) / 2 - 320);
target_y = clamp(target_y, 0, sprite_get_height(OverworldSprite) - 240);
//Sub room clamping
target_x = clamp(target_x, CameraLockPositions[OverworldSubRoom][0], CameraLockPositions[OverworldSubRoom][2] - 320);
target_y = clamp(target_y, CameraLockPositions[OverworldSubRoom][1], CameraLockPositions[OverworldSubRoom][3] - 240);
//Relax, clamp does basically 0ms to it won't matter, it looks cleaner than min(xxx), max(xxx) inside one clamp
camera_set_view_pos(view_camera[0], target_x, target_y);
#endregion

#region Overworld room transition
if !OverworldTransitioning
{
	var i = 0;
	repeat array_length(RoomTransitionPositions[i])
	{
		if rectangle_in_rectangle(oOWPlayer.bbox_left, oOWPlayer.bbox_top, oOWPlayer.bbox_right, oOWPlayer.bbox_bottom, 
			RoomTransitionPositions[OverworldSubRoom][i][0], RoomTransitionPositions[OverworldSubRoom][i][1],
			RoomTransitionPositions[OverworldSubRoom][i][2], RoomTransitionPositions[OverworldSubRoom][i][3])
		{
			oOWPlayer.moveable = false;
			OverworldTransitioning = true;
			Fader_Fade(0, 1, OverworldTransitionSpeed, 0, c_black);
			Fader_Fade(1, 0, OverworldTransitionSpeed, OverworldTransitionSpeed, c_black);
			var _f = RoomTransitionPositions[OverworldSubRoom][i][4] == -1 ?
				function(i)
				{
					room_goto(RoomTransitionPositions[OverworldSubRoom][i][5]);
				}
				:
				function(i)
				{
					oOWPlayer.x = RoomTransitionPositions[OverworldSubRoom][i][5];
					oOWPlayer.y = RoomTransitionPositions[OverworldSubRoom][i][6];
					OverworldSubRoom = RoomTransitionPositions[OverworldSubRoom][i][4];
				};
			DoLater(OverworldTransitionSpeed, _f, i);
			DoLater(OverworldTransitionSpeed * 2, function() {
				OverworldTransitioning = false;
				oOWPlayer.moveable = true;
				});
			break
		}
	}
	++i;
}
#endregion

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
	var input_horizontal = PRESS_HORIZONTAL,
		input_vertical =   PRESS_VERTICAL,
		input_confirm =    input_check_pressed("confirm"),
		input_cancel =     input_check_pressed("cancel"),
		input_menu =       input_check_pressed("menu");
	
	// Switching between ITEM - STAT - CELL and confirm input
	if menu_state == MENU_MODE.IDLE
	{
		var exist_check = 3,
		
		// Soul positioning and lerping
			menu_soul_target = [menu_ui_x + 34, 205 + (36 * menu_choice[MENU_MODE.IDLE])];
		
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
		if input_menu or input_cancel // This closes the menu
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
					Item_Info_Load();
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
					menu_soul_target = [60, 70];
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
			var menu_soul_target = [60 + box_state * 300, 85 + box_choice[box_state] * 35];
			if input_horizontal != 0 // Moving between 2 side during box mode
			{
				box_state = (box_state == BOX_STATE.INVENTORY) ? BOX_STATE.BOX : BOX_STATE.INVENTORY;
				box_choice[box_state] = clamp(box_choice[!box_state], 0, box_state ? 10 : 8);
			}
			if input_vertical != 0
			{
				var len = box_state == BOX_STATE.INVENTORY ? 8 : 10;
				box_choice[box_state] = posmod(box_choice[box_state] + input_vertical, len); 
				audio_play(snd_menu_switch);
			}
			if input_confirm
			{
				if box_state == BOX_STATE.INVENTORY && box_choice[0] < Item_Count()
				{
					global.Box[Box_ID, Box_GetFirstEmptySlot(Box_ID)] = global.item[box_choice[0]];
					Item_Remove(box_choice[0]);
				}
				if box_state == BOX_STATE.BOX && box_choice[1] < 10 && global.Box[Box_ID, box_choice[1]] != 0 && Item_Count() < 8
				{
					Item_Add(global.Box[Box_ID, box_choice[1]]);
					global.Box[Box_ID, box_choice[1]] = 0;
					Box_Shift(Box_ID);
				}
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




