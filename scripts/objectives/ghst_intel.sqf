//1.1 By: Ghost - spawns intel to be gathered
if (!isserver) exitwith {};
waitUntil{!(isNil "BIS_fnc_init")};

_position_mark = _this select 0;//position to search buildings around
_rad = _this select 1;//radius around position to search for buildings
_locselname = _this select 2;//name of location

//array of available intel objects
_intelarray = ["Land_Suitcase_F"];//,"Land_Laptop_unfolded_F","Land_Laptop_F","Land_FilePhotos_F","Land_File1_F","Land_File2_F"

//create random number
_rnum = str(round (random 999));

//select random intel
_intelsel = _intelarray call BIS_fnc_selectRandom;

//create intel
_intelobj = createVehicle [_intelsel,_position_mark, [], 0, "NONE"];
_veh_name = getText (configFile >> "cfgVehicles" >> (_intelsel) >> "displayName");
_VarName = ("ghst_intel" + _rnum);
_intelobj setVehicleVarName _VarName;
//_intelobj Call Compile Format ["%1=_This;",_VarName];
missionNamespace setVariable [_VarName,_intelobj];
publicVariable _VarName;

//create task
_tsk = "ghst_intel" + _rnum;
_tasktopic = format ["Find %1 in %2", _veh_name,_locselname];
_taskdesc = format ["Search the buildings in %2 for %1. Pay attention to the floors.", _veh_name,_locselname];
[_tsk,_tasktopic,_taskdesc,true,[],"created",_position_mark] call SHK_Taskmaster_add;

//attaches addaction to object
[[_intelobj,_tsk],"fnc_ghst_intel",true,true] spawn BIS_fnc_MP;

//send intel to random building
//null0 = [_position_mark,_rad,[_intelobj],[false,"ColorGreen",false],[3,6,EAST],((paramsArray select 3)/10),false] execvm "scripts\objectives\ghst_PutinBuild.sqf";
ghst_Build_objs = ghst_Build_objs + [_intelobj];
