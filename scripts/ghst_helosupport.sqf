//V1.3 Script by: Ghost - calls in a support helicopter until fuel is low or out of ammo then leaves
//ghst_helosupport = [(getmarkerpos "spawnmarker"),"typeofhelo",radius,delay in mins,[true,"ColorRed"]] execvm "scripts\ghst_helosupport.sqf";
//ghst_helosupport = [(getmarkerpos "helo_support"),"B_Heli_Attack_01_F",300,30,[true,"ColorRed"]] execvm "scripts\ghst_helosupport.sqf";

//if (!isServer) exitWith {};

_spawnmark = _this select 0;// spawn point where helo spawns and deletes
_type = _this select 1;// type of helo to spawn i.e. "B_Heli_Attack_01_F"
_tos = (_this select 2) * 60;// time on station
_rad = _this select 3;// radius helo will search
_delay = (_this select 4) * 60;// time before air support can be called again
_markunitsarray = _this select 5;//marks waypoints of helo
	_markunits = _markunitsarray select 0;
	_mcolor = _markunitsarray select 1;


if (player getVariable "ghst_helosup") exitwith {player groupchat "Air Support Busy";};

_flyheight = 150;
openMap true;
_veh_name = getText (configFile >> "cfgVehicles" >> (_type) >> "displayName");

player groupchat "Left click on the map where you want the helicopter to go or press escape to cancel";

mapclick = false;

onMapSingleClick "clickpos = _pos; mapclick = true; onMapSingleClick """";true;";

waituntil {mapclick or !(visiblemap)};
if (!visibleMap) exitwith {
	hint "Air Support Ready";
	};
	
_pos = [clickpos select 0, clickpos select 1, _flyheight];

sleep 1;

openMap false;

_wGrp = createGroup WEST;
_dir = [_spawnmark, _pos] call BIS_fnc_dirTo;

_air1 = createVehicle [_type,_spawnmark, [], 0, "FLY"];
_air1 setdir _dir;
_air1 setposatl [getposatl _air1 select 0, getposatl _air1 select 1, _flyheight];

_crew = [_air1, _wGrp] call BIS_fnc_SpawnCrew;

player setVariable ["ghst_helosup", true];
//publicvariable "ghst_helosup";
//[[_air1, _delay, _tos],"fnc_ghst_helosup",false,false] spawn BIS_fnc_MP;

sleep 1;

_air1 flyinheight _flyheight;
_air1 setSpeedMode "Normal";
//set combat mode
_wGrp setCombatMode "RED";

_air1 sidechat "I am inbound";

[_wGrp,_pos, [_rad,_rad],_markunitsarray,["COMBAT", "NORMAL", "WEDGE"]] call fnc_ghst_waypoints;
	
_t = time;//current time

While {time < (_t + _tos) and (fuel _air1 > 0.25)} do {
if (!(alive _air1) or !(canMove _air1)) exitwith {player groupchat "Shit we lost air support";};
if !(someAmmo _air1) exitwith {player groupchat "Out of ammo";};
sleep 10;
};

if ((alive _air1) and (canMove _air1)) then {

_wGrp addwaypoint [_spawnmark, 0];
[_wGrp, 4] setWPPos _spawnmark;
[_wGrp, 4] setWaypointType "MOVE";
[_wGrp, 4] setWaypointBehaviour "CARELESS";
_wGrp setCurrentWaypoint [_wGrp, 4];
		if (_markunits) then {
		_mtext = format ["%1 Waypoint %2",_wGrp, _w];
		[_spawnmark,_mcolor,_mtext] call fnc_ghst_mark_point;
		};

_air1 sidechat "Need to resupply heading home";

waituntil {((getpos _air1) distance _spawnmark) < (_flyheight * 2)};
{deletevehicle _x} foreach crew _air1;
deletevehicle _air1;

} else {

{deletevehicle _x} foreach crew _air1;
//deletevehicle _air1;

};
sleep 20;
deletegroup _wGrp;

sleep _delay;

hint format ["%1 Support Ready", _veh_name];

player setVariable ["ghst_helosup", false];

if (true) exitwith {};
