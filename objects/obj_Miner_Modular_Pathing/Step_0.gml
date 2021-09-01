/// @desc
if ((path == false) && (engaged == true))
{
	if (home == -1) home = [x,y];
	if (position == -1) position = image_index;
	if !(calculating) calculating = true;
	if (calculating) && (!homebound)
	{
		path_coords = Modular_Path_To_First(targetting, ["wall"], 
		path_coords[0], path_coords[1], path_coords[2],path_coords[3],path_coords[4]);
	}
	if (!calculating)
	{

		if (path_coords == -4)
		{
			homebound = true;
			if ((x == home[0]) &&(y == home[1])) 
			{
				image_index = position;
				position = -1;
				engaged = false;
				targetting = -1;
				path_coords = [[],1,[],0,[]];
				path = false;
				home = -1;
			}
			else
			{
				path_coords = Path_To_Weighted(home,["wall"])
				if (path_coords == -4)
				{
					engaged = false;
					targetting = -1;
					path_coords = [[],1,[],0,[]];
					path = false;
					home = -1;
				}
			}
		
		}
		if (array_length(path_coords) != 0) path = true;
	}


}

if ((engaged) && !(calculating)) && (path)
{
	Mine_to_Path();
	if !(path)
	{
		path_coords = [[],1,[],0,[]];
	}

	
}
