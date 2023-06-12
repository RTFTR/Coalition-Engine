///@desc Delete specific file based on the FILE enums
///@param {enum} enum The choosen file to be deleted
function delete_file(file)
{
	switch file
	{
		// Deletes the current data of the game
		case FILE.DATA:
			file_delete("Data.dat");
		break;
		
		// Deletes the current settings of the game
		case FILE.SETTINGS:
			file_delete("Settings.ini");
		break;
	}
}

///@desc Saves tempoary data
///@param {string} name The name of the slot to be saved
///@param value The value of the slot to be saved
function set_TempData(name, value)
{
	global.TempData[? name] = value;
}

///@desc Get tempoary data
///@param {string} name The name of the slot to be aquired
///@param value The value of the slot to be aquired
function get_TempData(name)
{
	return global.TempData[? name];
}

function save_file(file)
{
	switch file
	{
		#region Settings
		case FILE.SETTINGS: // Load the current settings of the game
			show_debug_message("Settings Saved");
			ini_open("Settings.ini");
			ini_write_real("Settings", "Volume", global.Volume);
			ini_write_real("Settings", "CompMode", global.CompatibilityMode);
	
			var keytexts =
			[
				"Up", "Down", "Left", "Right",
				"Confirm", "Cancel", "Settings",
			], i = 0, ID = "";
			repeat(array_length(keytexts))
			{
				if is_real(global.InputKeys[i])
				{
					ini_write_real("Input Keys", keytexts[i], global.InputKeys[i]);
					ID += "1";
				}
				else
				{
					if is_array(global.InputKeys[i])
						global.InputKeys[i] = global.InputKeys[i, 0];
					ini_write_string("Input Keys", keytexts[i], global.InputKeys[i]);
					ID += "0";
				}
				i++;
			}
			ini_write_real("Input Keys", "Input ID", ID);
			ini_write_real("Settings", "CompMode", global.CompatibilityMode);
			ini_write_real("Settings", "ShowFPS", global.ShowFPS);
			ini_close();
		break;
		#endregion
	}
}

function load_file(file)
{
	switch file
	{
		#region Settings
		case FILE.SETTINGS: // Save the current settings of the game
			show_debug_message("Settings Loaded");
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
			var FinInput, i = 0;
			repeat(array_length(keytexts))
			{
				if string_char_at(ID, i + 1) == "1"
					FinInput = ini_read_real("Input Keys", keytexts[i], 0);
				else FinInput = ini_read_string("Input Keys", keytexts[i], "");
				array_push(global.InputKeys, FinInput);
				i++;
			}
			ini_close();
		break;
		#endregion
	}
}

function RecordReplay()
{
	global.ReplayMode = "Record";
	instance_create_depth(0, 0, -1000, obj_Replayer);
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
	instance_destroy(obj_Replayer);
	instance_create_depth(0, 0, -1000, obj_Replayer);
}