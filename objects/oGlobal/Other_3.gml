/// @description Uninitialization
surface_free(GradientSurf);
instance_destroy(oBulletParents);
global.Settings[? "Volume"] = global.Volume;
Save_Settings();
ds_map_destroy(global.SaveFile);
ds_map_destroy(global.Settings);
ds_map_destroy(global.TempData);

part_system_destroy(global.TrailS);
part_type_destroy(global.TrailP);

//UnloadFonts();

time_source_destroy(all);