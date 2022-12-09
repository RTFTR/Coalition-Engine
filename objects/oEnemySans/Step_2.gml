var undo = keyboard_check(vk_backspace);
if undo and undoIndex > 0{
	undoIndex--;
	with oSoul
	{
		x = other.undoArray[undoIndex].x;
		y = other.undoArray[undoIndex].y;
	}
}
else {
	undoIndex++;
	undoArray[undoIndex] = new UndoConst(oSoul.x, oSoul.y)
}