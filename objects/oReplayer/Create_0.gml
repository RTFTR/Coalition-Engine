CurrentFrame = 0;
Mode = global.ReplayMode;
if (Mode == "Record")
{
	Recorder = ds_map_create();
	Recorder[? "U"] = ds_list_create();
	Recorder[? "D"] = ds_list_create();
	Recorder[? "L"] = ds_list_create();
	Recorder[? "R"] = ds_list_create();
	Recorder[? "X"] = ds_list_create();
	Recorder[? "Z"] = ds_list_create();
	var RandomSeed = random_get_seed();
	Recorder[? "Seed"] = RandomSeed;
	Recorder[? "Encounter"] = global.battle_encounter;
}
else if (Mode == "Replay")
{
	Replayer = ds_map_secure_load("Replays/" + global.ReplayLoadFileName + ".json");
	global.battle_encounter = Replayer[? "Encounter"];
	room_goto(room_battle);
	random_set_seed(Replayer[? "Seed"]);
}