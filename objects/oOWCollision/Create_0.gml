depth = oOWPlayer.depth + 10;
Event = -1;
Collided = false;
function CheckConfirm() {
	return oOWController.menu_state == INTERACT_STATE.IDLE and PRESS_CONFIRM;
}
function CheckCollide() {
	return place_meeting(x, y, oOWPlayer);
}