audio_stop_all();
enum DEBUG_STATE
{
	MAIN = 0,
	ROOMS = 1,
	SOUNDS = 2,
	SPRITES = 3,
}
State = 0;

//List of main options
MainOptions =
[
	"Rooms",
	"Sounds",
	"Sprites",
];
MainOptionSurf = -1;
MainOptionDisplaceX = 0;
MainOptionDisplaceY = 0;
MainOptionDisplaceXTarget = 0;
MainOptionDisplaceYTarget = 0;
MainOptionChoice = -1;
MainOptionLerp = 0;
var MainOptionMaxHeight = 440;
MainOptionTotalHeight = 70 * array_length(MainOptions);
MainOptionMaxY = -max(0, MainOptionTotalHeight - MainOptionMaxHeight);
SubOptionSurf = -1;

//Load rooms
RoomList = [room_get_name(room_first)];
var Rooms = room_first;
while room_next(Rooms) != -1
{
	Rooms = room_next(Rooms);
	array_push(RoomList, room_get_name(Rooms));
}
//Load sounds
audio_group_load(audgrpoverworld);
audio_group_load(audgrpbattle);
AudioList = [];
var i = 0;
while audio_exists(i)
{
	array_push(AudioList, audio_get_name(i));
	++i;
}
array_sort(AudioList, true);
//Load sprites
SpriteList = [];
i = 0;
while sprite_exists(i)
{
	array_push(SpriteList, sprite_get_name(i));
	++i;
}
array_sort(SpriteList, true);

function LoadSubOptions(listnum)
{
	var Lists =
		[
			RoomList,
			AudioList,
			SpriteList,
		];
	
	//Sub-options
	SubOptions = Lists[listnum];
	SubOptionDisplaceX = 0;
	SubOptionDisplaceY = 0;
	SubOptionDisplaceXTarget = 0;
	SubOptionDisplaceYTarget = 0;
	SubOptionChoice = -1;
	SubOptionLerp = 0;
	var SubOptionMaxHeight = 440;
	SubOptionTotalHeight = 70 * array_length(SubOptions);
	SubOptionMaxY = -max(0, SubOptionTotalHeight - SubOptionMaxHeight);
	SubOptionDrawSprite = -1;
}

function SubOptionAction(index)
{
	switch State
	{
		case DEBUG_STATE.ROOMS:
			room_goto(asset_get_index(RoomList[index]));
		break
		case DEBUG_STATE.SOUNDS:
			audio_stop_all();
			audio_play(asset_get_index(AudioList[index]));
		break
		case DEBUG_STATE.SPRITES:
			MainOptionDisplaceXTarget = -260;
			SubOptionDisplaceXTarget = -250;
			SubOptionDrawSprite = asset_get_index(SpriteList[index]);
		break
		
	}
}