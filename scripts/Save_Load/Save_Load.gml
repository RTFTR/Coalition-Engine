///@desc Save the current data of the game
function Save_Datas()
{
	if !file_exists("Data.dat")	ds_map_secure_save(global.SaveFile, "Data.dat");
}

///@desc Load the current data of the game
function Load_Datas()
{
	if file_exists("Data.dat") global.SaveFile = ds_map_secure_load("Data.dat");
}

///@desc Deletes the current data of the game
function Delete_Datas()
{
	file_delete("Data.dat");
}
