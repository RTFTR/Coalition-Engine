///@desc Gets the first empty slot of a box
///@param {real} Box_ID The Box ID to check (0 - Overword, 1 - D.Box A, 2 - D.Box B)
function Box_GetFirstEmptySlot(Box_ID) {
	var num = 0;
	for (var i = 0; i < 10; ++i)
		if global.Box[Box_ID, i] num = i + 1;
	return num;
}

///@desc Loads the Info of the Items of the Box
function Box_Info_Load() {
	for (var i = 0, n = Box_Count(Box_ID); i < n; ++i) {
		Box_Info(global.Box[Box_ID, i]);
		box_name[i] = name;
	}
}

///@desc Gets the Infos of the Item in the Box
///@param {real} Item The Item to get the info
function Box_Info(item) {
	name = "";

	switch item {
		case 1:
			name = "Pie";
		break;
		case 2:
			name = "I. Noodles";
		break;
		case 3:
			name = "Steak";
		break;
		case 4:
			name = "SnowPiece";
		break;
		case 5:
			name = "L. Hero";
		break;
	}
	if global.item_uses_left[item] > 1 name += " x" + string(global.item_uses_left[item])
}

///@desc Gets the number of items in the Box
///@param ID The ID of the Box
function Box_Count(ID) {
	var num = 0;
	for (var i = 0; i < 10; ++i)
		if global.Box[ID, i] num++;
	return num;
}
