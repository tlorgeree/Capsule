/// @desc
//Movement
move_up = keyboard_check(ord("W"));
move_down = keyboard_check(ord("S"));
move_left = keyboard_check(ord("A"));
move_right = keyboard_check(ord("D"));

//Movement functions
ver_move = (move_down - move_up)* spd;
hor_move = (move_right - move_left) * spd;

Player_Move(ver_move, hor_move);
Player_Collision(grav, hor_move);