//V1.1 Script by: Ghost - calls in a support UAV until dead
//ghst_uavsupport = [(getmarkerpos "spawnmarker"),"typeofuav",altitude,delay in mins] execvm "scripts\ghst_uavsupport.sqf";
//ghst_uavsupport = [(getmarkerpos "uav_support"),"B_UAV_02_F",500,30] execvm "scripts\ghst_uavsupport.sqf";

//if (!isServer) exitWith {};
private ["_dir"];

_spawnmark = _this select 0;// spawn point where uav spawns and deletes
_type = _this select 1;// type of uav to spawn i.e. "B_UAV_02_F"
_alt = _this select 2;// alt uav will fly
_delay = (_this select 3) * 60;// time before uav support can be called again

if (player getVariable "ghst_uavsup") exitwith {player groupchat "UAV Support Busy";};

openMap true;
_veh_name = getText (configFile >> "cfgVehicles" >> (_type) >> "displayName");

player groupchat "Left click on the map where you want the UAV to go or press escape to cancel";

mapclick = false;

onMapSingleClick "clickpos = _pos; mapclick = true; onMapSingleClick """";true;";

waituntil {mapclick or !(visiblemap)};
if (!visibleMap) exitwith {
	hint "UAV Support Ready";
	};
	
_pos = [clickpos select 0, clickpos select 1, _alt];

sleep 1;

openMap false;

_dir = [_spawnmark, _pos] call BIS_fnc_dirTo;

_air1_array = [_spawnmark, _dir, _type, WEST] call BIS_fnc_spawnVehicle;

_air1 = _air1_array select 0;
_wGrp = _air1_array select 2;

createVehicleCrew _air1;

_air1 setposatl [getposatl _air1 select 0, getposatl _air1 select 1, _alt];

//ghst_uavsup = true;
//publicvariable "ghst_uavsup";
player setVariable ["ghst_uavsup", true];
//publicvariable "ghst_uavsup";
//[[_delay,_air1],"fnc_ghst_uavsup",false,false] spawn BIS_fnc_MP;

sleep 1;

//connect player to uav
player connectTerminalToUav _air1;

_air1 flyinheight _alt;
_air1 setSpeedMode "Normal";
//set combat mode
//_wGrp setCombatMode "RED";

_air1 sidechat "UAV inbound";

_air1 doMove _pos;

/*
_wGrp addwaypoint [_pos, 300];
[_wGrp, 0] setWPPos _pos;
[_wGrp, 0] setWaypointType "LOITER";
*/
While {true} do {
if !(alive _air1) exitwith {player groupchat "Shit we lost UAV support";};
if (fuel _air1 < 0.2) then {_air1 sidechat "Fuel getting low. Need to refuel soon";};
sleep 10;
};

sleep 30;

{deletevehicle _x} foreach crew _air1;
deletevehicle _air1;

sleep 20;
deletegroup _wGrp;

sleep _delay;

hint format ["%1 Support Ready", _veh_name];

player setVariable ["ghst_uavsup", false];

if (true) exitwith {};
