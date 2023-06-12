if (Mode == "Record")
{
	ds_list_add(Recorder[? "U"], input_check("up"));
	ds_list_add(Recorder[? "D"], input_check("down"));
	ds_list_add(Recorder[? "L"], input_check("left"));
	ds_list_add(Recorder[? "R"], input_check("right"));
	ds_list_add(Recorder[? "X"], input_check("cancel"));
	ds_list_add(Recorder[? "Z"], input_check("confirm"));
}
else if (Mode == "Replay" && room == room_battle)
{
	if Replayer[? "U"][| CurrentFrame] keyboard_key_press(vk_up);
	else keyboard_key_release(vk_up);
	if Replayer[? "D"][| CurrentFrame] keyboard_key_press(vk_down);
	else keyboard_key_release(vk_down);
	if Replayer[? "L"][| CurrentFrame] keyboard_key_press(vk_left);
	else keyboard_key_release(vk_left);
	if Replayer[? "R"][| CurrentFrame] keyboard_key_press(vk_right);
	else keyboard_key_release(vk_right);
	if Replayer[? "X"][| CurrentFrame] keyboard_key_press(ord("X"));
	else keyboard_key_release(ord("X"));
	if Replayer[? "Z"][| CurrentFrame] keyboard_key_press(ord("Z"));
	else keyboard_key_release(ord("Z"));
	CurrentFrame++;
}
