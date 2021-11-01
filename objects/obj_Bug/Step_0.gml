/// @desc
/// @desc
if ((path == false) && (engaged == true)) //There is no current path but we are looking
{
	if (home == -1) home = [x,y];
	if (position == -1) position = image_index;
	if !(calculating) calculating = true;
	if (calculating)
	{
		path_coords = Bug_Path_to_Coords();
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
				
				path = false;
				home = -1;
			}
			else
			{
				
				path_coords = Path_To(home, except);
				if !(calculating)
				{
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
