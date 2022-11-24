for (var i = 0, n = array_length(edge_list); i < n; i++)
{
	var _prop = edge_list[i];
	var _bone = _prop[2];
	if instance_exists(_bone) instance_destroy();
}
