/// @desc


if ((path == false) && (engaged == true))
{
	path_coords = Path_To([target[target_step].x,target[target_step].y],["wall"], 0);
	if (array_length(path_coords) != 0) path = true;

}


if (engaged)
{
	Mine_to_Path();
	
	
}
