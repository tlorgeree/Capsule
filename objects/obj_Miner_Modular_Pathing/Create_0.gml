/// @desc
path = false;
path_coords = [[],1,[],0,[]];
path_step = 0;
spd = 4;
engaged = true;
targetting = obj_Iron_Ore;
except = ["wall"];
mine_spd = 2;//integrity per 1/2 second

integrity = 0;
attributes = ["bot"];
initial_check = 1;
mining = 0;
mine_target = -1;
mine_timer = 0;
image_speed = 0;
tier = 1;
position = -1;
home = -1;
homebound = false;

//Paths per second
pps = FPS;
calculating = false;