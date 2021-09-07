function Block_Sprite_Adapt()
{
	var check = id.object_index;
	var _up = false;
	var _down = false;
	var _left = false;
	var _right = false;
	
	if (instance_place(x + TILE_SIZE, y, check)) _right = true;
	if (instance_place(x - TILE_SIZE, y, check)) _left = true;
	if (instance_place(x, y + TILE_SIZE, check)) _down = true;
	if (instance_place(x, y - TILE_SIZE, check)) _up = true;
	
	// if block has no common nenighbors, return as default;
	if ((_up == false) && (_down == false) 
	&& (_left == false) && (_right == false)) 
	{
		image_index = 0; 
		return;
	}
	if ((_up == false) && (_down == true) 
	&& (_left == false) && (_right == true)) 
	{
		image_index = 1; 
		return;
	}
	if ((_up == false) && (_down == true) 
	&& (_left == true) && (_right == true)) 
	{
		image_index = 2; 
		return;
	}
	if ((_up == false) && (_down == true) 
	&& (_left == true) && (_right == false)) 
	{
		image_index = 3; 
		return;
	}
	if ((_up == true) && (_down == true) 
	&& (_left == false) && (_right == true)) 
	{
		image_index = 4; 
		return;
	}
	if ((_up == true) && (_down == true) 
	&& (_left == true) && (_right == true)) 
	{
		image_index = 5; 
		return;
	}
	if ((_up == true) && (_down == true) 
	&& (_left == true) && (_right == false)) 
	{
		image_index = 6; 
		return;
	}
	if ((_up == true) && (_down == false) 
	&& (_left == false) && (_right == true)) 
	{
		image_index = 7; 
		return;
	}
	if ((_up == true) && (_down == false) 
	&& (_left == true) && (_right == true)) 
	{
		image_index = 8; 
		return;
	}
	if ((_up == true) && (_down == false) 
	&& (_left == true) && (_right == false)) 
	{
		image_index = 9; 
		return;
	}
	if ((_up == false) && (_down == false) 
	&& (_left == true) && (_right == true)) 
	{
		image_index = 10; 
		return;
	}
	if ((_up == true) && (_down == true) 
	&& (_left == false) && (_right == false)) 
	{
		image_index = 11; 
		return;
	}
	if ((_up == false) && (_down == false) 
	&& (_left == false) && (_right == true)) 
	{
		image_index = 12; 
		return;
	}
	if ((_up == true) && (_down == false) 
	&& (_left == false) && (_right == false)) 
	{
		image_index = 13; 
		return;
	}
	if ((_up == false) && (_down == false) 
	&& (_left == true) && (_right == false)) 
	{
		image_index = 14; 
		return;
	}
	if ((_up == false) && (_down == true) 
	&& (_left == false) && (_right == false)) 
	{
		image_index = 15; 
		return;
	}
	
	
	
}

function Update_Surrounding_Block()
{
	var check = id.object_index;
	var right = instance_place(x + TILE_SIZE, y, check);
	var left = instance_place(x - TILE_SIZE, y, check);
	var above = instance_place(x, y + TILE_SIZE, check);
	var below = instance_place(x, y - TILE_SIZE, check);

	if !(right == noone) right.sprite_change = true;
	if !(left == noone) left.sprite_change = true;
	if !(above == noone) above.sprite_change = true;
	if !(below == noone) below.sprite_change = true;
}