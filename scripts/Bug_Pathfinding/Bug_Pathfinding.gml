/// @desc
function Bug_Move_to_Coords(coord_array){
	
}

function Bug_Path_to_Target(){
}

function Bug_Path_to_Coords(){
	var _x_adjust = x/TILE_SIZE //tile size = 16px*16px, for example
	var _y_adjust = y/TILE_SIZE

	if (floor(abs(_x_adjust) < 0.5)) var _x_start = TILE_SIZE * floor(_x_adjust);
	else var _x_start = TILE_SIZE * ceil(_x_adjust);

	if (floor(abs(_y_adjust) < 0.5)) var _y_start = TILE_SIZE * floor(_y_adjust);
	else var _y_start = TILE_SIZE * ceil(_y_adjust);
	var path_next = []; //placeholder for scoping next path steps. Iterattively becomes path last
	var _max, obst, check;
	var a_max = array_length(avoid);
	
	
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
				if Is_Adjacent([target[0],target[1]],[path_curr[i][0],path_curr[i][1]])
					{
						show_debug_message("This happened");
						found = 1;//if target is found, break. Add as final coordinate
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
							path_curr[i][1], all);
						}
			
					if !(check[1] == -1)
						{
							check[1] = instance_place(path_curr[i][0] - TILE_SIZE,
							path_curr[i][1], all);
						}
			
					if !(check[2] == -1)
						{
							check[2] = instance_place(path_curr[i][0],
							path_curr[i][1] + TILE_SIZE, all);
						}
				
					if !(check[3] == -1)
						{
							check[3] = instance_place(path_curr[i][0],
							path_curr[i][1] - TILE_SIZE, all);
						}
		
					for (var c=0;c<4;c++)
					{
						if (!(check[c] == -1))//if not nothing or if not visited
						{
							obst = false;//this one line of code can break the whole thing!
							if !(check[c] == -4)
							{
								for(var j = 0; j < array_length(check[c].attributes); j++)
								{
									for(var k = 0; k < a_max; k++)
									{
										if ((check[c].attributes[j] ==_avoid[k]) || (check[c].tier > id.tier))
										{
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
									case 0: if !(Coords_In_Array(path_next, [path_curr[i][0] + TILE_SIZE, path_curr[i][1]]))
										{
											path_next[array_length(path_next)] = [path_curr[i][0] + TILE_SIZE, path_curr[i][1], step];
											if (instance_place(path_curr[i][0] + TILE_SIZE, path_curr[i][1],all)) {
												path_next[array_length(path_next)-1][3] = instance_place(path_curr[i][0] + TILE_SIZE, path_curr[i][1],all).integrity;
											}else path_next[array_length(path_next)-1][3] = 0;
										}
										break;
										
									case 1: if !(Coords_In_Array(path_next, [path_curr[i][0] - TILE_SIZE, path_curr[i][1]]))
										{
											path_next[array_length(path_next)] = [path_curr[i][0] - TILE_SIZE, path_curr[i][1],step];
											if (instance_place(path_curr[i][0] - TILE_SIZE, path_curr[i][1],all)){
												path_next[array_length(path_next)-1][3] = instance_place(path_curr[i][0] - TILE_SIZE, path_curr[i][1],all).integrity;
											}else path_next[array_length(path_next)-1][3] = 0;
										}
										break;
								
								
									case 2: if !(Coords_In_Array(path_next, [path_curr[i][0], path_curr[i][1] + TILE_SIZE]))
										{
											path_next[array_length(path_next)] = [path_curr[i][0], path_curr[i][1] + TILE_SIZE,step];
											if (instance_place(path_curr[i][0], path_curr[i][1] + TILE_SIZE,all)){
												path_next[array_length(path_next)-1][3] = instance_place(path_curr[i][0], path_curr[i][1] + TILE_SIZE,all).integrity;
											}else path_next[array_length(path_next)-1][3] = 0;
										}
										break;
								
									case 3: if !(Coords_In_Array(path_next, [path_curr[i][0], path_curr[i][1] - TILE_SIZE]))
										{
											path_next[array_length(path_next)] = [path_curr[i][0], path_curr[i][1] - TILE_SIZE,step];
											if (instance_place(path_curr[i][0], path_curr[i][1] - TILE_SIZE,all)){
												path_next[array_length(path_next)-1][3] = instance_place(path_curr[i][0], path_curr[i][1] - TILE_SIZE,all).integrity;
											}else path_next[array_length(path_next)-1][3] = 0;
										}
										break;
								}
							

							}

						}
					}
				

				}

				
					for (var p = 0; p < array_length(path_curr); p++) //update history
					{
					
						visited[array_length(visited)] = path_curr[p];
					}
					if (array_length(path_next) == 0) 
					{
							calculating = false;
							return -4;
					}
					path_curr = path_next;
					path_next = [];
					step++;
				
					return [path_curr, step, visited, found, target];
				
			
	
		}
		//Part 2, return the shortest path as array of length (step - 1)
		var path_output = [];
		var step_back = visited[array_length(visited)-1][2];
		var step_max = step_back;
		var prev_x = target[0];
		var prev_y = target[1];
		var v_max = array_length(visited);
		//walk backwards from target to player using step markers.

		for (var v = v_max - 1; v >= 0; v--)
		{
			//filling arrays backwards after initialization is 100x faster apparently
			if (step_back == visited[v][2]) 
			{
				if Is_Adjacent([visited[v][0],visited[v][1]],[prev_x, prev_y])
				{
					path_output[(step_max -1) - (step_max - step_back)] = [visited[v][0],visited[v][1]];
					prev_x = visited[v][0];
					prev_y = visited[v][1];
					step_back--;
					if (step_back == 0) break;
				}
				
			}
		}
		path_output[array_length(path_output)] = [target[0], target[1]];
		calculating = false;
		path = true;
		step = 0;
		return path_output; 
}