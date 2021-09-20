/// @desc
/// @param target: obj or ID to travel to
/// @param except: array of attributes to avoid i.e. "wall"
//@param target
//target is an arr of coordinates [x2,y2]
///@param avoid
//avoid is an array of attributes that the objects along the way will be checked for.
//if in arr avoid[], this function will path around those objects.
///@param mode
// 0: first path, fastest
// 1: if more than 1 path back, choose one at random
function Path_To(_target, _avoid){
if (array_length(_target) == 0) return show_debug_message("Path_To function parameters error")
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
			if Is_Adjacent([_target[0],_target[1]],[path_curr[i][0],path_curr[i][1]])
				{
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
			path_curr = path_next;
			path_next = [];
			step++;
			if (array_length(path_curr)==0) return -4;

			
	
}
//Part 2, return the shortest path as array of length (step - 1)
var path_output = [];
var step_back = visited[array_length(visited)-1][2];
var step_max = step_back;
var prev_x = _target[0];
var prev_y = _target[1];
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
path_output[array_length(path_output)] = [_target[0], _target[1]];
return path_output; 
	
	
}

function Min_Steps_To(_target, _avoid)
{
if (array_length(_target) == 0) return show_debug_message("Min_Steps_To function parameters error")
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
			if Is_Adjacent([_target[0],_target[1]],[path_curr[i][0],path_curr[i][1]])
				{
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
								}
								break;
										
							case 1: if !(Coords_In_Array(path_next, [path_curr[i][0] - TILE_SIZE, path_curr[i][1]]))
								{
									path_next[array_length(path_next)] = [path_curr[i][0] - TILE_SIZE, path_curr[i][1],step];
								}
								break;
								
								
							case 2: if !(Coords_In_Array(path_next, [path_curr[i][0], path_curr[i][1] + TILE_SIZE]))
								{
									path_next[array_length(path_next)] = [path_curr[i][0], path_curr[i][1] + TILE_SIZE,step];
								}
								break;
								
							case 3: if !(Coords_In_Array(path_next, [path_curr[i][0], path_curr[i][1] - TILE_SIZE]))
								{
									path_next[array_length(path_next)] = [path_curr[i][0], path_curr[i][1] - TILE_SIZE,step];
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
			path_curr = path_next;
			path_next = [];
			step++;
			if (array_length(path_curr)==0) return -4;
}
return visited[array_length(visited)-1][2];
	
}

function Path_To_First(_object, _avoid){

//from current coordinates, round to nearest “tile coordinate”
var _x_adjust = x/TILE_SIZE //tile size = 16px*16px, for example
var _y_adjust = y/TILE_SIZE

if (floor(abs(_x_adjust) < 0.5)) var _x_start = TILE_SIZE * floor(_x_adjust);
else var _x_start = TILE_SIZE * ceil(_x_adjust);

if (floor(abs(_y_adjust) < 0.5)) var _y_start = TILE_SIZE * floor(_y_adjust);
else var _y_start = TILE_SIZE * ceil(_y_adjust);
var path_next = []; //placeholder for scoping next path steps. Iterattively becomes ath last
var step = 1;
var path_curr = [[_x_start, _y_start, step]];//each index is recorded as [x, y, step]

var visited = []; //store all previously visited coordinates
	 
var found = 0;
var _target = [];
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
			if (instance_place(path_curr[i][0] + TILE_SIZE, path_curr[i][1], _object))
			{
				found = 1;//if target is found, break. Add as final coordinate
				_target[0] = path_curr[i][0] + TILE_SIZE;
				_target[1] = path_curr[i][1];
			}
			if (instance_place(path_curr[i][0] - TILE_SIZE, path_curr[i][1], _object))
			{
				found = 1;//if target is found, break. Add as final coordinate
				_target[0] = path_curr[i][0] - TILE_SIZE;
				_target[1] = path_curr[i][1];
			}
			if (instance_place(path_curr[i][0], path_curr[i][1] + TILE_SIZE, _object))
			{
				found = 1;//if target is found, break. Add as final coordinate
				_target[0] = path_curr[i][0];
				_target[1] = path_curr[i][1] + TILE_SIZE;
			}
			if (instance_place(path_curr[i][0], path_curr[i][1] - TILE_SIZE, _object))
			{
				found = 1;//if target is found, break. Add as final coordinate
				_target[0] = path_curr[i][0];
				_target[1] = path_curr[i][1] - TILE_SIZE;
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
								}
								break;
										
							case 1: if !(Coords_In_Array(path_next, [path_curr[i][0] - TILE_SIZE, path_curr[i][1]]))
								{
									path_next[array_length(path_next)] = [path_curr[i][0] - TILE_SIZE, path_curr[i][1],step];
								}
								break;
								
								
							case 2: if !(Coords_In_Array(path_next, [path_curr[i][0], path_curr[i][1] + TILE_SIZE]))
								{
									path_next[array_length(path_next)] = [path_curr[i][0], path_curr[i][1] + TILE_SIZE,step];
								}
								break;
								
							case 3: if !(Coords_In_Array(path_next, [path_curr[i][0], path_curr[i][1] - TILE_SIZE]))
								{
									path_next[array_length(path_next)] = [path_curr[i][0], path_curr[i][1] - TILE_SIZE,step];
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
			path_curr = path_next;
			path_next = [];
			step++;
			if (array_length(path_curr)==0) return -4;

			
	
}
//Part 2, return the shortest path as array of length (step - 1)
var path_output = [];
var step_back = visited[array_length(visited)-1][2];
var step_max = step_back;
var prev_x = _target[0];
var prev_y = _target[1];
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
path_output[array_length(path_output)] = [_target[0], _target[1]];
return path_output; 
		

	
	
}
	
function Path_To_Weighted(_target, _avoid){
if (array_length(_target) == 0) return show_debug_message("Path_To_Weighted function parameters error")
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
			if Is_Adjacent([_target[0],_target[1]],[path_curr[i][0],path_curr[i][1]])
				{
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
			path_curr = path_next;
			path_next = [];
			step++;
			if (array_length(path_curr)==0) return -4;

}

//Part 2, return the shortest path as array of length (step - 1)
var path_output = [];
var step_back = visited[array_length(visited)-1][2];
var step_max = step_back;
var prev_x = _target[0];
var prev_y = _target[1];
var v_max = array_length(visited);
//walk backwards from target to player using step markers.
var branches = [];
var possible_path = [[]];

for (var v = v_max - 1; v >= 0; v--)
{
	for (var path = 0; path < array_length(possible_path); path++)
	{
		if !(step_back==step_max)
		{
			prev_x = possible_path[path][array_length(possible_path[path])-1][0];
			prev_y = possible_path[path][array_length(possible_path[path])-1][1];
		} 
		if (step_back == visited[v][2]) 
		{
			if Is_Adjacent([visited[v][0],visited[v][1]],[prev_x, prev_y])
			{
				branches[array_length(branches)] = [visited[v][0],visited[v][1],visited[v][3]];
			}
		}
		if ((v-1) == -1) break;
		if (step_back-1 == visited[v-1][2]) 
		{
			for (var branch = 0; branch < array_length(branches); branch++)
			{
				possible_path[array_length(possible_path)] = possible_path[path];
				possible_path[array_length(possible_path)-1][array_length(possible_path[array_length(possible_path)-1])] = branches[branch];
				step_back--;
				branches = [];
				branch = 0;
				if (step_back == 0) break;
			}
		}
	}
}
var count = [];
var sum;
for (var choice = 0; choice < array_length(possible_path); choice++)
{
	sum = 0;
	for (var total = 0; total < array_length(possible_path[choice]);total++)
	{
		sum += possible_path[choice][total][2];
	}
	count[choice] = sum;
}
path_output = possible_path[Smallest_in_Array(count)];

var path_output_rev = [];
for (var thing = array_length(path_output)-1; thing >= 0; thing--)
{
	path_output_rev[thing] = path_output[((array_length(path_output)-1) - thing)]
}

path_output_rev[array_length(path_output)] = [_target[0], _target[1]];
return path_output_rev; 


	
	
}
	
function Modular_Path_To_First(_object, _avoid, path_curr, step, visited, found, _target)
{
	//from current coordinates, round to nearest “tile coordinate”
	var _x_adjust = x/TILE_SIZE //tile size = 16px*16px, for example
	var _y_adjust = y/TILE_SIZE

	if (floor(abs(_x_adjust) < 0.5)) var _x_start = TILE_SIZE * floor(_x_adjust);
	else var _x_start = TILE_SIZE * ceil(_x_adjust);

	if (floor(abs(_y_adjust) < 0.5)) var _y_start = TILE_SIZE * floor(_y_adjust);
	else var _y_start = TILE_SIZE * ceil(_y_adjust);
	var path_next = []; //placeholder for scoping next path steps. Iterattively becomes path last
	if (array_length(path_curr) == 0) 
	{
		path_curr = [[_x_start, _y_start, step]];
		//each index is recorded as [x, y, step]
	}
	
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
				check[0] = instance_place(path_curr[i][0] + TILE_SIZE, path_curr[i][1], _object);
				check[1] = instance_place(path_curr[i][0] - TILE_SIZE, path_curr[i][1], _object);
				check[2] = instance_place(path_curr[i][0], path_curr[i][1] + TILE_SIZE, _object);
				check[3] = instance_place(path_curr[i][0], path_curr[i][1] - TILE_SIZE, _object);
				//is next branch target?
			if ((check[0]) && (found !=1))
			{
				if (ds_list_find_index(global.Mining_Target, check[0]) == -1)
				{
					found = 1;//if target is found, break. Add as final coordinate
					if (found == 1)
					{
						target_id = check[0];
						ds_list_add(global.Mining_Target, target_id);
					}
					
					_target[0] = path_curr[i][0] + TILE_SIZE;
					_target[1] = path_curr[i][1];
				}
				
			}
			if((check[1]) && (found !=1))
			{
				if (ds_list_find_index(global.Mining_Target, check[1]) == -1)
				{
					found = 1;//if target is found, break. Add as final coordinate
					if (found == 1)
					{
						target_id = check[1];
						ds_list_add(global.Mining_Target, target_id);
					}
					_target[0] = path_curr[i][0] - TILE_SIZE;
					_target[1] = path_curr[i][1];
				} 
			}
			if ((check[2]) && (found !=1))
			{
				if (ds_list_find_index(global.Mining_Target, check[2]) == -1)
				{
					
					found = 1;//if target is found, break. Add as final coordinate
					if (found == 1)
					{
						target_id = check[2];
						ds_list_add(global.Mining_Target, target_id);
					}
					_target[0] = path_curr[i][0];
					_target[1] = path_curr[i][1] + TILE_SIZE;
				} 
			}
			if ((check[3]) && (found !=1))
			{
				if (ds_list_find_index(global.Mining_Target, check[3]) == -1)
				{
					found = 1;//if target is found, break. Add as final coordinate
					if (found == 1)
					{
						target_id = check[3];
						ds_list_add(global.Mining_Target, target_id);
					}
					_target[0] = path_curr[i][0];
					_target[1] = path_curr[i][1] - TILE_SIZE;
				} 
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
				
				return [path_curr, step, visited, found, _target];
				
			
	
	}
	//Part 2, return the shortest path as array of length (step - 1)
	var path_output = [];
	var step_back = visited[array_length(visited)-1][2];
	var step_max = step_back;
	var prev_x = _target[0];
	var prev_y = _target[1];
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
	path_output[array_length(path_output)] = [_target[0], _target[1]];
	calculating = false;
	path = true;
	return path_output; 
	
	
	
}

function Modular_Path_To_Coords(_target, _avoid, path_curr, step, visited, found)
{
	//from current coordinates, round to nearest “tile coordinate”
var _x_adjust = x/TILE_SIZE //tile size = 16px*16px, for example
var _y_adjust = y/TILE_SIZE

if (floor(abs(_x_adjust) < 0.5)) var _x_start = TILE_SIZE * floor(_x_adjust);
else var _x_start = TILE_SIZE * ceil(_x_adjust);

if (floor(abs(_y_adjust) < 0.5)) var _y_start = TILE_SIZE * floor(_y_adjust);
else var _y_start = TILE_SIZE * ceil(_y_adjust);
var path_next = []; //placeholder for scoping next path steps. Iterattively becomes path last
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
			if Is_Adjacent([_target[0],_target[1]],[path_curr[i][0],path_curr[i][1]])
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
				
				return [path_curr, step, visited, found, _target];
				
			
	
	}
	//Part 2, return the shortest path as array of length (step - 1)
	var path_output = [];
	var step_back = visited[array_length(visited)-1][2];
	var step_max = step_back;
	var prev_x = _target[0];
	var prev_y = _target[1];
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
	path_output[array_length(path_output)] = [_target[0], _target[1]];
	calculating = false;
	path = true;
	return path_output; 
	
	
	
}