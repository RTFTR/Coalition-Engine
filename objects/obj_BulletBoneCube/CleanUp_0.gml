var i = 0;
repeat(array_length(edge_list))
{
	var _prop = edge_list[i],
		_bone = _prop[2];
	if instance_exists(_bone) instance_destroy();
	i++;
}
