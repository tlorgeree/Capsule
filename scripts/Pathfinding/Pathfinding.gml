/// @desc
/// @param target: obj or ID to travel to
/// @param except: array of attributes to avoid i.e. "wall"
//@param target
//target is an arr of coordinates [x2,y2]
///@param avoid
//avoid is an array of attributes that the objects along the way will be checked for.
//if in arr avoid[], this function will path around those objects.
function Path_To(_target, _avoid){
	//from current coordinates, round to nearest “tile coordinate”
	var _x_adjust = x/TILE_SIZE //tile size = 16px*16px, for example
	var _y_adjust = y/TILE_SIZE

	if (floor(abs(_x_adjust) < 0.5)) var _x_start = TILE_SIZE * floor(_x_adjust);
	else var _x_start = TILE_SIZE * ceil(_x_adjust);

	if (floor(abs(_y_adjust) < 0.5)) var _y_start = TILE_SIZE * floor(_y_adjust);
	else var _y_start = TILE_SIZE * ceil(_y_adjust);
	var path_next = []; //placeholder for scoping next path steps. Iterattively becomes path last
	var step = 1;
	var path_curr = [[_x_start, _y_start, step]];//each index is recorded as [x, y, step]

	var visited = []; //store all previously visited coordinates
	 
	var found = 0;
	var _max, obst, check;
	var a_max = array_length(_avoid);
	
	
	//from starting coords, check surrounding coords for obstacles
			//store each branching path as array of indices (see Fig 2)
	while (found == 0)
	{
		_max = array_length(path_curr);
		
		for (var i = 0; i < _max; i++)
			{
				//reset history checks
				check = [0,0,0,0]; //-1 means don't check
				
				//is next branch target?
								show_debug_message("Path curr is :" + string(path_curr));
								show_debug_message(string(i));
				if ((path_curr[i][0] + TILE_SIZE == _target[0]) && (path_curr[i][1] == _target[1]))
				|| ((path_curr[i][0] - TILE_SIZE == _target[0]) && (path_curr[i][1] == _target[1]))
				|| ((path_curr[i][0] == _target[0]) && (path_curr[i][1] + TILE_SIZE == _target[1]))
				|| ((path_curr[i][0] == _target[0]) && (path_curr[i][1] - TILE_SIZE == _target[1]))
					{
						found = 1;//if target is found, break. Doesn't path on target's location.
						show_debug_message("Found it!");
						break;
					}
				
				//check if next branch is in history
				
				
				for (var h = 0; h < array_length(visited); h++)//additional gate to make sure it hasn't been visited before
				{
					if ((path_curr[i][0] + TILE_SIZE == visited[h][0]) && (path_curr[i][1] == visited[h][1]))
					{ check[0] = -1;}
					if ((path_curr[i][0] - TILE_SIZE == visited[h][0]) && (path_curr[i][1] == visited[h][1]))
					{ check[1] = -1;}
					if ((path_curr[i][0] == visited[h][0]) && (path_curr[i][1] + TILE_SIZE == visited[h][1]))
					{ check[2] = -1;}
					if ((path_curr[i][0] == visited[h][0]) && (path_curr[i][1] - TILE_SIZE  == visited[h][1]))
					{ check[3] = -1;}
					
				}
				
				

				obst = false;
				if !(check[0] == -1)
					{
					check[0] = instance_place(path_curr[i][0] + TILE_SIZE,
					path_curr[i][1], obj_Wall);
					}
			
				if !(check[1] == -1)
					{
						check[1] = instance_place(path_curr[i][0] - TILE_SIZE,
						path_curr[i][1], obj_Wall);
					}
			
				if !(check[2] == -1)
					{
						check[2] = instance_place(path_curr[i][0],
						path_curr[i][1] + TILE_SIZE, obj_Wall);
					}
				
				if !(check[3] == -1)
					{
						check[3] = instance_place(path_curr[i][0],
						path_curr[i][1] - TILE_SIZE, obj_Wall);
					}
		
				//show_debug_message(string(check));
				for (var c=0;c<4;c++)
				{
					if (!(check[c] == -1))//if not nothing or if not visited
					{
						if !(check[c] == -4)
						{
							for(var j = 0; j < array_length(check[c].attributes); j++)
							{
								for(var k = 0; k < a_max; k++)
								{
									if(check[c].attributes[j] ==_avoid[k])
									{
										show_debug_message("Found obstacle");
										obst = true; //don't check remaining avoid traits after 1st found
											break;
									}
								
								}
								if (obst == true) break; //don't check remaining attributes after 1st found
							}
						}

						if (obst == false)
						{
							
							switch (c)
							{
								case 0: path_next[array_length(path_next)] = [path_curr[i][0] + TILE_SIZE, path_curr[i][1],step];
										break;
										
								case 1: path_next[array_length(path_next)] = [path_curr[i][0] - TILE_SIZE, path_curr[i][1],step];
										break;
								
								case 2: path_next[array_length(visited)] = [path_curr[i][0], path_curr[i][1] + TILE_SIZE,step];
										break;
								
								case 3: path_next[array_length(path_next)] = [path_curr[i][0], path_curr[i][1]  - TILE_SIZE,step];
										break;
							}
							

						}

					}
				}
				

			}
			if !(found == 1)
			{
				for (var p = 0; p < array_length(path_curr); p++) //update history
				{
					
					visited[array_length(visited)] = path_curr[p];
				}show_debug_message("Visited: " + string(visited));
				
				show_debug_message("Path next is: " + string(path_next));
				path_curr = path_next;
				path_next = [];
				step++;
				
			}
			show_debug_message("Moving onto step " + string(step));
			
	
	}
	show_debug_message("Done");
	
	
	
}
