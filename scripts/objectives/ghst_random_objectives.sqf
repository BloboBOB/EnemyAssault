//V1.2.2 - By Ghost modified
//Randomly selects and generates objectives. Requires funciton module.
//ghst_random_objectives = [_random_pos,_marksizex_inc,2,_campmark] execVM "scripts/ghst_random_objectives.sqf";

if (!isserver) exitwith {};
waitUntil{!(isNil "BIS_fnc_init")};

//check to see if there are multiple positions

_position_array = _this select 0;//center position for objectives
_radarray = _this select 1;//radius around center position e.g. [30,40]
_numobjs = _this select 2;//number of random objectives
_campmark = _this select 3;//location where camp site is
_locselname = _this select 4;//name of location

//list of objectives
_objlist = ["leader","rescue","ARTY","ammo","intel","ZSU_AA2","comtower","leader2","intel2","rescue2","ZSU_AA","tower","ammo2","intel3","leader3","ammo3","Bombtruck","leader4","ARTY2"];
//["leader","rescue","ARTY","ammo","intel","crash","ZSU_AA2","comtower","leader2","intel2","rescue2","ZSU_AA","tower","ammo2","intel3","leader3","ammo3","Bombtruck","leader4","ARTY2"];

_commanderlist = ghst_commanderlist;
_transport_heli_list = ghst_transport_heli_list;
_ammobox_list = ghst_ammobox_list;
_ghst_side = ghst_side;

//empty array for objects to be put into for script later on
ghst_Build_objs = [];

private ["_random_pos"];

//select specified number of random objectives
for "_o" from 1 to (_numobjs) do {
	//select a position
		_idx = floor(random count _position_array);
		_random_pos = _position_array select _idx;
		//_position_array set [_idx,-1];
		//_position_array = _position_array - [-1];

	//select random objective from list
	_r =  floor(random count _objlist);
	_objsel = _objlist select _r;
	//_objsel = _objlist call BIS_fnc_selectRandom;
	_objlist = _objlist - [_objsel];
	switch (_objsel) do
		{   
			case "leader":
			{
			[_random_pos,_radarray,_commanderlist,_locselname,_ghst_side] execVM "scripts\objectives\ghst_assasinate.sqf";
			};
			case "leader2":
			{
			[_random_pos,_radarray,_commanderlist,_locselname,_ghst_side] execVM "scripts\objectives\ghst_assasinate.sqf";
			};
			case "leader3":
			{
			[_random_pos,_radarray,_commanderlist,_locselname,_ghst_side] execVM "scripts\objectives\ghst_assasinate.sqf";
			};
			case "leader4":
			{
			[_random_pos,_radarray,_commanderlist,_locselname,_ghst_side] execVM "scripts\objectives\ghst_assasinate.sqf";
			};
			case "intel":
			{
			[_random_pos,_radarray,_locselname] execVM "scripts\objectives\ghst_intel.sqf";
			};
			case "intel2":
			{
			[_random_pos,_radarray,_locselname] execVM "scripts\objectives\ghst_intel.sqf";
			};
			case "intel3":
			{
			[_random_pos,_radarray,_locselname] execVM "scripts\objectives\ghst_intel.sqf";
			};
			//not used
			case "clear":
			{
			[_random_pos,_radarray,_locselname,_ghst_side] execVM "scripts\objectives\ghst_clear.sqf";
			};
			case "rescue":
			{
			[_random_pos,_radarray,_campmark,"B_Helipilot_F",_locselname] execVM "scripts\objectives\ghst_rescue.sqf";
			};
			case "rescue2":
			{
			[_random_pos,_radarray,_campmark,"B_officer_F",_locselname] execVM "scripts\objectives\ghst_rescue.sqf";
			};
			case "crash":
			{
			_crasharray = ["Land_Wreck_Heli_Attack_01_F","Land_Wreck_Plane_Transport_01_F"];
			_crashsel = _crasharray call BIS_fnc_selectRandom;
			[_random_pos,_radarray,_crashsel,[15,15],((paramsArray select 3)/10),_locselname,[true,"ColorRed",[200,200]],_ghst_side] execVM "scripts\objectives\ghst_randomcrash.sqf";
			};
			case "tower":
			{
			_buildarray = ["Land_TTowerBig_2_F","Land_TTowerBig_1_F"];
			[(getmarkerpos "center"),13000,_buildarray,[200,200],[2,3],_ghst_side,((paramsArray select 3)/10),[true, _transport_heli_list]] execVM "scripts\objectives\ghst_randombuild.sqf";
			};
			case "ammo":
			{
			[_random_pos,_radarray,_ammobox_list,_locselname] execVM "scripts\objectives\ghst_objin_build.sqf";
			};
			case "ammo2":
			{
			[_random_pos,_radarray,_ammobox_list,_locselname] execVM "scripts\objectives\ghst_objin_build.sqf";
			};
			case "ammo3":
			{
			[_random_pos,_radarray,_ammobox_list,_locselname] execVM "scripts\objectives\ghst_objin_build.sqf";
			};
			//not used
			case "seawreck":
			{
			_wreckarray = ["Land_UWreck_FishingBoat_F","Land_Wreck_Traw2_F","Land_Wreck_Traw_F","Land_UWreck_MV22_F","Land_UWreck_Heli_Attack_02_F"];//"Land_UWreck_FishingBoat_F","Land_Wreck_Traw2_F","Land_Wreck_Traw_F","Land_UWreck_MV22_F","Land_UWreck_Heli_Attack_02_F"
			//"UWreck_base_F"
			[(getmarkerpos "center"),11000,_wreckarray,[100,100],[3,2],_ghst_side,((paramsArray select 3)/10)] execVM "scripts\objectives\ghst_randomwreck.sqf";
			};
			case "ZSU_AA":
			{
			[_random_pos,_radarray,"O_APC_Tracked_02_AA_F",true,((paramsArray select 3)/10),_locselname,[true,"ColorRed",[200,200]],_ghst_side] execVM "scripts\objectives\ghst_randomloc.sqf";
			};
			case "ZSU_AA2":
			{
			[_random_pos,_radarray,"O_APC_Tracked_02_AA_F",true,((paramsArray select 3)/10),_locselname,[true,"ColorRed",[200,200]],_ghst_side] execVM "scripts\objectives\ghst_randomloc.sqf";
			};
			case "ARTY":
			{
			[_random_pos,_radarray,"O_MBT_02_arty_F",true,((paramsArray select 3)/10),_locselname,[true,"ColorRed",[200,200]],_ghst_side] execVM "scripts\objectives\ghst_randomloc.sqf";
			};
			case "ARTY2":
			{
			[_random_pos,_radarray,"O_MBT_02_arty_F",true,((paramsArray select 3)/10),_locselname,[true,"ColorRed",[200,200]],_ghst_side] execVM "scripts\objectives\ghst_randomloc.sqf";
			};
			case "comtower":
			{
			_towers = ["Land_Communication_F","Land_TTowerSmall_1_F"];
			_towersel = _towers call BIS_fnc_selectRandom;
			[_random_pos,_radarray,_towersel,true,((paramsArray select 3)/10),_locselname,[true,"ColorRed",[200,200]],_ghst_side] execVM "scripts\objectives\ghst_randomloc.sqf";
			};
			case "Bombtruck":
			{
			_devices = ["O_Truck_03_device_F","Land_Device_assembled_F","Land_Device_disassembled_F"];
			_devicesel = _devices call BIS_fnc_selectRandom;
			[_random_pos,_radarray,_devicesel,true,((paramsArray select 3)/10),_locselname,[true,"ColorRed",[200,200]],_ghst_side] execVM "scripts\objectives\ghst_randomloc.sqf";
			};
		};
	sleep 3;
};

sleep 5;
//send all objects to buildings that are in array ghst_Build_objs
[_random_pos,_radarray,ghst_Build_objs,[true,"ColorRed",[100,100]],[3,7,_ghst_side],((paramsArray select 3)/10),false] execVM "scripts\objectives\ghst_PutinBuild.sqf";

sleep 60;
//check for all tasks complete and activate end variable.
_curtasks = [];
{_curtasks = _curtasks + [(_x select 0)];} foreach SHK_Taskmaster_Tasks;

While {true} do {
	{if (_x call SHK_Taskmaster_isCompleted) then {_curtasks = _curtasks - [_x];};} foreach _curtasks;
	if (count _curtasks == 0) exitwith {[_random_pos,1000] call ghst_cleanUp;};
	if (count alldead > 50) then {call fnc_ghst_cleanup;};
	_randnum = round (random 10);
	sleep 10;
	if ((_ghst_side countSide allunits < 45) and (_randnum > 8) and (count _curtasks > 0)) then {[_random_pos,_radarray,_transport_heli_list,false,[false,"ColorRed"],((paramsArray select 3)/10)] execVM "scripts\eparadrop.sqf";
	};
	if ((_ghst_side countSide allunits < 45) and (_randnum > 6) and (count _curtasks > 0)) then {[_random_pos,[2000,2000],(_radarray select 0),(2 + (floor (random 1))),[false,"ColorRed"],((paramsArray select 3)/10)] execvm "scripts\ghst_ecounter.sqf";
	};
	sleep 10;
};