///@param array
///@param item
//checks if item is in array
//returns 0 or 1
function In_Array(array, item){
	var _in_array = 0;
	var _max = array_length(array);
	for (var i = 0; i < _max; i++)
	{
		if (array[i] == item) _in_array = 1;
		
	}
	return _in_array
}

function Coords_In_Array(array, item){
	var _in_array = 0;
	var _max = array_length(array);
	for (var i = 0; i < _max; i++)
	{
		if (array[i][0] == item[0]) && (array[i][1] == item[1])
		{
			_in_array = 1;
		}
		
	}
	return _in_array
}

function Is_Adjacent(coords1, coords2)
{
	var x1 = coords1[0];
	var x2 = coords2[0];
	var y1 = coords1[1];
	var y2 = coords2[1];
	
	var output = false;
	if (((x1 + TILE_SIZE == x2) && (y1 == y2)))
	|| (((x1 - TILE_SIZE == x2) && (y1 == y2)))
	|| (((x1 == x2) && (y1 + TILE_SIZE == y2)))
	|| (((x1 == x2) && (y1 - TILE_SIZE == y2)))
	{
		output = true;
	}
	return output;
}

function Smallest_in_Array(_array)
{
	var smallest = 0;
	var index = 0;
	for (var item = 0; item < array_length(_array); item++)
	{
		if (_array[item] < smallest) 
		{
			smallest = _array[item];
			index = item;
		}
	}
	return index;
}

function At_Coords(_arr1, _arr2)
{
	if ((_arr1[0] == _arr2[0]) && (_arr1[0] == _arr2[0])) return 1;
	return 0;
}