/*
 * Randomizes the appearance of a given unit
 * adds different uniforms, vests, glasses, headgear and faces
 *
 * Arguments:
 * 0: Unit (Object)
 *
 * Return Value:
 * none
 */


private ["_unit", "_randomAppearance"];

_unit = _this select 0;

_allGear = [_unit] call bux_fnc_getAllGear;

[_unit] call bux_fnc_resetUnit;

_randomAppearance = [] call bux_fnc_getRandomAppearance;
if ((floor random 2) == 0) then {
    _unit addGoggles (_randomAppearance select 0);
} else {
    _unit addHeadgear (_randomAppearance select 3);
};
_unit forceAddUniform (_randomAppearance select 1);
_unit addVest (_randomAppearance select 2);
_unit setFace (_randomAppearance select 4);

_unit addBackpack "B_FieldPack_khk";

[_unit, _allGear] call bux_fnc_restoreGear;