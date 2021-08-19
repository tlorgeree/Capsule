/// @desc
if (instance_exists(target))
{
	path = Path_To_Closest(target, except);
	show_debug_message(path[|0]);
}