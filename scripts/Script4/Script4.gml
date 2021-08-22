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