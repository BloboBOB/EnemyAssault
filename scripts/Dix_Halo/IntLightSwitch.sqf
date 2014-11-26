/* Intlight by Dixon: calls the Interior light on or off, the following line need to be on your C130.
nul = [this] execVM "scripts\Dix_Halo\IntLightSwitch.sqf";
*/

_aircraft = [_this,0,objNull,[objNull]] call BIS_fnc_param;

IntLight = {
	if (driver _target != (player)) exitWith{false};
	if (!(_target getVariable ["Light_available",true])) exitWith{false};
	if (true) exitWith{true};
};

IntLight1 = {
	if (driver _target != (player)) exitWith{false};
	if (_target getVariable ["Light_available",true]) exitWith{false};
	if (isEngineOn _target) exitWith{true};
	if (true) exitWith{true};
};

_IntON = _aircraft addaction ["<t color='#8080ff'>Interior Light ON","Scripts\Dix_Halo\IntLightON.sqf",[],20,false,true,"","[] call IntLight"];
_IntOff = _aircraft addaction ["<t color='#8080ff'>Interior Light OFF","(_this select 0) setVariable ['Light_available',true,true]",[],2,false,true,"","[] call IntLight1"];