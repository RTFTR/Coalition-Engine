///@desc Battle Instances
MainBoard = instance_create_depth(320, 320, -1, oBoard);
MainSoul = instance_create_depth(48, 454, -1, oSoul);
Enemy_Function_Load(global.battle_encounter);
global.debug = false;
