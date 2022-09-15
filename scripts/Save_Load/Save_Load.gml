function Save_Datas()
{
	if !file_exists("Data.dat")	ds_map_secure_save(global.SaveFile, "Data.dat");
}

function Load_Datas()
{
	if file_exists("Data.dat") global.SaveFile = ds_map_secure_load("Data.dat");
}
