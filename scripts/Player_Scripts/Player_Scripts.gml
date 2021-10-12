/// @desc
/*function Player_Move(vertical, horizontal)
{
	if ((vertical != 0) && (horizontal == 0))
	|| ((vertical == 0) && (horizontal != 0))
	{
		//y += vertical;
		x += horizontal;
	}
	else
	{
		//y += (vertical * (1^(1/2)));
		x += (horizontal * (1^(1/2)));
	}
}*/

function Player_Collision_Move_Check(_grav)
{
	var w = sprite_get_width(sprite_index) * 0.5;
	var h = sprite_get_height(sprite_index);
	var _collision = false;
	//Horizontal tiles
	
	if (place_meeting(x + hor_move, y, obj_Parent_Block))
	{
		if (hor_move > 0)
		{
			while (!place_meeting(x+1, y, obj_Parent_Block))
			{
				x++;
			}
		}
		if (hor_move < 0)
		{
			while (!place_meeting(x-1, y, obj_Parent_Block))
			{
				x--;
			}
		}
		hor_move = 0;
		_collision = true;
	}
		
	
	

	
	//Horizontal Move Commit
	x += hor_move;




	//Vertical Collision Check
	if (place_meeting(x, y + ver_move, obj_Parent_Block))
	{
		show_debug_message("This is happenning");
		if (ver_move > 0) && !(grounded)
		{
			while (!place_meeting(x, y + 1, obj_Parent_Block))
			{
				y++;
			}
			grounded = true;
		}
		if (ver_move < 0)
		{
			while (!place_meeting(x, y - 1, obj_Parent_Block))
			{
				
				y--;
			}
		}
		ver_move = 0;
		ver_spd = 0;
		_collision = true;
	}

	//Vertical Move Commit
	y += ver_move;
	
	if (grounded)
	{
		
		if !(collision_rectangle(x + w - 4, y + 1, x - w + 4, y -(h * 0.5), obj_Parent_Block, true, true))
		{
			grounded = false;
		}
	}
	else
	{
		if !(ver_allow)
		{
			ver_spd += _grav;
		}
	}

	return _collision;	
}