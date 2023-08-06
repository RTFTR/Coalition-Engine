if destroyable
{
	var destroy = false
	
	if (destroydir == DIR.UP and y < 0)
	or (destroydir == DIR.DOWN and y > 480)
	or (destroydir == DIR.LEFT and x < 0)
	or (destroydir == DIR.RIGHT and y > 640)
		destroy = true;
	else if y < -length or y > (480 + length) or x < -length or x > (640 + length)
		destroy = true;
	
	if destroy
		instance_destroy();
}
if (Battle_State() == 0) instance_destroy();

