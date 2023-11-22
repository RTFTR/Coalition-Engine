/*
	Note that the current save system is a tempoary function towards the public
	and will be a subject to change because nobody wants their game to have a
	save file that can be easily hacked right?
*/


///@desc Deletes the current data of the game
function Delete_Datas()
{
	file_delete("Data.dat");
}

///@desc Saves tempoary data
///@param {string} name The name of the slot to be saved
///@param value The value of the slot to be saved
function SetTempData(name, value)
{
	global.TempData[? name] = value;
}

///@desc Get tempoary data
///@param {string} name The name of the slot to be aquired
///@param value The value of the slot to be aquired
function GetTempData(name)
{
	return global.TempData[? name];
}

///@desc Save the current settings of the game
function Save_Settings()
{
	show_debug_message("Settings Saved");
	ini_open("Settings.ini");
	ini_write_real("Settings", "Volume", global.Volume);
	ini_write_real("Settings", "CompMode", global.CompatibilityMode);
	ini_write_real("Settings", "ShowFPS", global.ShowFPS);
	ini_close();
}

///@desc Load the current settings of the game
function Load_Settings()
{
	show_debug_message("Settings Loaded");
	ini_open("Settings.ini");
	global.Volume = ini_read_real("Settings", "Volume", 100);
	global.CompatibilityMode = ini_read_real("Settings", "CompMode", false);
	global.ShowFPS = ini_read_real("Settings", "ShowFPS", 100);
	ini_close();
}

///@desc Deletes the current settings of the game
function Delete_Settings()
{
	file_delete("Settings.ini");
}


function RecordReplay()
{
	global.ReplayMode = "Record";
	instance_create_depth(0, 0, -1000, oReplayer);
}

function SaveReplay(FileName)
{
	global.ReplaySaveFileName = string(FileName);
}

function PlayReplay(FileName)
{
	global.ReplayMode = "Replay";
	var Name = FileName, i;
	Name = string_replace(Name, ".json", "");
	i = string_last_pos("\\", Name) + 1;
	Name = string_copy(Name, i, string_length(Name) + 1 - i);
	global.ReplayLoadFileName = Name;
	instance_destroy(oReplayer);
	instance_create_depth(0, 0, -1000, oReplayer);
}

