/// @description Uninitialization
instance_destroy(obj_ParentBullet);
global.Settings[? "Volume"] = global.Volume;
save_file(FILE.SETTINGS);
ds_map_destroy(global.SaveFile);
ds_map_destroy(global.Settings);
ds_map_destroy(global.TempData);

part_system_destroy(global.TrailS);
part_type_destroy(global.TrailP);

