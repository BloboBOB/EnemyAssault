/*
V1.1 by: Ghost
creates set number of groups of up to 8 units in a random location around a designated area in water
ghst_ediverspawn = [[1,1,2] or "marker",[wpradius_X,wpradius_Y,direction] if not a marker,grpnum,sqdnum,east,[true,"ColorRed"],aiaccuracy,true] execVM "scripts\ediverspawn.sqf";
*/
if !(isServer) exitWith {};

_patrol_mark = _this select 0;//position or marker
_radarray = _this select 1;
_grpnum = _this select 2;
_sqdnum = _this select 3;
_sideguards = _this select 4;//side of guards
_markunitsarray = _this select 5;
	_markunits = _markunitsarray select 0;//true to mark units
	_mcolor = _markunitsarray select 1;//marker color
#define aiSkill _this select 6//sets AI accuracy and aiming speed
_respawn = _this select 7;//respawn group when dead

//Unit list to randomly select and spawn - Edit as needed
//#include "unit_list.sqf"
_menlist = ghst_diverlist;

//Do not edit below this line unless you know what you are doing//
/////////////////////////////////////////////////////

for "_t" from 0 to (_grpnum)-1 do {

_eGrp = createGroup _sideguards;

	_spawnpos = [_patrol_mark,_radarray,true] call fnc_ghst_rand_position;
	_spawnposasl = ATLtoASL _spawnpos;
	_randomz = random (_spawnposasl select 2);
	_spawnposasl = [_spawnposasl select 0, _spawnposasl select 1, _randomz];

	for "_x" from 0 to ceil(random _sqdnum)+1 do {

		_mansel = _menlist call BIS_fnc_selectRandom;
		_man = [_spawnposasl,_egrp,_mansel,aiSkill] call fnc_ghst_create_unit;

		sleep 0.2;
	};
	
//set combat mode
_eGrp setCombatMode "RED";

	for "_w" from 0 to (3) do {
	
		_wppos = [_patrol_mark,_radarray,true] call fnc_ghst_rand_position;
		_wpposasl = ATLtoASL _wppos;
		_randomz = random (_wpposasl select 2);
		_wpposasl = [_wpposasl select 0, _wpposasl select 1, _randomz];
			
		_egrp addwaypoint [_wpposasl, 10];
		[_egrp, _w] setWPPos _wpposasl;
			if (_w == 3) then {
				[_egrp, _w] setWaypointType "CYCLE";
			} else {
				[_egrp, _w] setWaypointType "SAD";
			};
		[_egrp, _w] setWaypointSpeed "LIMITED";
		[_egrp, _w] setWaypointFormation "STAG COLUMN";
		[_egrp, _w] setWaypointTimeout [10, 30, 60];
		sleep 0.1;

		//create markers for units
		if (_markunits) then {
		_mtext = format ["%1 Waypoint %2",_egrp, _w];
		_mark1 = [_wpposasl,_mcolor,_mtext] call fnc_ghst_mark_point;
		};
	};
	
	//repspawn groups when all untis are dead
	if (_respawn) then {

		[_eGrp, _spawnposasl, _menlist, _sqdnum, aiSkill] spawn {

			_eGrp = _this select 0;
			_spawnposasl = _this select 1;
			_menlist = _this select 2;
			_sqdnum = _this select 3;
			_aiSkill = _this select 4;
			
			while {true} do {
			
				if (count units _eGrp == 0) then {
				
					sleep 600;
			
					for "_x" from 0 to ceil(random _sqdnum)+1 do {

					_mansel = _menlist call BIS_fnc_selectRandom;
					_man = [_spawnposasl,_egrp,_mansel,aiSkill] call fnc_ghst_create_unit;

					sleep 0.2;
					};
				};
				
				sleep 60;
			};
		};
	};
	
};

if (true) exitWith {};