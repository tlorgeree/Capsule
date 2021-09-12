/// @desc
#region Base variables
integrity = 0; //Bot's health
attributes = ["bot"];//Is bot
tier = 1; //What tier blocks this bot can mine
image_speed = 0; 
#endregion
#region Pathing
path = false;	// A path has been found
path_coords = [[],1,[],0,[]];	//Set up for Modular Pathing Function
path_step = 0;	//Current coordinate set along path
spd = 4;	// Movement speed in px
engaged = true;		//Looking for path
targetting = obj_Iron_Ore;	//What object to target and path to.
target_id = -1;		//The id of the target object
except = ["wall"];	//Attributes to avoid when pathing.
calculating = false;	//Creating path = true | outputting coordinates = false

//Reseting to initialized position
home = -1;	//home coordinates
homebound = false;	//Going home currently
position = -1;	//Original facing position once at home
#endregion
#region Mining

initial_check = 1; //For beginning Mining state when path is given.
mining = 0; //Mining state T/F
mine_spd = 20;	//integrity per 1/2 second
mine_target = -1; //There is/isnt a target block being mined
mine_timer = 0; //Manages mine speed ticks per second
#endregion

