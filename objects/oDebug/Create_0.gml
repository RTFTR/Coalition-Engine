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
MainOption = {};
MainOption.Options =
[
	"Rooms",
	"Sounds",
	"Sprites",
];
MainOption.Surf = -1;
MainOption.DisplaceX = 0;
MainOption.DisplaceY = 0;
MainOption.DisplaceXTarget = 0;
MainOption.DisplaceYTarget = 0;
MainOption.Choice = -1;
MainOption.Lerp = 0;
var MainOptionMaxHeight = 440;
MainOption.TotalHeight = 70 * array_length(MainOption.Options);
MainOption.MaxY = -max(0, MainOption.TotalHeight - MainOptionMaxHeight);
SubOption = {};
SubOption.Surf = -1;

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
var file_name = file_find_first("Music/*.ogg", fa_none);
while file_name != ""
{
    array_push(AudioList, file_name);
    file_name = file_find_next();
}
file_find_close();
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
	SubOption.Options = Lists[listnum];
	SubOption.DisplaceX = 0;
	SubOption.DisplaceY = 0;
	SubOption.DisplaceXTarget = 0;
	SubOption.DisplaceYTarget = 0;
	SubOption.Choice = -1;
	SubOption.Lerp = 0;
	var SubOptionMaxHeight = 440;
	SubOption.TotalHeight = 70 * array_length(SubOption.Options);
	SubOption.MaxY = -max(0, SubOption.TotalHeight - SubOptionMaxHeight);
	SubOption.DrawSprite = -1;
	SubOption.Stream = -1;
	SubOption.Audio = -1;
	SubOption.AudioLength = -1;
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
			if string_ends_with(AudioList[index], ".ogg")
			{
				SubOption.Stream = audio_create_stream("Music/" + string(AudioList[index]));
				SubOption.Audio = audio_play(SubOption.Stream);
			}
			else SubOption.Audio =  audio_play(asset_get_index(AudioList[index]));
			SubOption.AudioLength = audio_sound_length(SubOption.Audio);
			SubOption.AudioLengthMin = string(SubOption.AudioLength div 60);
			SubOption.AudioLengthSec = string(round(SubOption.AudioLength mod 60));
			if SubOption.AudioLengthSec < 10 SubOption.AudioLengthSec = "0" + SubOption.AudioLengthSec;
		break
		case DEBUG_STATE.SPRITES:
			MainOption.DisplaceXTarget = -260;
			SubOption.DisplaceXTarget = -250;
			SubOption.DrawSprite = asset_get_index(SpriteList[index]);
		break
		
	}
}

var t = CreateTextWriter(320, 240, "[c_white][fnt_dt_sans][scale,3][sprFriskCell][scale,1]blabla[snd_item_heal]\nlba");
t[0].in(0.5, 0)
t[0].sound_per_char(snd_txtTyper, 1, 1, " ^!.?,:/\\|*")