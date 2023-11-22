global.sur_list[| TEMPID + 1][0].Free();
ds_list_delete(global.sur_list, TEMPID + 1);
global.sur_list[| TEMPID][0].Free();
ds_list_delete(global.sur_list, TEMPID);
with oCutScreen TEMPID -= 2;