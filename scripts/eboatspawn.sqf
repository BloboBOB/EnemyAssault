/*
Ver 1 - By: Ghost   Randomly creates different types of boats to patrol area .
_eboatspawn = [[1,1,2] or "marker",[wpradius_X,wpradius_Y,dir],grpnum,EAST,[true,"ColorRed"],aiaccuracy] execVM "scripts\eboatspawn.sqf";
*/
if !(isServer) exitWith {};

_position_mark = _this select 0;//position or marker
_radarray = _this select 1;//radius array around position and Direction [300,300,53]
_grpnum = _this select 2;
_sideguards = _this select 3;//side of guards
_markunitsarray = _this select 4;
	_markunits = _markunitsarray select 0;
	_mcolor = _markunitsarray select 1;
#define aiSkill _this select 5//sets AI accuracy and aiming speed

//Unit list to randomly select and spawn - Edit as needed
//#include "unit_list.sqf"
_menlist = ghst_crewmenlist;
_boatlist = ghst_patrolboatlist;

for "_x" from 0 to (_grpnum)-1 do {

	_pos = [_position_mark,_radarray,true] call fnc_ghst_rand_position;

	_veh = _boatlist call BIS_fnc_selectRandom;
	_boat1 = createVehicle [_veh,_pos, [], 0, "NONE"];
	_eGrp = createGroup _sideguards;

	_crew = [_boat1, _eGrp] call BIS_fnc_SpawnCrew;
	
	//set combat mode
	_eGrp setCombatMode "RED";

	for "_w" from 0 to (3) do {

		_wppos = [_position_mark,_radarray,true] call fnc_ghst_rand_position;
		
		_eGrp addwaypoint [_wppos, 10];
		//create markers for units
		if (_markunits) then {
		_markname = str(_wppos);
		_mark1 = createMarker [_markname, _wppos];
		_mark1 setMarkerShape "ICON";
		_mark1 setmarkertype "mil_dot";
		_mark1 setmarkercolor _mcolor;
		_mark1 setmarkertext format ["%1 Waypoint %2",_egrp, _w];
		};
		[_eGrp, _w] setWPPos _wppos;
			if (_w == 3) then {
				[_eGrp, _w] setWaypointType "CYCLE";
				[_eGrp, _w] setWaypointStatements ["true", "vehicle this setFuel 0.7; vehicle this setVehicleAmmo 0.7;"];
			} else {
				[_eGrp, _w] setWaypointType "SAD";
			};
		//[_eGrp, _w] setWaypointSpeed "LIMITED";
		[_egrp, _w] setWaypointTimeout [10, 30, 60];
		[_egrp, _w] setWaypointCompletionRadius 50;
		sleep 0.1;
	};
	
	sleep 2;
	
};

if (true) exitWith {};