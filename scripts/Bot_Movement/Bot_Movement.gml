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
	if (initial_check == 1)
	{
		if (path_step< array_length(path_coords)) && (instance_place(path_coords[path_step][0],path_coords[path_step][1], obj_Parent_Block))
		{ 
			mining = true;
			mine_target = instance_place(path_coords[path_step][0],path_coords[path_step][1], obj_Parent_Block);
		}
		initial_check = 0;
	}
	
	if ((path_coords[path_step][0] == x) && (path_coords[path_step][1] == y))
	&& !(mining) && (path_step< array_length(path_coords))
	{
		
		path_step++;
		if (path_step< array_length(path_coords)) && (instance_place(path_coords[path_step][0],path_coords[path_step][1], obj_Parent_Block))
		{ 
			mining = true;
			mine_target = instance_place(path_coords[path_step][0],path_coords[path_step][1], obj_Parent_Block);
		}
	}
	if (mining)
	{
		if (path_coords[path_step][0] > x) image_index = 0;
		if (path_coords[path_step][0] < x) image_index = 2;
		if (path_coords[path_step][1] > y) image_index = 3;
		if (path_coords[path_step][1] < y) image_index = 1;
		if (!instance_exists(mine_target))
		{
			mining = false;
			mine_timer = -1;
			mine_target = -1;
		}
		with (mine_target)
		{
			if (other.mine_timer == 0) || (other.mine_timer % 30 == 0)
			{
				integrity -= other.mine_spd;
				if (integrity<=0)
				{
					other.mining = false;
					instance_destroy();
					other.mine_timer = -1;
					other.mine_target = -1;
				}
				
			}other.mine_timer++
			
				
		}
	}
	if (path) && (path_step< array_length(path_coords)) && !(mining)
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
		if !(mining)
		{
			path = false;
			path_step = 0;
			initial_check = 1;
			
		}
	}
}

function Target_Block(object)
{
	
}