/// @desc
//Key bindings
move_left = keyboard_check(ord("A"));
move_right = keyboard_check(ord("D"));
move_up = keyboard_check(ord("W"));
move_down = keyboard_check(ord("S"));
jump = keyboard_check_pressed(vk_space);

if (jump)
{
	grounded = false;
	ver_spd = ver_spd_max;
}

hor_move = (move_right - move_left) * spd;
if (ver_allow) ver_move = (move_down- move_up) * spd;
else ver_move = ver_spd;



Player_Collision_Move_Check(grav);
show_debug_message(string(ver_spd));