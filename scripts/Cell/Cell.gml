///@desc Gets the amount of phone numbers you have
function Cell_Count() {
	var cnt = 0;
	for (var i = 0; i < 8; i++)
		if global.cell[i] != 0 cnt++;
	return cnt;
}

///@desc Gets the name of the Cell Slot
///@param {real} slot The slot to get the name of
function Cell_GetName(slot) {
	var name = ["", "Phone", "Dimensional Box A"];
	return name[global.cell[slot - 1]];
}

///@desc Gets the dialog of the Cell Slot
///@param {real} slot The slot to get the dialog of
function Cell_GetText(slot) {
	var text = ["", "Test Phone text 1", ""];
	return text[global.cell[slot]];
}

///@desc Check if a Cell slot is a Dimensional box
///@param {real} slot The slot to get the data of
function Is_CellABox(slot) {
	var is_box = [0, 0, 1];
	return is_box[global.cell[slot]];
}

///@desc Check the BOx ID of the Cell if it's a D.Box
///@param {real} slot The slot to get the data of
function Cell_GetBoxID(slot) {
	var Name = Cell_GetText(slot);
	var Name_To_ID = ["Dimensional Box A"];
	var ID = [1, 2];
	var target = 0;
	for (var i = 0, n = array_length(Name_To_ID); i < n; ++i)
		if Name == Name_To_ID[i] {
		target = 1;
		continue
	}
	return (Is_CellABox(slot) ? ID[target] : 0);
}
