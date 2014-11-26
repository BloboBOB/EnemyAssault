waituntil {! isnull player};

_vehlist = execvm "scripts\vehiclelist.sqf";
_airlist = execvm "scripts\aircraftlist.sqf";
//_boatlist = execvm "scripts\boatlist.sqf";

#include "addnotes.sqf"

if (player iskindof "B_recon_JTAC_F") then {
[player,"AH99"] call BIS_fnc_addCommMenuItem;
player setVariable ["ghst_helosup", false];
[player,"A164"] call BIS_fnc_addCommMenuItem;
player setVariable ["ghst_cassup", false];
};

if (player iskindof "B_soldier_UAV_F") then {
[player,"UAV"] call BIS_fnc_addCommMenuItem;
player setVariable ["ghst_uavsup", false];
[player,"UGV"] call BIS_fnc_addCommMenuItem;
player setVariable ["ghst_ugvsup", 0];
[player,"PUAV"] call BIS_fnc_addCommMenuItem;
player setVariable ["ghst_puavsup", false];
//[player,"Artillery"] call BIS_fnc_addCommMenuItem;
};

if (player iskindof "B_Soldier_SL_F") then {
[player,"AMMO"] call BIS_fnc_addCommMenuItem;
player setVariable ["ghst_ammodrop", false];
[player,"PUAV"] call BIS_fnc_addCommMenuItem;
player setVariable ["ghst_puavsup", false];
};

//[player,"Transport"] call BIS_fnc_addCommMenuItem;

player setVariable ["dix_halojump", false];

//addactions for halo and vehspawn. Should ensure them showing even with jip
vehspawn addAction ["<t shadow='1' color='#FFA000'>Spawn Vehicle</t> <img color='#FFA000' shadow='1' image='\A3\armor_f_gamma\MBT_01\Data\UI\Slammer_M2A1_Base_ca.paa'/>", "dlg\ghst_spawnveh.sqf", ["veh_spawn",45], 6, true, true, "","alive _target"];
vehspawn setObjectTexture [0, "\A3\armor_f_gamma\MBT_01\Data\UI\Slammer_M2A1_Base_ca.paa"];

airspawn addAction ["<t shadow='1' color='#FFA000'>Spawn Aircraft</t> <img color='#FFA000' shadow='1' image='\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Plane_CAS_01_CA.paa'/>", "dlg\ghst_spawnair.sqf", ["air_spawn",135], 6, true, true, "","alive _target"];
airspawn setObjectTexture [0, "\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Plane_CAS_01_CA.paa"];

halo addAction ["<t shadow='1' color='#00ffff'>HALO</t> <img color='#00ffff' shadow='2' image='\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa'/>", "call ghst_fnc_halo", [false,1000,60,false], 5, true, true, "","alive _target"];

airport_teleport addAction ["<t shadow='1' color='#8904B1'>Move to Airport</t> <img color='#8904B1' shadow='1' image='\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Plane_CAS_01_CA.paa'/>", {player setposatl [getmarkerpos "spawn_board_2" select 0,getmarkerpos "spawn_board_2" select 1,0.2];}, [], 5, false, true, "","alive _target"];
airport_teleport setObjectTexture [0, "\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Plane_CAS_01_CA.paa"];


ghst_local_vehicles = [];
ghst_players = [];//["p1","p2","p3","p4","p5","p6","p7","p8","p9","p10","p11","p12"];
ghst_vehicles = ["uh80_1","uh80_2"];

[] spawn ghst_fnc_ptracker;

player addEventHandler ["Respawn", {call ghst_fnc_playeraddactions}];  
call ghst_fnc_playeraddactions;

//set weather
_delay = 86400;
waituntil {! isNil {missionNamespace getvariable "ghst_weather"}};

skipTime -24;
[_delay] call fnc_ghst_UpdateWeather;
skipTime 24;

sleep 1;

simulWeatherSync;

[] spawn ghst_fnc_vehicle_actioninit;

