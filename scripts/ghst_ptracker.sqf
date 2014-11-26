/*
V1.1 By: Ghost
Creates markers that stay with the players until nil.
*/
//if (!isserver) exitwith {};

if (true) then {
	/*{
		[_x, [0,0],"ICON","ColorBlue",[1,1],"",0,"mil_dot"] call XfCreateMarkerLocal;
		sleep 0.01;
	} forEach ghst_players;*/
	{
		[_x, [0,0],"ICON","ColorGrey",[1,1],"",0,"mil_dot"] call XfCreateMarkerLocal;
		sleep 0.01;
	} forEach ghst_vehicles;
};

sleep 1;
while {true} do {
	//[] spawn ghstMarkerPlayers;
	[] spawn ghstMarkerVehicles;
	sleep 1;
};