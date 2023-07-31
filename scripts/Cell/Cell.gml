///@desc Gets the amount of phone numbers you have
///@desc return {real}
function Cell_Count() {
	for (var i = 0, cnt = 0; i < 8; i++)
		if global.cell[i] != 0 cnt++;
	return cnt;
}

///@desc Gets the name of the Cell Slot
///@param {real} slot The slot to get the name of
///@return {string}
function Cell_GetName(slot) {
	var name = ["", "Phone", "Dimensional Box A"];
	return name[global.cell[slot - 1]];
}

///@desc Gets the dialog of the Cell Slot
///@param {real} slot The slot to get the dialog of
///@return {string}
function Cell_GetText(slot) {
	var text = ["", "Test Phone text 1", ""];
	return text[global.cell[slot]];
}

///@desc Check if a Cell slot is a Dimensional box
///@param {real} slot The slot to get the data of
///@return {real}
function Is_CellABox(slot) {
	var is_box = [0, 0, 1];
	return is_box[global.cell[slot]];
}

///@desc Check the Box ID of the Cell if it's a D.Box
///@param {real} slot The slot to get the data of
///@return {real}
function Cell_GetBoxID(slot) {
	var NameToID = ["Dimensional Box A"],
		ID = [1, 2],
		i = 0, Name = Cell_GetText(slot), target = 0;
	repeat(array_length(NameToID))
	{
		if Name == NameToID[i] {
			target = 1;
			continue
		}
		i++;
	}
	return (Is_CellABox(slot) ? ID[target] : 0);
}
