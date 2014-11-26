//V1 By: Ghost - spawns enemy near player randomly as long as player is X distance from base and all players
//ghst_rand_espawn = [[(getmarkerpos "base"),base dist],[wpradius_X,wpradius_Y],sqdnum,east,[true,"ColorRed"],aiaccuracy,] execVM "scripts\ghst_rand_espawn.sqf";

if !(isServer) exitWith {};

_basearray = _this select 0;//base position
	_basepos = _basearray select 0;//base position
	_basedist = _basearray select 1;//dist from base
_radarray = _this select 1;//radius [300,300]
_sqdnum = _this select 2;//how many units in each group
_sideguards = _this select 3;//side of guards
_markunitsarray = _this select 4;
	_markunits = _markunitsarray select 0;//true to mark units
	_mcolor = _markunitsarray select 1;//marker color
#define aiSkill _this select 5//sets AI accuracy and aiming speed

//Unit list to randomly select and spawn - Edit as needed
_menlist = ghst_menlist;

while {true} do {

	private ["_playersel","_playerpos"];
	
	_playersel = (playableunits + switchableUnits) call BIS_fnc_selectRandom;
	
	if !(isnil "_playersel") then {

		_playerpos = getpos _playersel;
		
		if (((_playerpos distance _basepos) > _basedist) and !(surfaceIsWater _playerpos)) then {
		
			private ["_eGrp","_spawnpos"];
			
			_spawnpos = [_playerpos,_radarray] call fnc_ghst_rand_position;
			
			if (({ _x distance _spawnpos < ((_radarray select 0) - 100) } count (playableunits + switchableUnits)) == count (playableunits + switchableUnits)) exitwith {};
		
			_eGrp = createGroup _sideguards;
			
				if (_markunits) then {
					[_spawnpos,_mcolor,"RANDOM ESPAWN"] call fnc_ghst_mark_point;
				};

				for "_x" from 0 to ceil(random _sqdnum)+2 do {

					_mansel = _menlist call BIS_fnc_selectRandom;
					_man = [_spawnpos,_egrp,_mansel,aiSkill] call fnc_ghst_create_unit;

					sleep 0.2;
				};
			
			[_eGrp,_playerpos, _radarray,_markunitsarray,["AWARE", "FULL", "WEDGE"]] call fnc_ghst_waypoints;

				while {true} do {
				
					if (({ _x distance (getpos leader _eGrp) > _basedist } count (playableunits + switchableUnits)) == count (playableunits + switchableUnits)) exitwith {{deletevehicle _x} foreach units _egrp; sleep 20; deleteGroup _egrp;};
					
					if (count units _eGrp == 0) exitwith {sleep 20; deleteGroup _egrp;};
					
					sleep 10;
				};
			
			sleep 600 + (random 300);
		
		};
	};
	
	sleep 10;

};