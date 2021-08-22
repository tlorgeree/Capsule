/// @desc
if (path == false)
{
	show_debug_message("Path started");
	path_coords = Path_To([432,400],["wall"], 0);
	path = true;
	show_debug_message("Returned path coords: " + string(path_coords));
}


