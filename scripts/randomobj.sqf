/*
V1.5 By: Ghost  
selects random obj to spawn. ghst_randomobj = [] execvm "scripts\randomobj.sqf";
*/

if (!isserver) exitwith {};

//_sizex_inc = _this select 0;//size to increase objective area
//_sizey_inc = _this select 1;//size to increase objective area

if (count ghst_objarray == 0) exitwith {finish = true; publicvariable "finish"; diag_log format ["TASK LOCATIONS END %1", ghst_objarray];};

_ghst_side = ghst_side;

//diag_log format ["TASK LOCATIONS %1", ghst_objarray];

_loop = true;
_locarray = [];
private ["_locselpos","_locselname"];
While {_loop} do {

	//Select one random location and spawn objective
	_idx = floor(random count ghst_objarray);
	_locsel = ghst_objarray select _idx;
	ghst_objarray set [_idx,-1];
	ghst_objarray = ghst_objarray - [-1];
	_locselname = text _locsel;//get name of location
	_locselpos = locationPosition _locsel;//get position of location
	//_locselsize = size _locsel;//get size of position

	//_loc_sizex = ((_locselsize select 0) * _sizex_inc);//multiply specified amount by x radius
	//_loc_sizey = ((_locselsize select 1) * _sizey_inc);//multiply specified amount by y radius
		if (!(isnil "_locselpos") and !(_locselname in ["Sagonisi"])) exitwith {
			_loop = false;
			_locarray = _locarray + [_locselpos];
		};
};

if (isnil "_locselpos") exitwith {finish = true; publicvariable "finish"; diag_log format ["TASK LOCATIONS END PAST LOOP %1", ghst_objarray];};
/*
//random boat patrol
if (round (random 10) > 5) then {
	_eboatspawn1 = [(getmarkerpos "center"),[15000,15000],3,_ghst_side,[false,"ColorRed"],((paramsArray select 3)/10)] execVM "scripts\eboatspawn.sqf";
	waituntil {scriptDone _eboatspawn1};
};
*/
private ["_area_size","_helo_area_size","_enemy_house","_enemy_patrols","_enemy_squadsize","_enemy_vehicles"];

_ghst_side = ghst_side;
_area_size = 500;
_helo_area_size = [700,700];
_enemy_house = [50,30];
_enemy_patrols = (4 + round(random 2));
_enemy_squadsize = (3 + round(random 3));
_enemy_vehicles = (3 + round(random 3));

if (count playableunits < 8) then {

	_enemy_house = [40,20];
	_enemy_patrols = (3 + round(random 2));
	//_enemy_squadsize = (3 + round(random 3));
	_enemy_vehicles = (3 + round(random 2));

};

if ((_locselname == "Kavala") or (_locselname == "Aggelochori")) then {

	_enemy_house = [60,40];
	//_enemy_patrols = (4 + round(random 2));
	//_enemy_squadsize = (3 + round(random 3));
	//_enemy_vehicles = (3 + round(random 3));

};


_ghst_fillbuild3 = [_locselpos,_area_size,_ghst_side,_enemy_house,[false,"ColorRed"],((paramsArray select 3)/10),false,false] execVM "scripts\ghst_fillbuild3.sqf";

//waitUntil {scriptDone _ghst_fillbuild3};

//external scripts to spawn enemy around objective
_espawn = [_locselpos,[_area_size,_area_size,(random 360)],_enemy_patrols,_enemy_patrols,_ghst_side,[false,"ColorRed"],((paramsArray select 3)/10),false] execVM "scripts\espawn.sqf";

//waitUntil {scriptDone _espawn};

_ghst_roofmgs = [_locselpos,_area_size,[false,"Colorblack"],_ghst_side,((paramsArray select 3)/10)] execVM "scripts\ghst_roofmgs.sqf";

_eveh_sentry_spawn = [_locselpos,[_area_size,_area_size],_enemy_vehicles,_ghst_side,[false,"ColorRed"],((paramsArray select 3)/10)] execVM "scripts\eveh_sentry_spawn.sqf";

//waitUntil {scriptDone _eveh_sentry_spawn};

//random enemy helo
if (round (random 10) > 5) then {
	waituntil {!(isnil "ghst_attack_heli_list")};
	_attack_heli_list = ghst_attack_heli_list;
	_ghst_eair = [_locselpos,_locselpos,_helo_area_size,[_attack_heli_list],300,1,_ghst_side,[false,20],[false,"ColorRed"]] execVM "scripts\eair.sqf";
};

_ghst_civcars = [_locselpos,800,18,true,false,WEST] execVM "scripts\ghst_civcars.sqf";

_ghst_mines = [_locselpos,800,10,_ghst_side,[false,"ColorBlack"]] execvm "scripts\ghst_mines.sqf";

//_ghst_ieds = [_locselpos,800,10,WEST,[false,"ColorRed"]] execvm "scripts\ghst_ieds.sqf";

//random objective script
_ghst_random_objectives = [_locarray,[_area_size,_area_size],(paramsArray select 4),(getmarkerpos "pow_rescue"),_locselname] execVM "scripts\objectives\ghst_random_objectives.sqf";

//random island patrols and vehicle sentry
//_eveh_sentry_spawn1 = [(getmarkerpos "center"),[1000,2400,35],2,_ghst_side,[false,"ColorRed"],((paramsArray select 3)/10)] execVM "scripts\eveh_sentry_spawn.sqf";

//_patrol1 = [(getmarkerpos "center"),[1000,2400,35],5,4,_ghst_side,[false,"ColorRed"],((paramsArray select 3)/10),false] execVM "scripts\espawn.sqf";

if ((paramsArray select 6) == 1) then {
	waituntil {!(isnil "ghst_transport_heli_list")};
	_transport_heli_list = ghst_transport_heli_list;
_ghst_epara = [_locselpos,[_area_size,_area_size],_transport_heli_list,true,[false,"ColorRed"],((paramsArray select 3)/10)] execVM "scripts\eparadrop.sqf";
};