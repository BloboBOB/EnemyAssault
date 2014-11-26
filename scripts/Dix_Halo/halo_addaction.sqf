_soldier = _this select 0;
_C130 = vehicle _soldier;
If (_soldier == driver _C130) exitWith {};
If (_soldier == gunner _C130) exitWith {};
_Time_to_remove_action = 20;

(driver _C130) groupchat "Jumpers Go";
hint "Jumpers Go";
_halo_action = _soldier addAction ["<t shadow='1' color='#00ffff'>HALO JUMP!!!</t> <img color='#00ffff' shadow='1' image='\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa'/>", "call ghst_fnc_halo", [false,1000,60,true], 5, true, true, "","alive _target"];

while {(alive _soldier)} do 
{
	sleep 1;
	_Time_to_remove_action = _Time_to_remove_action -1;
	If (vehicle _soldier != _C130) exitWith {};
	If (_Time_to_remove_action == 0) exitWith {};
			
};

_soldier removeAction _halo_action; 