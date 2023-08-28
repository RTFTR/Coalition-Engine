//This is very stupid, but this is one of the only ways to not spam rooms
///@desc Loads all the positions for the camera to lock for the sub rooms in overworld
function LoadCameraLockPositions()
{
	/*
		You have to manually add every position for now
		because i cant think of a way for using a single instance
		as a camera scroll lock
		
		Switch case is used to prevent unneeded data to be loaded in
		
		Each entry of the array corresponds to the respective id
		in the OverworldSubRoom
	*/
	CameraLockPositions = [];
	switch room
	{
		case rUTDemo:
			array_push(CameraLockPositions, [1200, 1042, 1520, 1505]);
			array_push(CameraLockPositions, [1200, 802, 1520, 1041]);
		break
		default:
			array_push(CameraLockPositions, [0, 0, room_width, room_height]);
		break
	}
}

///@desc Sets all positions for the room transitions to take place
function SetRoomTransitionPositions()
{
	/*
		Format: rect x1 y1 x2 y2, then insert the sub room id, if it's
		a room change, insert -1 and the room name after it,
		after the target rooms, put the player spawn position
		
		Note that you need to manually add the room transition position
		to return to the previous room as well
	*/
	RoomTransitionPositions = [];
	switch room
	{
		case rUTDemo:
			array_push(RoomTransitionPositions, [[1348, 1138, 1370, 1141, 1, 1360, 1020]]);
			array_push(RoomTransitionPositions, [[13480, 1138, 13700, 1141, 1]]);
		break
		default:
			array_push(RoomTransitionPositions, [[0, 0, 0, 0, 0, 0, 0]]);
		break
	}
}

///Sets the names of the rooms (and sub-rooms)
function SetRoomNames()
{
	RoomNames = [];
	switch room
	{
		case rUTDemo:
			array_push(RoomNames, "Ruins Entrance")
		break
		default:
			array_push(RoomNames, room_get_name(room));
		break
	}
}