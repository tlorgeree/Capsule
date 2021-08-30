/// @desc
if ((path == false) && (engaged == true))
{
	if (targetting != -1)
	{
		if (array_length(target) == 0)
		{
			if (position = -1) position = image_index;
			target_step = 0;
			target = Multi_Target_To(targetting);
		}
	}
	path_coords = Path_To([target[target_step][0],target[target_step][1]],["wall"], 0);
	if (path_coords == -4) 
	{
		show_debug_message("No valid path was found");
		engaged = false;
		targetting = -1;
		target = [];
		target_step = -1;
		path_coords = [];
		path = false;
	}
	if (array_length(path_coords) != 0) path = true;


}

if (engaged)
{
	Mine_to_Path();
	if (target_step == -1) image_index = position;
	
}
