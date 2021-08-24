/// @desc
if ((path == false) && (engaged == true))
{
	path_coords = Path_To([target.x,target.y],["wall"], 0);
	if (array_length(path_coords) != 0) path = true;

}


if (engaged)
{
	if ((path_coords[path_step][0] == x) && (path_coords[path_step][1] == y)) path_step++;
	if (path) && (path_step< array_length(path_coords))
	{
		if (path_coords[path_step][0] > x)
		{x+=spd; image_index = 0}
		if (path_coords[path_step][0] < x)
		{x-=spd; image_index = 2;}
		if (path_coords[path_step][1] > y)
		{y+=spd; image_index = 3;}
		if (path_coords[path_step][1] < y)
		{y-=spd; image_index = 1;}

	}
	else
	{
		engaged = false;
		path = false;
		path_coords = [];
		path_step = 0;
	}
				
	
	
	
}
