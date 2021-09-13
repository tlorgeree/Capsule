/// @desc
function Player_Move(vertical, horizontal)
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
}

function Player_Collision(_grav, _horizontal)
{
	var spr_width = sprite_get_width(image_index);
	if !(grounded)
	{
		if (!(place_meeting(x - (0.5 * spr_width), y +_grav, obj_Parent_Block)) 
		|| !(place_meeting(x + (0.5 * spr_width), y + _grav, obj_Parent_Block)))
	
		{
			y += _grav;
		
		}
		else
		{
			for (var i = 0; i < _grav; i++)
			{
				if ((place_meeting(x - (0.5 * spr_width), y + i, obj_Parent_Block)) 
				|| (place_meeting(x + (0.5 * spr_width), y + i, obj_Parent_Block)))
				{
					break;
				}
				else y++;
			}
			grounded = true;
		}
	}
	else
	{
		if (!(place_meeting(x - (0.5 * spr_width), y, obj_Parent_Block)) 
		&& !(place_meeting(x + (0.5 * spr_width), y, obj_Parent_Block)))
		{
			grounded = false;
		}
	}
}