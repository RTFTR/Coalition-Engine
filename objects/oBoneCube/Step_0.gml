//Modified Siki's bone cube codes
for(var  i = 0; i < 3; ++i)
	angles[i] += angleAdd[i];
update_vert();
for (var i = 0, n = array_length(edge_list), out_cnt = 0; i < n; i++)
{
	var _prop = edge_list[i],
		x1 = vert_list_draw[_prop[0]][0],
		y1 = vert_list_draw[_prop[0]][1],
		z1 = vert_list_draw[_prop[0]][2],
		x2 = vert_list_draw[_prop[1]][0],
		y2 = vert_list_draw[_prop[1]][1],
		z2 = vert_list_draw[_prop[1]][2];
	var _bone = _prop[2];
	if instance_exists(_bone)
	{
		var len3 = point_distance_3d(x1, y1, z1, x2, y2, z2);
		_bone.x = x + (x1 + x2) / 2;
		_bone.y = y + (y1 + y2) / 2;
		_bone.length = point_distance(x1, y1, x2, y2) - len3 / (abs(z1 - z2) / 50 + 5);
		_bone.image_angle = point_direction(x1, y1, x2, y2);
		_bone.type = type;
		if (_bone.x > 640 + _bone.length and hspeed > 0)
		or (_bone.x < 0 - _bone.length and hspeed < 0)
		or (_bone.y > 480 + _bone.length and vspeed > 0)
		or (_bone.y < 0 - _bone.length and vspeed < 0)
			out_cnt++;
		if out_cnt == 12 instance_destroy();
	}
}

if Battle_GetState() == 0 instance_destroy();