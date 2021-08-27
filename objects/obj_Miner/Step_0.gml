/// @desc


if ((path == false) && (engaged == true) && (targetting != -1))
{
	if (array_length(target) == 0)
	{
		if (position = -1) position = image_index;
		var find = instance_number(targetting);
		var _curr_target;
		target_step = 0;
		for (var f = 0; f < find; f++)
		{
			_curr_target = instance_find(targetting, f);
			target[f][0] = _curr_target.x;
			target[f][1] = _curr_target.y;
		}
		target[array_length(target)] = [x, y];
		
	}
	path_coords = Path_To([target[target_step][0],target[target_step][1]],["wall"], 0);
	if (array_length(path_coords) != 0) path = true;


}


if (engaged)
{
	Mine_to_Path();
	if (target_step == -1) image_index = position;
	
}
