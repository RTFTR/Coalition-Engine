if draw_papyrus
draw_sprite(spr_pap,0,papyrus_x,y);
event_inherited();
if time > 16760
{
	if x < -200 x += 1040
	if x > 940 x -= 1040
	if y < -200 y += 780
	if y > 680 y -= 780
}