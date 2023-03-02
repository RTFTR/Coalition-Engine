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
	global.TempFile[? name] = value;
}

///@desc Get tempoary data
///@param {string} name The name of the slot to be aquired
///@param value The value of the slot to be aquired
function GetTempData(name)
{
	return global.TempFile[? name];
}

///@desc Save the current settings of the game
function Save_Settings()
{
	show_debug_message("Settings Saved")
	ini_open("Settings.ini");
	ini_write_real("Settings", "Volume", global.Volume);
	ini_write_real("Settings", "CompMode", global.CompatibilityMode);
	
	var keytexts =
	[
		"Up", "Down", "Left", "Right",
		"Confirm", "Cancel", "Settings",
	]
	for(var i = 0, n = array_length(keytexts), ID = ""; i < n; i++)
	{
		if is_real(global.InputKeys[i])
		{
			ini_write_real("Input Keys", keytexts[i], global.InputKeys[i]);
			ID += "1";
		}
		else
		{
			ini_write_string("Input Keys", keytexts[i], global.InputKeys[i]);
			ID += "0";
		}
	}
	ini_write_real("Input Keys", "Input ID", ID);
	ini_write_real("Settings", "Inputs", global.CompatibilityMode);
	ini_write_real("Settings", "ShowFPS", global.ShowFPS);
	ini_close();
}

///@desc Load the current settings of the game
function Load_Settings()
{
	show_debug_message("Settings Loaded")
	ini_open("Settings.ini");
	global.Volume = ini_read_real("Settings", "Volume", 100);
	global.CompatibilityMode = ini_read_real("Settings", "CompMode", false);
	global.ShowFPS = ini_read_real("Settings", "ShowFPS", 100);
	var ID = ini_read_string("Input Keys", "Input ID", "");
	var keytexts =
	[
		"Up", "Down", "Left", "Right",
		"Confirm", "Cancel", "Settings",
	];
	global.InputKeys = [];
	for(var i = 0, n = array_length(keytexts); i < n; i++)
	{
		var FinInput;
		if string_char_at(ID, i + 1) == "1"
			FinInput = ini_read_real("Input Keys", keytexts[i], 0);
		else FinInput = ini_read_string("Input Keys", keytexts[i], "");
		array_push(global.InputKeys, FinInput);
	}
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