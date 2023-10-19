global.sur_list[| TEMPID][0].Free();
global.sur_list[| TEMPID + 1][0].Free();
ds_list_delete(global.sur_list, TEMPID + 1);
ds_list_delete(global.sur_list, TEMPID);