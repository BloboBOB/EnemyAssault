//V1.2.2 By: Ghost
//Selects random wreck type and spawns ammobox or intel near it
//[_position_mark,_rad,["Land_UWreck_FishingBoat_F","Land_Wreck_Traw2_F","Land_Wreck_Traw_F"],300,[2,3],EAST,((paramsArray select 3)/10)] execvm "scripts\objectives\ghst_randomwreck.sqf";

if (!isserver) exitwith {};
waitUntil{!(isNil "BIS_fnc_init")};

_position_mark = _this select 0;//position
_wreckrad = _this select 1;//radius around position to search for buildings
_objarray = _this select 2;//wrecks to select randomly e.g. "Land_Wreck_Traw2_F"
_patrol_rad = _this select 3;//radius around obj to have guards
_patrol_num = _this select 4;//patrol number [number of patrols, number in group]
	_patrol_group = _patrol_num select 0;//number of patrols
	_patrol_sqd = _patrol_num select 1;//number of units in each patrol
_side = _this select 5;//side of enemy
#define aiSkill _this select 6//sets AI accuracy and aiming speed


//create random number and add to task
_rnum = str(ceil (random 999));

_tsk = "ghst_wreck" + _rnum;

//array of available intel objects
_intelarray = ["Land_Suitcase_F"];
_ammobox_list = ghst_ammobox_list;

//Unit list to randomly select and spawn - Edit as needed
//#include "unit_list.sqf"
_menlist = ghst_diverlist;
_boatlist = ghst_patrolboatlist;

_wreckobj = _objarray call BIS_fnc_selectRandom;

//get all wrecks around position of set radius
//_nearobjs = _position_mark nearObjects [_wreckobj, _wreckrad];
_posatl = [(getmarkerpos "center"),[_wreckrad,_wreckrad,(random 360)],true] call fnc_ghst_rand_position;
_selobj = createVehicle [_wreckobj,_posatl, [], 0, "NONE"];
_selobj setposatl [_posatl select 0, _posatl select 1, 0];

//_selobj = _nearobjs call BIS_fnc_selectRandom;

_wreckposatl = [(getposatl _selobj select 0), (getposatl _selobj select 1), 0];

_wreck_name = getText (configFile >> "cfgVehicles" >> (_wreckobj) >> "displayName");

	//create units as guards
	_eGrp = createGroup _side;
	for "_g" from 0 to ceil(random 5)+2 do {
		_posatl = [_wreckposatl,[15,15,(random 360)],true] call fnc_ghst_rand_position;
		_posasl = ATLtoASL _posatl;
		_randomz = random (_posasl select 2);
		_posasl = [_posasl select 0, _posasl select 1, _randomz];
		_mansel = _menlist call BIS_fnc_selectRandom;
		_unit1 = [_posasl,_egrp,_mansel,aiSkill] call fnc_ghst_create_unit;
		_unit1 setposasl _posasl;
		_unit1 setFormDir (random 360);
		sleep 0.03;
	};
	
	//create boats
	for "_b" from 0 to ceil(random 2)+1 do {
	
		_ebGrp = createGroup _side;
		
		_posatl = [_wreckposatl,[200,200,(random 360)],true] call fnc_ghst_rand_position;

		_veh = _boatlist call BIS_fnc_selectRandom;
		_boat1 = createVehicle [_veh,_posatl, [], 0, "NONE"];

		_crew = [_boat1, _ebGrp] call BIS_fnc_SpawnCrew;
		
		//set combat mode
		_ebGrp setCombatMode "RED";
		
		sleep 0.03;
	};
	
	//create random mines
	for "_m" from 0 to ceil(random ((_patrol_rad select 0) / 10))+2 do {
		_posatl = [_wreckposatl,_patrol_rad,true] call fnc_ghst_rand_position;
		//_posasl = ATLtoASL _posatl;
		_mine = createMine ["UnderwaterMine", _posatl, [], 0];
		//_mine setposatl [getposatl _mine select 0, getposatl _mine select 1, -1];
		sleep 0.03;
	};
	
//create random patrols
ediverspawn = [_wreckposatl,_patrol_rad,_patrol_group,_patrol_sqd,_side,[false,"ColorRed"],aiSkill,false] execVM "scripts\ediverspawn.sqf";

//choose random task, intel or destroy obj
if (floor (random 10) > 5) then {

	//select random intel
	_intelsel = _intelarray call BIS_fnc_selectRandom;

	//create intel
	_posatl = [_wreckposatl,[15,15,(random 360)],true] call fnc_ghst_rand_position;
	_intelobj = createVehicle [_intelsel,_posatl, [], 0, "NONE"];
	_veh_name = getText (configFile >> "cfgVehicles" >> (_intelsel) >> "displayName");
	//_intelobj setposasl [getposasl _intelobj select 0, getposasl _intelobj select 1, 0];
	//_intelobj setVectorUP (surfaceNormal [(getposasl _intelobj) select 0,(getposasl _intelobj) select 1]);
	_VarName = ("ghst_intel" + _rnum);
	_intelobj setVehicleVarName _VarName;
	//_intelobj Call Compile Format ["%1=_This;",_VarName];
	missionNamespace setVariable [_VarName,_intelobj];
	publicVariable _VarName;
	//_veh_name = name _intelobj;
	
	//create task
	_tasktopic = format ["Find Underwater %1", _veh_name];
	_taskdesc = format ["Search the ocean area for %1.  Pay attention to the wrecks.", _veh_name];
	[_tsk,_tasktopic,_taskdesc,true,[],"created",_wreckposatl] call SHK_Taskmaster_add;

	//attaches addaction to object
	[[_intelobj,_tsk],"fnc_ghst_intel",true,true] spawn BIS_fnc_MP;

} else {

	_posatl = [_wreckposatl,[15,15,(random 360)],true] call fnc_ghst_rand_position;
	_obj = createVehicle [_ammobox_list,_posatl, [], 0, "NONE"];
	_obj setposatl [_posatl select 0, _posatl select 1, 0];
	_veh_name = getText (configFile >> "cfgVehicles" >> (_ammobox_list) >> "displayName");
	_VarName = ("ghst_obj" + _rnum);
	_obj setVehicleVarName _VarName;
	//_obj Call Compile Format ["%1=_This;",_VarName];
	missionNamespace setVariable [_VarName,_obj];
	publicVariable _VarName;

	//create task
	_tasktopic = format ["Locate Underwater %1", _veh_name];
	_taskdesc = format ["Locate and destroy %1 found around ocean area", _veh_name];
	[_tsk,_tasktopic,_taskdesc,true,[],"created",_wreckposatl] call SHK_Taskmaster_add;

	//create trigger for object being destroyed
	_trig1stat = format ["!(alive %1)",_obj];
	_trig1act = format ["[""%1"",'succeeded'] call SHK_Taskmaster_upd;", _tsk];
	_trg1=createTrigger["EmptyDetector",_wreckposatl];
	_trg1 setTriggerArea[0,0,0,false];
	_trg1 setTriggerActivation["NONE","PRESENT",false];
	_trg1 setTriggerStatements[_trig1stat,_trig1act, "deleteVehicle thistrigger;"];

};