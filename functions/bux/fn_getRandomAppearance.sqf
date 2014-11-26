#define ALL_INSUR_GLASSES ["G_Balaclava_blk", "G_Balaclava_lowprofile", "G_Balaclava_oli", "G_Bandanna_aviator", "G_Bandanna_blk", "G_Bandanna_aviator", "G_Bandanna_shades"]
#define ALL_INSUR_GLASSES_COUNT 7

#define ALL_INSUR_UNIFORMS ["U_BG_Guerilla3_1", "U_BG_Guerrilla_6_1", "U_BG_Guerilla1_1", "U_BG_Guerilla2_1", "U_C_HunterBody_grn", "U_C_WorkerCoveralls", "U_BG_Guerilla2_2", "U_I_G_resistanceLeader_F"]
#define ALL_INSUR_UNIFORMS_COUNT 8

#define ALL_INSUR_VESTS ["V_HarnessO_brn", "V_HarnessO_gry", "V_Chestrig_rgr", "V_Chestrig_khk", "V_Chestrig_blk", "V_Chestrig_oli"]
#define ALL_INSUR_VESTS_COUNT 6

#define ALL_INSUR_HEADGEAR ["H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Shemag_olive_hs", "H_Bandanna_camo", "H_Bandanna_khk_hs"]
#define ALL_INSUR_HEADGEAR_COUNT 5

#define ALL_INSUR_FACES ["GreekHead_A3_01", "GreekHead_A3_02", "GreekHead_A3_03", "GreekHead_A3_04", "GreekHead_A3_05", "GreekHead_A3_06", "GreekHead_A3_07", "GreekHead_A3_08", "GreekHead_A3_09", "PersianHead_A3_01", "PersianHead_A3_02", "PersianHead_A3_03"]
#define ALL_INSUR_FACES_COUNT 12

private ["_equipment", "_glass", "_uniform", "_vest", "_headgear", "_face"];

_glass = ALL_INSUR_GLASSES select floor random ALL_INSUR_GLASSES_COUNT;
_uniform = ALL_INSUR_UNIFORMS select floor random ALL_INSUR_UNIFORMS_COUNT;
_vest = ALL_INSUR_VESTS select floor random ALL_INSUR_VESTS_COUNT;
_headgear = ALL_INSUR_HEADGEAR select floor random ALL_INSUR_HEADGEAR_COUNT;
_face = ALL_INSUR_FACES select floor random ALL_INSUR_FACES_COUNT;

_equipment = [_glass, _uniform, _vest, _headgear, _face];

_equipment