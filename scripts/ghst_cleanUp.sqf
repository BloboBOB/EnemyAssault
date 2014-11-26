/*
V1.3.1 By: Ghost - deletes all vehicles and units that are dead around given position and radius
ghst_cleanUp = [(getmarkerpos "mark1"),500] execvm "ghst_cleanUp.sqf";
*/

if !(isserver) exitwith {};

_objmark = _this select 0;//position
_rad = _this select 1;//radius around position

[["All Tasks Complete, RTB for new tasking"],"fnc_ghst_global_sidechat"] spawn BIS_fnc_MP;

while {true} do {
	if ({ isPlayer _x and _x distance _objmark > (_rad + 500) } count playableunits == count playableunits) exitwith {};
	//sleep 10;
};

{deletevehicle _x;} foreach ghst_mine_array;

{deletevehicle _x;} foreach ghst_ied_array;

{if ((faction _x == "IND_F") or (faction _x == "OPF_F") or (faction _x == "CIV_F")) then {deletevehicle _x;};} foreach (_objmark nearObjects ["ALL", _rad]);

//sleep 1;

{if (((side _x == east) or (side _x == independent)) and !(vehicle _x isKindOf "Plane_Base_F")) then {_x setdamage 1;};} foreach allunits;

//sleep 1;

{if !(alive _x) then {deletevehicle _x;};} foreach vehicles;

{deleteVehicle _x;} forEach allDead;

//sleep 20;

//delete empty groups
{deleteGroup _x;} foreach allGroups;

//sleep 10;

call ghst_randomobj;
