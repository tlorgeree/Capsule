/// @desc
function Player_Move(vertical, horizontal)
{
	if ((vertical != 0) && (horizontal == 0))
	|| ((vertical == 0) && (horizontal != 0))
	{
		y += vertical;
		x += horizontal;
	}
	else
	{
		y += (vertical * (1^(1/2)));
		x += (horizontal * (1^(1/2)));
	}
}