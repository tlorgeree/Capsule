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
	if (collision_rectangle(x + w + hor_move, y-1, x - w + hor_move, y - h, obj_Parent_Block, true, true))
	{
		if (hor_move > 0) 
		{
			var target = collision_rectangle(x + w + hor_move, y-1, x - w, y - h, obj_Parent_Block, true, true);
			if (target)
			{
				with(target)
				{
					//other.x = bbox_left - w - 0.01;
					
				}
			}
			
		}
		if (hor_move < 0)
		{
			if (collision_rectangle(x + w, y-1, x - w + hor_move, y - h, obj_Parent_Block, true, true))
			{
				var target = collision_rectangle(x + w, y-1, x - w + hor_move, y - h, obj_Parent_Block, true, true);
				with(target) 
				{
					
					//other.x = bbox_left 
					//+ sprite_get_width(target.sprite_index)*image_xscale + w;
					//show_debug_message(sprite_get_width(tar_spr));
				}
			}
		}
		hor_move = 0;
		_collision = true;

	}

	
	//Horizontal Move Commit
	x += hor_move;




	//Vertical Collision Check

	if (collision_rectangle(x + w-1, y + ver_move, x - w+1, y -h + ver_move, obj_Parent_Block, true, true))
	{
		
		if collision_line(x + w-1, y + ver_move+4, x - w+1, y+ver_move+1, obj_Parent_Block, true, true)
			{
				grounded = true;
				//with(collision_rectangle(x + w-5, y + ver_move, x - w+5, 
				//y -h, obj_Parent_Block, true, true)) other.y = y;	
			}
		
		ver_spd = 0;
		_collision = true;

	}



	//Vertical Move Commit
	if (grounded) ver_spd = 0;
	else 
	{
		y += ver_spd;
		ver_spd += _grav;
	}
	
	if (grounded)
	{
		
		if !(collision_rectangle(x + w-4, y, x - w+4, y -(h * 0.5), obj_Parent_Block, true, true))
		{
			grounded = false;
		}
	}

	return _collision;	
}