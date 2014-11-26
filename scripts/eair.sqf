//V1.8 by: Ghost
/*
Spawn Enemy Air patrols
ghst_eair = [getMarkerPos "spawnmarker",getMarkerPos "centermarker",["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F"], 2,EAST,[true,Delay in mins],[true/false for mark waypoints,,"ColorRed"]] execvm "eair.sqf";
[(getmarkerpos "eairspawn"),(getmarkerpos "center"),[2500,2500],["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F"], 2,EAST,[true,10],[true,"ColorRed"]] execvm "scripts\eair.sqf";
*/
if !(isserver) exitwith {};

_spawnmarker = _this select 0;//spawn point
_centermarker = _this select 1;//center point
_radarray = _this select 2;//radius around center point [2500,2500]
	_radx = _radarray select 0;//radius A
	_rady = _radarray select 1;//radius B
_air_typearray = _this select 3;//vehicle type array ["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F"]
_flyheight = _this select 4;//fly height
_airqty = _this select 5;//how many to spawn rg 2,3
_sideguards = _this select 6;//side of guards
_rspawn = _this select 7;//respawn array
	_dorspawn = _rspawn select 0;//true for respawn
	_minrspawn = ((_rspawn select 1) * 60);//delay in mins minimum till respawn
_markunitsarray = _this select 8;
	_markwps = _markunitsarray select 0;
	_mcolor = _markunitsarray select 1;

_dir = [_spawnmarker, _centermarker] call BIS_fnc_dirTo;

_egrp = createGroup _sideguards;

for "_x" from 0 to (_airqty) - 1 do {

	_air_type = _air_typearray call BIS_fnc_selectRandom;
	_air1 = createVehicle [_air_type,_spawnmarker, [], 0, "FLY"];
	_air1 setdir _dir;
	_air1 setpos [(getpos _air1 select 0), (getpos _air1 select 1), (_flyheight * 2)];
	_crew = [_air1, _egrp] call BIS_fnc_SpawnCrew;
	sleep 1;
	_air1 flyinheight _flyheight;
	_air1 setSpeedMode "NORMAL";
	
	sleep 0.2;
};
//set combat mode
_eGrp setCombatMode "RED";

[_eGrp,_centermarker,_radarray,_markunitsarray,["AWARE", "NORMAL", "WEDGE"]] call fnc_ghst_waypoints;

sleep 5;

while {count units _egrp > 0} do {
	{if (alive _x) then {
		_x setfuel 1;
		_x setVehicleAmmo 1;
	};} foreach units _egrp;
sleep 600;
};
hint "air dead";
sleep 30;

deletegroup _egrp;

if (_dorspawn) then {

sleep round(random _minrspawn) + _minrspawn;

[_spawnmarker,_centermarker,_radarray,_air_typearray,_flyheight,_airqty,_sideguards,_rspawn,_markunitsarray] execvm "scripts\eair.sqf";

};

if (true) exitwith {};