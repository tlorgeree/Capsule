/// @desc
function Move_to_Path(){
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
	
	
function Mine_to_Path(){
	if ((path_coords[path_step][0] == x) && (path_coords[path_step][1] == y))
	{
		path_step++;
		//now check for block to mine
		var _mine = instance_place(path_coords[path_step][0], path_coords[path_step][1], obj_Dirt)
		if !(_mine == -4)
		{
			var mining = true;
			if (path_coords[path_step][0] > x) image_index = 0;
			if (path_coords[path_step][0] < x) image_index = 2;
			if (path_coords[path_step][1] > y) image_index = 3;
			if (path_coords[path_step][1] < y) image_index = 1;
			with (_mine)
			{
				integrety -= other.mine_spd;
			}
		} else mining = false;
	}
	if (path) && (path_step< array_length(path_coords)) && !(mining)
	{
		if (path_coords[path_step][0] > x)
		{x+=spd; image_index = 0;}
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