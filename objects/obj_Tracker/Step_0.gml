/// @desc
if ((path == false) && (engaged == true))
{
	path_coords = Path_To([target.x,target.y],["wall"], 0);
	if (array_length(path_coords) != 0) path = true;

}


if (engaged)
{
	if !(position_meeting(path[path_step][0],path[path_step][1], all))
	{
		Move_to_Path();
	}
	else
	{
		Mine_Path();
	}
	
	
}
