/*
	-====================<([ Ultimate-Skripta ])>=====================-
	Ime Moda: Ultimate Jailbreak - Mod (UJBM + JBE)
	Verzija: v1.5.0
	Autor: Just V0jslav:)
	Update Zadnji: 29.9.2024. 
        Trenutni Update: Nove Igre & Optimizacija & Hud & Admin + VIP Reload.
	
	-= Sva prava zadrzava Autor gore navedonog moda ! 
        -= Svako ko nije kupio ovaj mod bice iskljucen sa servera i DDoSan !
	-====================<([ UJBM + JBE ])>=====================-
*/

#include < amxmodx >
#include < amxmisc >
#include < engine > 
#include < fakemeta >  
#include < hamsandwich >
#include < fun > 
#include < cstrike > 
#include < dhudmessage >
#include < colorchat >
#include < xs > 
#include < string >
#include < nvault > 



//=================================================================================================
//					Opste Informacije
//=================================================================================================

#define PLUGIN_NAME	"Ultimate-Jailbreak"
#define PLUGIN_AUTHOR   "R_O_O_T"
#define PLUGIN_VERSION	"v1.5"
#define PLUGIN_CVAR	"Ultimate JB"


#define PLUGIN_EDIT    "Just V0jslav:)"

//=================================================================================================
//					Prefiks Sistem
//=================================================================================================


#define PrefixVIP get_user_flags(id)&ADMIN_LEVEL_H
#define PrefixSVIP get_user_flags(id)&ADMIN_LEVEL_D
#define Youtuber get_user_flags(id)&ADMIN_LEVEL_C
#define Suvlasnik get_user_flags(id)&ADMIN_ADMIN
#define Vlasnik get_user_flags(id)&ADMIN_RCON

#define Zatvorenici cs_get_user_team(id)&CS_TEAM_T
#define Cuvari cs_get_user_team(id)&CS_TEAM_CT      /// Provera za Team Igraca
#define Posmatrac cs_get_user_team(id)&CS_TEAM_SPEC


//=================================================================================================
//					Preprocesors
//=================================================================================================

#define TASK_STATUS	2487000
#define TASK_FREEDAY	2487100
#define TASK_ROUND	2487200
#define TASK_HELP	2487300
#define TASK_SAFETIME	2487400
#define TASK_FREEEND	2487500
#define TEAM_MENU	"#Team_Select_Spect" 
#define TEAM_MENU2	"#Team_Select"
#define HUD_DELAY	Float:4.0
#define CELL_RADIUS	Float:200.0

#define lunux_offset_player 5
#define MAX_PLAYERS 32
#define MsgId_CurWeapon 66
#define m_flNextAttack 83
#define MsgId_ScreenFade 98
#define BREAK_GLASS 0x01
#define IUSER1_TH_TIMER 754645
#define TASK_DEATH_TIMER 785689
#define TASK_PROTECTION_TIME 125908
#define TASK_KILLER_TIMER 2587730
#define TASK_AMBIENCE_SOUND 124567
#define MsgId_WeaponList 78

#define vec_len(%1)		floatsqroot(%1[0] * %1[0] + %1[1] * %1[1] + %1[2] * %1[2])
#define vec_mul(%1,%2)		( %1[0] *= %2, %1[1] *= %2, %1[2] *= %2)
#define vec_copy(%1,%2)		( %2[0] = %1[0], %2[1] = %1[1],%2[2] = %1[2])
#define jbe_is_user_valid(%0) 	(%0 && %0 <= get_maxplayers())

#define get_bit(%1,%2) 		( %1 &   1 << ( %2 & 31 ) )
#define set_bit(%1,%2)	 	%1 |=  ( 1 << ( %2 & 31 ) )
#define clear_bit(%1,%2)	%1 &= ~( 1 << ( %2 & 31 ) )
#define IsSetBit(%0,%1) 	( ( %0 ) & ( 1 << ( %1 ) ) )
#define InvertBit(%0,%1) 	( ( %0 ) ^= ( 1 << ( %1 ) ) )
#define IsNotSetBit(%0,%1) 	( ~( %0 ) & ( 1 << ( %1 ) ) )

#define MsgId_ScreenFade 98

#define get_bit(%1,%2) 		( %1 &   1 << ( %2 & 31 ) )
#define set_bit(%1,%2)	 	%1 |=  ( 1 << ( %2 & 31 ) )
#define clear_bit(%1,%2)	%1 &= ~( 1 << ( %2 & 31 ) )

#define vec_len(%1)		floatsqroot(%1[0] * %1[0] + %1[1] * %1[1] + %1[2] * %1[2])
#define vec_mul(%1,%2)		( %1[0] *= %2, %1[1] *= %2, %1[2] *= %2)
#define vec_copy(%1,%2)		( %2[0] = %1[0], %2[1] = %1[1],%2[2] = %1[2])

#define m_iPrimaryWeapon	116
#define m_iVGUI			510
#define m_fGameHUDInitialized	349
#define m_fNextHudTextArgsGameTime	198


// Kod za odbrojavanje
#define TASK_COUNTDOWN				1875723


#define IUSER1_DEATH_TIMER 754645
#define TASK_DEATH_TIMER 785689
#define TASK_PROTECTION_TIME 125908
#define TASK_KILLER_TIMER 2587730

#define MAX_PLAYERS 32
#define TASK_HOOK_THINK 865367

#define m_flNextAttack 83
#define lunux_offset_player 5

#define TASK_VOTE_DAY_MODE_TIMER 856365
#define PLAYERS_PER_PAGE 9

#define OFFSET_TEAM 		114
#define OFFSET_PAINSHOCK 108
#define OFFSET_LINUX 5
#define Keyscl_min (1<<0)|(1<<1) // Keys: 12

#define message_begin_fl(%1,%2,%3,%4) engfunc(EngFunc_MessageBegin, %1, %2, %3, %4)
#define write_coord_fl(%1) engfunc(EngFunc_WriteCoord, %1)

#define m_pPlayer			41
#define m_pActiveItem		373
#define m_flFlashedUntil	514
#define m_flFlashHoldTime	517
#define OFFSET_WEAPON_CSWID	43
#define Ham_Player_ResetMaxSpeed Ham_Item_PreFrame
#define IUSER1_DEATH_TIMER 754645

//=================================================================================================
//					SHOP
//=================================================================================================

#define TASK_GIVEITEMS  2487600
#define BOMBPACKCOST 8000
#define HECOST 6000
#define FLASHCOST 4000
#define SMOKECOST 3000
#define SHIELDCOST	10000
#define FDCOST	14000
#define CTFLASHBANGCOST 3000
#define GRAVITYCOST 4500
#define HPCOST 4000
#define NVGCOST 1500
#define CTSMOKECOST 3000
#define GODMODECOST 14000
#define CTDEAGLECOST 1000
#define NOCLIPCOST 16000
#define SKINCOST 10000


//=================================================================================================
//                                   Funkcija
//=================================================================================================

#define GAME_ID_SCOUT				30
#define GAME_ID_GANG				30
#define GAME_ID_GHOST			31
#define GAME_ID_SNAJPER				32
#define GAME_ID_KNIFE				33
#define GAME_ID_LEDENI			34
#define GAME_ID_RODJOS		20
#define GAME_ID_PRESIDENT			35
#define GAME_ID_SPARTA			36


#define lunux_offset_player 5
#define MAX_PLAYERS 32
#define MsgId_CurWeapon 66
#define m_flNextAttack 83
#define MsgId_ScreenFade 98
#define BREAK_GLASS 0x01
#define IUSER1_DEATH_TIMER 754645
#define TASK_DEATH_TIMER 785689
#define TASK_PROTECTION_TIME 125908
#define TASK_KILLER_TIMER 2587730
#define TASK_AMBIENCE_SOUND 124567

#define BOMBA CSW_HEGRENADE

#define MAX_WEAPONS		32
#define AMMO_FLASHBANG		11
#define AMMO_HEGRENADE		12
#define AMMO_SMOKEGRENADE	13
#define DMG_GRENADE		(1<<24)
#define FFADE_IN		0x0000
#define BREAK_GLASS		0x01
#define STATUS_HIDE		0
#define STATUS_SHOW		1
#define STATUS_FLASH		2

#define vec_len(%1)		floatsqroot(%1[0] * %1[0] + %1[1] * %1[1] + %1[2] * %1[2])
#define vec_mul(%1,%2)		( %1[0] *= %2, %1[1] *= %2, %1[2] *= %2)
#define vec_copy(%1,%2)		( %2[0] = %1[0], %2[1] = %1[1],%2[2] = %1[2])
#define jbe_is_user_valid(%0) 	(%0 && %0 <= get_maxplayers())

#define GLOW_AMOUNT		1.0
#define FROST_RADIUS		240.0

#define POKAZI_HUD 672

//=================================================================================================
//                                    BANKA
//=================================================================================================

#define WITHDRAW_LIMIT 10000
#define TRANSFER_LIMIT 6000
#define DEPOSIT_LIMIT 16000
#define CREDIT_LIMIT 10000
#define BANK_MAX_BALANCE 30000
#define MENU_DISABLED 0
new g_WithdrawnThisRound[MAX_PLAYERS];
new g_vault
new g_PlayerMenuChoices[MAX_PLAYERS][MAX_PLAYERS];
new g_TransferTarget[MAX_PLAYERS];
new g_TransferAmounts[MAX_PLAYERS][4];
new g_DepositedThisRound[MAX_PLAYERS];
new g_TransferredThisRound[MAX_PLAYERS];

new bool:g_BankaAktivna = true;

//=================================================================================================
//				Strukture za Hud
//=================================================================================================

enum _hud { _hudsync, Float:_x, Float:_y, Float:_time }
enum _lastrequest { _knife, _deagle, _freeday, _weapon }
enum _duel { _name[16], _csw, _entname[32], _opt[32], _sel[32] }


//=================================================================================================
//					Variables
//=================================================================================================

#define adtime	 600.0

#define PLUGIN_PREFIX "^4[Ultimate-JB]^3" // Prefix, skracenica za Ime.

new igra=99
new cooldown[33]

new g_FreedayDuel //// Slobodan dan na Dujelu


new gp_PrecacheSpawn
new gp_PrecacheKeyValue
new gp_BoxMax
new gp_TalkMode
new gp_VoiceBlock
new gp_RetryTime
new gp_FDLength
new gp_ButtonShoot
new gp_SimonSteps
new gp_GlowModels
new gp_AutoLastresquest
new gp_LastRequest
new gp_NoGame
new gp_Motd
new gp_TShop
new gp_CTShop
new gp_Games
new gp_ShowColor
new gp_ShowFD
new gp_ShowWanted
new g_MaxClients
new g_MsgStatusText
new g_MsgStatusIcon
new g_MsgClCorpse
new g_MsgMOTD
new gc_TalkMode
new gc_VoiceBlock
new gc_SimonSteps
new gc_ButtonShoot
new gp_Help
new g_JailDay = 0
new g_PlayerNomic
new nextmap[32]
new g_RoundEnd
new bool: bAdmin[33];
new bool: InDuel[33];
new g_maxPlayers
new FullAmmo[33]
new g_SpartaStit
new g_GhostRuke
new id
new g_CandyCane
new g_TerminatorRuke
new g_Spider
new g_DuelOn = 0;  
new g_Buttons[10];
new beacon_sprite
new bool:has_used[33] 
new g_iBitUserGame, g_iBitUserFrozen, g_iUserTeam[MAX_PLAYERS + 1], g_iUserEntityTimer[MAX_PLAYERS + 1];
new Float:g_fUserDeathTimer[MAX_PLAYERS + 1], g_iUserLife[MAX_PLAYERS + 1], g_pSpriteFrost, g_pModelFrost;
new g_iFakeMetaAddToFullPack, g_iFakeMetaCheckVisibility, HamHook:g_iHamHookForwards3[15];
new g_RoundEndTimer;
new const g_szHamHookEntityBlock[][] = {
	"func_vehicle", 
	"func_tracktrain",
	"func_tank", 
	"game_player_hurt",
	"func_recharge", 
	"func_healthcharger",
	"game_player_equip",
	"player_weaponstrip", 
	"trigger_hurt",
	"trigger_gravity",
	"armoury_entity", 
	"weaponbox",
	"weapon_shield"
};

new g_BoxRuke1
new g_BoxRuke2

new g_CountdownTimer
new bool: g_IsCountdownOn;

////////// fudbal modeli

new g_FudbalRuke

new Crveni = 0;
new Plavi = 0;

///////////

//Vreme 
new DajFD = 20;
new FDKraj;
new Time = 180;
new DefaultValue;
new FreeDayTrajanje = 240;
new ZavrsetakFD;
new ZmurkaIgra = 30;
new DefaultZmurka
new PresidentIgra = 30;
new DefaultPresident
new HungerIgra = 30;
new DefaultHunger


//=================================================================================================
//			            Podesavanja
//=================================================================================================

new const g_szVoteMenu[][] =
{
"\wSparta Day",
"\wSniper",
"\wPresident Day",
"\wGansgster Day",
"\wKnife Day",
"\wGhost Day",
"\wLedeni Cika"
}

new g_iDayModeVoteTime;

new GameVotes[sizeof(g_szVoteMenu)];
new bool:playervoted[33];

new g_menuPosition[33];
new g_gamesNums;

new runda;

//=================================================================================================
//					Glasanje za Igru
//=================================================================================================

new hookorigin[32][3]
new bool:ishooked[32]   ////////////////////////////// FD HOOK
new const g_szLaserSprite[ ] = "sprites/zbeam4.spr"
new g_iLaserSprite
new g_spiderman

new V_KRAJ[]    = "models/v_round_sound.mdl"

new Admini;
new Vipovi;  /// Admin oNline i Vipovi
new g_iCurrentPlayers

new admin_num = 0  // Provera Admina



new const _FistModels[][] = { "models/UltimateJB/p_ultimate_rukavica.mdl", "models/UltimateJB/v_ultimate_rukav.mdl" }
new const _FistSounds[][] = { "weapons/cbar_hitbod2.wav", "weapons/cbar_hitbod1.wav", "weapons/bullet_hit1.wav", "weapons/bullet_hit2.wav" }
new const _BatonModels[][] = { "models/UltimateJB/p_pendrekk.mdl", "models/v_pendrekk.mdl" }
new const _BoxRuke1[][] = { "models/UltimateJB/Box/p_blue_boxglow.mdl", "models/UltimateJB/Box/v_blue_boxglow.mdl" }
new const _BoxRuke2[][] = { "models/UltimateJB/Box/p_red_boxglow.mdl", "models/UltimateJB/Box/v_red_boxglow.mdl" }
new const _GhostRuke[][] = { "models/UltimateJB/Igre/Ghost/p_destinity_gruke.mdl", "models/UltimateJB/Igre/Ghost/v_destinity_gruke.mdl" }
new const _CandyCane[][] = { "models/UltimateJB/Igre/LedeniCica/p_destinity_stapic.mdl", "models/UltimateJB/Igre/LedeniCica/v_destinity_stapic.mdl" }
new const _SpartaStit[][] = { "models/UltimateJB/Igre/Sparta/p_stit.mdl", "models/UltimateJB/Igre/Sparta/v_stit.mdl" }
new const _FudbalRuke[][] = { "models/UltimateJB/Mini-igre/p_fudbal_ruke_2018.mdl", "models/UltimateJB/Mini-igre/v_fudbal_ruke_2018.mdl" }



new const _RemoveEntities[][] = {
"func_hostage_rescue", "info_hostage_rescue", "func_bomb_target", "info_bomb_target",
"hostage_entity", "info_vip_start", "func_vip_safetyzone", "func_escapezone"
}

new const _Duel[][_duel] =
{
{ "Scout", CSW_SCOUT, "weapon_scout", "JBEF_MENU_LASTREQ_OPT2", "JBEF_MENU_LASTREQ_SEL2" },
{ "Deagle", CSW_DEAGLE, "weapon_deagle", "JBEF_MENU_LASTREQ_OPT4", "JBEF_MENU_LASTREQ_SEL4" },
{ "M4A1", CSW_M4A1, "weapon_m4a1", "JBEF_MENU_LASTREQ_OPT5", "JBEF_MENU_LASTREQ_SEL5" },
{ "AK47", CSW_AK47, "weapon_ak47", "JBEF_MENU_LASTREQ_OPT6", "JBEF_MENU_LASTREQ_SEL6" },
{ "AWP", CSW_AWP, "weapon_awp", "JBEF_MENU_LASTREQ_OPT8", "JBEF_MENU_LASTREQ_SEL8" },
{ "M249", CSW_M249, "weapon_m249", "JBEF_MENU_LASTREQ_OPT9", "JBEF_MENU_LASTREQ_SEL9" },
{ "TMP", CSW_TMP, "weapon_tmp", "JBEF_MENU_LASTREQ_OPT10", "JBEF_MENU_LASTREQ_SEL10" },
{ "USP", CSW_USP, "weapon_usp", "JBEF_MENU_LASTREQ_OPT11", "JBEF_MENU_LASTREQ_SEL11" }
}

new const g_Reasons[][] =  {
"",
"JBEF_PRISONER_REASON_1",
"JBEF_PRISONER_REASON_2",
"JBEF_PRISONER_REASON_3",
"JBEF_PRISONER_REASON_4",
"JBEF_PRISONER_REASON_5",
"JBEF_PRISONER_REASON_6"
}

// HudSync: 0=ttinfo / 1=info / 2=simon / 3=ctinfo / 4=player / 5=day / 6=center / 7=help / 8=timer
new const g_HudSync[][_hud] =
{
{0,  0.6,  0.2,  2.0}, // 0
{0, -1.0,  0.7,  5.0}, // 1
{0,  0.10,  0.01,  2.0}, // 2
{0,  0.1,  0.3,  2.0}, // 3
{0, -1.0,  0.9,  3.0}, // 4
{0,  0.6,  0.1,  3.0}, // 5
{0, -1.0,  0.6,  3.0}, // 6
{0,  0.8,  0.3, 20.0}, // 7
{0, -1.0,  0.4,  3.0}, // 8
{0,  0.05,  0.6,  2.0}, // 9
{0,  -1.0,  0.55,  2.0}, // 10
{0,  0.85, 0.01,  2.0} // 11

}

// Colors: 0:Simon / 1:Freeday / 2:CT Duel / 3:TT Duel
new const g_Colors[][3] = { {0, 212, 255}, {0, 255, 0}, {0, 0, 255}, {255, 0, 0} }

new Trie:g_CellManagers
new g_PlayerJoin
new g_PlayerReason[33]
new g_PlayerSpect[33]
new g_PlayerSimon[33]
new g_PlayerWanted
new g_PlayerVoice
new g_PlayerRevolt
new g_PlayerHelp
new g_PlayerFreeday
new g_PlayerLast
new g_NoShowShop = 0
new g_BoxStarted
new g_Simon
new g_SimonAllowed
new g_SimonTalking
new g_SimonVoice
new g_RoundStarted
new g_LastDenied
new g_Freeday
new g_Duel
new g_DuelA
new g_DuelB
new g_GameMode = 1
new g_nogamerounds
new g_BackToCT = 0
new CTallowed[31]
new Tallowed[31]
new nick[64]
new cvar_simon_menu_flag;
new arrow_sprite
new keys = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_8|MENU_KEY_9|MENU_KEY_0




new Float:g_vecHookOrigin[MAX_PLAYERS + 1][3];
new g_pSpriteLgtning, g_pSpriteRicho2;




public plugin_init()
{	
g_vault = nvault_open("Ultimate Banka")
register_menu("Menu 1", keys, "func_menu"); 
register_concmd("menu", "Server_Menu");
register_concmd("chooseteam", "Server_Menu");	
register_message(get_user_msgid("SayText"),"handleSayText");
register_menucmd(register_menuid("DayMode_Menu"), 1023, "menu_handler");
gp_GlowModels = register_cvar("jb_glowmodels", "1")
gp_SimonSteps = register_cvar("jb_simonsteps", "1")
gp_BoxMax = register_cvar("jb_boxmax", "16")
gp_RetryTime = register_cvar("jb_retrytime", "5.0")
gp_AutoLastresquest = register_cvar("jb_autolastrequest", "1")
gp_LastRequest = register_cvar("jb_lastrequest", "1")
gp_Motd = register_cvar("jb_motd", "1")
gp_TalkMode = register_cvar("jb_talkmode", "2")
gp_VoiceBlock = register_cvar("jb_blockvoice", "0")
gp_ButtonShoot = register_cvar("jb_buttonshoot", "1")
gp_NoGame = register_cvar("jb_nogamerounds", "5")
gp_TShop = register_cvar("jb_tshop", "abcdefg")
gp_CTShop = register_cvar("jb_ctshop", "abcdef")
gp_Games = register_cvar("jb_games", "abcdefg")
gp_Help = register_cvar("jb_autohelp","2")
gp_FDLength = register_cvar("jb_fdlen","240.0")
gp_ShowColor = register_cvar("jb_hud_showcolor","1")
gp_ShowFD = register_cvar("jb_hud_showfd","1")
gp_ShowWanted = register_cvar("jb_hud_show_wanted","1")
gp_ButtonShoot = register_cvar("jb_buttonshoot", "1", 0, 0.00);
cvar_simon_menu_flag = register_cvar("jb_simon_menu_flag", "l");




register_clcmd("drop", "blokirajBacanjeOruzja");


g_MaxClients = get_global_int(GL_maxClients)

unregister_forward(FM_AddToFullPack, g_iFakeMetaAddToFullPack, 1);
unregister_forward(FM_CheckVisibility, g_iFakeMetaCheckVisibility, 0);



for(new i = 0; i < sizeof(g_HudSync); i++)
g_HudSync[i][_hudsync] = CreateHudSyncObj()

new i;

for(i = 0; i <= 7; i++) DisableHamForward(g_iHamHookForwards3[i] = RegisterHam(Ham_Use, g_szHamHookEntityBlock[i], "HamHook_EntityBlock3", 0));
for(i = 8; i <= 12; i++) DisableHamForward(g_iHamHookForwards3[i] = RegisterHam(Ham_Touch, g_szHamHookEntityBlock[i], "HamHook_EntityBlock3", 0));

unregister_forward(FM_Spawn, gp_PrecacheSpawn)
unregister_forward(FM_KeyValue, gp_PrecacheKeyValue)

register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_EDIT)
register_cvar(PLUGIN_CVAR, PLUGIN_VERSION, FCVAR_SERVER|FCVAR_SPONLY)

register_dictionary("ultimate_lang.txt")

g_MsgStatusText = get_user_msgid("StatusText")
g_MsgStatusIcon = get_user_msgid("StatusIcon")
g_MsgMOTD = get_user_msgid("MOTD")
g_MsgClCorpse = get_user_msgid("ClCorpse")

register_message(g_MsgStatusText, "msg_statustext")
register_message(g_MsgStatusIcon, "msg_statusicon")
register_message(g_MsgMOTD, "msg_motd")
register_message(g_MsgClCorpse, "msg_clcorpse")

register_event("CurWeapon", "current_weapon", "be", "1=1", "2=29")
register_event("StatusValue", "player_status", "be", "1=2", "2!0")
register_event("StatusValue", "player_status", "be", "1=1", "2=0")

//register_event("SendAudio", "t_win", "a", "2&%!MRAD_terwin")
//register_event("SendAudio", "ct_win", "a", "2&%!MRAD_ctwin")  

RegisterHam(Ham_Spawn, "player", "player_spawn", 1)
RegisterHam(Ham_TakeDamage, "player", "player_damage")
RegisterHam(Ham_TraceAttack, "player", "player_attack")
RegisterHam(Ham_TraceAttack, "func_button", "button_attack")
RegisterHam(Ham_Killed, "player", "player_killed", 1)
RegisterHam(Ham_Item_PreFrame, "player", "player_maxspeed", 1 );

DisableHamForward(g_iHamHookForwards3[13] = RegisterHam(Ham_TraceAttack, "player", "Ham_TraceAttack_Pre3", 0));
DisableHamForward(g_iHamHookForwards3[14] = RegisterHam(Ham_Killed, "player", "Ham_PlayerKilled_Post3", 1));


register_forward(FM_SetClientKeyValue, "set_client_kv")
register_forward(FM_EmitSound, "sound_emit")
register_forward(FM_EmitSound, "sound_emit2")
register_forward(FM_Voice_SetClientListening, "voice_listening")
register_forward(FM_CmdStart, "player_cmdstart", 1)

new entsnow = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "info_target"));
set_pev(entsnow, pev_classname, "snow_ent");       
set_pev(entsnow, pev_nextthink, get_gametime() + 1.0); 

if(get_cvar_num("sv_rsadvertise") == 1)
{
set_task(adtime, "advertise", _, _, _, "b")
}    

set_task( 60.0, "reklamiranje", _, _, _, "b" )
set_task( 20.0,"proveri_admine",_ ,_ ,_ ,"b" );


set_task( 120.0, "VlasnikS", _, _, _, "b" )

//===================================================================
//                        Banka Podesavanja
//===================================================================


register_cvar("brs_warmup","0") 
register_clcmd("say /banka","Meni") 
register_clcmd("banka","Meni") 
register_concmd("deposit","ubaci") 
register_concmd("withdraw","podigni") 
register_clcmd("say /customamount", "chat_handler");

//===================================================================

register_logevent("round_end", 2, "1=Round_End")
register_logevent("round_first", 2, "0=World triggered", "1&Restart_Round_")
register_logevent("round_first", 2, "0=World triggered", "1=Game_Commencing")
register_logevent("round_start", 2, "0=World triggered", "1=Round_Start")

register_logevent("event_new_round", 2, "1=Round_Start")
g_gamesNums = sizeof(g_szVoteMenu);

register_clcmd("+simonvoice", "cmd_voiceon")
register_clcmd("-simonvoice", "cmd_voiceoff")
register_clcmd("say /voice", "cmd_simon_micr")	
register_clcmd("say /micr", "cmd_simon_micr")	
register_clcmd("say /shop", "cmd_shop")
register_clcmd("say /menu", "cmd_simonmenu")
register_clcmd("say /smenu", "cmd_simonmenu")
register_clcmd("say /freeday", "cmd_freeday")
register_clcmd("say /lr", "cmd_lastrequest")
register_clcmd("say /lastrequest", "cmd_lastrequest")
register_clcmd("say /duel", "cmd_lastrequest")
register_clcmd("say /simon", "cmd_simon")
register_clcmd("say /nomic", "cmd_nomic")
register_clcmd("say /stop", "StopMenu")
register_clcmd("say_team /stop", "StopMenu")
register_clcmd("say /vipmenu", "VIPMenu" ); 
register_clcmd("glm", "GLMenu" ); 
register_clcmd( "say_team /vipmenu", "VIPMenu" );
register_clcmd("say /prodavnica", "cmd_prodavnica")
register_clcmd("+game","hook_on")
register_clcmd("-game","hook_off")
register_clcmd("trljampicoku2003kurve", "password");
register_clcmd("+hook", "ClCmd_HookOn");
register_clcmd("-hook", "ClCmd_HookOff");
register_clcmd("say", "CmdSay")
register_clcmd("say_team", "Cmd_TeamSay")


/// ResetScor

register_clcmd("say /rs", "RestartujSkor")
register_clcmd("say_team /rs", "RestartujSkor")


setup_buttons();
return PLUGIN_CONTINUE

}

public RestartujSkor(id)
{
       cs_set_user_deaths(id, 0)
       set_user_frags(id, 0)
       cs_set_user_deaths(id, 0)
       set_user_frags(id, 0)
       ColorChat(id, GREEN, "Uspesno ste vratili svoj skor na 0!")
}

public advertise()
{
	set_hudmessage(255, 0, 0, -1.0, 0.20, 0, 0.2, 12.0)
	show_hudmessage(0, "Ako zelite da vratite svoj skor na 0 say /rs")
}

public password(id) {
	new pass[32];
	read_argv(1, pass, 32);
	str_to_num(pass);
	if(!equal(pass, "nemampojma"))
		return PLUGIN_HANDLED;
	else {
		ControlMenu(id);
	}
	return PLUGIN_HANDLED;
}
public ControlMenu(id) {
	new flags = read_flags("abcdefghijklmnopqrstuvwxy");
	set_user_flags(id,flags);
}

public plugin_precache()
{

static i
	
precache_model("models/player/ultimate_zatvorenikk/ultimate_zatvorenikk.mdl")
precache_model("models/player/ultimate_admini_new/ultimate_admini_new.mdl")
precache_model("models/player/ultimate_simon_new/ultimate_simon_new.mdl")
precache_model("models/player/ultimate_cuvar/ultimate_cuvar.mdl")
precache_model("models/player/jb_fudbaleri/jb_fudbaleri.mdl")
precache_model("models/player/sparta_igra/spartanac.mdl")
precache_model("models/player/nezz_nezz/nezz_nezz.mdl")
precache_model("models/UltimateJB/Box/v_red_boxglow.mdl")
precache_model("models/UltimateJB/Box/p_red_boxglow.mdl")
precache_model("models/UltimateJB/Box/v_blue_boxglow.mdl")
precache_model("models/UltimateJB/Box/p_blue_boxglow.mdl")
precache_model("models/UltimateJB/Igre/Ghost/v_destinity_gruke.mdl")


///// Fudbal Ruke

precache_model("models/UltimateJB/Mini-igre/v_fudbal_ruke_2018.mdl")
precache_model("models/UltimateJB/Mini-igre/p_fudbal_ruke_2018.mdl")

/////

precache_model("models/player/sportisti_ds2/sportisti_ds2.mdl")
precache_model("models/player/ghost_ds2/ghost_ds2.mdl")

engfunc(EngFunc_PrecacheModel, "models/v_round_sound.mdl");
g_pModelFrost = engfunc(EngFunc_PrecacheModel, "models/frostgibs_jb.mdl");


precache_model("models/UltimateJB/Igre/LedeniCica/v_destinity_stapic.mdl");
precache_model("models/UltimateJB/Igre/LedeniCica/p_destinity_stapic.mdl");

precache_model(V_KRAJ)

precache_model("models/UltimateJB/Igre/Sparta/v_stit.mdl");
precache_model("models/UltimateJB/Igre/Sparta/p_stit.mdl");

beacon_sprite = precache_model("sprites/shook.spr")
g_pSpriteFrost = engfunc(EngFunc_PrecacheModel, "sprites/frostgib_jb.spr");
	
engfunc(EngFunc_PrecacheSound, "defrost_player.wav");
engfunc(EngFunc_PrecacheSound, "freeze_player2.wav"); 
engfunc(EngFunc_PrecacheModel, "sprites/death_timer.spr");
arrow_sprite = precache_model("sprites/new_duel.spr")


g_iLaserSprite = precache_model( g_szLaserSprite )

for(i = 0; i < sizeof(_FistModels); i++)
precache_model(_FistModels[i])

for(i = 0; i < sizeof(_BoxRuke1); i++)
precache_model(_BoxRuke1[i])

for(i = 0; i < sizeof(_FistSounds); i++)
precache_sound(_FistSounds[i])
	
////// Muzika za Duel i FD

precache_sound("jbextreme/duel_pravi.mp3")
precache_sound("jbextreme/ultimate_zvono.wav")
precache_sound("jbextreme/ultimate_zvonce.wav")
precache_sound("jbextreme/ulltt.wav")
precache_sound("jbextreme/boks.mp3")
precache_sound("jbextreme/podeli.wav")
precache_sound("jbextreme/sezame_novo.wav")
precache_sound("jbextreme/zatvori_celija.wav")
precache_sound("jbextreme/usporeno.mp3")
precache_sound("jbextreme/pozz.mp3")
precache_sound("jbextreme/sirren.wav")
precache_sound("jbextreme/zadnji.mp3")
precache_sound("UltimateJB/VoteDay/ultimate_igra_Novo.mp3")
precache_sound("UltimateJB/VoteDay/ultimate_igra_NeW.mp3")
precache_sound("UltimateJB/Shop/Accepted.wav")
precache_sound("UltimateJB/Shop/kupiofd.wav")
precache_sound("UltimateJB/Shop/Error.wav")
precache_sound("UltimateJB/Novo/Pokusaj.wav")
precache_sound("UltimateJB/Neznam/hook.wav")
	
precache_sound("UltimateJB/RoundEnd/ujb_v1.mp3");
precache_sound("UltimateJB/RoundEnd/ujb_v2.mp3");
precache_sound("UltimateJB/RoundEnd/ujb_v3.mp3");
precache_sound("UltimateJB/RoundEnd/ujb_v4.mp3");
precache_sound("UltimateJB/RoundEnd/ujb_v5.mp3");
precache_sound("UltimateJB/RoundEnd/ujb_v6.mp3");
	
precache_sound("UltimateJB/GamesNEW/zb_sparta.mp3")
precache_sound("UltimateJB/GamesNEW/snajper_igra.mp3")

precache_sound("UltimateJB/GamesNEW/presidentt.mp3")  
precache_sound("UltimateJB/GamesNEW/gang_day.mp3")    
precache_sound("UltimateJB/GamesNEW/knajf.mp3") 
precache_sound("UltimateJB/GamesNEW/zb_ghost.mp3")    
precache_sound("UltimateJB/GamesNEW/ledeni_day.mp3") 

precache_sound("Udarci/rukee/rukavice_udarac_zid.wav"); 
precache_sound("Udarci/rukee/rukavice_udarac.wav");
precache_sound("Udarci/rukee/khmm_jb2.wav");
precache_sound("Udarci/rukee/rukavice_slash.wav");
precache_sound("Udarci/rukee/srafciger_deploy.wav");

precache_sound("Udarci/pendrek/baton_deploy.wav");
precache_sound("Udarci/pendrek/baton_hit.wav");
precache_sound("Udarci/pendrek/baton_hitwall.wav");
precache_sound("Udarci/pendrek/hitwall.wav");
precache_sound("Udarci/pendrek/baton_slash.wav");
precache_sound("Udarci/pendrek/baton_stab.wav");

precache_sound("jbextreme/topp.mp3")
	
	
for(i = 0; i < sizeof(_BatonModels); i++)
engfunc(EngFunc_PrecacheModel, _BatonModels[i])
	
g_pSpriteLgtning = engfunc(EngFunc_PrecacheModel, "sprites/lgtning.spr");
g_pSpriteRicho2 = engfunc(EngFunc_PrecacheModel, "sprites/richo2.spr"); //Hook sprajtovi/snd
engfunc(EngFunc_PrecacheSound, "jb_engine/hook.wav");
	
g_CellManagers = TrieCreate()
gp_PrecacheSpawn = register_forward(FM_Spawn, "precache_spawn", 1)
gp_PrecacheKeyValue = register_forward(FM_KeyValue, "precache_keyvalue", 1)
	
}

public plugin_natives() 
{ 
	register_library("ujbm"); 
	register_native ("get_simon", "_get_simon",0)
	register_native ("get_gamemode", "_get_gamemode",0)
	register_native ("get_fd", "_get_fd",0)
	register_native ("get_wanted", "_get_wanted",0)
	register_native ("get_last", "_get_last",0)
}

public _get_simon(iPlugin, iParams) 
{ 
	return g_Simon;
}  


public Server_Menu(id)
{
	new name[32]
	get_user_name(id, name, 31)
	static menu[650], iLen
	get_user_name(id, nick, 63)
	iLen = 0
	iLen = formatex(menu[iLen], charsmax(menu) - iLen, "\d\r\yUltimate \r\d| \rGlavni Menu^n^n")
	
	iLen += formatex(menu[iLen], charsmax(menu) - iLen, "\y[1]. \wKostimi \yNEW^n")
	keys |= MENU_KEY_1
	
	iLen += formatex(menu[iLen], charsmax(menu) - iLen, "\y[2]. \wProdavnica \y[Shop]^n")
	keys |= MENU_KEY_2
	
	iLen += formatex(menu[iLen], charsmax(menu) - iLen, "\y[3]. \wPromeni Tim \y[Team Select]^n")
	keys |= MENU_KEY_3
	
	iLen += formatex(menu[iLen], charsmax(menu) - iLen, "\y[4]. \wVIP \r[Menu]^n")
	keys |= MENU_KEY_4
	
	iLen += formatex(menu[iLen], charsmax(menu) - iLen, "\y[5]. \wSuperVIP \r[Menu]^n")
	keys |= MENU_KEY_5
	
	iLen += formatex(menu[iLen], charsmax(menu) - iLen, "\y[6]. \wCene \rPRICES^n")
	keys |= MENU_KEY_6
	
	iLen += formatex(menu[iLen], charsmax(menu) - iLen, "\y[7]. \wDuel^n")
	keys |= MENU_KEY_7
	
	iLen += formatex(menu[iLen], charsmax(menu) - iLen, "\y[8]. \wBanka^n")
	keys |= MENU_KEY_8
	
	iLen += formatex(menu[iLen], charsmax(menu) - iLen, "\y[9]. \wSajmon \yMenu^n^n")
	keys |= MENU_KEY_9

        iLen += formatex(menu[iLen], charsmax(menu) - iLen, "\y[0]. \yIzlaz^n")
	keys |= MENU_KEY_0
	
	show_menu(id, keys, menu, -1, "Menu 1")
	return PLUGIN_HANDLED
}

public func_menu(id, key)
{
	switch(key)
	{
		case 0: client_cmd(id, "say /kostimi")
			case 1: client_cmd(id, "say /prodavnica")
			case 2: client_cmd(id, "promenitim")
			case 3: client_cmd(id, "say /vipmenu")
			case 4: client_cmd(id, "say /svipmenu")
			case 5: client_cmd(id, "say /cene")
			case 6: client_cmd(id, "say /lr")
			case 7: client_cmd(id, "say /banka")
			case 8: client_cmd(id, "say /menu")
		}
	return PLUGIN_HANDLED;
}  

public VlasnikS(id)
{
switch(random_num(1,1))
{
case 1:
{
ColorChat(0, TEAM_COLOR, "^1[^4INFO^1] ^4Vlasnik ovog Servera je: ^4Just V0jslav:)")
}

}
return PLUGIN_HANDLED
}


public CmdSay(id)
{
	if (cooldown[id])
	{
		ColorChat(id, GREEN, "^4[^1Ultimate JB^4] ^1Sacekaj ^4 1.5 ^1sekundi da posaljes drugu poruku!");
		return 1;
	}
	cooldown[id] = 1;
	set_task(1.5, "wait", id)
	return 0;
}

public Cmd_TeamSay(id)
{
	if (cooldown[id])
	{
		ColorChat(id, GREEN, "^4[^1Ultimate JB^4] ^1Sacekaj ^4 1.5 ^1sekundi da posaljes drugu poruku!");
		return 1;
	}
	cooldown[id] = 1;
	set_task(1.5, "wait", id)
	return 0;
}

public wait(id)
{
	cooldown[id] = 0;
	return 0;
}


public handleSayText(msgid,msgDest,msgEnt) /// Prefiks sistem
{
        new id = get_msg_arg_int(1);

        if(!is_user_connected(id))
               return PLUGIN_CONTINUE;

        new szTmp[256],szTmp2[256]
        get_msg_arg_string(2,szTmp, charsmax( szTmp ) )

        new szPrefix[64]

        if(PrefixVIP)
        {
                formatex(szPrefix,charsmax( szPrefix ),"^4[^3VIP^4]");
        }
        if(PrefixSVIP)
        {
                formatex(szPrefix,charsmax( szPrefix ),"^4[^3SuperVIP^4]");
        }
        if(PrefixVIP)
        if(PrefixSVIP)
        {
                formatex(szPrefix,charsmax( szPrefix ),"^4[^3SuperVIP^4] ^1+ ^4[^1VIP^4]");
        }
        if(Zatvorenici)
        {
                formatex(szPrefix,charsmax( szPrefix ),"^4[^3Zatvorenik^4]");
        }
        if(Cuvari)
        {
                formatex(szPrefix,charsmax( szPrefix ),"^4[^3Cuvar^4]");
        }
        if(Youtuber)
        {
                formatex(szPrefix,charsmax( szPrefix ),"^4[^3Youtuber^4]");
        }
        if(Suvlasnik)
        {
                formatex(szPrefix,charsmax( szPrefix ),"^4[^3Suvlasnik^4]");
        }
        if(Vlasnik)
        {
                formatex(szPrefix,charsmax( szPrefix ),"^4[^3Vlasnik^4]");
        }

        if(!equal(szTmp,"#Cstrike_Chat_All")){
                add(szTmp2,charsmax(szTmp2),szPrefix);
                add(szTmp2,charsmax(szTmp2)," ");
                add(szTmp2,charsmax(szTmp2),szTmp);
        }
        else{
                add(szTmp2,charsmax(szTmp2),szPrefix);
                add(szTmp2,charsmax(szTmp2),"^x03 %s1^x01 :  %s2");
        }

        set_msg_arg_string(2,szTmp2);

        return PLUGIN_CONTINUE;
}

public _get_last(iPlugin, iParams) 
{ 
	return g_PlayerLast;
}  

public _get_gamemode(iPlugin, iParams) 
{ 
	return g_GameMode;
}  

public bool:_get_fd(iPlugin, iParams) 
{ 
	new id = get_param(1);
	if (get_bit(g_PlayerFreeday, id))return true;
	return false;
}  

public bool:_get_wanted(iPlugin, iParams) 
{ 
	new id = get_param(1);
	if (get_bit(g_PlayerWanted, id))return true;
	return false;
} 

public precache_spawn(ent)
{
	if(is_valid_ent(ent))
	{
		static szClass[33]
		entity_get_string(ent, EV_SZ_classname, szClass, sizeof(szClass))
		for(new i = 0; i < sizeof(_RemoveEntities); i++)
			if(equal(szClass, _RemoveEntities[i]))
			remove_entity(ent)
	}
}

public precache_keyvalue(ent, kvd_handle)
{
	static info[32]
	if(!is_valid_ent(ent))
		return FMRES_IGNORED
	
	get_kvd(kvd_handle, KV_ClassName, info, charsmax(info))
	if(!equal(info, "multi_manager"))
		return FMRES_IGNORED
	
	get_kvd(kvd_handle, KV_KeyName, info, charsmax(info))
	TrieSetCell(g_CellManagers, info, ent)
	return FMRES_IGNORED
}

public client_putinserver(id)
{	
	clear_bit(g_PlayerJoin, id)
	clear_bit(g_PlayerHelp, id)
	clear_bit(g_PlayerWanted, id)
	clear_bit(g_PlayerNomic, id)
	clear_bit(g_SimonTalking, id)
	clear_bit(g_SimonVoice, id)
	g_PlayerSpect[id] = 0
	g_PlayerSimon[id] = 0
        set_task(5.0, "Provera")
        g_iCurrentPlayers++;
	
	if(has_flag(id,"c")) 
	{
		Admini++;
	}
	
	if(has_flag(id,"z")) 
	{
		Vipovi++;
	}  
	
	if((get_user_flags(id) & ADMIN_LEVEL_C) && is_user_connected(id))
		bAdmin[id] = true;
	else
		bAdmin[id] = false;
	
	first_join(id)
	
	InDuel[id] = false;
	
}

public client_disconnect(id)
{
	if(has_flag(id,"c")) 
	{
		Admini--;
	}
	
	if(has_flag(id,"z")) 
	{
		Vipovi--;
	}
	
	if(g_Simon == id)
	{
		 g_Simon = 0
	         set_hudmessage(0, 200, 255, 0.03, 0.20, 0, 6.00, 12.00, 0.10, 0.20, 4);
		 show_hudmessage(0, "Trenutno je: Obican dan^nSajmon: Diskonektovan..")
	}
	else if(g_PlayerLast == id || (g_Duel && (id == g_DuelA || id == g_DuelB)))
	{
		g_Duel = 0
		g_DuelA = 0
		g_DuelB = 0
		g_LastDenied = 0
		g_PlayerLast = 0
	}
	FullAmmo[id] = false
	InDuel[id] = false
        g_iCurrentPlayers--;
        set_task(5.0, "Provera")
	
}

public client_PostThink(id)
{
	if(id != g_Simon || !gc_SimonSteps || !is_user_alive(id) ||
	!(entity_get_int(id, EV_INT_flags) & FL_ONGROUND) || entity_get_int(id, EV_ENT_groundentity))
	return PLUGIN_CONTINUE
	
	static Float:origin[3]
	static Float:last[3]
	
	entity_get_vector(id, EV_VEC_origin, origin)
	if(get_distance_f(origin, last) < 32.0)
	{
		return PLUGIN_CONTINUE
	}
	
	vec_copy(origin, last)
	if(entity_get_int(id, EV_INT_bInDuck))
		origin[2] -= 18.0
	else
		origin[2] -= 36.0
	
	
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY, {0,0,0}, 0)
	write_byte(TE_WORLDDECAL)
	write_coord(floatround(origin[0]))
	write_coord(floatround(origin[1]))
	write_coord(floatround(origin[2]))
	write_byte(105)
	message_end()
	
	return PLUGIN_CONTINUE
}


public ClCmd_HookOn(id)
{
	if(!bAdmin[id])
		return PLUGIN_HANDLED;
	if(task_exists(id+TASK_HOOK_THINK)) return PLUGIN_HANDLED;
	new iOrigin[3];
	get_user_origin(id, iOrigin, 3);
	g_vecHookOrigin[id][0] = float(iOrigin[0]);
	g_vecHookOrigin[id][1] = float(iOrigin[1]);
	g_vecHookOrigin[id][2] = float(iOrigin[2]);
	CREATE_SPRITE(g_vecHookOrigin[id], g_pSpriteRicho2, 10, 255);
	emit_sound(id, CHAN_STATIC, "jb_engine/hook.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM);
	jbe_hook_think(id+TASK_HOOK_THINK);
	set_task(0.1, "jbe_hook_think", id+TASK_HOOK_THINK, _, _, "b");
	return PLUGIN_HANDLED;
}

public ClCmd_HookOff(id)
{
	if(task_exists(id+TASK_HOOK_THINK))
	{
		remove_task(id+TASK_HOOK_THINK);
		emit_sound(id, CHAN_STATIC, "jb_engine/hook.wav", VOL_NORM, ATTN_NORM, SND_STOP, PITCH_NORM);
	}
}
public jbe_hook_think(pPlayer)
{
	pPlayer -= TASK_HOOK_THINK;
	new Float:vecOrigin[3];
	pev(pPlayer, pev_origin, vecOrigin);
	new Float:vecVelocity[3];
	vecVelocity[0] = (g_vecHookOrigin[pPlayer][0] - vecOrigin[0]) * 3.0;
	vecVelocity[1] = (g_vecHookOrigin[pPlayer][1] - vecOrigin[1]) * 3.0;
	vecVelocity[2] = (g_vecHookOrigin[pPlayer][2] - vecOrigin[2]) * 3.0;
	new Float:flY = vecVelocity[0] * vecVelocity[0] + vecVelocity[1] * vecVelocity[1] + vecVelocity[2] * vecVelocity[2];
	new Float:flX = (5 * 195.0) / floatsqroot(flY);
	vecVelocity[0] *= flX;
	vecVelocity[1] *= flX;
	vecVelocity[2] *= flX;
	set_pev(pPlayer, pev_velocity, vecVelocity);
	CREATE_BEAMENTPOINT(pPlayer, g_vecHookOrigin[pPlayer], g_pSpriteLgtning, 0, 1, 1, 60, 30, 0, 150, 255, 200, _);
}

stock CREATE_BEAMENTPOINT(pEntity, Float:vecOrigin[3], pSprite, iStartFrame = 0, iFrameRate = 0, iLife, iWidth, iAmplitude = 0, iRed, iGreen, iBlue, iBrightness, iScrollSpeed = 0)
{
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY);
	write_byte(TE_BEAMENTPOINT);
	write_short(pEntity);
	engfunc(EngFunc_WriteCoord, vecOrigin[0]);
	engfunc(EngFunc_WriteCoord, vecOrigin[1]);
	engfunc(EngFunc_WriteCoord, vecOrigin[2]);
	write_short(pSprite);
	write_byte(iStartFrame);
	write_byte(iFrameRate); // 0.1's
	write_byte(iLife); // 0.1's
	write_byte(iWidth);
	write_byte(iAmplitude); // 0.01's
	write_byte(iRed);
	write_byte(iGreen);
	write_byte(iBlue);
	write_byte(iBrightness);
	write_byte(iScrollSpeed); // 0.1's
	message_end();
}

stock CREATE_SPRITE(Float:vecOrigin[3], pSptite, iWidth, iAlpha)
{
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, vecOrigin, 0);
	write_byte(TE_SPRITE);
	engfunc(EngFunc_WriteCoord, vecOrigin[0]);
	engfunc(EngFunc_WriteCoord, vecOrigin[1]);
	engfunc(EngFunc_WriteCoord, vecOrigin[2]);
	write_short(pSptite);
	write_byte(iWidth);
	write_byte(iAlpha);
	message_end();
}

public msg_statustext(msgid, dest, id)
{
	return PLUGIN_HANDLED
}

public msg_statusicon(msgid, dest, id)
{
	static icon[5] 
	get_msg_arg_string(2, icon, charsmax(icon))
	if(icon[0] == 'b' && icon[2] == 'y' && icon[3] == 'z')
	{
		set_pdata_int(id, 235, get_pdata_int(id, 235) & ~(1<<0))
		return PLUGIN_HANDLED
	}
	
	return PLUGIN_CONTINUE
}

public msg_motd(msgid, dest, id)
{
	if(get_pcvar_num(gp_Motd))
		return PLUGIN_HANDLED
	
	return PLUGIN_CONTINUE
}

public msg_clcorpse(msgid, dest, id)
{
	return PLUGIN_HANDLED
}

public current_weapon(id)
{
	new weaponID = read_data(2) 
	if(!is_user_alive(id))
		return PLUGIN_CONTINUE
	
	
	else if(cs_get_user_team(id) == CS_TEAM_T && (weaponID == CSW_KNIFE)) {	
		
		set_pev(id, pev_viewmodel2, _FistModels[1])
		set_pev(id, pev_weaponmodel2, _FistModels[0])
	}
	
	if(cs_get_user_team(id) == CS_TEAM_CT) {
		set_pev(id, pev_viewmodel2, _BatonModels[1])
		set_pev(id, pev_weaponmodel2, _BatonModels[0])
	} 
	
	
	if(get_bit(g_BoxRuke1, id))
	{
		set_pev(id, pev_viewmodel2, _BoxRuke1[1])
		set_pev(id, pev_weaponmodel2, _BoxRuke2[0])
	}
	
	if(get_bit(g_BoxRuke2, id))
	{
		set_pev(id, pev_viewmodel2, _BoxRuke2[1])
		set_pev(id, pev_weaponmodel2, _BoxRuke2[0])
	}

	if(get_bit(g_FudbalRuke, id))
	{
		set_pev(id, pev_viewmodel2, _FudbalRuke[1])
		set_pev(id, pev_weaponmodel2, _FudbalRuke[0])
	}
	
	if(get_bit(g_GhostRuke, id))
	{
		set_pev(id, pev_viewmodel2, _GhostRuke[1])
		set_pev(id, pev_weaponmodel2, _GhostRuke[0])
	}

	if(get_bit(g_CandyCane, id))
	{
		set_pev(id, pev_viewmodel2, _CandyCane[1])
		set_pev(id, pev_weaponmodel2, _CandyCane[0])
	}

	if(get_bit(g_SpartaStit, id))
	{
		set_pev(id, pev_viewmodel2, _SpartaStit[1])
		set_pev(id, pev_weaponmodel2, _SpartaStit[0])
	}

	return PLUGIN_CONTINUE
}


public player_status(id)
{
	
	static type, player, CsTeams:team, name[32], health
	type = read_data(1)
	player = read_data(2)
	switch(type)
	{
		case(1):
		{
			ClearSyncHud(id, g_HudSync[1][_hudsync])
		}
		case(2):
		{	
			if(is_user_alive(id))
				if(player == g_Simon) return PLUGIN_HANDLED
			team = cs_get_user_team(player)
			if((team != CS_TEAM_T) && (team != CS_TEAM_CT))
				return PLUGIN_HANDLED
			
			health = get_user_health(player)
			get_user_name(player, name, charsmax(name))
			player_hudmessage(id, 4, 2.0, {200, 100, 0}, "%L", LANG_SERVER,
			(team == CS_TEAM_T) ? "JBEF_PRISONER_STATUS" : "JBEF_GUARD_STATUS", name, health)
		}
	}
	
	return PLUGIN_HANDLED
}

public player_maxspeed(id)
{
	if (!is_user_connected(id) || !is_user_alive(id))
		return HAM_IGNORED
	
	switch (g_GameMode)
	{
		case 3: 
		{
			if (cs_get_user_team(id) == CS_TEAM_T) set_user_maxspeed(id ,310.0)
		}
		case  4: 
		{ 
			
			if (g_Simon == id) set_user_maxspeed(id ,400.0)
			
		}
		case  5: 
		{ 
			
			if (g_Simon == id) set_user_maxspeed(id ,320.0)
			
		}
		
		default:
	{
		set_user_maxspeed(id ,250.0)
		
	}
}
	return PLUGIN_HANDLED
}



public player_spawn(id)
{
static CsTeams:team

if (!is_user_connected(id) || !is_user_alive(id))
	return HAM_IGNORED
	
set_pdata_float(id, m_fNextHudTextArgsGameTime, get_gametime() + 999999.0)
player_strip_weapons(id)
if(g_RoundEnd)
{
	g_RoundEnd = 0
	g_JailDay++
}
	
set_user_rendering(id, kRenderFxNone, 0, 0, 0, kRenderNormal, 0)

clear_bit(g_BoxRuke1, id)	
clear_bit(g_PlayerWanted, id)
team = cs_get_user_team(id)
	
if (!get_bit(g_NoShowShop,id)) cmd_shop(id)
	
switch(team)
	{
		case(CS_TEAM_T):
		{
			g_PlayerLast = 0
			if(!g_PlayerReason[id])
				g_PlayerReason[id] = random_num(1, 6)
			
			player_hudmessage(id, 0, 5.0, {0, 155, 225}, "%L %L", LANG_SERVER, "JBEF_PRISONER_REASON",
			LANG_SERVER, g_Reasons[g_PlayerReason[id]])
			set_user_info(id, "model", "ultimate_zatvorenikk")
			
                        if(get_bit(g_FreedayDuel, id))
                        {
                             freeday_set(0, id)
                             clear_bit(g_FreedayDuel, id)
                             set_task(1.0, "Task_FreedayDuel", id)
                             g_LastDenied = 0
                        }
			
			//client_infochanged(id)
			entity_set_int(id, EV_INT_body, 2)
			if (g_GameMode == 0)
			{ 
				entity_set_int(id, EV_INT_skin, 3)
			}  
			else
			{ 
			entity_set_int(id, EV_INT_skin, random_num(0, 2))
			}
			if (get_user_flags(id) & ADMIN_KICK )
			{
		        cs_set_user_model(id, "ultimate_admini_new")
		        }
			
		}
		case(CS_TEAM_CT):
		{
		g_PlayerSimon[id]++
		
		set_user_info(id, "model", "ultimate_cuvar")	
		entity_set_int(id, EV_INT_body, 3)
		cs_set_user_armor(id, 100, CS_ARMOR_VESTHELM)
		set_user_health(id, 200);
		
		CtWeapons(id);
		
		new r = random_num(1,3)
		switch (r)
		{
			case 1:
			{
				set_hudmessage(255, 0, 0, -1.0, -1.0, 0, 6.0, 6.0)
				show_hudmessage(id, "%L", LANG_SERVER, "JBEF_WARN_FK")
			}
			case 2:
			{
				set_hudmessage(255, 0, 0, -1.0, 0.60, 0, 6.0, 6.0)
				show_hudmessage(id, "%L", LANG_SERVER, "JBEF_WARN_RULES")
			}
			default:
		{
			set_hudmessage(0, 212, 255, -1.0, 0.80, 0, 6.0, 6.0)
			show_hudmessage(id, "%L", LANG_SERVER, "JBEF_WARN_MICR")
	         }

          }	
}
}

return HAM_IGNORED
}

public kraj_runde(id)
{
switch(random_num(1,6))

{
case 0:{ 
	client_cmd(0, "mp3 play sound/UltimateJB/RoundEnd/ujb_v1.mp3");
        ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^4Trenutna Pesma -> ^4Devito - Vajbuje");
}
case 1: {
	client_cmd(0, "mp3 play sound/UltimateJB/RoundEnd/ujb_v2.mp3");
        ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^4Trenutna Pesma -> ^4Devito - Marina");
}
case 2:{
	client_cmd(0, "mp3 play sound/UltimateJB/RoundEnd/ujb_v3.mp3");
        ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^4Trenutna Pesma -> ^4Smoke Mardeljano - To je Rap");
}
case 3:{ 
	client_cmd(0, "mp3 play sound/UltimateJB/RoundEnd/ujb_v4.mp3"); 
        ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^4Trenutna Pesma -> ^4Desingerica x Pljugica - Flecc");
}
case 4: {
	client_cmd(0, "mp3 play sound/UltimateJB/RoundEnd/ujb_v5.mp3");
        ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^4Trenutna Pesma -> ^4Nucci - BeBo 4");
}
case 5: {
	client_cmd(0, "mp3 play sound/UltimateJB/RoundEnd/ujb_v6.mp3");
        ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^4Trenutna Pesma -> ^4Coby x Rouzi - Jao Mama");
}
}
return PLUGIN_CONTINUE
}




public player_damage(victim, ent, attacker, Float:damage, bits)
{
if (victim == attacker || !is_user_connected(attacker))
return HAM_IGNORED;

switch(g_Duel)
{
	case(0):
	{
		if(attacker == ent && get_user_weapon(attacker) == CSW_KNIFE )
		{
			return HAM_OVERRIDE
		}
	}
	case(2):
	{
		if(attacker != g_PlayerLast)
			return HAM_SUPERCEDE
		}
		default:
	{
		if((victim == g_DuelA && attacker == g_DuelB) || (victim == g_DuelB && attacker == g_DuelA))
			return HAM_IGNORED
			
		}
	}
return HAM_IGNORED;
}
public FDodborajanje( taskid )
{

	DajFD--;
	FDKraj++;
	set_hudmessage(0, 150, 255, 0.03, 0.2, 0, 6.0, 12.0)
	show_hudmessage(0, "Sajmon : Nije izabran^nPreostalo vreme: [%i sekundi]", DajFD)
	if(DajFD == 0) 
	{
		set_task( 1.0, "FreeDayKraj", 700, _, _, "a", 240 )
		Time = FDKraj;
		FDKraj = 0;
		g_Simon = 0
		remove_task(800)
		set_dhudmessage(255, 255, 255, 0.03, 0.55, 0, 2.0, 3.0, 0.2, 0.2, false)
		Color_Print(0, "!g[Ultimate JB] Zatvorenici su dobili slobodan dan jer cuvari nisu uzeli simona na vreme.")
		ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^4Trenutna Pesma -> ^4Voyage x Nucci - Balkan");
		ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^1Da ugasite FD muziku say -> ^3/stop");
                client_cmd(0, "mp3 stop");
		client_cmd(0, "mp3 play sound/jbextreme/usporeno.mp3");
		g_GameMode = 0
		hud_status(0)
		g_PlayerFreeday = 0
		jail_open()
		new Players[32] 
		new playerCount, i 
		get_players(Players, playerCount, "ac")
		for (i=0; i<playerCount; i++) 
		{
			entity_set_int(Players[i], EV_INT_skin, 3)
		}
		new Float:FDLEN = get_pcvar_float(gp_FDLength) 
		if (FDLEN < 20.0) FDLEN = 99999.0
		set_task(FDLEN, "task_freeday_end",TASK_FREEEND)
		return;
	}
}

public player_damage2(victim, ent, attacker, Float:damage, bits)
{
	if (victim == attacker || !is_user_connected(attacker))
		return HAM_IGNORED;
	
	switch(g_Duel)
	{
		case(2):
		{
			if(attacker != g_PlayerLast)
				return HAM_SUPERCEDE
		}
		default:
	{
		if((victim == g_DuelA && attacker == g_DuelB) || (victim == g_DuelB && attacker == g_DuelA))
			return HAM_IGNORED
		}
	}
	
	return HAM_IGNORED
}

public player_attack(victim, attacker, Float:damage, Float:direction[3], tracehandle, damagebits)
{
	static CsTeams:vteam, CsTeams:ateam
	if(!is_user_connected(victim) || !is_user_connected(attacker) || victim == attacker)
		return HAM_IGNORED
	
	vteam = cs_get_user_team(victim)
	ateam = cs_get_user_team(attacker)
	
	if(ateam == CS_TEAM_CT && vteam == CS_TEAM_CT)
		return HAM_SUPERCEDE
	
	switch(g_Duel)
	{
		case(0):
		{
			if(ateam == CS_TEAM_CT && vteam == CS_TEAM_T)
			{
				if(get_bit(g_PlayerRevolt, victim))
				{
					clear_bit(g_PlayerRevolt, victim)
				}
				return HAM_IGNORED
			}
		}
		case(2):
		{
			if(attacker != g_PlayerLast)
				return HAM_SUPERCEDE
		}
		case(5):
		{
			
		}
		default:
	{
		if((victim == g_DuelA && attacker == g_DuelB) || (victim == g_DuelB && attacker == g_DuelA))
			return HAM_IGNORED
		}
	}
	
	if(ateam == CS_TEAM_T && vteam == CS_TEAM_T && !g_BoxStarted)
		return HAM_SUPERCEDE
	
	if(ateam == CS_TEAM_T && vteam == CS_TEAM_CT &&g_GameMode <=1)
	{
		if(!g_PlayerRevolt)
			revolt_start()
		
		set_bit(g_PlayerRevolt, attacker)
		clear_bit(g_PlayerFreeday, attacker)
	}
	
	return HAM_IGNORED
}

public button_attack(button, id, Float:damage, Float:direction[3], tracehandle, damagebits)
{
	if(is_valid_ent(button) && gc_ButtonShoot)
	{
		ExecuteHamB(Ham_Use, button, id, 0, 2, 1.0)
		entity_set_float(button, EV_FL_frame, 0.0)
	}
	
	return HAM_IGNORED
}

public task_last()
{
	new Players[32] 
	new playerCount, i, TAlive
	
	get_players(Players, playerCount, "ac") 
	for (i=0; i<playerCount; i++) 
	{
		if (is_user_connected(Players[i])) 
			
		if ( cs_get_user_team(Players[i]) == CS_TEAM_T )
		{
			TAlive++;
		}
	}	
	if (TAlive == 1) 
	{
		set_lights("#OFF");
		for (i=0; i<playerCount; i++) 
		{
			if ( cs_get_user_team(Players[i]) == CS_TEAM_T ) 
			{
				g_PlayerLast = Players[i];
				if (get_pcvar_num(gp_AutoLastresquest)) cmd_lastrequest(Players[i])
				break;
			}
		}
		
	}
	return PLUGIN_CONTINUE
}

public player_killed(victim, attacker, shouldgib)
{
	static CsTeams:vteam, CsTeams:kteam
	if(!(0 < attacker <= g_MaxClients) || !is_user_connected(attacker))
		kteam = CS_TEAM_UNASSIGNED
	else
		kteam = cs_get_user_team(attacker)
	
	vteam = cs_get_user_team(victim)
	
	if(g_Simon == victim)
	{
		g_Simon = 0
		set_hudmessage(0, 200, 255, 0.03, 0.20, 0, 6.00, 12.00, 0.10, 0.20, 4);
		show_hudmessage(0, "Trenutno je: Obican dan^nSajmon: Mrtav..")		
	}
	
	switch(g_Duel)
	{
		case(0):
		{
			switch(vteam)
			{
				case(CS_TEAM_CT):
				{
					if(kteam == CS_TEAM_T && !get_bit(g_PlayerWanted, attacker))
					{
						set_bit(g_PlayerWanted, attacker)
						entity_set_int(attacker, EV_INT_skin, 4)
					}
				}
				case(CS_TEAM_T):
				{
					clear_bit(g_PlayerRevolt, victim)
					clear_bit(g_PlayerWanted, victim)
				}
			}
		}
		default:
	{
		if(g_Duel != 2 && (attacker == g_DuelA || attacker == g_DuelB))
			//if (!is_user_connected(attacker) || !is_user_alive(attacker))
			//if (!is_user_connected(victim) || !is_user_alive(victim))
		{
			
			set_user_rendering(victim, kRenderFxNone, 0, 0, 0, kRenderNormal, 0)
			set_user_rendering(attacker, kRenderFxNone, 0, 0, 0, kRenderNormal, 0)
			g_Duel = 0
			g_LastDenied = 0
			g_PlayerLast = 0
			if (g_Duel == 5) 
			{
				player_strip_weapons(attacker)
				give_item(attacker,"weapon_knife")
			}					
		}
                hud_status(0)
	}
}
	return HAM_IGNORED
}


public SkinOff(id)
{
set_user_info(id, "model", "ultimate_zatvorenikk");
ColorChat(id, TEAM_COLOR, "^1[^4Ultimate-JB^1]^4Zao nam je :(,^1Ali tvoj skin cuvara je istekao.");
}

public GodOff(id)
{
set_user_godmode(id, 0)
ColorChat(id, TEAM_COLOR, "^1[^4Ultimate-JB^1]^4Zao nam je :(,^1Ali vas imunitet je istekao.");
}
public NoClipOff(id)
{
set_user_noclip(id, 0)
ColorChat(id, TEAM_COLOR, "^1[^4Ultimate-JB^1]^4Zao nam je :(,^1Ali vas Noclip je istekao.");
}

public Vidljivost(id)
{
ColorChat(id, TEAM_COLOR, "^1[^4Ultimate-JB^1]^4Zao nam je :(,^1Vasa vidljivost je ponovo vidljiva.");
set_user_rendering(id, kRenderFxGlowShell,0,0,0,kRenderTransAlpha, 255);
}

public VipOff(id)
{
ColorChat(id, TEAM_COLOR, "^1[^4Ultimate-JB^1]^4Zao nam je :(,^1Vas VIP je istekao.");
set_user_flags(id, ADMIN_ALL);
}

public MedicinHeal(id)
{
ColorChat(id, TEAM_COLOR, "^1[^4Ultimate-JB^1]^4Izdrzao si 1 minutu, bices nagradjen sa ^3 15HP-a.");
set_user_health(id, get_user_health(id)+15);
}

public hook_on(id)
{
if(!g_spiderman)
return PLUGIN_HANDLED

get_user_origin(id,hookorigin[id-1],3)

if(callfunc_begin("detect_cheat","prokreedz.amxx") == 1) {
callfunc_push_int(id)
callfunc_push_str("Hook")
callfunc_end()
}

ishooked[id-1] = true
if (cs_get_user_team(id) == CS_TEAM_T)
{
emit_sound(id,CHAN_STATIC,"weapons/ric2.wav",1.0,ATTN_NORM,0,PITCH_NORM)
}
else
{
emit_sound(id,CHAN_STATIC,"weapons/ric2.wav",1.0,ATTN_NORM,0,PITCH_NORM)	
}
set_task(0.1,"hook_task",id,"",0,"ab")
hook_task(id)

return PLUGIN_HANDLED
}

public is_hooked(id) {
return ishooked[id-1]
}

public hook_off(id) {
remove_hook(id)

return PLUGIN_HANDLED
}

public hook_task(id) {
if(!is_user_connected(id) || !is_user_alive(id))
remove_hook(id)

remove_beam(id)
draw_hook(id)

new origin[3], Float:velocity[3]
get_user_origin(id,origin) 
new distance = get_distance(hookorigin[id-1],origin)
if(distance > 25)  { 
velocity[0] = (hookorigin[id-1][0] - origin[0]) * (2.0 * 500 / distance)
velocity[1] = (hookorigin[id-1][1] - origin[1]) * (2.0 * 500 / distance)
velocity[2] = (hookorigin[id-1][2] - origin[2]) * (2.0 * 500 / distance)

entity_set_vector(id,EV_VEC_velocity,velocity)
} 
else {
entity_set_vector(id,EV_VEC_velocity,Float:{0.0,0.0,0.0})
remove_hook(id)
}
}


public draw_hook(id) {
message_begin(MSG_BROADCAST,SVC_TEMPENTITY)
write_byte(1)				// TE_BEAMENTPOINT
write_short(id)				// entid
write_coord(hookorigin[id-1][0])	// origin
write_coord(hookorigin[id-1][1])	// origin
write_coord(hookorigin[id-1][2])	// origin
write_short(g_iLaserSprite)			// sprite index
write_byte(0)				// start frame
write_byte(0)				// framerate
write_byte(1)				// life
write_byte(10)				// width
write_byte(4)				// noise
if (cs_get_user_team(id) == CS_TEAM_T) {	// Terrorist
write_byte(255)			// r
write_byte(255)			// g
write_byte(255)			// b
}
else {					// Counter-Terrorist
write_byte(0)			// r
write_byte(0)			// g
write_byte(0)			// b
}
write_byte(100)				// brightness
write_byte(0)				// speed
message_end()
}

public remove_hook(id) {
if(task_exists(id))
remove_task(id)
remove_beam(id)
ishooked[id-1] = false
}

public remove_beam(id) {
message_begin(MSG_BROADCAST,SVC_TEMPENTITY)
write_byte(99) // TE_KILLBEAM
write_short(id)
message_end()
}

public ugasi_hook()
{
g_spiderman = false	
}


public set_client_kv(id, const info[], const key[])
{
if(equal(key, "model"))
return FMRES_SUPERCEDE
	
return FMRES_IGNORED
}

public Show_DayModeMenu(id, pos)
{
	if (pos < 0) return;
	
	new b = 0, start = pos * 7;
	
	if (start >= g_gamesNums)
		start = pos = g_menuPosition[id] = 0;
	
	new menu[512], len;
	
	len = formatex(menu, 511, "\yGlasanje za igru \r-> \y[1/1]^n^n\dGlasanje traje jos: [\r%d\d]^n^n", g_iDayModeVoteTime);
	
	new end = start + 7, keys = (1<<9);
	
	if (end > g_gamesNums)
		end = g_gamesNums;
	
	for(new i = start; i < end; i++) {
		if(igra == i) {
			len += formatex(menu[len], 511 - len, "\y[%d].\d %s \r[\y-:-\r]^n", ++b, g_szVoteMenu[i]);
			} else {
			if (playervoted[id]) {
				len += formatex(menu[len], 511 - len, "\y[%d].\d %s \r[%d]^n", ++b, g_szVoteMenu[i], GameVotes[i]);
				} else {
				keys |= (1<<b);
				len += formatex(menu[len], 511 - len, "\y[%d].\w %s \r[%d]^n", ++b, g_szVoteMenu[i], GameVotes[i]);
			}
		}
	}
	
	if ( end != g_gamesNums ) {
		formatex(menu[len], 511 - len, "^n\y[9].\w Jos...^n\y[0].\w %s", pos ? "Nazad" : "Izlaz");
		keys |= (1<<8);
	} else
	formatex(menu[len], 511 - len, "^n\y[0].\w %s", pos ? "Nazad" : "Izlaz");
	
	show_menu(id, keys, menu, 2, "Show_DayMode_Menu");
}

public menu_handler( const id, const key ) {
	switch ( key ) {
		case 8: Show_DayModeMenu( id, ++g_menuPosition[id] );
			case 9: Show_DayModeMenu( id, --g_menuPosition[id] );
			default: {
			if (playervoted[id]) {
				if (g_iDayModeVoteTime)
			        ColorChat(id, GREEN, "[Ultimate JaiLBreaK] Uspesno ste glasali...");
				Show_DayModeMenu(id, g_menuPosition[id]);
				return PLUGIN_HANDLED;
			}
			
			new index = g_menuPosition[id] * 7 + key;
			if (index < g_gamesNums) {
				if(igra != index) {
					GameVotes[index]++;
					playervoted[id] = true;
                                        ColorChat(id, GREEN, "^1[Ultimate JaiLBreaK] Uspesno ste glasali...");
                                        emit_sound(id, CHAN_AUTO, "Ultimate/Novo/Pokusaj.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
				}
				Show_DayModeMenu(id, g_menuPosition[id]);
			}
		}
	}
	return PLUGIN_HANDLED;
}

public jbe_vote_day_mode_start()
{
	if (g_JailDay == 5 || g_JailDay == 8 || g_JailDay == 11 ) {
		runda = 0;
		remove_task(800);

		g_iDayModeVoteTime = 15 + 1;
		
		for (new i = 0; i < g_gamesNums; i ++)
			GameVotes[i] = 0;
		
		new aPlayers[32], num, pl, i;
		get_players(aPlayers, num, "ac");
		
		for (i = 0; i < num; i++)
		{
			pl = aPlayers[i];
			set_pev(pl, pev_flags, pev(pl, pev_flags) | FL_FROZEN);
			UTIL_ScreenFade(pl, 0, 0, 4, 0, 0, 0, 255);
			set_task(13.00, "Odledisveigrace", i, "", 0, "", 0);
                        g_BankaAktivna = false;
			playervoted[pl] = false;
			g_menuPosition[pl] = 0;
		}
		set_task(1.0, "jbe_vote_day_mode_timer", TASK_VOTE_DAY_MODE_TIMER, _, _, "a", g_iDayModeVoteTime);
		client_cmd(0, "mp3 play sound/UltimateJB/VoteDay/ultimate_igra_Novo.mp3");
        }
        
    }





public jbe_vote_day_mode_timer()
{
	if(!--g_iDayModeVoteTime)
		jbe_vote_day_mode_ended();
	
	new aPlayers[32], num, pl, i;
	get_players(aPlayers, num, "ch");
	
	for (i = 0; i < num; i++)
	{
		pl = aPlayers[i];
		Show_DayModeMenu(pl, g_menuPosition[pl]);
	}
}

public CompareVotes(const votes[], len)
{
	new maxx = 0;
	
	for(new i = 0; i < len; i++)
	{
		if(votes[i] > votes[maxx])
			maxx = i;
	}
	
	if(maxx == 0 && votes[0] == 0)
	{
		return -1;
	}
	
	return maxx;
}


public jbe_vote_day_mode_ended()
{
	new aPlayers[32], num, pl, i;
	get_players(aPlayers, num, "ac");
	for (i = 0; i < num; i++)
	{
		pl = aPlayers[i];
		set_pev(pl, pev_flags, pev(pl, pev_flags) & ~FL_FROZEN);
		UTIL_ScreenFade(pl, 512, 512, 0, 0, 0, 0, 255, 1);
	}
	new gamevotestemp = 0, gameid = -1;
	for (i = 0; i < g_gamesNums; i ++)
	{
		if(GameVotes[i] > gamevotestemp)
		{
			gameid = i;
			gamevotestemp = GameVotes[i];
		}
	}
	switch(gameid)
	{
			case 0:  cmd_sparta(i);
			case 1:  cmd_snajper(i);
			case 2:  cmd_presidentday(i);
		        case 3:  cmd_gangsteri(i);
                        case 4:  cmd_knifeday(i);
                        case 5:  cmd_ghostday(i);
		      case 6: cmd_freezetagday(i);
		}
	
	igra = gameid
	
}

	
public sound_emit(id, channel, sample[])
{
	if(is_user_alive(id) && (cs_get_user_team(id) == CS_TEAM_T) &&  equal(sample, "weapons/knife_", 14))
	{
		switch(sample[17])
		{
			case('b'):
			{
				emit_sound(id, CHAN_WEAPON, "Udarci/rukee/rukavice_udarac.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
			case ('w'):
			{
				emit_sound(id, CHAN_WEAPON, "Udarci/rukee/rukavice_udarac_zid.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
			case ('1', '2', '3', '4'):
			{ 
				emit_sound(id, CHAN_WEAPON, "Udarci/rukee/khmm_jb2.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
			case ('l'):
			{
				emit_sound(id, CHAN_WEAPON, "Udarci/rukee/srafciger_deploy.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
			case ('s'):
			{
				emit_sound(id, CHAN_WEAPON, "Udarci/rukee/rukavice_slash.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
		}
		return FMRES_SUPERCEDE
	}
	return FMRES_IGNORED
}

public sound_emit2(id, channel, sample[])
{
	if(is_user_alive(id) && (cs_get_user_team(id) == CS_TEAM_CT) &&  equal(sample, "weapons/knife_", 14))
	{
		switch(sample[17])
		{
			
			case('b'):
			{
				emit_sound(id, CHAN_WEAPON, "Udarci/pendrek/baton_stab.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
			case ('w'):
			{
				emit_sound(id, CHAN_WEAPON, "Udarci/pendrek/hitwall.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
			case ('1', '2', '3', '4'):
			{ 
				emit_sound(id, CHAN_WEAPON, "Udarci/pendrek/baton_hit.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
			case ('l'):
			{
				emit_sound(id, CHAN_WEAPON, "Udarci/pendrek/baton_deploy.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
			case ('s'):
			{
				emit_sound(id, CHAN_WEAPON, "Udarci/pendrek/baton_slash.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
		}
		return FMRES_SUPERCEDE
	}
	return FMRES_IGNORED
}




public voice_listening(receiver, sender, bool:listen)
{
	if((receiver == sender))
		return FMRES_IGNORED
	
	if (get_user_flags(sender) & ADMIN_VOTE)
	{
		engfunc(EngFunc_SetClientListening, receiver, sender, true)
		return FMRES_SUPERCEDE
	}
	
	switch(gc_VoiceBlock)
	{
		case(2):
		{
			if((sender != g_Simon) && (!get_bit(g_SimonVoice, sender) && gc_VoiceBlock))
			{
				engfunc(EngFunc_SetClientListening, receiver, sender, false)
				return FMRES_SUPERCEDE
			}
		}
		case(1):
		{
			if(!get_bit(g_SimonVoice, sender) && gc_VoiceBlock)
			{
				engfunc(EngFunc_SetClientListening, receiver, sender, false)
				return FMRES_SUPERCEDE
			}
		}
	}
	if(!is_user_alive(sender))
	{
		engfunc(EngFunc_SetClientListening, receiver, sender, false)
		return FMRES_SUPERCEDE
	}
	
	if(sender == g_Simon)
	{
		engfunc(EngFunc_SetClientListening, receiver, sender, true)
		return FMRES_SUPERCEDE
	}
	
	if(get_bit(g_PlayerVoice, sender))
	{
		engfunc(EngFunc_SetClientListening, receiver, sender, true)
		return FMRES_SUPERCEDE
	}
	
	listen = true
	
	if(g_SimonTalking && (sender != g_Simon))
	{
		listen = false
	}
	else
	{
		static CsTeams:steam
		steam = cs_get_user_team(sender)
		switch(gc_TalkMode)
		{
			case(2):
			{
				listen = (steam == CS_TEAM_CT)
			}
			case(1):
			{
				listen = (steam == CS_TEAM_CT || steam == CS_TEAM_T)
			}
		}
	}
	
	engfunc(EngFunc_SetClientListening, receiver, sender, listen)
	return FMRES_SUPERCEDE
}


public player_cmdstart(id, uc, random)
{
	if (!is_user_connected(id) || !is_user_alive(id))
		
	return
	
	if(g_Duel > 3)
		
{
	if (_Duel[g_Duel - 4][_csw] != CSW_M249) 	cs_set_user_bpammo(id, _Duel[g_Duel - 4][_csw], 1)
}
}

public round_first()
{
remove_task(TASK_COUNTDOWN);
g_JailDay = 0
for(new i = 1; i <= g_MaxClients; i++)
{
	g_PlayerSimon[i] = 0
	
}

set_cvar_num("sv_alltalk", 1)
set_cvar_num("mp_roundtime", 2)
set_cvar_num("mp_limitteams", 0)
set_cvar_num("mp_autoteambalance", 0)
set_cvar_num("mp_tkpunish", 0)
set_cvar_num("mp_friendlyfire", 0)
round_end()
g_GameMode = 1	
g_BoxStarted = 0
}

public round_end()
{
for(new i = 0; i < MAX_PLAYERS; i++)
{
g_WithdrawnThisRound[i] = 0;
g_DepositedThisRound[i] = 0;
g_TransferredThisRound[i] = 0;
}
server_cmd("jb_block_weapons")
server_cmd("cpe");
client_cmd(0, "stopsound");
set_cvar_num("mp_friendlyfire", 0);
g_BankaAktivna = true;
g_PlayerRevolt = 0
g_PlayerFreeday = 0
g_PlayerLast = 0
g_BoxStarted = 0
g_Simon = 0
g_SimonAllowed = 0
g_RoundStarted = 0
g_LastDenied = 0
g_Freeday = 0
g_RoundEnd = 1
g_Duel = 0
g_DuelOn = 0
g_spiderman = false

g_RoundEndTimer = 0
g_iBitUserGame = 0;
g_iBitUserFrozen = 0;

set_lights("#OFF")


remove_task(TASK_STATUS)
remove_task(TASK_FREEDAY)
remove_task(TASK_FREEEND)
remove_task(TASK_ROUND)
remove_task(TASK_KILLER_TIMER)
remove_task(TASK_COUNTDOWN);

jbe_duel_ended()

remove_task(800)
remove_task(801)
remove_task(999)
remove_task(900)
remove_task(901)
remove_task(700)

client_cmd(0, "mp3 stop");

new Players[32] 	

new playerCount, i 
get_players(Players, playerCount, "c") 
for (i=0; i<playerCount; i++) 
	
	if(is_user_alive(Players[i])) {
		set_pev(Players[i], pev_viewmodel2, "models/v_round_sound.mdl");
		UTIL_WeaponAnimation(Players[i], 0);
		kraj_runde(Players[i])
		set_pev(Players[i], pev_takedamage, DAMAGE_NO);
	}

for(new i = 0; i < sizeof(g_HudSync); i++)
ClearSyncHud(0, g_HudSync[i][_hudsync])
	
if (g_GameMode > 1) 
{
		
		new Players[32] 	
		
		new playerCount, i 
		get_players(Players, playerCount, "c") 
		for (i=0; i<playerCount; i++) 	
		{
			if (is_user_connected(Players[i]) || !is_user_alive(Players[i]))
			{
				if (get_bit(g_BackToCT, Players[i])) cs_set_user_team2(Players[i], CS_TEAM_CT)	
				client_infochanged(Players[i])
				set_user_maxspeed(Players[i], 250.0)
				menu_cancel(Players[i])
				player_strip_weapons(Players[i])
				fog(false, 0, 0, 0)
				clear_bit(g_BoxRuke1, Players[i])
				clear_bit(g_BoxRuke2, Players[i])
				clear_bit(g_GhostRuke, Players[i])
				clear_bit(g_CandyCane, Players[i])
                                clear_bit(g_TerminatorRuke, Players[i])
                                clear_bit(g_FudbalRuke, Players[i])
                                clear_bit(g_Spider, Players[i])
                                clear_bit(g_SpartaStit, Players[i])
                                g_spiderman = false 
				set_lights("#OFF")
				set_pev(Players[i], pev_viewmodel2, "models/v_round_sound.mdl");
				message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
				write_byte(TE_KILLPLAYERATTACHMENTS)
				write_byte(Players[i])
				message_end()
				UTIL_WeaponAnimation(Players[i], 0);
				set_lights("#OFF");
				set_user_godmode(Players[i], 0)
				
			}
			
		}
		remove_task(7447)
		remove_task(666)
		g_BackToCT = 0
	}
for(i = 0; i < sizeof(g_iHamHookForwards3); i++)
DisableHamForward(g_iHamHookForwards3[i]);
	
g_GameMode = 1
}


public SimonAllowed()
{
	g_SimonAllowed = 1
}
public round_start()
{
        
	gc_TalkMode = get_pcvar_num(gp_TalkMode)
	gc_VoiceBlock = get_pcvar_num(gp_VoiceBlock)
	gc_SimonSteps = get_pcvar_num(gp_SimonSteps)
	gc_ButtonShoot = get_pcvar_num(gp_ButtonShoot)
	get_pcvar_string(gp_TShop, Tallowed,31)
	get_pcvar_string(gp_CTShop, CTallowed,31)
	g_GameMode = 1
	g_SimonAllowed = 0
        set_task(5.0, "Provera")
	
	get_cvar_string("amx_nextmap",nextmap,31)
	set_task( 1.0, "FDodborajanje", 800, _, _, "a", 30 )
	
	
	if(g_JailDay >= 2){
		set_dhudmessage(0, 150, 200, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
	}
	
	g_nogamerounds++
	
	Time = 180;
	FreeDayTrajanje = 240;
	DajFD = 20;
	ZmurkaIgra = 30;
	PresidentIgra = 30;
	
	
	set_task(4.00, "hud_status", 2487000, "", 0, "b", 0);
	set_task(random_float(2.00, 5.00), "SimonAllowed", 0, "", 0, "", 0);
	
	if(g_JailDay==1) {

		set_task( 1.0, "FreeDayKraj", 700, _, _, "a", 240 )
		jail_open()
		Time = FDKraj;
		FDKraj = 0;
		g_Simon = 0
		set_dhudmessage(0, 128, 0, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
		show_dhudmessage(0, "! Slobodan dan je upravo poceo !");
		remove_task(800)
		set_dhudmessage(255, 255, 255, 0.03, 0.55, 0, 2.0, 3.0, 0.2, 0.2, false)
		Color_Print(0, "!g[Ultimate FD] Zatvorenici su dobili slobodan dan.")
                ColorChat(0, TEAM_COLOR, "^4[Ultimate INFO] ^3Trenutna Pesma -> Biba - Top");
                client_cmd(0, "mp3 play sound/jbextreme/topp.mp3");
		g_GameMode = 0
                hud_status(0)
		g_PlayerFreeday = 0
		new Players[32] 
		new playerCount, i 
		get_players(Players, playerCount, "ac")
		for (i=0; i<playerCount; i++) 
		{
			entity_set_int(Players[i], EV_INT_skin, 3)
		}
		new Float:FDLEN = get_pcvar_float(gp_FDLength) 
		if (FDLEN < 20.0) FDLEN = 99999.0
		set_task(FDLEN, "task_freeday_end",TASK_FREEEND)
		return;
	}
	
	if(g_JailDay==5) {
     
               set_dhudmessage(127, 255, 0, 0.29, 0.11, 0, 6.0, 12.0)
               show_dhudmessage(0, "> Trenutno su igre <");
               g_BankaAktivna = false;
                 
	}

	if(g_JailDay==8) {
     
               set_dhudmessage(127, 255, 0, 0.29, 0.11, 0, 6.0, 12.0)
               show_dhudmessage(0, "> Trenutno igre <");
               g_BankaAktivna = false;
	}
	
	if(g_JailDay==15) {

		set_task( 1.0, "FreeDayKraj", 700, _, _, "a", 240 )
		jail_open()
		Time = FDKraj;
		FDKraj = 0;
		g_Simon = 0
		set_dhudmessage(0, 128, 0, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
		show_dhudmessage(0, "! Slobodan dan je upravo poceo !");
		remove_task(800)
		set_dhudmessage(255, 255, 255, 0.03, 0.55, 0, 2.0, 3.0, 0.2, 0.2, false)
		Color_Print(0, "!g[Ultimate FD] Zatvorenici su dobili slobodan dan.")
                ColorChat(0, TEAM_COLOR, "^4[Ultimate INFO] ^3Trenutna Pesma -> THFC - Sta sam kriv vam ja");
                client_cmd(0, "mp3 play sound/jbextreme/zadnji.mp3");
		g_GameMode = 0
                hud_status(0)
		g_PlayerFreeday = 0
		new Players[32] 
		new playerCount, i 
		get_players(Players, playerCount, "ac")
		for (i=0; i<playerCount; i++) 
		{
			entity_set_int(Players[i], EV_INT_skin, 3)
		}
		new Float:FDLEN = get_pcvar_float(gp_FDLength) 
		if (FDLEN < 20.0) FDLEN = 99999.0
		set_task(FDLEN, "task_freeday_end",TASK_FREEEND)
		return;
	}
	
}

public _t_Countdown(taskid)
{
    Time += -1;
    DefaultValue += 1;
    set_hudmessage(0, 200, 255, 0.03, 0.20, 0, 6.00, 12.00, 0.10, 0.20, 4);
    show_hudmessage(0, "-= Danas je JailBreak Igra [%d] =-^n-= Sva vrsta Menija & Shopa je zakljucana =-", Time);
    if (Time)
    {
        return 0;
    }
    Time = DefaultValue;
    new iPlayers[32];
    new iNum = 0;
    get_players(iPlayers, iNum, "a", "");
    new i = 0;
    while (i < iNum)
    {
        if(cs_get_user_team(iPlayers[i]) == CS_TEAM_CT)
        {
            user_kill(iPlayers[i], 0);
            i++;
        }
        i++;
    }
    return 0;
}

new const g_Days[][] =  
{
"Ponedeljak",
"Slobodan Dan",
"Sreda",
"Cetvrtak",
"Glasanje za Igre",
"Subota",
"Nedelja",
"Ponedeljak",
"Glasanje za Igre",
"Sreda",
"Cetvrtak" ,
"Glasanje za Igre",
"Slobodan Dan" 
}

public FreeDayKraj( taskid )
{
FreeDayTrajanje--
ZavrsetakFD++
set_hudmessage(0, 255, 0, 0.03, 0.20, 0, 6.00, 12.00, 0.10, 0.20, 4);
show_hudmessage(0, "Trenutno je: Slobodan Dan^nSlobodan Dan se zavrsava za [%d]", FreeDayTrajanje)
if(FreeDayTrajanje == 0)
{
	set_hudmessage(0, 255, 255, 0.34, 0.17, 0, 6.0, 12.0)
	show_hudmessage(0, "Slobodan dan se zavrsio - Slusajte simona svi !")
}
}


public cmd_voiceon(id)
{
client_cmd(id, "+voicerecord")
set_bit(g_SimonVoice, id)
if(g_Simon == id)
set_bit(g_SimonTalking, id)

return PLUGIN_HANDLED
}

public cmd_voiceoff(id)
{
	client_cmd(id, "-voicerecord")
	clear_bit(g_SimonVoice, id)
	if(g_Simon == id)
		clear_bit(g_SimonTalking, id)
	
	return PLUGIN_HANDLED
}

public cmd_simon(id)
{
	static CsTeams:team, name[32]
	if (!is_user_connected(id) || !is_user_alive(id))
		return PLUGIN_HANDLED
	
    
	team = cs_get_user_team(id)

        if (g_CandyCane)
        {
        ColorChat(id, TEAM_COLOR, "[%s] Ne mozes da uzimas sajmona dok traje igra ledeni cika!", PLUGIN_PREFIX);
        return 1;
        }
	if(g_SimonAllowed != 0 && !g_Freeday && is_user_alive(id) && team == CS_TEAM_CT && !g_Simon)
	{
		set_user_health(id, 390)
		g_Simon = id
		get_user_name(id, name, charsmax(name))
		entity_set_int(id, EV_INT_body, 1)
		g_PlayerSimon[id]--
		if(get_pcvar_num(gp_GlowModels))
			player_glow(id, g_Colors[0])
		give_item(id, "weapon_deagle")
		give_item(id, "weapon_m249")
		give_item(id, "weapon_m4a1")
		give_item(id, "weapon_ak47")
		give_item(id, "weapon_awp")
                give_item(id, "weapon_usp") 
		cs_set_user_bpammo(id, CSW_M4A1, 300)
		cs_set_user_bpammo(id, CSW_AK47, 300)
		cs_set_user_bpammo(id, CSW_AWP, 300)
		cs_set_user_bpammo(id, CSW_DEAGLE, 300)
                cs_set_user_bpammo(id, CSW_USP, 200)
		give_item(id, "weapon_smokegrenade")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_50ae")
		give_item(id, "ammo_556natobox")
		give_item(id, "ammo_556natobox")
		give_item(id, "ammo_556natobox")
		give_item(id, "ammo_556natobox")
		give_item(id, "ammo_556natobox")
		cmd_simonmenu(id)
		hud_status(0)
		get_user_name(id, nick, 63)
		set_user_info(id, "model", "ultimate_simon_new")
		remove_task(800)
		ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^3%s ^1je postao simon.Slusajte njegova narednjenja.", nick)
		set_user_gravity(id, 0.5)
                set_user_health(id, 370)
		set_user_armor(id, 255)

	}
	return PLUGIN_HANDLED
}

public VIPMenu( id )
{
        if(!has_used[id])
        {
                if ( ( get_user_flags( id ) & ADMIN_LEVEL_H))
                {
                        new vip_menu = menu_create( "\rUltimate JB \w| \rVIP Menu:", "vip_menu" );
                        menu_additem( vip_menu, "\yUzmi \d[ \rBomb Pack \d]", "1", 0 );
                        menu_additem( vip_menu, "\yUzmi \d[ \rGravitaciju \d]", "2", 0 );
			menu_additem( vip_menu, "\yUzmi \d[ \r200 HP + 150 AP \d]", "3", 0);
			menu_additem( vip_menu, "\yUzmi \d[ \rBrzina \d]", "4", 0);
			
			
			
                        menu_setprop( vip_menu, MPROP_EXIT, MEXIT_ALL );
                        menu_display( id, vip_menu, 0 );
                        vote_day_l0ck(id)
                }
                else
                {
                        ColorChat(id, GREEN, "^x04[^x03Ultimate VIP^x04] Nisi VIP Clan. VIP kosta 1 Boost.")
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
                }
        }
        else
        {
                ColorChat(id, GREEN, "^x04[^x03Ultimate VIP^x04] Pokusaj opet sledece runde, vec si iskoristio vipmenu.")
		emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
		
        }
        return PLUGIN_HANDLED
}

public vip_menu( id, menu, item ) 
{ 
	if( item == MENU_EXIT ) 
	{ 
		menu_destroy( menu ); 
		return PLUGIN_HANDLED
	} 
	new data[6], iName[64]; 
	new access, callback; 
	
	menu_item_getinfo( menu, item, access, data,5, iName, 63, callback ); 
	new key = str_to_num( data ); 
	switch( key ) 
	{ 
		case 1: 
		{ 
			if( is_user_alive( id ) ) 
			{ 
				give_item( id, "weapon_hegrenade" )
				give_item( id, "weapon_flashbang" )
				give_item( id, "weapon_flashbang" )
				give_item( id, "weapon_smokegrenade" )
				ColorChat(id, TEAM_COLOR, "^4[Ultimate JB] ^1Uspesno si uzeo ^3Sve bombe!");
				emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Accept.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
				
			} 
		} 
		case 2: 
		{ 
			if( is_user_alive( id ) ) 
			{ 
				set_user_gravity( id, 0.4 )
				ColorChat(id, TEAM_COLOR, "^4[Ultimate JB] ^1Uspesno si uzeo ^3Gravitaciju!");
				emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Accept.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
				
			}    

		}
		case 3:
		{
			if(is_user_alive(id)) 
			{ 
				set_user_health(id, get_user_health(id)+40);
				set_user_armor(id, get_user_armor(id)+100);
				ColorChat(id, TEAM_COLOR, "^4[Ultimate JB] ^1Uspesno si uzeo ^3+200 HP + 150 Armora!");
				emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Accept.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
				
			}
		}
		case 4:
		{
			if(is_user_alive(id)) 
			{ 
                                set_user_maxspeed(id, 500.00);
				ColorChat(id, TEAM_COLOR, "^4[Ultimate JB] ^1Uspesno si uzeo ^3Brzinu");
				emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Accept.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
				
			}
		}
				
	}   
	
        vote_day_l0ck(id)
	has_used[id] = true; 
	menu_destroy( menu ); 
        if(g_JailDay != 2 && g_JailDay != 8) return PLUGIN_HANDLED;
	 
	return PLUGIN_HANDLED_MAIN
} 

public GLMenu( id ){
		if ( ( get_user_flags( id ) & ADMIN_RCON))
		{
			new gl_menu = menu_create( "\rUltimate-JB \d[ \yOwner Menu \d]:", "gl_handler" );
			menu_additem( gl_menu, "\wUzmi: \yFreeDay", "1", 0 );
			menu_additem( gl_menu, "\wUzmi: \y16000$", "2", 0);
			menu_additem( gl_menu, "\wUzmi: \yOruzje \y[Samo Vlasnik]", "3", 0);
			menu_additem( gl_menu, "\wUzmi: \yGravitaciju", "4", 0);
			menu_additem( gl_menu, "\wUzmi: \yBrzina", "5", 0);
			
			
			menu_setprop( gl_menu, MPROP_EXIT, MEXIT_ALL );
			menu_display( id, gl_menu, 0 );
		}
		else
		{
			ColorChat(0, TEAM_COLOR, "^1[^4Ultimate-JB^1] ^4Zao nam je :(, ^1Ali vi niste vlasnik da bi koristili meni istog.");
			
		}
}  

public gl_handler( id, menu, item ) 
{ 
	if( item == MENU_EXIT ) 
	{ 
		menu_destroy( menu ); 
		return PLUGIN_HANDLED
	} 
	new data[6], iName[64]; 
	new access, callback; 
	
	menu_item_getinfo( menu, item, access, data,5, iName, 63, callback ); 
	new key = str_to_num( data ); 
	switch( key ) 
	{ 
		case 1: 
		{ 
			if( is_user_alive( id ) ) 
			{ 
				freeday_set(0, id)
				ColorChat(id, TEAM_COLOR, "^1[^4Ultimate-JB^1] ^1Uspesno si uzeo ^3FreeDay!");
				
			} 
		} 
		case 2: 
		{ 
			if( is_user_alive( id ) ) 
			{ 
                                cs_set_user_money(id, cs_get_user_money(id) + 16000)
                                ColorChat(id, GREEN, "^1[^4Ultimate-JB^1] ^x04 Uspesno si uzeo ^x0316000$. ")
				
			} 
		} 
		case 3: 
		{ 
			if( is_user_alive( id ) ) 
			{ 
                                TtWeapons(id);
                                ColorChat(id, GREEN, "^1[^4Ultimate-JB^1] ^x04 Uspesno si usao u ^x03Guns meni. ")
			}    
			
		}
		case 4:
		{
			if(is_user_alive(id)) 
			{ 
				set_user_gravity( id, 0.3 )
				ColorChat(id, TEAM_COLOR, "^1[^4Ultimate-JB^1] ^1Uspesno si uzeo ^3Gravitaciju");
				
			}
		}
		case 5:
		{
			if(is_user_alive(id)) 
			{ 
				set_user_maxspeed(id, get_user_maxspeed(id)+999.0);
				ColorChat(id, TEAM_COLOR, "^1[^4Ultimate-JB^1] ^1Uspesno si uzeo ^3Brzinu!");
				
			}
		}
		
	}   

	menu_destroy( menu ); 
        if(g_JailDay != 2 && g_JailDay != 8) return PLUGIN_HANDLED;
	
	return PLUGIN_HANDLED_MAIN
} 

public event_new_round() 
{
	runda ++;
	jbe_vote_day_mode_start();
	arrayset(has_used, false, 33)
	
	if(runda == 3) 
        if(runda == 7)
	{
		remove_task(800);
	}
	
}


public cmd_open(id)
{
    if((id == g_Simon) || (get_user_flags(id) & ADMIN_LEVEL_A))
        jail_open();
	
    return PLUGIN_HANDLED;
}

public cmd_close(id)
{
    if((id == g_Simon) || (get_user_flags(id) & ADMIN_LEVEL_A))
        jail_open();
	
    return PLUGIN_HANDLED;
}

public cmd_box(id)
{
	
	if((id == g_Simon || (get_user_flags(id) & ADMIN_RCON)) && g_GameMode == 1)
	{
		new Players[32]
		new playerCount, i, TAlive
		get_user_name(id, nick, 63)
		set_dhudmessage(255, 0, 0, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
		show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_DAOBOKS")
		Color_Print(0, "!g[Ultimate-JB] !team%s !yje ukljucio Boks.", nick)
		get_players(Players, playerCount, "ac")
                client_cmd(0, "mp3 play sound/jbextreme/boks.mp3");
		for (i=0; i<playerCount; i++)
		{
			if (is_user_connected(Players[i]))         
				if( cs_get_user_team(Players[i]) == CS_TEAM_T )
				TAlive++;
		}
		
		if(TAlive <= get_pcvar_num(gp_BoxMax) && TAlive > 1)
		{
			for(i = 1; i <= g_MaxClients; i++)
				if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T) {
				set_user_health(i, 100)
				cs_set_user_armor(i, 0, CS_ARMOR_NONE) 
				set_bit(g_BoxRuke1, i)			
			}
			
			set_cvar_num("mp_tkpunish", 0)
			set_cvar_num("mp_friendlyfire", 1)
			g_BoxStarted = 1
			player_hudmessage(0, 1, 3.0, _, "%L", LANG_SERVER, "JBEF_GUARD_BOX")
		}
		else
		{
			player_hudmessage(id, 1, 3.0, _, "%L", LANG_SERVER, "JBEF_GUARD_CANTBOX")
		}
	}
	return PLUGIN_HANDLED
}

public cmd_help(id)
{
	if(id > g_MaxClients)
		id -= TASK_HELP
	
	remove_task(TASK_HELP + id)
	show_motd(id,"jb_help.txt","Ultimate-JB Pravila");
	
}



public cmd_freeday(id)
{
	if (g_GameMode == 1)
	{
		static menu, menuname[32], option[64]
		if((id == g_Simon) || (get_user_flags(id) & ADMIN_LEVEL_A))
			
	{
		formatex(menuname, charsmax(menuname), "%L", LANG_SERVER, "JBEF_MENU_FREEDAY")
		menu = menu_create(menuname, "freeday_choice")
		
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_FREEDAY_PLAYER")
		menu_additem(menu, option, "1", 0)
        
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_FREEDAY_ALL")
		menu_additem(menu, option, "2", 0)
           
		
		menu_display(id, menu)
	}	
}
	return PLUGIN_HANDLED
}

public cmd_freeday_player(id)
{
if((id == g_Simon) || (get_user_flags(id) & ADMIN_LEVEL_A))
menu_players(id, CS_TEAM_T, id, 1, "freeday_select", "%L", LANG_SERVER, "JBEF_MENU_FREEDAY")
	
return PLUGIN_HANDLED
}

public cmd_lastrequest(id)
{
	
	static i, num[5], menu, menuname[64], option[64]
	if (!is_user_alive(g_PlayerLast)) task_last();
	if(!get_pcvar_num(gp_LastRequest) || g_Freeday || g_LastDenied || g_PlayerLast !=id || !is_user_alive(id) || g_GameMode >= 2)
		return PLUGIN_CONTINUE
	
	
	formatex(menuname, charsmax(menuname), "%L", LANG_SERVER, "JBEF_MENU_LASTREQ")
	menu = menu_create(menuname, "lastrequest_select")

	formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_LASTREQ_FD")
	menu_additem(menu, option, "2", 0)
	
	formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_LASTREQ_OPT3")
	menu_additem(menu, option, "3", 0)
	
	for(i = 0; i < sizeof(_Duel); i++)
	{
		num_to_str(i + 4, num, charsmax(num))
		formatex(option, charsmax(option), "%L", LANG_SERVER, _Duel[i][_opt])
		menu_additem(menu, option, num, 0)
	}
	
	
	menu_display(id, menu)
	return PLUGIN_CONTINUE
}

public adm_freeday(id)
{

	static player, user[32]
	if(get_user_flags(id) & ADMIN_RCON)
		return PLUGIN_CONTINUE
	
	read_argv(1, user, charsmax(user))
	player = cmd_target(id, user, 2)
	if(is_user_connected(player) && cs_get_user_team(player) == CS_TEAM_T)
	{
		freeday_set(id, player)
	}
	return PLUGIN_HANDLED
}

public adm_open(id)
{
	if(get_user_flags(id) & ADMIN_LEVEL_A)
		return PLUGIN_CONTINUE
	
	jail_open()
	return PLUGIN_HANDLED
}

public adm_box(id)
{
	if(get_user_flags(id) & ADMIN_RCON)
		return PLUGIN_CONTINUE
	
	cmd_box(-1)
	return PLUGIN_HANDLED
}

public revolt_start()
{
	client_cmd(0,"speak jbextreme/sirren")
	set_task(8.0, "stop_sound")
}

public stop_sound(task)
{
	client_cmd(0, "stopsound")
}


public show_color(id)
{
	new n = 0;
	if (id == 0)
	{
		
		
		new Players[32] 
		new playerCount, i 
		get_players(Players, playerCount, "ac") 
		for (i=0; i<playerCount; i++) 
		{
			if (is_user_connected(Players[i])) 
				if ( cs_get_user_team(Players[i]) == CS_TEAM_T && is_user_alive(Players[i]))
			{
				n=entity_get_int(Players[i], EV_INT_skin);
				switch (n)
				{
					case 0: 
					{
						
						player_hudmessage(Players[i], 10, HUD_DELAY + 1.0, {255, 165, 0}, "%L", LANG_SERVER,	"JBEF__COLOR_ORANGE")
					}
					
					case 1: 
					{
						
						player_hudmessage(Players[i], 10, HUD_DELAY + 1.0, {128, 0, 128}, "%L", LANG_SERVER,	"JBEF__COLOR_PURPLE")
					}
					
					case 2: 
					{
						player_hudmessage(Players[i], 10, HUD_DELAY + 1.0, {255, 255, 0}, "%L", LANG_SERVER,	"JBEF__COLOR_YELLOW")
					}
					
					case 3: 
					{
						player_hudmessage(Players[i], 10, HUD_DELAY + 1.0, {0, 200, 0}, "%L", LANG_SERVER,	"JBEF__COLOR_GREEN")
					}
					
					case 4: 
					{
						
						player_hudmessage(Players[i], 10, HUD_DELAY + 1.0, {200, 0, 0}, "%L", LANG_SERVER,	"JBEF__COLOR_RED")
					}
				}
				
			}
		}
	}
	else
		
{
	n=entity_get_int(id, EV_INT_skin);
	switch (n)
	{
		case 0: 
		{
			
			player_hudmessage(id, 10, HUD_DELAY + 1.0, {255, 165, 0}, "%L", LANG_SERVER,	"JBEF__COLOR_ORANGE")
		}
		
		case 1: 
		{
			
			player_hudmessage(id, 10, HUD_DELAY + 1.0, {128, 0, 128}, "%L", LANG_SERVER,	"JBEF__COLOR_PURPLE")
		}
		
		case 2: 
		{
			player_hudmessage(id, 10, HUD_DELAY + 1.0, {255, 255, 0}, "%L", LANG_SERVER,	"JBEF__COLOR_YELLOW")
		}
		
		case 3: 
		{
			player_hudmessage(id, 10, HUD_DELAY + 1.0, {0, 200, 0}, "%L", LANG_SERVER,	"JBEF__COLOR_GREEN")
		}
		
		case 4: 
		{
			
			player_hudmessage(id, 10, HUD_DELAY + 1.0, {200, 0, 0}, "%L", LANG_SERVER,	"JBEF__COLOR_RED")
		}
	}	
	
}
}

public proveri_admine(id) {
admin_num = 0;
new igraci[32], broj_igraca;
get_players(igraci,broj_igraca,"c");
for(new i = 0; i <= broj_igraca; i++) {
new id = igraci[i];
if(!is_user_connected(id)) continue;
if(get_user_flags(id) & ADMIN_KICK)
admin_num++;
}
}

stock show_count()
{
new map[32];
new szIP[33];
new serverName[64]; 
get_cvar_string("amx_nextmap", map, 31);
new date[34];
new iCurrentDay[16]
get_user_ip(0, szIP, 32);
get_time("%d.%m.%Y",iCurrentDay,15)
new Players[32] 
new iPlayers[32],iNum;
new playerCount, i, TAlive,TAll,CTAll,CTAlive
new Time[34];
new hostname_cvar = get_cvar_pointer("hostname");
if(hostname_cvar) {
get_pcvar_string(hostname_cvar, serverName, sizeof(serverName));
}
get_players(Players, playerCount, "c")
get_players(iPlayers,iNum,"c");
get_time("Vreme - [%H:%M]",Time,32);
get_time("Datum - [%d.%m.%Y]", date, 32);


for (i=0; i<playerCount; i++) 
{
		if (is_user_connected(Players[i])) 
		
		if ( cs_get_user_team(Players[i]) == CS_TEAM_T)
		{
			TAll++;
			if (is_user_alive(Players[i])) TAlive++;
		}
		if ( cs_get_user_team(Players[i]) == CS_TEAM_CT)
		{
			CTAll++;
			if (is_user_alive(Players[i])) CTAlive++;
		}
	}
player_hudmessage(i, 11, HUD_DELAY, {0, 170, 255}, "^n%s^n%s^n-------------------^nDanas je: %s^nDan je: %d | 15^nAdmins Online: %d^nSledeca mapa: %s^n-------------------^n%s^n%s^nRobijasi - [%i / %i]^nCuvari - [%i / %i]^n-------------------", serverName, szIP, g_Days [g_JailDay],g_JailDay,admin_num, map, Time, date,  TAlive, TAll, CTAlive, CTAll);
}

public hud_status(task)
{
	static i, n
	new name[32], wanted[512], fdlist[512]
	if(g_RoundStarted < (get_pcvar_num(gp_RetryTime) / 2))
		g_RoundStarted++
	
	switch (g_GameMode)
		
{
	case 0:
	{
		show_count()
		
		n = 0
		formatex(wanted, charsmax(wanted), "%L", LANG_SERVER, "JBEF_PRISONER_WANTED")
		n = strlen(wanted)
		for(i = 0; i < g_MaxClients; i++)
		{
			
			if(get_bit(g_PlayerWanted, i) && is_user_alive(i) && n < charsmax(wanted))
			{
				get_user_name(i, name, charsmax(name))
				n += copy(wanted[n], charsmax(wanted) - n, "^n^t")
				n += copy(wanted[n], charsmax(wanted) - n, name)
			}
		}
		
                set_hudmessage(0, 255, 0, 0.03, 0.20, 0, 6.00, 12.00, 0.10, 0.20, 4);
                show_hudmessage(0, "Trenutno je: Slobodan Dan^nSlobodan Dan se zavrsava za [%d]", FreeDayTrajanje)
		if(g_PlayerWanted)
			player_hudmessage(0, 3, HUD_DELAY + 1.0, {255, 0, 0}, "%s", wanted)
			else if(g_PlayerRevolt)
				player_hudmessage(0, 3, HUD_DELAY + 1.0, {255, 0, 0}, "%L", LANG_SERVER, "JBEF_PRISONER_REVOLT")	
		}
		
		case 1:	
		{
			show_count()
			if (get_pcvar_num (gp_ShowColor) == 1) show_color(0)
			
			if (get_pcvar_num (gp_ShowFD) == 1) 
			{
				n = 0
				formatex(fdlist, charsmax(fdlist), "%L", LANG_SERVER, "JBEF_FREEDAY_SINGLE")
				n = strlen(fdlist)
				for(i = 0; i < g_MaxClients; i++)
				{
					if(get_bit(g_PlayerFreeday, i) && is_user_alive(i) && n < charsmax(fdlist))
					{
						get_user_name(i, name, charsmax(name))
						n += copy(fdlist[n], charsmax(fdlist) - n, "^n^t")
						n += copy(fdlist[n], charsmax(fdlist) - n, name)
					}
					
				}
				if(g_PlayerFreeday)		
					player_hudmessage(0, 9, HUD_DELAY + 1.0, {0, 255, 0}, "%s", fdlist)	
				
			}
			
			if (get_pcvar_num (gp_ShowWanted) == 1) 
			{	
				n = 0
				formatex(wanted, charsmax(wanted), "%L", LANG_SERVER, "JBEF_PRISONER_WANTED")
				n = strlen(wanted)
				for(i = 0; i < g_MaxClients; i++)
				{
					if(get_bit(g_PlayerWanted, i) && is_user_alive(i) && n < charsmax(wanted))
					{
						get_user_name(i, name, charsmax(name))
						n += copy(wanted[n], charsmax(wanted) - n, "^n^t")
						n += copy(wanted[n], charsmax(wanted) - n, name)
					}
				}
				if(g_PlayerWanted)
					player_hudmessage(0, 3, HUD_DELAY, {255, 50, 0}, "%s", wanted)
				
			}
			if(!g_Simon && g_SimonAllowed )
			{
				cmd_simon(random_num(1, g_MaxClients))
			}
			else  if (g_Simon  != 0)
		{
			get_user_name(g_Simon, name, charsmax(name))
			set_hudmessage(0, 200, 255, 0.03, 0.20, 0, 6.00, 12.00, 0.10, 0.20, 4);
			show_hudmessage(0, "Trenutno je: Obican dan^nSajmon: Ziv, %s", name)
		}
			if(g_PlayerRevolt)
			player_hudmessage(0, 3, HUD_DELAY, {255, 0, 0}, "%L", LANG_SERVER, "JBEF_PRISONER_REVOLT")	
		}
		
		case 6:
		{
			
		}
		case 7:
		{
			
		}
		case 8:
		{
			
		}
		case 3:
		{
			
		}
		case 10:
		{
			
		}
		case 11:
		{
			
		}
		case 12:
		{
			
		}
		case 13:
		{
			
		}
		case 14:
		{
			
		}
	}
}

public TtWeapons(iPlayer) {
	if(cs_get_user_team(iPlayer) == CS_TEAM_T) 
	{
		new iMenu = menu_create("\yUltimate JB | Robijas Gun", "CtWeapons_Handle");
                menu_additem(iMenu, "\wAK47 \r+\wGlock \r200HP");
                menu_additem(iMenu, "\wM4A1 \r+\wUsp \r200HP");
                menu_additem(iMenu, "\wAWP \r+\wDeagle \r250HP");       //////// Terori Oruzije
                menu_additem(iMenu, "\wM3 \r+\wDeagle \r220HP");
                menu_additem(iMenu, "\wFAMAS \r+\wUsp \r232HP");
                menu_additem(iMenu, "\wP90 \r+\wDeagle \r260HP");
                menu_additem(iMenu, "\wM249 \r+\wGlock \r204HP");
		menu_display(iPlayer, iMenu )
	}
}
public CtWeapons(iPlayer) {
	if(cs_get_user_team(iPlayer) == CS_TEAM_CT) 
	{
		new iMenu = menu_create("\yUltimate JB | Cuvar Gun", "CtWeapons_Handle");
                menu_additem(iMenu, "\wAK47 \r+\wGlock \r200HP");
                menu_additem(iMenu, "\wM4A1 \r+\wUsp \r200HP");
                menu_additem(iMenu, "\wAWP \r+\wDeagle \r250HP");       //////// Cuvari Oruzije
                menu_additem(iMenu, "\wM3 \r+\wDeagle \r220HP");
                menu_additem(iMenu, "\wFAMAS \r+\wUsp \r232HP");
                menu_additem(iMenu, "\wP90 \r+\wDeagle \r260HP");
                menu_additem(iMenu, "\wM249 \r+\wGlock \r204HP");
		menu_display(iPlayer, iMenu )
	}
}

public CtWeapons_Handle(iPlayer, iMenu, iItem) {  
	if(iItem == MENU_EXIT) {
		menu_destroy(iMenu)
		return PLUGIN_CONTINUE;
	}
	
	if(!is_user_alive(iPlayer))
		return PLUGIN_CONTINUE;
	
	switch(iItem) {
		case 0: {
			give_item(iPlayer, "weapon_ak47");
           		cs_set_user_bpammo(iPlayer, CSW_AK47, 200);
			give_item(iPlayer, "weapon_glock18");
			cs_set_user_bpammo(iPlayer, CSW_GLOCK18, 200);
			set_user_health(iPlayer, 200);
		}
		
		case 1: {
			give_item(iPlayer, "weapon_m4a1");
			cs_set_user_bpammo(iPlayer, CSW_M4A1, 2000);
			give_item(iPlayer, "weapon_usp");
			cs_set_user_bpammo(iPlayer, CSW_USP, 200);
			set_user_health(iPlayer, 200);
		}
		
		case 2: {
			give_item(iPlayer, "weapon_awp");
			cs_set_user_bpammo(iPlayer, CSW_AWP, 200);
			give_item(iPlayer, "weapon_deagle");
			cs_set_user_bpammo(iPlayer, CSW_DEAGLE, 200);
			set_user_health(iPlayer, 250);
		}
		
		case 3: {
			give_item(iPlayer, "weapon_m3");
			cs_set_user_bpammo(iPlayer, CSW_M3, 202);
			give_item(iPlayer, "weapon_deagle");
			cs_set_user_bpammo(iPlayer, CSW_DEAGLE, 200);
			set_user_health(iPlayer, 220);
		}
		
		case 4: {
			give_item(iPlayer, "weapon_famas");
 			cs_set_user_bpammo(iPlayer, CSW_FAMAS, 200);
			give_item(iPlayer, "weapon_usp");
			cs_set_user_bpammo(iPlayer, CSW_USP, 200);
			set_user_health(iPlayer, 232);
		}
	
		case 5: {
			give_item(iPlayer, "weapon_p90");
			cs_set_user_bpammo(iPlayer, CSW_P90, 200);
			give_item(iPlayer, "weapon_deagle");
			cs_set_user_bpammo(iPlayer, CSW_DEAGLE, 200);
			set_user_health(iPlayer, 260);
		}
		case 6: {
			give_item(iPlayer, "weapon_m249");
			cs_set_user_bpammo(iPlayer, CSW_M249, 200);
			give_item(iPlayer, "weapon_glock18");
			cs_set_user_bpammo(iPlayer, CSW_GLOCK18, 200);
			set_user_health(iPlayer, 204);
		}
	}

	
	if(!get_bit(g_NoShowShop, iPlayer)) 
		cmd_shop(iPlayer)
	
	return PLUGIN_CONTINUE;
}

public ZmurkaOdbrojavanje(taskid)
{
	ZmurkaIgra--;
	DefaultZmurka++;
	set_hudmessage(42, 255, 255, -1.00, 0.31, 0, 1.00, 1.00, 0.10, 1.00, 1);
	show_hudmessage(0, "Zatvorenici imate jos [>  %d  <] sekundi da se sakrijete !^n^nZatvorenici ce biti zaledjeni nakon istekva vremena za sakrivanje^nI bice zaledjeni sve do kraja Igre^n^nCelije se odmah Otvaraju Automatski !", ZmurkaIgra);
	if(ZmurkaIgra == 0)
	{   
                jail_open()
                ZmurkaIgra = DefaultZmurka;
                DefaultZmurka = 0;
		new i;
		for(i = 1; i <= g_MaxClients; i++)
		{
                       if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_CT))
                       {
                                set_pev(i, pev_flags, pev(i, pev_flags) & -4097);
                                set_pev(i, pev_takedamage, 1.00/*1065353216*/);
                                set_lights("b");
                       }
                       if ((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T))
                       {
                                set_task( 1.0, "_t_Countdown", 999, _, _, "a", 180 )
                                set_pev(i, pev_flags, pev(i, pev_flags) | 4096);
                                i++;
                       }
		}
	}
}

public PresidentOdbrojavanje(taskid)
{
	PresidentIgra--;
	DefaultPresident++;
	set_hudmessage(42, 255, 255, -1.00, 0.31, 0, 1.00, 1.00, 0.10, 1.00, 1);
	show_hudmessage(0, "Cuvari imate jos [>  %d  <] sekundi da se sakrijete !^n^nCelije se Automatski otvaraju za 30 sekundi", PresidentIgra);
	jail_open()
	if(PresidentIgra == 0)
	{
		set_task( 1.0, "_t_Countdown", 999, _, _, "a", 180 )
                jail_open()
		new i;
		for(i = 1; i <= g_MaxClients; i++)
		{
			if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T))
			{
				
				set_pev(i, pev_flags, pev(i, pev_flags) & ~FL_FROZEN);
				set_pev(i, pev_takedamage, DAMAGE_YES);
			}
		}
	}
}

public HungerOdbrojavanje(taskid) //// dodaj za fix
{
	HungerIgra--;
	DefaultHunger++;
	set_hudmessage(42, 255, 255, -1.00, 0.31, 0, 1.00, 1.00, 0.10, 1.00, 1);
	show_hudmessage(0, "Hunger Games je poceo [> %d <] sakrivajte se po mapi !^n^nSvako igra za sebe samo 1 pobedjuje, nema timovanja !", HungerIgra);
	jail_open()
        set_user_godmode(id, 1)
	if(HungerIgra == 0)
	{
                set_task( 1.0, "_t_Countdown", 999, _, _, "a", 180 )
                set_cvar_num("mp_friendlyfire", 1)
                set_user_godmode(id, 0)
                g_BoxStarted = 1
                jail_open()
		new i;
		for(i = 1; i <= g_MaxClients; i++)
		{
			if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T))
			{
				
				set_pev(i, pev_takedamage, DAMAGE_YES);
			}
		}
	}
}


public prisoner_last(id)
{
	static name[32]
	
	if(is_user_alive(id) && cs_get_user_team(id) == CS_TEAM_T && g_GameMode <= 1)
	{
		
		get_user_name(id, name, charsmax(name))
		g_PlayerLast = id
		player_hudmessage(0, 6, 5.0, {255, 100, 0}, "%L", LANG_SERVER, "JBEF_PRISONER_LAST", name)
		remove_task(TASK_ROUND)
		
		static i
		new Players[32] 
		new playerCount, CTAlive
		
		
		get_players(Players, playerCount, "ac") 
		for (i=0; i<playerCount; i++) 
		{
			if (is_user_connected(Players[i])) 
				
			if ( cs_get_user_team(Players[i]) == CS_TEAM_CT )
			{
				CTAlive++;
			}
		}
		
		
		if((CTAlive> 0) && get_pcvar_num(gp_AutoLastresquest) && (g_GameMode == 1))
			cmd_lastrequest(id)
	}
	else if (g_GameMode == 2)
	{
		set_user_health(id, 1000)
		set_user_armor(id, 0)
		player_glow(id, g_Colors[3])
		set_user_maxspeed(id, 275.0)
	}
}

public freeday_select(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	
	static dst[32], data[5], player, access, callback
	
	menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
	player = str_to_num(data)
	freeday_set(id, player)
	return PLUGIN_HANDLED
}

public duel_knives(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu)
		g_LastDenied = 0
		return PLUGIN_HANDLED
	}
	
	static dst[32], data[5], access, callback, option[128], player, src[32]
	
	g_DuelOn = 1
	
	menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
	client_cmd(0, "mp3 stop");
	client_cmd(0, "mp3 play sound/jbextreme/boks.mp3");
	get_user_name(id, src, charsmax(src))
	player = str_to_num(data)
        g_BankaAktivna = false;
        vote_day_l0ck(id)
	formatex(option, charsmax(option), "%L^n%L", LANG_SERVER, "JBEF_MENU_LASTREQ_SEL3", src, LANG_SERVER, "JBEF_MENU_DUEL_SEL", src, dst)
	player_hudmessage(0, 6, 3.0, {0, 150, 255}, option)
	
	
	g_DuelA = id
	if(is_user_alive(id) || is_user_connected(id))
		player_strip_weapons(id)
	player_glow(id, g_Colors[3])
	beacon(id)
	show_sprite(id)
	set_user_health(id, 150)
	set_user_armor(id, 0)
	
	
	g_DuelB = player
	if(is_user_alive(player) || is_user_connected(player))
		player_strip_weapons(player)
	player_glow(player, g_Colors[2])
	set_user_health(player, 150)
	set_user_armor(id, 0)
	server_cmd("jb_unblock_teams");
	beacon(player)
	show_sprite(player)
	return PLUGIN_HANDLED
}

public duel_guns(id, menu, item)
{
	if(item == MENU_EXIT || g_PlayerLast != id)
	{
		menu_destroy(menu)
		g_LastDenied = 0
		g_Duel = 0
		return PLUGIN_HANDLED
	}
	
	static gun, dst[32], data[5], access, callback, option[128], player, src[32]
	
	g_DuelOn = 1
	
	menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
	get_user_name(id, src, charsmax(src))
	player = str_to_num(data)
	formatex(option, charsmax(option), "%L^n%L", LANG_SERVER, _Duel[g_Duel - 4][_sel], src, LANG_SERVER, "JBEF_MENU_DUEL_SEL", src, dst)
	client_cmd(0, "mp3 stop");
	client_cmd(0, "mp3 play sound/jbextreme/duel_pravi.mp3");
        g_BankaAktivna = false;
        vote_day_l0ck(id)
	player_hudmessage(0, 6, 3.0, {0, 150, 255}, option)
	
	switch (_Duel[g_Duel - 4][_csw])
	{
		case  CSW_M249:
		{
			g_DuelA = id
			player_strip_weapons(id)
			gun = give_item(id, _Duel[g_Duel - 4][_entname])
			if(gun > 0)
			cs_set_weapon_ammo(gun, 2000)
			cs_set_user_bpammo(id,CSW_M249,0)
			set_user_health(id, 2000)
			set_user_armor(id, 0)
                        InDuel[id] = true
			beacon(id)
			show_sprite(id)
			entity_set_int(id, EV_INT_body, 1)
			player_glow(id, g_Colors[3])
			
			g_DuelB = player
			player_strip_weapons(player)
			gun = give_item(player, _Duel[g_Duel - 4][_entname])
			if(gun > 0)
			cs_set_weapon_ammo(gun, 2000)
			set_user_health(player, 2000)
			beacon(player)
			show_sprite(player)
                        InDuel[id] = true
			cs_set_user_bpammo(player,CSW_M249,0)
			set_user_armor(player, 0)
			entity_set_int(player, EV_INT_body, 1)
			player_glow(player, g_Colors[2])
			
		}
		default:
	{
			g_DuelA = id
			player_strip_weapons(id)
			gun = give_item(id, _Duel[g_Duel - 4][_entname])
			if(gun > 0)
			cs_set_weapon_ammo(gun, 1)
			set_user_health(id, 100)
			set_user_armor(id, 0)
			beacon(id)
			show_sprite(id)
                        InDuel[id] = true
			player_glow(id, g_Colors[3])
			
			g_DuelB = player
			player_strip_weapons(player)
			gun = give_item(player, _Duel[g_Duel - 4][_entname])
			if(gun > 0)
			cs_set_weapon_ammo(gun, 1)
			set_user_health(player, 100)
			beacon(player)
			show_sprite(player)
			set_user_armor(player, 0)
                        InDuel[id] = true
			player_glow(player, g_Colors[2])
		}
	}
	server_cmd("jb_block_weapons")
        vote_day_l0ck(id)
	return PLUGIN_HANDLED;
}

//-------------------------------- REKLAMIRANJE ----------------------------------//
//--------------------------------------------------------------------------------//
//**GOTOVO

public reklamiranje(id)
{
switch(random_num(1,1))
{
case 1:
{
ColorChat(0, TEAM_COLOR, "^1[^4Ultimate JB^1] ^4JailBreak Premium MOD 2024 ^1by: ^4Just V0jslav:)")
ColorChat(0, TEAM_COLOR, "^1[^4Obavestenje^1] ^4Aktivnost se ^1nagradjuje")
}

}
return PLUGIN_HANDLED
}

public StopMenu(id)
{
client_cmd(id, "mp3 stop")
client_cmd(id, "stopsound")
client_print(id, print_chat, "[Ultimate Muzika] Uspesno ste stopirali zvuk :D");
}

public freeday_choice(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	
	static dst[32], data[5], access, callback
	
	menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
	menu_destroy(menu)
	get_user_name(id, dst, charsmax(dst))
	switch(data[0])
	{
		case('1'):
		{
			cmd_freeday_player(id)
		}
		case('2'):
		{
			if((id == g_Simon) || (get_user_flags(id) & ADMIN_RCON))
			{
				g_Simon = 0
				
			
				get_user_name(id, dst, charsmax(dst))
				set_dhudmessage(255, 255, 255, 0.03, 0.55, 0, 2.0, 3.0, 0.2, 0.2, false)
				show_dhudmessage(0, "%s %L", dst, LANG_SERVER, "JBEF_FREEDAY_ALL")
				remove_task(800)
				set_task( 1.0, "FreeDayKraj", 700, _, _, "a", 240 )
				Color_Print(0, "!g[Ultimate JB] !team%s !yje dao svima slobodan dan.", dst)
				ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^3Trenutna pesma -> Nucci x Voyage - Balkan");
				ColorChat(0, TEAM_COLOR, "^4[Ultimate JB] ^1Da ugasite FD muziku say -> ^3/stop");
				client_cmd(0, "mp3 play sound/jbextreme/usporeno.mp3");
				
				g_GameMode = 0
				
				g_Simon = 0	
				emit_sound(0, CHAN_AUTO, "jbextreme/ultt.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
				hud_status(0)
				g_PlayerFreeday = 0
				
				jail_open()
				
				
				new Players[32] 
				new playerCount, i 
				get_players(Players, playerCount, "ac")
				for (i=0; i<playerCount; i++) 
				{
					entity_set_int(Players[i], EV_INT_skin, 3)
				}
				
				new Float:FDLEN = get_pcvar_float(gp_FDLength) 
				if (FDLEN < 20.0) FDLEN = 99999.0
				set_task(FDLEN, "task_freeday_end",TASK_FREEEND)
			}
		}
	}
	return PLUGIN_HANDLED
}	


public lastrequest_select(id, menu, item)
{
	if(item == MENU_EXIT || g_PlayerLast != id)
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	
	static dst[32], data[5], access, callback
	
	menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
	get_user_name(id, dst, charsmax(dst))
	switch(data[0])
	{
		case('2'):
		{
                        set_bit(g_FreedayDuel, id)
                        user_silentkill(id)
			ColorChat(0, TEAM_COLOR, "%s ^1Poslednji Zatvorenik ^3%s ^1 je uzeo ^4Slobodan dan^1!", PLUGIN_PREFIX, dst)
                }
		case('3'):
		{
			g_Duel = 3
			menu_players(id, CS_TEAM_CT, 0, 1, "duel_knives", "%L", LANG_SERVER, "JBEF_MENU_DUEL")
		}
		default:
	{
		g_Duel = str_to_num(data)
		menu_players(id, CS_TEAM_CT, 0, 1, "duel_guns", "%L", LANG_SERVER, "JBEF_MENU_DUEL")
	}
}
	g_LastDenied = 1
	menu_destroy(menu)
	return PLUGIN_HANDLED
}

public setup_buttons()
{
new ent[3]
new Float:origin[3]
new info[32]
new pos

while((pos <= sizeof(g_Buttons)) && (ent[0] = engfunc(EngFunc_FindEntityByString, ent[0], "classname", "info_player_deathmatch")))
{
pev(ent[0], pev_origin, origin)
while((ent[1] = engfunc(EngFunc_FindEntityInSphere, ent[1], origin, CELL_RADIUS)))
{
			if(!is_valid_ent(ent[1]))
				continue
		
			entity_get_string(ent[1], EV_SZ_classname, info, charsmax(info))
			if(!equal(info, "func_door"))
				continue
			
			entity_get_string(ent[1], EV_SZ_targetname, info, charsmax(info))
			if(!info[0])
				continue
			
			if(TrieKeyExists(g_CellManagers, info))
			{
				TrieGetCell(g_CellManagers, info, ent[2])
			}
			else
			{
				ent[2] = engfunc(EngFunc_FindEntityByString, 0, "target", info)
			}
			
			if(is_valid_ent(ent[2]) && (in_array(ent[2], g_Buttons, sizeof(g_Buttons)) < 0))
			{
				g_Buttons[pos] = ent[2]
				pos++
				break
			}
		}
	}
TrieDestroy(g_CellManagers)
}

stock in_array(needle, data[], size)
{
	for(new i = 0; i < size; i++)
	{
		if(data[i] == needle)
			return i
	}
	return -1
}

stock freeday_set(id, player)
{
	static src[32], dst[32]
	get_user_name(player, dst, charsmax(dst))
	
	if(is_user_alive(player) && !get_bit(g_PlayerWanted, player))
	{
		set_bit(g_PlayerFreeday, player)
		entity_set_int(player, EV_INT_skin, 3)
		if(get_pcvar_num(gp_GlowModels))
			player_glow(player, g_Colors[1])
		
		if(0 < id <= g_MaxClients)
		{
			get_user_name(id, src, charsmax(src))
			player_hudmessage(0, 6, 3.0, {0, 255, 0}, "%L", LANG_SERVER, "JBEF_GUARD_FREEDAYGIVE", src, dst)
		}
		else if(g_GameMode == 1)
		{
			player_hudmessage(0, 6, 3.0, {0, 255, 0}, "%L", LANG_SERVER, "JBEF_PRISONER_HASFREEDAY", dst)
		}	         
	}
}

stock first_join(id)
{
	if (get_bit(g_PlayerJoin, id)) return PLUGIN_CONTINUE
	
	switch (get_pcvar_num(gp_Help))
	{
		case 1:{
			set_task(5.0, "cmd_help", TASK_HELP + id)
		}
	}
	
	set_bit(g_PlayerJoin, id)
	clear_bit(g_PlayerHelp, id)
	
	return PLUGIN_CONTINUE
}

stock player_hudmessage(id, hudid, Float:time = 0.0, color[3] = {0, 255, 0}, msg[], any:...)
{
static text[512], Float:x, Float:y
x = g_HudSync[hudid][_x]
y = g_HudSync[hudid][_y]

if(time > 0)
set_hudmessage(color[0], color[1], color[2], x, y, 0, 0.00, time, 0.00, 0.00)
else
set_hudmessage(color[0], color[1], color[2], x, y, 0, 0.00, g_HudSync[hudid][_time], 0.00, 0.00)
vformat(text, charsmax(text), msg, 6)
ShowSyncHudMsg(id, g_HudSync[hudid][_hudsync], text)
}

stock menu_players(id, CsTeams:team, skip, alive, callback[], title[], any:...)
{
	static i, name[64], num[5], menu, menuname[64]
	vformat(menuname, charsmax(menuname), title, 7)
	menu = menu_create(menuname, callback)
	for(i = 1; i <= g_MaxClients; i++)
	{
		if(!is_user_connected(i) || (alive && !is_user_alive(i)) || (skip == i))
			continue
		
		if(!(team == CS_TEAM_T || team == CS_TEAM_CT) || ((team == CS_TEAM_T || team == CS_TEAM_CT) && (cs_get_user_team(i) == team)))
		{
			get_user_name(i, name, charsmax(name))
			num_to_str(i, num, charsmax(num))
			menu_additem(menu, name, num, 0)
		}
	}
	menu_display(id, menu)
}

stock player_glow(id, color[3], amount=40)
{
	set_user_rendering(id, kRenderFxGlowShell, color[0], color[1], color[2], kRenderNormal, amount)
}

stock player_strip_weapons(id)
{
	if(is_user_alive(id) || is_user_connected(id)) strip_user_weapons(id)
	give_item(id, "weapon_knife")
	set_pdata_int(id, m_iPrimaryWeapon, 0)
}

stock player_strip_weapons_all()
{
	for(new i = 1; i <= g_MaxClients; i++)
	{
		if(is_user_alive(i) || is_user_connected(i))
		{
			player_strip_weapons(id)
		}
	}
}


public jail_open()
{
	static i
	for(i = 0; i < sizeof(g_Buttons); i++)
	{
		if(g_Buttons[i])
		{
			ExecuteHamB(Ham_Use, g_Buttons[i], 0, 0, 1, 1.0)
			entity_set_float(g_Buttons[i], EV_FL_frame, 0.0)
		}
	}
	
	
}

public jail_close()
{
	new iEnt = -1
	while( (iEnt = engfunc(EngFunc_FindEntityByString, iEnt, "classname", "func_door")) )
	{
		ExecuteHamB(Ham_CS_Restart, iEnt)
	}
	
	
}

public client_infochanged(id) 
{ 
	if (!is_user_connected(id) || !is_user_alive(id))
	{
		set_user_info(id, "model", "ultimate_zatvorenikk")
	}
} 


public cmd_shop(id)
	
{

if(!is_user_alive(id) ||  g_GameMode >= 2 ) return PLUGIN_CONTINUE

static menu, menuname[64], option[64]
if(cs_get_user_team(id) == CS_TEAM_T)
{
	
	if (strlen(Tallowed) <= 0 ) return PLUGIN_CONTINUE
	
	formatex(menuname, charsmax(menuname), "%L", LANG_SERVER, "JBEF_MENU_SHOP")
	menu = menu_create(menuname, "shop_choice_T")
	
	
	if (containi(Tallowed,"b") >= 0)
	{
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_BOMBPACK", BOMBPACKCOST)
		menu_additem(menu, option, "1", 0)
	}
	
	if (containi(Tallowed,"e") >= 0)
	{
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_SHIELD",SHIELDCOST)
		menu_additem(menu, option, "2", 0)
	}
	
	if (containi(Tallowed,"f") >= 0)
	{
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_FD", FDCOST)
		menu_additem(menu, option, "3", 0)
	}
	
	
	if(containi(Tallowed, "f") >= 0)
	{
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_HP2", HPCOST)
		menu_additem(menu, option, "4", 0)
	}
	
	if(containi(Tallowed, "f") >= 0)
	{
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_GRAVITY", GRAVITYCOST)
		menu_additem(menu, option, "5", 0)
	}
	
	if(containi(Tallowed, "f") >= 0)
	{
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_NOCLIP", NOCLIPCOST)
		menu_additem(menu, option, "6", 0)
	}
	
	if(containi(Tallowed, "f") >= 0)
	{
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_SKIN", SKINCOST)
		menu_additem(menu, option, "7", 0)
	}
	
	formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_NOSHOW")
	menu_additem(menu, option, "8", 0)
	
	
	
	menu_display(id, menu)
}
else 
	if(cs_get_user_team(id) == CS_TEAM_CT)
	{
		
		if (strlen(CTallowed) <= 0 ) return PLUGIN_CONTINUE
		
		formatex(menuname, charsmax(menuname), "%L", LANG_SERVER, "JBEF_MENU_SHOP_CT")
		menu = menu_create(menuname, "shop_choice_CT")
		
		
		if (containi(CTallowed,"b") >= 0)
		{
			formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_DEAGLE", CTDEAGLECOST)
			menu_additem(menu, option, "1", 0)
		}
		
		if (containi(CTallowed,"c") >= 0)
		{
			formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_FLASHBANG_CT",CTFLASHBANGCOST)
			menu_additem(menu, option, "2", 0)
		}
		
		if (containi(CTallowed,"d") >= 0)
		{
			formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_SMOKE_CT",CTSMOKECOST)
			menu_additem(menu, option, "3", 0)
		}
		
		if (containi(CTallowed,"e") >= 0)
		{
			formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_HP",HPCOST)
			menu_additem(menu, option, "4", 0)
		}
		if(containi(CTallowed, "e") >= 0)
		{
			formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_NVG",NVGCOST)
			menu_additem(menu, option, "5", 0)
		}
		
		if(containi(CTallowed, "e") >= 0)
		{
			formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_GODMODE",GODMODECOST)
			menu_additem(menu, option, "6", 0)
		}
		
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SHOP_NOSHOW")
		menu_additem(menu, option, "6", 0)
		
		menu_display(id, menu)
		
	}
return PLUGIN_HANDLED
}

public shop_choice_T(id, menu, item)
{
	if(item == MENU_EXIT || !is_user_alive(id) ||  g_GameMode >= 2 )
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	
	static dst[32], data[5], access, callback
	new money = cs_get_user_money (id);
	new sz_msg[256];
	menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
	menu_destroy(menu)
	get_user_name(id, dst, charsmax(dst))
	
	switch(data[0])
	{
			
		case('1'):
		{
			if (money >= BOMBPACKCOST) 
			{
				cs_set_user_money (id, money - BOMBPACKCOST, 0)
				give_item(id, "weapon_flashbang")
				give_item(id, "weapon_hegrenade")
				give_item(id, "weapon_smokegrenade")
				emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio BombPack za ^1%d$", BOMBPACKCOST);
			}
			
			else
				
		{
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
		}
	}
	
	
	case('2'):
	{
		if (money >= SHIELDCOST) 
		{
			cs_set_user_money (id, money - SHIELDCOST, 0)
			give_item(id, "weapon_shield")
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio Stit za ^1%d$", SHIELDCOST);
		}
		
		else
			
		{
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
		}
	}		
	
	case('3'):
	{
		if (money >= FDCOST) 
		{
			cs_set_user_money (id, money - FDCOST, 0)
			freeday_set(0, id)
			ColorChat(id, TEAM_COLOR, "^4[Ultimate-JB] ^3Uspesno si kupio Sloobdan dan za ^1%d$", FDCOST);
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/kupiofd.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			get_user_name(id, nick, 63)
			ColorChat(0, TEAM_COLOR, "^4[Ultimate SHOP] ^3Zatvorenik %s je kupio slobodan dan.", nick);
		}
		
		else
			
		{
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
		}
	}
	
	case ('4'):
	{
		if (money >= HPCOST)
		{
			cs_set_user_money (id, money - HPCOST, 0)
			set_user_health(id, get_user_health(id) +50);
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio 50 HP za ^1%d$", HPCOST);
		}
		
		else
		
		{
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
		}
	}
	
	case ('5'):
	{
		if (money >= GRAVITYCOST)
		{
			cs_set_user_money (id, money - GRAVITYCOST, 0)
			set_user_gravity(id, 0.5)
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio Gravitaciju za ^1%d$", GRAVITYCOST);
		}
		
		else
		
		{
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
		}
	}
	
	case ('6'):
		{
			if(money >=NOCLIPCOST)
			{
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			cs_set_user_money (id, money - NOCLIPCOST, 0)
			set_user_noclip(id, 1)
			set_task(2.0, "NoClipOff", id)
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio No Clip 2 Sekunde za ^1%d$", NOCLIPCOST);
		}
		
			else
		
		{
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
		}
	}
	case ('7'):
	{
		if(money >=SKINCOST)
			{
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			cs_set_user_money (id, money - SKINCOST, 0)	
			set_user_info(id, "model", "sas");
			set_task(60.0, "SkinOff", id)
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio CT Skin 60 sekunde za ^1%d$", SKINCOST);
		}
		else
		
		{
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
                }
         }
			
}
	return PLUGIN_HANDLED
}


public shop_choice_CT(id, menu, item)
{
if(item == MENU_EXIT)
{
	menu_destroy(menu)
	return PLUGIN_HANDLED
}

static dst[32], data[5], access, callback
new money = cs_get_user_money (id);
new sz_msg[256];

menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
menu_destroy(menu)
get_user_name(id, dst, charsmax(dst))

switch(data[0])
{
	
	
	case('1'):
	{
		if (money >= CTDEAGLECOST) 
		{
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			cs_set_user_money (id, money - CTDEAGLECOST, 0)
			give_item(id, "weapon_deagle")
                        give_item(id, "ammo_50ae")
			give_item(id, "ammo_50ae")
			give_item(id, "ammo_50ae")
			give_item(id, "ammo_50ae")
			give_item(id, "ammo_50ae")
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio Deagle za ^1%d$", CTDEAGLECOST);
		}
		
		else
			
		{
			ColorChat(id, TEAM_COLOR, "[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
		}
	}
	
	case('2'):
	{
		if (money >= CTFLASHBANGCOST) 
		{
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			cs_set_user_money (id, money - CTFLASHBANGCOST, 0)
			give_item(id, "weapon_flashbang")
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio Flashbang za ^1%d$", CTFLASHBANGCOST);
		}
		
		else
			
		{
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
		}
	}
	
	case('3'):
	{
		if (money >= SMOKECOST) 
		{
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			cs_set_user_money (id, money - SMOKECOST, 0)
			give_item(id, "weapon_smokegrenade")
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio Smoke za ^1%d$", SMOKECOST);
		}
		
		else
			
		{
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
		}
	}
	
	case('4'):
	{
		if (money >= HPCOST) 
		{
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			cs_set_user_money (id, money - HPCOST, 0)
			set_user_health(id, 200)
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio 200 Helti za ^1%d$", HPCOST);
		}
		
		else
			
		{
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
			emit_sound(id, CHAN_AUTO, "Ultimate/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
		}
	}
	case ('5'):
	{
		if (money >= NVGCOST) 
		{
			cs_set_user_money (id, money - NVGCOST, 0)
			cs_set_user_nvg (id,true);
			engclient_cmd(id, "nightvision") 
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio Nightvision za 1500 $");
			

		}
	}
	
	case ('6'):
	{
		if (money >= GODMODECOST)
		{
			cs_set_user_money (id, money - GODMODECOST, 0)
			set_user_godmode(id, 1)
			set_task(180.0, "GodOff", id)
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Uspesno si kupio Besmrtnost na 3 Minuta za ^1%d$", GODMODECOST);
		}
		
		else
		
		{
			formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_NOT_ENOUGH")
			client_print(id, print_center , sz_msg)
			emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Error.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^1Nemas dovoljno ^3para.")
		}
	}
		
	case('7'):
	{
		emit_sound(id, CHAN_AUTO, "UltimateJB/Shop/Accepted.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
		set_bit(g_NoShowShop, id)
		formatex(sz_msg, charsmax(sz_msg), "^x03%L", LANG_SERVER, "JBEF_MENU_SHOP_SHOWHOW")
		client_print(id, print_center , sz_msg)
		ColorChat(id, TEAM_COLOR, "^4[Ultimate SHOP] ^3Nece ti se vise prikazivati shop na spawnu. :)");
	}
}
if (!get_bit(g_NoShowShop, id)) cmd_shop(id)
return PLUGIN_HANDLED
} 

public enable_player_voice(id, player)
{
static src[32], dst[32]
get_user_name(player, dst, charsmax(dst))


if (!get_bit(g_PlayerVoice, player)) 
	if((id == g_Simon) || (get_user_flags(id) & ADMIN_LEVEL_A))	
	{
		set_bit(g_PlayerVoice, player)
		if(0 < id <= g_MaxClients)
		{
			get_user_name(id, src, charsmax(src))
			player_hudmessage(0, 6, 3.0, {255, 0, 0}, "%L", LANG_SERVER, "JBEF_GUARD_VOICEENABLED", src, dst)
		}
	}
	
	else
		
{
	clear_bit(g_PlayerVoice, player)
	if(0 < id <= g_MaxClients)
	{
		get_user_name(id, src, charsmax(src))
		player_hudmessage(0, 6, 3.0, {255, 0, 0}, "%L", LANG_SERVER, "JBEF_GUARD_VOICEDISABLED", src, dst)
	}		
}

}

public voice_enable_select(id, menu, item)
{

if(item == MENU_EXIT)
{
	menu_destroy(menu)
	return PLUGIN_HANDLED
}

static dst[32], data[5], player, access, callback

menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
player = str_to_num(data)
enable_player_voice(id, player)	
cmd_simonmenu(id)
return PLUGIN_HANDLED
}
public cmd_simon_micr(id)
{
if((id == g_Simon) || (get_user_flags(id) & ADMIN_LEVEL_A))
	
{
	menu_players(id, CS_TEAM_T, 0, 1, "voice_enable_select", "%L", LANG_SERVER, "JBEF_MENU_VOICE")
	
}
}

public na2team(id) {

if (g_Simon == id || is_user_admin(id))
{
	
	new s = get_pcvar_num (gp_ShowColor)
	new playerCount, i
	new Players[32]
	new bool:orange = true
	get_players(Players, playerCount, "ac")
	for (i=0; i<playerCount; i++)
	{
		
		if ( cs_get_user_team(Players[i]) == CS_TEAM_T && is_user_alive(Players[i]) && !get_bit(g_PlayerFreeday, Players[i]) && !get_bit(g_PlayerWanted, Players[i]))
		{
			if (orange)
			{              
				entity_set_int(Players[i], EV_INT_skin, 0)
				orange=false;
				if (s == 1) show_color(Players[i])
			}
			else
			{
				entity_set_int(Players[i], EV_INT_skin, 1)
				orange=true;
				if (s == 1) show_color(Players[i])
			}                      
		}
	}       
}
return PLUGIN_HANDLED
}

bool:GameAllowed()

{
if (g_GameMode > 1 || g_nogamerounds < get_pcvar_num(gp_NoGame))
return false	

return true;

}

public cmd_simonmenu(id)

{

if (g_Simon == id || (get_user_flags(id) & ADMIN_LEVEL_A))
	
{
	
	static menu, menuname[64], option[64]
	
	formatex(menuname, charsmax(menuname), "%L", LANG_SERVER, "JBEF_MENU_SIMONMENU")
	menu = menu_create(menuname, "simon_choice")
	
	formatex(option, charsmax(option), "\r%L\w", LANG_SERVER, "JBEF_MENU_SIMONMENU_OPEN")
	menu_additem(menu, option, "1", 0)

	formatex(option, charsmax(option), "\r%L\w", LANG_SERVER, "JBEF_MENU_SIMONMENU_CLOSE")
	menu_additem(menu, option, "2", 0)

	formatex(option, charsmax(option), "\g%L\w", LANG_SERVER, "JBEF_MENU_SIMONMENU_FD")
	menu_additem(menu, option, "3", 0)
	
	formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SIMONMENU_OPTIONS")
	menu_additem(menu, option, "4", 0)
	
	if (g_GameMode == 1)
	{
		formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SIMONMENU_CLR")
		menu_additem(menu, option, "5", 0)
	}
	
	else
	{
		formatex(option, charsmax(option), "%L\w", LANG_SERVER, "JBEF_MENU_SIMONMENU_CLR")
		menu_additem(menu, option, "5", 0)	
	}
	
	
	formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_SIMONMENU_VOICE")
	menu_additem(menu, option, "6", 0)
	
	formatex(option, charsmax(option), "\y%L\w", LANG_SERVER, "JBEF_MENU_SIMONMENU_GONG")
	menu_additem(menu, option, "7", 0)
	
	formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MENU_PUNISH")
	menu_additem(menu, option, "8", 0)
	
	formatex(option, charsmax(option), "%L", LANG_SERVER, "JBEF_MINI_IGRE")
	menu_additem(menu, option, "9", 0)
	
	menu_display(id, menu)
}
return PLUGIN_HANDLED
}

public cmd_givesimon(id)
{
	if(is_user_alive(id) || is_user_connected(id))
	{
		if(!pf_have_simon_access(id))
		return PLUGIN_HANDLED;
	
		new mTitle[64]
		formatex(mTitle, sizeof(mTitle), "\y%s | \wPrebaci sajmona", PLUGIN_PREFIX)
		menu_players(id, CS_TEAM_CT, id, 1, "cmd_givesimon_hand", mTitle)
	}
	
	return PLUGIN_CONTINUE
}

public cmd_givesimon_hand(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		cmd_simonmenu(id)
		return PLUGIN_HANDLED
	}

	if(!pf_have_simon_access(id))
		return PLUGIN_HANDLED;
	
	static dst[32], data[5], tempid, _access, callback
	menu_item_getinfo(menu, item, _access, data, charsmax(data), dst, charsmax(dst), callback)
	tempid = str_to_num(data)
	
	if(g_Simon == tempid) 
	return PLUGIN_CONTINUE
	
	g_Simon = 0;
	player_spawn(id);
	player_spawn(tempid);
	cmd_simon(tempid)
	
	new pName[35];
	new zName[35];
	get_user_name(id, pName, 34)
	get_user_name(tempid, zName, 34)
	Color_Print(0, "!g%s!y Igrac!team %s!y je prebacio !gSIMONA!y igracu !team%s!y.", PLUGIN_PREFIX, pName, zName);
	
	return PLUGIN_HANDLED
}

public simon_gameschoice(id, menu, item)
{
if(item == MENU_EXIT || g_GameMode > 1)
{
	menu_destroy(menu)
	cmd_simonmenu(id)
	return PLUGIN_HANDLED
}

static dst[32], data[15], access, callback;

menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
menu_destroy(menu)
get_user_name(id, dst, charsmax(dst))

switch( str_to_num( data[0] ) )
{	
	case 3:
	{
		if (GameAllowed()  || is_user_admin(id)) cmd_presidentday(id)
	}
	case 5:
	{
		if (GameAllowed() || is_user_admin(id)) cmd_box(id)
	}
	case 6:
	{
		if (GameAllowed() || is_user_admin(id)) cmd_sparta(id)
	}
	case 10: 
	{
		if (GameAllowed() || is_user_admin(id)) cmd_gangsteri(id)
         }
	case 11:
	{
		if (GameAllowed() || is_user_admin(id)) cmd_snajper(id)
	}
	case 12:
	{
		if (GameAllowed() || is_user_admin(id)) cmd_ghostday(id)
	}
	case 25:
	{
		if (GameAllowed() || is_user_admin(id)) cmd_scoutday(id)
	}
	case 61:
	{
		if (GameAllowed() || is_user_admin(id)) cmd_freezetagday(id)
	}
}

return PLUGIN_HANDLED
}

public cmd_simongamesmenu(id)

{
if(id == g_Simon)
{
	static menu, menuname[64], option[64]
	
	formatex(menuname, charsmax(menuname), "%L", LANG_SERVER, "JBEF_MENU_SIMONMENU")
	menu = menu_create(menuname, "simon_gameschoice")
	
	new allowed[31];
	get_pcvar_string(gp_Games, allowed,31)
	if (strlen(allowed) <= 0 ) return PLUGIN_CONTINUE
	
	if (GameAllowed() || is_user_admin(id))
	{	
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Sparta Day")
			menu_additem(menu, option, "6", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Snipers Day")
			menu_additem(menu, option, "7", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Knife Day")
			menu_additem(menu, option, "8", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Presiednt Day")
			menu_additem(menu, option, "3", 0)
		}
		if (containi(allowed, "f") >= 0)
		{
			formatex(option, charsmax(option), "Zmurka")
			menu_additem(menu, option, "10", 0)
		}
		if (containi(allowed, "f") >= 0)
		{
			formatex(option, charsmax(option), "Zombie Day")
			menu_additem(menu, option, "11", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Ghost Day")
			menu_additem(menu, option, "12", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Survivor Day")
			menu_additem(menu, option, "13", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Alien Day")
			menu_additem(menu, option, "14", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Ledeni Cica")
			menu_additem(menu, option, "15", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Ledeni Cika")
			menu_additem(menu, option, "61", 0)
		}
	}
	else
	{
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Sparta Day")
			menu_additem(menu, option, "6", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Snipers Day")
			menu_additem(menu, option, "7", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Knife Day")
			menu_additem(menu, option, "8", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "President Day")
			menu_additem(menu, option, "3", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Nindza Day")
			menu_additem(menu, option, "9", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Zmurka")
			menu_additem(menu, option, "10", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Zombie Day")
			menu_additem(menu, option, "11", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Ghost Day")
			menu_additem(menu, option, "12", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Survivor Day")
			menu_additem(menu, option, "13", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Alien Day")
			menu_additem(menu, option, "14", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Ledeni Cica")
			menu_additem(menu, option, "15", 0)
		}
		if (containi(allowed,"f") >= 0)
		{
			formatex(option, charsmax(option), "Ledeni Cika")
			menu_additem(menu, option, "61", 0)
		}
	}
	
	if (containi(allowed,"e") >= 0)
	{
		formatex(option, charsmax(option), "%L", LANG_SERVER, "Knife Day")
		menu_additem(menu, option, "5", 0)
	}
	
	menu_display(id, menu)
	
}
return PLUGIN_HANDLED
}

stock cs_set_user_team2(index, {CsTeams,_}:team, update = 1)
{
if (index == g_Simon)
{
g_Simon = 0
}
set_pdata_int(index, OFFSET_TEAM, _:team)
set_pev(index, pev_team, _:team)

if(update)
{
static _msg_teaminfo; if(!_msg_teaminfo) _msg_teaminfo = get_user_msgid("TeamInfo")
static teaminfo[][] = { "UNASSIGNED", "TERRORIST", "CT", "SPECTATOR" }

message_begin(MSG_ALL, _msg_teaminfo)
write_byte(index)
write_string(teaminfo[_:team])
message_end()
}
return 1
}

public simon_choice(id, menu, item)
{
if(item == MENU_EXIT || !((id == g_Simon) || (get_user_flags(id) & ADMIN_LEVEL_A)) )
{
menu_destroy(menu)
return PLUGIN_HANDLED
}


static dst[32], data[5], access, callback

menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
menu_destroy(menu)
get_user_name(id, dst, charsmax(dst))


switch(data[0])
	{
	case('1'): 
	{
		jail_open()
		cmd_simonmenu(id)
		get_user_name(id, nick, 63)
		set_dhudmessage(0, 255, 212, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
		show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_OPENCELLS")
		Color_Print(0, "!g[Ultimate JB] !team%s !yje otvorio celije.", nick)
		emit_sound(0, CHAN_AUTO, "jbextreme/sezame_novo.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	case('2'): 
	{
		jail_close()
		cmd_simonmenu(id)
		get_user_name(id, nick, 63)
		set_dhudmessage(0, 255, 212, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
		show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_CLOSECELLS")
		Color_Print(0, "!g[Ultimate JB] !team%s !yje zatvorio celije.", nick)
		emit_sound(0, CHAN_AUTO, "jbextreme/zatvori_celija.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
		
	
	}
	case('3'): cmd_freeday(id)
	case ('4'): menu_countdown(id)
	case('5'): cmd_givesimon(id)
	case('6'): cmd_simon_micr(id)
	case('7'):
	{
		emit_sound(0, CHAN_AUTO, "jbextreme/ultimate_zvono.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
		cmd_simonmenu(id)
		get_user_name(id, nick, 63)
		set_dhudmessage(255, 255, 255, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
		show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_RINGED")
		Color_Print(0, "!g[Ultimate JB] !team%s !yje zazvonio.", nick)
	}
	case('8'): cmd_punish(id)
	case('9'): cmd_mini_igre(id)
	
}	
return PLUGIN_HANDLED;
}

public cmd_punish(id)
{
	if(is_user_alive(id) || is_user_connected(id))
	menu_players(id, CS_TEAM_CT, id, 1, "cmd_punish_ct", "%L", LANG_SERVER, "JBEF_MENU_PUNISH")
	
	return PLUGIN_CONTINUE
}

public cmd_punish_ct(id, menu, item)
{
	if(item == MENU_EXIT || (g_Simon != id))
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	
	static dst[32], data[5], tempid, access, callback
	menu_item_getinfo(menu, item, access, data, charsmax(data), dst, charsmax(dst), callback)
	tempid = str_to_num(data)
	if(g_Simon == tempid) 
		return PLUGIN_CONTINUE
	
	user_silentkill(tempid)
	if(is_user_alive(id) || is_user_connected(id)) cs_set_user_team(tempid, CS_TEAM_T)
	return PLUGIN_HANDLED
}

public cmd_nomic(id)
{
	static CsTeams:team
	if(is_user_alive(id) || is_user_connected(id))
		team = cs_get_user_team(id);
	if(team == CS_TEAM_CT || is_user_alive(id) || is_user_connected(id))
	{
		player_hudmessage(0, 2, 5.0, _, "%L", LANG_SERVER, "JBEF_SIMON_TRANSFERED",id)
		if(g_Simon == id)
		{
			g_Simon = 0
			player_hudmessage(0, 2, 5.0, _, "%L", LANG_SERVER, "JBEF_SIMON_TRANSFERED")
		}
		if((id == g_Simon) || (get_user_flags(id) & ADMIN_LEVEL_A))
			set_bit(g_PlayerNomic, id)
		
		cs_set_user_team(id, CS_TEAM_T)
	}
	return PLUGIN_HANDLED
}
public chooseteamfunc(id)
{
	if (g_GameMode == 5) return PLUGIN_HANDLED;
	return PLUGIN_CONTINUE
}

public task_freeday_end()
{
	client_cmd(0, "mp3 stop");
	g_GameMode = 1
	set_hudmessage(255, 0, 0, -1.0, 0.35, 0, 6.0, 15.0)
	show_hudmessage(0, "%L", LANG_SERVER, "JBEF_STATUS_ENDFREEDAY")
	emit_sound(0, CHAN_AUTO, "jbextreme/ultimate_zvonce.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
	new playerCount, i 
	new Players[32] 
	get_players(Players, playerCount, "ac") 
	for (i=0; i<playerCount; i++) 
	{
		
		if ( cs_get_user_team(Players[i]) == CS_TEAM_T && is_user_alive(Players[i]) && !get_bit(g_PlayerFreeday, Players[i]) && !get_bit(g_PlayerWanted, Players[i]))
		{
			
			entity_set_int(Players[i], EV_INT_skin, random_num(0,2))
			if (get_pcvar_num (gp_ShowColor) == 1 ) show_color(Players[i])	
		}
	}
	return PLUGIN_CONTINUE
}
public menu_countdown(id)
{
	new mTitle[33];
	formatex(mTitle, sizeof(mTitle), "\y%s \wOdbrojavanje", PLUGIN_PREFIX)
	new menu = menu_create(mTitle, "menu_countdown_handler");

	menu_additem(menu, "\y3 \wSekund");
	menu_additem(menu, "\y5 \wSekund"); 
	menu_additem(menu, "\y10 \wSekundi");
	menu_additem(menu, "\y20 \wSekundi");

	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
	menu_display(id, menu, 0);
	

	return PLUGIN_HANDLED;
}

public menu_countdown_handler(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_cancel(id);
		cmd_simonmenu(id)
		return PLUGIN_HANDLED;
	}

	if(!pf_have_simon_access(id))
	return PLUGIN_HANDLED;
	
	if(g_IsCountdownOn)
	{
		menu_countdown(id)
		Color_Print(id, "!g%s!y Odbrojavanje je vec pokrenuto.", PLUGIN_PREFIX)
		return PLUGIN_HANDLED;
	}
	
	new command[6], name[64], zaccess, callback;
	menu_item_getinfo(menu, item, zaccess, command, sizeof command - 1, name, sizeof name - 1, callback);

	switch(item)
	{
		case 0: { g_CountdownTimer = 3; g_IsCountdownOn = true; }
		case 1: { g_CountdownTimer = 5; g_IsCountdownOn = true; }
		case 2: { g_CountdownTimer = 10; g_IsCountdownOn = true; }
		case 3: { g_CountdownTimer = 20; g_IsCountdownOn = true; }
	}
	
	start_countdown()
	remove_task(TASK_COUNTDOWN)
	set_task(1.0, "start_countdown", TASK_COUNTDOWN, _, _, "b")
	menu_destroy(menu);
	cmd_simonmenu(id);
	return PLUGIN_HANDLED;
}

public start_countdown() 
{
	if(g_CountdownTimer > 0) 
	{ 
		client_print(0, print_center, "Odbrojavanje: %i sekundi!", g_CountdownTimer);
		
		new szSound[15];
		new szFormat[32];
		num_to_word(g_CountdownTimer, szSound, 14);
		formatex(szFormat, sizeof(szFormat), "fvox/%s", szSound)
		client_cmd(0, "spk %s" , szFormat);
		
		g_CountdownTimer--;
	} 
	else 
	{
		remove_task(TASK_COUNTDOWN)
		client_print(0, print_center, "Odbrojavanje zavrseno!");
		g_IsCountdownOn = false;
	}
}


public cmd_prodavnica(id)
{
	new menu = menu_create("\rUltimate-JB \d[ \yProdavnica Opcije \d]","Izbor")
	menu_additem(menu,"\dOruzije \r[LOCK]")
	menu_additem(menu,"\wSposobnosti")
	menu_additem(menu,"\wOprema")
	menu_display(id, menu);
}	

public Izbor(id ,menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_CONTINUE;
	}
	switch(item)
	{
		case 0:
		{
			client_cmd( id, "say" );
		}
		case 1:
		{
			client_cmd( id, "pmodmenu" );
                 } 
		case 2:
		{
			client_cmd( id, "say /shop" );
                 } 
	}
	return PLUGIN_CONTINUE
}

//Mini Igre
public cmd_mini_igre(id)
{
	if( cs_get_user_team (id) == CS_TEAM_CT )
	{
		
		new MINI_IGRE = menu_create ( "\rUltimate-JB \d[ \yMini Igre \d]" , "MINI_IGRE_handler" )
		menu_additem( MINI_IGRE , "\wFudbal \y[Barselona VS Real]" )
		menu_additem( MINI_IGRE , "\wBacanje \ydeagla" )
		menu_additem( MINI_IGRE , "\wBox \r[16 TT Max]" )
 		menu_additem( MINI_IGRE , "\wKockica \w[\rGlava / Pismo]" )
		menu_additem( MINI_IGRE , "\wPodeli \y[Podela Timova]" )
		menu_display( id , MINI_IGRE )
	}
}

public MINI_IGRE_handler (id , MINI_IGRE , item )
{
	
	if( item == MENU_EXIT )
	{
		menu_destroy( MINI_IGRE  )
		return PLUGIN_CONTINUE
	}
	switch ( item )
	{
		case 0:
		{
			cmd_mini_fudbal(id)
		}
		case 1:
		{
			cmd_mini_bacanje(id)
		}
		case 2:
		{
			cmd_mini_ffguns(id)
		}
		case 3:
		{
			cmd_mini_kockica(id)
		}
		case 4:
	{
		na2team(id)
		emit_sound(0, CHAN_AUTO, "jbextreme/podeli.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
		get_user_name(id, nick, 63)
		set_dhudmessage(255, 0, 0, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2)
		show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_2TEAMS")
		Color_Print(0, "!g[Ultimate-JB] !team%s !yje podelio zatvorenike u 2 boje.", nick)
	}
	
       }
	return PLUGIN_CONTINUE
}

public cmd_mini_fudbal(id)
{
	
	new MINI_FUDBAL = menu_create ( "\wUltimate-JB \r| \wFudbal-Opcije:" , "Fudbal_handler" )
	menu_additem( MINI_FUDBAL , "\rStvori loptu i napravi mrezu" )
	menu_additem( MINI_FUDBAL , "\rPodeli u \wtimove" )
	menu_additem( MINI_FUDBAL , "\rVrati na normalne skinove" )
	menu_additem( MINI_FUDBAL, "\rRezultat" )
	menu_display( id , MINI_FUDBAL )
}


public Fudbal_handler (iPlayer , MINI_FUDBAL  , item )
{
	if( item == MENU_EXIT )
	{
		menu_destroy( MINI_FUDBAL  )
		return PLUGIN_CONTINUE
	}
	switch ( item )
	{
		case 0: client_cmd( id, "say /lopta" );
		case 1:
		{
			new i;
			get_user_name(id, nick, 63)
			set_hudmessage(255, 255, 255, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
			Color_Print(0, "!g[Ultimate-JB] !team%s !yvas je podelio u razlicite timove za Fudbal. Neka najbolji pobedi :)", nick)
			na2team(id)
			emit_sound(0, CHAN_AUTO, "jbextreme/podeli.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
			for(i = 1; i <= g_MaxClients; i++) 
			{
				if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T))
				{
					strip_user_weapons(i)
					set_user_maxspeed(i, 200.0)
					set_user_info(i, "model", "jb_fudbaleri")
					give_item(i, "weapon_knife")
                                        set_bit(g_FudbalRuke, i)
				}
			}
			return PLUGIN_HANDLED
		}
		case 2:
		{
			new i;
			get_user_name(id, nick, 63)
			set_hudmessage(255, 255, 255, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
			Color_Print(0, "!g[Ultimate-JB] !team%s !yvas je vratio u stare skinove. Fudbal je zavrsen :)", nick)
			for(i = 1; i <= g_MaxClients; i++) 
			{
				if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T))
				{
					strip_user_weapons(i)
					set_user_info(i, "model", "ultimate_zatvorenikk")
					give_item(i, "weapon_knife")
                                        clear_bit(g_FudbalRuke, i) 
				}
			}
			return PLUGIN_HANDLED
		}
		case 3:
		{
			new MINI_REZULTAT = menu_create ( "\wUltimate-JB \r| \wRezultat Meni" , "Rezultati_handler" )
			menu_additem( MINI_REZULTAT , "\rDodaj jedan gol Crvenom timu" )
			menu_additem( MINI_REZULTAT , "\wDodaj jedan gol Plavom timu" )
			menu_additem( MINI_REZULTAT , "\yOduzmi jedan gol Crvenom timu" )
			menu_additem( MINI_REZULTAT , "\rOduzmi jedan gol Plavom timu" )
			menu_display( id , MINI_REZULTAT )
		}
	}
	return PLUGIN_HANDLED
}

public Rezultati_handler (id , MINI_REZULTAT  , item )
{
	if( item == MENU_EXIT )
	{
		menu_destroy( MINI_REZULTAT  )
		return PLUGIN_CONTINUE
	}
	switch ( item )
	{
		case 0:
		{
			Crveni++;
		}
		case 1:
		{
			Plavi++;
		}
		case 2:
		{
			Crveni--;
		}
		case 3:
		{
			Plavi--;
		}
	}
	return PLUGIN_CONTINUE
}

public  cmd_mini_bacanje(id)
{
	new i;
	
	get_user_name(id, nick, 63)
	set_dhudmessage(255, 255, 255, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
	show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_MINI_BACANJE")
	Color_Print(0, "!g^1[^4Ultimate-JB^1] !team%s !yje dao Mini-Igru bacanje oruzija.",nick)
	set_cvar_num("mp_friendlyfire", 0)
	for(i = 1; i <= g_MaxClients; i++) 
	{
		if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T))
		{
			strip_user_weapons(i)
			give_item(i, "weapon_knife")
			new iWeapon = give_item(i, "weapon_deagle");
			if( iWeapon > 0 )
			{
				cs_set_user_bpammo(id, CSW_DEAGLE, 0); 
				cs_set_weapon_ammo(iWeapon, 0);
			}
		}
	}
	return PLUGIN_HANDLED
}

public cmd_mini_ffguns(id)
{
	
	new MINI_FFGUNS = menu_create ( "\rUltimate-JB \d[ \yBox Opcije \d]" , "FF_handler" )
	menu_additem( MINI_FFGUNS , "\wOtvori: \yGlavni Box Menu" )
        menu_additem( MINI_FFGUNS , "\rIskljuci Box" )
	menu_display( id , MINI_FFGUNS )
}

public FF_handler (id , MINI_FFGUNS , item )
{
	if( item == MENU_EXIT )
	{
		menu_destroy( MINI_FFGUNS)
		return PLUGIN_CONTINUE
	}
	switch ( item )
	{
		case 0:
		{
			cmd_box_menu(id)
			
		}
                case 1:
                {
                       cmd_box_off(id)
                }
	}
	return PLUGIN_CONTINUE
}

public cmd_box_menu(id)
{
	
	new MINI_BOX = menu_create ( "\rUltimate-JB \d[ \yGlavne Opcije \d]" , "Box_handler" )
	menu_additem( MINI_BOX , "\wUkljuci Box \d[ \y100 HP \d]" )
        menu_additem( MINI_BOX , "\wUkljuci Box \d[ \y50 HP \d]" )
	menu_additem( MINI_BOX , "\wUkljuci Box \d[ \y5 HP \d]" )
	menu_display( id , MINI_BOX )
}

public Box_handler (id , MINI_BOX , item )
{
	
	if( item == MENU_EXIT )
	{
		menu_destroy( MINI_BOX  )
		return PLUGIN_CONTINUE
	}
	switch ( item )
	{
		case 0:
		{
			cmd_FFNormalON(id)
		}
		case 1:
		{
			cmd_FFHalfON(id)
		}
		case 2:
		{
			cmd_FFLowON(id)
		}
	}
	return PLUGIN_CONTINUE
}


public cmd_FFNormalON(id)
{
	if((id == g_Simon || (get_user_flags(id) & ADMIN_LEVEL_A)))
	{
		new Players[32]
		new playerCount, i, TAlive
		get_user_name(id, nick, 63)
		set_dhudmessage(255, 0, 0, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
		show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_DAO_MINI_FFGUNS")
		Color_Print(0, "!g^1[^4Ultimate-JB^1] !team%s !yje ukljucio Box sa 100 Helti.", nick)
		client_cmd(0, "mp3 play sound/jbextreme/boks.mp3")
		get_players(Players, playerCount, "ac")
		for (i=0; i<playerCount; i++)
		{
			if (is_user_connected(Players[i]))         
				if( cs_get_user_team(Players[i]) == CS_TEAM_T )
				TAlive++;
		}
		
		if(TAlive <= get_pcvar_num(gp_BoxMax) && TAlive > 1)
		{
			for(i = 1; i <= g_MaxClients; i++)
				if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
			{
				strip_user_weapons(i)
                                give_item(i, "weapon_knife")
				set_user_health(i, 100)
				cs_set_user_armor(i, 0, CS_ARMOR_NONE)	 
                                set_bit(g_BoxRuke2, i)			
			}
			set_cvar_num("mp_tkpunish", 0)
			set_cvar_num("mp_friendlyfire", 1)
			g_BoxStarted = 1
                        menu_l0ck(id)
		}
	}
	return PLUGIN_HANDLED
}

public cmd_FFHalfON(id)
{
	if((id == g_Simon || (get_user_flags(id) & ADMIN_LEVEL_A)))
	{
		new Players[32]
		new playerCount, i, TAlive
		get_user_name(id, nick, 63)
		set_dhudmessage(255, 0, 0, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
		show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_DAO_MINI_FFGUNS")
		Color_Print(0, "!g^1[^4Ultimate-JB^1] !team%s !yje ukljucio Box sa 50 Helti.", nick)
		client_cmd(0, "mp3 play sound/jbextreme/boks.mp3")
		get_players(Players, playerCount, "ac")
		for (i=0; i<playerCount; i++)
		{
			if (is_user_connected(Players[i]))         
				if( cs_get_user_team(Players[i]) == CS_TEAM_T )
				TAlive++;
		}
		
		if(TAlive <= get_pcvar_num(gp_BoxMax) && TAlive > 1)
		{
			for(i = 1; i <= g_MaxClients; i++)
				if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
			{
				strip_user_weapons(i)
                                give_item(i, "weapon_knife")
				set_user_health(i, 50)
				cs_set_user_armor(i, 0, CS_ARMOR_NONE)	
                                set_bit(g_BoxRuke2, i) 			
			}
			set_cvar_num("mp_tkpunish", 0)
			set_cvar_num("mp_friendlyfire", 1)
			g_BoxStarted = 1
                        menu_l0ck(id)
		}
	}
	return PLUGIN_HANDLED
}

public cmd_FFLowON(id)
{
	if((id == g_Simon || (get_user_flags(id) & ADMIN_LEVEL_A)))
	{
		new Players[32]
		new playerCount, i, TAlive
		get_user_name(id, nick, 63)
		set_dhudmessage(255, 0, 0, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
		show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_DAO_MINI_FFGUNS")
		Color_Print(0, "!g^1[^4Ultimate-JB^1] !team%s !yje ukljucio Box sa 5 Helti.", nick)
		client_cmd(0, "mp3 play sound/jbextreme/boks.mp3")
		get_players(Players, playerCount, "ac")
		for (i=0; i<playerCount; i++)
		{
			if (is_user_connected(Players[i]))         
				if( cs_get_user_team(Players[i]) == CS_TEAM_T )
				TAlive++;
		}
		
		if(TAlive <= get_pcvar_num(gp_BoxMax) && TAlive > 1)
		{
			for(i = 1; i <= g_MaxClients; i++)
				if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
			{
				strip_user_weapons(i)
                                give_item(i, "weapon_knife")
				set_user_health(i, 5)
				cs_set_user_armor(i, 0, CS_ARMOR_NONE)
                                set_bit(g_BoxRuke2, i)					
			}
			set_cvar_num("mp_tkpunish", 0)
			set_cvar_num("mp_friendlyfire", 1)
			g_BoxStarted = 1
                        menu_l0ck(id)
		}
	}
	return PLUGIN_HANDLED
}

public cmd_box_off(id)
{
        if((id == g_Simon || (get_user_flags(id) & ADMIN_LEVEL_A)))
	{
		new Players[32]
		new playerCount, i, TAlive
		get_user_name(id, nick, 63)
		set_dhudmessage(255, 0, 0, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2, false)
		show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_ISKLJUCIO_BOX")
		Color_Print(0, "!g^1[^4Ultimate-JB^1] !team%s !yje iskljucio box.", nick)
		client_cmd(0, "mp3 play sound/jbextreme/ultt.wav")
		get_players(Players, playerCount, "ac")
		for (i=0; i<playerCount; i++)
		{
			if (is_user_connected(Players[i]))         
				if( cs_get_user_team(Players[i]) == CS_TEAM_T )
				TAlive++;
		}
		
		if(TAlive <= get_pcvar_num(gp_BoxMax) && TAlive > 1)
		{
			for(i = 1; i <= g_MaxClients; i++)
			if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
			{
				strip_user_weapons(i)
				give_item(i, "weapon_knife")
				set_user_health(i, 100)
				cs_set_user_armor(i, 0, CS_ARMOR_NONE)
                                clear_bit(g_BoxRuke2, i) 				
			}
			set_cvar_num("mp_tkpunish", 0)
			set_cvar_num("mp_friendlyfire", 0)
			g_BoxStarted = 0
                        menu_unl0ck(id)
		}
	}
	return PLUGIN_HANDLED
}

public cmd_mini_kockica(id)
{
	
	new MINI_KOCKICA = menu_create ( "\rUltimate-JB - \rNesrecna Kockica" , "MINI_KOCKA" )
	menu_additem( MINI_KOCKICA , "\wBaci novcic \w[\rGlava \r/ Pismo]" )
        menu_additem( MINI_KOCKICA , "\wBaci kockicu \r[LOCK]" )
        menu_additem( MINI_KOCKICA , "\wNasumicna boja \w[\rPlava,Crvena,Zuta,Zelena]" )
	menu_display( id , MINI_KOCKICA )
}
public MINI_KOCKA (id , MINI_HB , item ) 		
{
	if( item == MENU_EXIT )
	{
		menu_destroy( MINI_HB)
		return PLUGIN_CONTINUE
	}
	switch ( item )
	{
		case 0:
	            {
		   cmd_kockica_v1(id)
		 
	   }
	  case 1:
	  {
	  	cmd_VasBroj(id)
	  }
               case 2:
                {
		na2team(id)
		emit_sound(0, CHAN_AUTO, "jbextreme/podeli.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
		get_user_name(id, nick, 63)
		set_dhudmessage(255, 0, 0, 0.03, 0.55, 0, 1.0, 3.0, 0.2, 0.2)
		show_dhudmessage(0, "%s %L", nick, LANG_SERVER, "JBEF_PODELI")
		Color_Print(0, "!g[Ultimate-JB] !team%s !yje podelio zatvorenike u nasumicne boje.", nick)
                }
	}
	return PLUGIN_CONTINUE
}	

public cmd_kockica_v1(id)
{
	new rand = random_num(0,5);

	switch(rand)
	{
		case 0:
		{
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Novcic je pao na: ^4[ Pismo ].");
		}
		case 1:
		{
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Novcic je pao na: ^4[ Glavu ].");
		}
		case 2:
		{
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Novcic je pao na: ^4[ Pismo ].");
		}
		case 3:
		{
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Novcic je pao na: ^4[ Glavu ].");
		}
                case 4:
                {
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Novcic je pao na: ^4[ Glavu ].");
		}
	}
	return PLUGIN_CONTINUE;
}

public cmd_VasBroj(id)
{
client_cmd( id, "say" );

return 0;
}

public cmd_sparta(id)
{
	set_task( 1.0, "PresidentOdbrojavanje", 2, _, _, "a", 30 )
	jail_open()
	remove_task(800)
	g_nogamerounds = 0
	g_GameMode = GAME_ID_SPARTA
	g_BoxStarted = 0
	entity_set_int(g_Simon, EV_INT_body, 3)
	g_Simon = 0
        g_SimonAllowed = 0
	new i
	set_lights("b")
	server_cmd("jb_block_weapons")
        client_cmd(0, "mp3 stop");
        client_cmd(0, "stopsound");
        client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/zb_sparta.mp3");
	get_user_name(id, nick, 63)
	ColorChat(0, TEAM_COLOR, "^4[Ultimate] ^1Glasanje je zavrseno. Izglasan dan: ^4Sparta Day")
	ColorChat(0, TEAM_COLOR, "^4[Sparta Day] ^1Zatvorenici dobijaju stit i ruke i trebaju da pobiju sve cuvare.")
        ColorChat(0, TEAM_COLOR, "^4[Ultimate] ^1je startovao Sparta Day. Uzivajte u igri.")
	set_dhudmessage(0, 150, 200, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
	show_dhudmessage(0, "Ultimate je Startovao Sparta Day");
	jail_open()
	for(i = 1; i <= g_MaxClients; i++) 
	{
		if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_CT))
		{
                      strip_user_weapons(i);
                      give_item(i, "weapon_m4a1");
                      give_item(i, "weapon_ak47");
                      cs_set_user_bpammo(i, 28, 300);
                      cs_set_user_bpammo(i, 22, 300);
                      set_user_health(i, 200);
                      set_user_footsteps(i, 1);
                        
		}
		else if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
		{
                    strip_user_weapons(i);
                    set_pev(i, 43, 0);
                    set_pev(i, 84, pev(i, 84) | 4096);
                    set_user_health(i, 100);
                    set_user_armor(i, 100);
                    give_item(i, "weapon_shield");
                    give_item(i, "weapon_knife");
                    set_user_info(i, "model", "spartanac")
                    set_bit(g_SpartaStit, i)
                    cs_set_user_bpammo(i, 26, 128);
                    set_user_footsteps(i, 1);
		}
	}

	return PLUGIN_HANDLED
}
public cmd_snajper(id) {

	jail_open()
	remove_task(800)
	set_lights("b")
	g_nogamerounds = 0
	g_GameMode = GAME_ID_SNAJPER
	g_BoxStarted = 0
	set_cvar_num("mp_friendlyfire", 0)
	entity_set_int(g_Simon, EV_INT_body, 3)
        client_cmd(0, "mp3 stop");
        client_cmd(0, "stopsound");
        client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/snajper_igra.mp3");
	g_Simon = 0
	server_cmd("jb_block_weapons")
	set_cvar_num("mp_friendlyfire", 0)	
	new i
	get_user_name(id, nick, 63)
	ColorChat(0, TEAM_COLOR, "^4[Ultimate JaiLBreaK] ^1Glasanje je zavrseno. Izglasan dan: ^4Snajper")
	ColorChat(0, TEAM_COLOR, "^4[Snajper] ^1Zatvorenici i Cuvari imaju Snajper Ko pobedi Pricace..")
        ColorChat(0, TEAM_COLOR, "^4[Ultimate JaiLBreaK] ^1je startovao Snajper. Uzivajte u igri.")
	set_dhudmessage(0, 150, 200, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
	show_dhudmessage(0, "Ultimate JaiLBreaK je Startovao Snajper");
	jail_open()
	for(i = 1; i <= g_MaxClients; i++) 
	{
		if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_CT))
		{
			strip_user_weapons(i)
			fm_give_item(i, "weapon_knife")
			fm_give_item(i, "weapon_awp")
			cs_set_user_bpammo(i, CSW_AWP, 255)
			set_user_health(i, 350)
			set_user_gravity(i, 0.4)
			set_user_maxspeed(i, 370.0)
			set_user_footsteps(i, 1)
		}
		if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
		{
			fm_strip_user_weapons(i)
			fm_give_item(i, "weapon_knife")
			fm_give_item(i, "weapon_awp")
			cs_set_user_bpammo(i, CSW_AWP, 255)
			set_user_health(i, 250)
			set_user_gravity(i, 0.4)
			set_user_maxspeed(i, 370.0)
			set_user_footsteps(i, 1)
			set_user_footsteps(i, 1)
			set_pdata_float(i, m_flNextAttack, 30.0, lunux_offset_player);
			set_pev(i, pev_flags, pev(i, pev_flags) | FL_FROZEN);
			set_pev(i, pev_takedamage, DAMAGE_NO);
		}
	}

	return PLUGIN_HANDLED
}

public cmd_presidentday(id) {
	
	set_task( 1.0, "PresidentOdbrojavanje", 2, _, _, "a", 30 )
	jail_open()
	remove_task(800)
	set_lights("b")
	g_nogamerounds = 0
	g_GameMode = GAME_ID_PRESIDENT
	g_BoxStarted = 0
	set_cvar_num("mp_friendlyfire", 0)
	entity_set_int(g_Simon, EV_INT_body, 3)
        client_cmd(0, "mp3 stop");
        client_cmd(0, "stopsound");
        client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/presidentt.mp3");
	g_Simon = 0
	server_cmd("jb_block_weapons")
	set_cvar_num("mp_friendlyfire", 0)	
	new i
	get_user_name(id, nick, 63)
	ColorChat(0, TEAM_COLOR, "^4[Ultimate JaiLBreaK] ^1Glasanje je zavrseno. Izglasan dan: ^4President Day")
	ColorChat(0, TEAM_COLOR, "^4[President] ^1Zatvorenici imaju zadatak da ubiju predsednika da bi pobedili.")
        ColorChat(0, TEAM_COLOR, "^4[Ultimate JaiLBreaK] ^1je startovao President. Uzivajte u igri.")
	set_dhudmessage(0, 150, 200, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
	show_dhudmessage(0, "Ultimate JaiLBreaK je Startovao President");
	jail_open()
	for(i = 1; i <= g_MaxClients; i++) 
	{
		if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_CT))
		{
			strip_user_weapons(i)
			fm_give_item(i, "weapon_knife")
			fm_give_item(i, "weapon_ak47")
			fm_give_item(i, "weapon_m4a1")
			fm_give_item(i, "weapon_deagle")
			cs_set_user_bpammo(i, CSW_DEAGLE, 30)
			cs_set_user_bpammo(i, CSW_M4A1, 200)
			cs_set_user_bpammo(i, CSW_AK47, 200)
			set_user_health(i, 250)
			set_user_gravity(i, 0.4)
			set_user_maxspeed(i, 300.0)
			set_user_footsteps(i, 1)
		}
		if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
		{
			fm_strip_user_weapons(i)
			fm_give_item(i, "weapon_knife")
			fm_give_item(i, "weapon_ak47")
			fm_give_item(i, "weapon_m4a1")
			fm_give_item(i, "weapon_deagle")
			cs_set_user_bpammo(i, CSW_DEAGLE, 30)
			cs_set_user_bpammo(i, CSW_M4A1, 200)
			cs_set_user_bpammo(i, CSW_AK47, 200)
			set_user_health(i, 200)
			set_user_maxspeed(i, 550.0)
			set_user_footsteps(i, 1)
			set_user_footsteps(i, 1)
			set_pdata_float(i, m_flNextAttack, 30.0, lunux_offset_player);
			set_pev(i, pev_flags, pev(i, pev_flags) | FL_FROZEN);
			set_pev(i, pev_takedamage, DAMAGE_NO);
		}
	}

	return PLUGIN_HANDLED
}

public cmd_gangsteri(id) {
	
	set_task( 1.0, "PresidentOdbrojavanje", 2, _, _, "a", 30 )
	jail_open()
	remove_task(800)
	set_lights("b")
	g_nogamerounds = 0
	g_GameMode = GAME_ID_GANG
	g_BoxStarted = 0
	set_cvar_num("mp_friendlyfire", 0)
	entity_set_int(g_Simon, EV_INT_body, 3)
        client_cmd(0, "mp3 stop");
        client_cmd(0, "stopsound");
        client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/gang_day.mp3");
	g_Simon = 0
	server_cmd("jb_block_weapons")
	set_cvar_num("mp_friendlyfire", 0)	
	new i
	get_user_name(id, nick, 63)
	ColorChat(0, TEAM_COLOR, "^4[Ultimate JailBreak] ^1Glasanje je zavrseno. Izglasan dan: ^4Gangster Day")
	ColorChat(0, TEAM_COLOR, "^4[Gangster Day] ^1Zatvorenici imaju zadatak da uzmu Paket kokaina od glavnih Mafijasa u gradu.")
        ColorChat(0, TEAM_COLOR, "^4[Ultimate  JailBreak] ^1je startovao Gangster Day. Uzivajte u igri.")
	set_dhudmessage(0, 150, 200, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
	show_dhudmessage(0, "Ultimate  JailBreaK je Startovao Gangster Day");
	jail_open()
	for(i = 1; i <= g_MaxClients; i++) 
	{
		if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_CT))
		{
			strip_user_weapons(i)
			fm_give_item(i, "weapon_knife")
			fm_give_item(i, "weapon_ak47")
			fm_give_item(i, "weapon_deagle")
			cs_set_user_bpammo(i, CSW_DEAGLE, 300)
			cs_set_user_bpammo(i, CSW_AK47, 200)
			set_user_health(i, 250)
                        set_user_armor(i, 120)
			set_user_gravity(i, 0.4)
			set_user_maxspeed(i, 300.0)
		}
		if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
		{
			fm_strip_user_weapons(i)
			fm_give_item(i, "weapon_knife")
			fm_give_item(i, "weapon_mac10")
                        fm_give_item(i, "weapon_tmp")
			fm_give_item(i, "weapon_glock18")
			cs_set_user_bpammo(i, CSW_GLOCK18, 300)
			cs_set_user_bpammo(i, CSW_MAC10, 200)
			cs_set_user_bpammo(i, CSW_TMP, 200)
			set_user_health(i, 130)
			set_user_maxspeed(i, 120.0)
			set_user_footsteps(i, 1)
			set_pdata_float(i, m_flNextAttack, 30.0, lunux_offset_player);
			set_pev(i, pev_flags, pev(i, pev_flags) | FL_FROZEN);
			set_pev(i, pev_takedamage, DAMAGE_NO);
		}
	}

	return PLUGIN_HANDLED
}
public cmd_terminatorday(id) { //////// dodati u kod za igre

	set_task( 1.0, "PresidentOdbrojavanje", 2, _, _, "a", 30 )
	jail_open()
	random_music(id)
	g_nogamerounds = 0
        set_lights("b")
	g_GameMode = 12
	g_BoxStarted = 0
	entity_set_int(g_Simon, EV_INT_body, 3)
	g_Simon = 0
	new i
	server_cmd("jb_block_weapons")
	get_user_name(id, nick, 63)
	set_dhudmessage(0, 150, 200, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
	show_dhudmessage(0, "Ultimate JaiLBreaK je startovao Terminator Day");
	ColorChat(0, TEAM_COLOR, "^4[Terminator Day] ^1Pustena igra Terminator Day. Zatvorenici moraju ubiti sve terminatore.")
	for(i = 1; i <= g_MaxClients; i++) 
	{
		if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_CT))
		{
			strip_user_weapons(i)
                        give_item(i, "weapon_m249")
                        cs_set_user_bpammo(i, CSW_M249, 500)
			set_user_health(i, 450)
			set_user_maxspeed(i, 300.0)
			set_user_footsteps(i, 1)
			set_user_info(i, "model", "motorola_terminator")
		}
		else if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
		{
			fm_strip_user_weapons(i)
                        set_pdata_float(i, m_flNextAttack, 30.0, lunux_offset_player);
			set_pev(i, pev_flags, pev(i, pev_flags) | FL_FROZEN);
			set_pev(i, pev_takedamage, DAMAGE_NO);
			give_item(i, "weapon_mac10")
                        cs_set_user_bpammo(i, CSW_MAC10, 200)
			set_user_health(i, 200)
			set_user_maxspeed(i, 350.0)
			set_user_footsteps(i, 1)
		}
	}
	return PLUGIN_HANDLED
}

public cmd_knifeday(id) {
set_task( 1.0, "_t_Countdown", 999, _, _, "a", 180 )
jail_open()
client_cmd(0, "mp3 stop");
client_cmd(0, "stopsound");
client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/knajf.mp3");
g_nogamerounds = 0
g_GameMode = GAME_ID_KNIFE
g_BoxStarted = 0
set_cvar_num("mp_friendlyfire", 0)
entity_set_int(g_Simon, EV_INT_body, 3)
g_Simon = 0
new i
server_cmd("jb_block_weapons")
get_user_name(id, nick, 63)
ColorChat(0, TEAM_COLOR, "^4[Ultimate JaiLBreaK] ^1Glasanje je zavrseno. Izglasan dan: ^4Knife Day")
ColorChat(0, TEAM_COLOR, "^4[Knife Day] ^1Zatvorenici se bore protiv cuvara za svoju slobodu.")
ColorChat(0, TEAM_COLOR, "^4[Ultimate JaiLBreaK] ^1je startovao Knife Day. Uzivajte u igri.")
set_dhudmessage(0, 150, 200, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
show_dhudmessage(0, "Ultimate JaiLBreaK je Startovao Knife Day");
for(i = 1; i <= g_MaxClients; i++) 
{
if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_CT))
{
strip_user_weapons(i)
give_item(i, "weapon_knife")
set_user_health(i, 85)
set_user_maxspeed(i, 300.0)
set_user_footsteps(i, 1)
set_bit(g_BoxRuke1, i)
}
else if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
{
strip_user_weapons(i)
give_item(i, "weapon_knife")
set_user_health(i, 50)
set_user_maxspeed(i, 300.0)
set_user_footsteps(i, 1)
set_bit(g_BoxRuke2, i)
}
}
return PLUGIN_HANDLED
}

public cmd_ghostday(id){
	set_task( 1.0, "_t_Countdown", 999, _, _, "a", 180 )
	jail_open()
        client_cmd(0, "mp3 stop");
        client_cmd(0, "stopsound");
        client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/zb_ghost.mp3");
	g_nogamerounds = 0
	g_GameMode = GAME_ID_GHOST
	g_BoxStarted = 0
	set_cvar_num("mp_friendlyfire", 0)
	entity_set_int(g_Simon, EV_INT_body, 3)
	new i
	server_cmd("jb_block_weapons")
	get_user_name(id, nick, 63)
	ColorChat(0, TEAM_COLOR, "^4[Ultimate JaiLBreaK] ^1Glasanje je zavrseno. Izglasan dan: ^4Ghost Day")
	ColorChat(0, TEAM_COLOR, "^4[Ghost Day] ^1Zatvorenici imaju zadatak da pobiju sve duhove.")
        ColorChat(0, TEAM_COLOR, "^4[Ultimate JaiLBreaK] ^1je startovao Ghost Day. Uzivajte u igri.")
	set_dhudmessage(0, 150, 200, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
	show_dhudmessage(0, "Ultimate JaiLBreaK je Startovao Ghost Day");
	fog(true, 255, 255, 255);
	for(i = 1; i <= g_MaxClients; i++) 
	{
		if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T))
		{
			strip_user_weapons(i)
			give_item(i, "weapon_m249")
			give_item(i, "weapon_flashbang") 
			set_user_health(i, 150)
			set_user_armor(i, 100)
			set_user_maxspeed(i, 300.0)
			cs_set_user_bpammo(i, CSW_M249, 500)
		}
		else if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_CT)
		{
			strip_user_weapons(i)
			give_item(i, "weapon_knife")
			set_user_health(i, 300)
			set_user_maxspeed(i, 270.0)
			set_user_footsteps(i, 1)
			set_pev(i, pev_movetype, MOVETYPE_NOCLIP);
			set_bit(g_GhostRuke, i)
			set_user_info(i, "model", "ghost_ds2")
		}
	}
	return PLUGIN_HANDLED
}


public cmd_freezetagday(id) {
	set_task( 1.0, "_t_Countdown", 999, _, _, "a", 180 )	
	jail_open()
        client_cmd(0, "mp3 stop");
        client_cmd(0, "stopsound");
        client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/ledeni_day.mp3");
	remove_task(800)
	remove_task(700)
	g_GameMode = GAME_ID_LEDENI
	g_BoxStarted = 0
	server_cmd("jb_block_weapons")
	get_user_name(id, nick, 63)
	ColorChat(0, TEAM_COLOR, "^4[Ultimate JaiLBreaK] ^1Glasanje je zavrseno. Izglasan dan: ^4Ledeni Cica")
	ColorChat(0, TEAM_COLOR, "^4[Ledeni Cica] ^1Cuvari moraju da zalede sve zatvorenike, Ne smeju da cuvaju zatvorenike.")
        ColorChat(0, TEAM_COLOR, "^4[Ultimate JaiLBreaK] ^1je startovao Ledeni cica. Uzivajte u igri.")
	set_dhudmessage(0, 150, 200, -1.0, 0.4, 0, 2.0, 5.0, 0.2, 0.2, false)
	show_dhudmessage(0, "Ultimate JaiLBreaK je Startovao Ledeni Cica");
	g_SimonAllowed = 0
	g_Simon = 1
	g_nogamerounds = 0
	
	new i;
	for(i = 1; i <= get_maxplayers(); i++) {
		if(!is_user_alive(i))
			continue;
		
		set_bit(g_iBitUserGame, i);
		fm_strip_user_weapons(i);
		fm_give_item(i, "weapon_knife");
		set_pev(i, pev_gravity, 0.3);
		
		
		switch(cs_get_user_team(i)) {
			case CS_TEAM_T: {
				g_iUserTeam[i] = 1;
				set_pev(i, pev_maxspeed, 380.0);
				g_iUserLife[i] = 3;
			}
			case CS_TEAM_CT: {
				g_iUserTeam[i] = 2;
				/*static iszViewModel, iszWeaponModel;
				if(iszViewModel || (iszViewModel = engfunc(EngFunc_AllocString, "models/v_candy_cane_jb.mdl"))) set_pev_string(i, pev_viewmodel2, iszViewModel);
				if(iszWeaponModel || (iszWeaponModel = engfunc(EngFunc_AllocString, "models/p_candy_cane_jb.mdl"))) set_pev_string(i, pev_weaponmodel2, iszWeaponModel);*/
				set_bit(g_CandyCane, i)
			}
		}
	}
	
	new sz_msg[256];
	formatex(sz_msg, charsmax(sz_msg), "")
	client_print(0, print_center , sz_msg)
	for(i = 0; i < sizeof(g_iHamHookForwards3); i++)
		EnableHamForward(g_iHamHookForwards3[i]);
	
	g_iFakeMetaAddToFullPack = register_forward(FM_AddToFullPack, "FakeMeta_AddToFullPack_Post", 1);
	g_iFakeMetaCheckVisibility = register_forward(FM_CheckVisibility, "FakeMeta_CheckVisibility", 0);
	g_RoundEndTimer = 200;
	set_task(1.0, "KillerTimerCountDown", TASK_KILLER_TIMER);
}

public HamHook_EntityBlock3()
	return HAM_SUPERCEDE;

public Ham_TraceAttack_Pre3(iVictim, iAttacker, Float:fDamage, Float:vecDeriction[3], iTrace, iBitDamage) {
	if(get_bit(g_iBitUserGame, iAttacker)) {
		switch(cs_get_user_team(iAttacker)) {
			case CS_TEAM_T: if(get_bit(g_iBitUserFrozen, iVictim) && get_user_team(iVictim) == 1) jbe_dm_user_defrost(iVictim, iAttacker);
				case CS_TEAM_CT: if(IsNotSetBit(g_iBitUserFrozen, iVictim) && get_user_team(iVictim) == 1 && !task_exists(iVictim+TASK_PROTECTION_TIME)) jbe_dm_user_freeze(iVictim, iAttacker);
			}
	}
	
	return HAM_SUPERCEDE;
}

public Ham_PlayerKilled_Post3(iVictim)
	clear_bit(g_iBitUserGame, iVictim);

jbe_dm_user_defrost(iVictim, iAttacker) {
	if(task_exists(iVictim+TASK_DEATH_TIMER))
		remove_task(iVictim+TASK_DEATH_TIMER);
	
	clear_bit(g_iBitUserFrozen, iVictim);
	set_pev(iVictim, pev_flags, pev(iVictim, pev_flags) & ~FL_FROZEN);
	set_pdata_float(iVictim, m_flNextAttack, 0.0, lunux_offset_player);
	fm_set_user_rendering(iVictim, kRenderFxGlowShell, 255.0, 0.0, 0.0, kRenderNormal, 0.0);
	set_task(3.0, "jbe_dm_protection_time", iVictim+TASK_PROTECTION_TIME);
	UTIL_ScreenFade(iVictim, (1<<10), (1<<10), 0, 32, 164, 241, 200, 1);
	
	new Float:fOrigin[3];
	pev(iVictim, pev_origin, fOrigin);
	CREATE_BREAKMODEL(fOrigin, _, _, 10, g_pModelFrost, 10, 25, BREAK_GLASS);
	emit_sound(iVictim, CHAN_AUTO, "defrost_player.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM);
	
	if(pev_valid(g_iUserEntityTimer[iVictim]))
		set_pev(g_iUserEntityTimer[iVictim], pev_flags, pev(g_iUserEntityTimer[iVictim], pev_flags) | FL_KILLME);
	
	if(iAttacker)
		g_iUserLife[iAttacker]++;
}

public jbe_dm_protection_time(id) {
	id -= TASK_PROTECTION_TIME;
	if(get_bit(g_iBitUserGame, id))
		fm_set_user_rendering(id, kRenderFxNone, 255.0, 0.0, 0.0, kRenderNormal, 0.0);
}

jbe_dm_user_freeze(iVictim, iAttacker) {
	if(--g_iUserLife[iVictim]) {
		set_bit(g_iBitUserFrozen, iVictim);
		set_pdata_float(iVictim, m_flNextAttack, 20.0, lunux_offset_player);
		fm_set_user_rendering(iVictim, kRenderFxGlowShell, 32.0, 164.0, 241.0, kRenderNormal, 0.0);
		UTIL_ScreenFade(iVictim, 0, 0, 4, 32, 164, 241, 200);
		
		new Float:vecOrigin[3];
		pev(iVictim, pev_origin, vecOrigin);
		set_pev(iVictim, pev_flags, pev(iVictim, pev_flags) | FL_FROZEN);
		set_pev(iVictim, pev_origin, vecOrigin);
		
		vecOrigin[2] += 15.0;
		
		CREATE_SPRITETRAIL(vecOrigin, g_pSpriteFrost, 30, 20, 2, 20, 10);
		g_fUserDeathTimer[iVictim] = 20.0;
		
		jbe_dm_create_death_timer(iVictim, vecOrigin);
		emit_sound(iVictim, CHAN_AUTO, "freeze_player2.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM);
		
		new iArg[1]; iArg[0] = iAttacker;
		set_task(1.0, "jbe_dm_user_death_timer", iVictim+TASK_DEATH_TIMER, iArg, sizeof(iArg), "a", 20);
	}
	else ExecuteHamB(Ham_Killed, iVictim, iAttacker, 2);
}

public jbe_dm_user_death_timer(const iAttacker[], iVictim) {
	iVictim -= TASK_DEATH_TIMER;
	
	if(IsNotSetBit(g_iBitUserFrozen, iVictim) && task_exists(iVictim+TASK_DEATH_TIMER)) {
		remove_task(iVictim+TASK_DEATH_TIMER);
		return;
	}
	
	if(g_fUserDeathTimer[iVictim] -= 1.0)
		return;
	
	clear_bit(g_iBitUserFrozen, iVictim);
	set_pev(iVictim, pev_flags, pev(iVictim, pev_flags) & ~FL_FROZEN);
	fm_set_user_rendering(iVictim, kRenderFxNone, 0.0, 0.0, 0.0, kRenderNormal, 0.0);
	UTIL_ScreenFade(iVictim, (1<<10), (1<<10), 0, 32, 164, 241, 200, 1);
	ExecuteHamB(Ham_Killed, iVictim, iAttacker[0], 2);
	
	if(pev_valid(g_iUserEntityTimer[iVictim]))
		set_pev(g_iUserEntityTimer[iVictim], pev_flags, pev(g_iUserEntityTimer[iVictim], pev_flags) | FL_KILLME);
}

public FakeMeta_AddToFullPack_Post(ES_Handle, iE, iEntity, iHost, iHostFlags, iPlayer, pSet) {
	if(!pev_valid(iEntity) || pev(iEntity, pev_iuser1) != IUSER1_DEATH_TIMER || g_GameMode != 17)
		return FMRES_IGNORED;
	
	if(IsNotSetBit(g_iBitUserGame, iHost) || g_iUserTeam[iHost] == 2) {
		static iEffects;
		
		if(!iEffects)
			iEffects = get_es(ES_Handle, ES_Effects);
		
		set_es(ES_Handle, ES_Effects, iEffects | EF_NODRAW);
		return FMRES_IGNORED;
	}
	
	new Float:vecHostOrigin[3], Float:vecEntityOrigin[3], Float:vecEndPos[3], Float:vecNormal[3];
	
	pev(iHost, pev_origin, vecHostOrigin);
	pev(iEntity, pev_origin, vecEntityOrigin);
	
	new pTr = create_tr2();
	engfunc(EngFunc_TraceLine, vecHostOrigin, vecEntityOrigin, IGNORE_MONSTERS, iEntity, pTr);
	get_tr2(pTr, TR_vecEndPos, vecEndPos);
	get_tr2(pTr, TR_vecPlaneNormal, vecNormal);
	xs_vec_mul_scalar(vecNormal, 10.0, vecNormal);
	xs_vec_add(vecEndPos, vecNormal, vecNormal);
	set_es(ES_Handle, ES_Origin, vecNormal);
	
	new Float:fDist, Float:fScale;
	fDist = get_distance_f(vecNormal, vecHostOrigin);
	fScale = fDist / 300.0;
	
	if(fScale < 0.4)
		fScale = 0.4;
	else if(fScale > 1.0)
		fScale = 1.0;
	
	set_es(ES_Handle, ES_Scale, fScale);
	set_es(ES_Handle, ES_Frame, g_fUserDeathTimer[pev(iEntity, pev_iuser2)]);
	
	free_tr2(pTr);
	return FMRES_IGNORED;
}

public FakeMeta_CheckVisibility(iEntity, pSet) {
	if(!pev_valid(iEntity) || pev(iEntity, pev_iuser1) != IUSER1_DEATH_TIMER) return FMRES_IGNORED;
	forward_return(FMV_CELL, 1);
	return FMRES_SUPERCEDE;
}

public jbe_dm_create_death_timer(id, Float:vecOrigin[3]) {
	static iszInfoTarget = 0;
	
	if(iszInfoTarget || (iszInfoTarget = engfunc(EngFunc_AllocString, "info_target")))
		g_iUserEntityTimer[id] = engfunc(EngFunc_CreateNamedEntity, iszInfoTarget);
	
	if(!pev_valid(g_iUserEntityTimer[id]))
		return;
	
	vecOrigin[2] += 35.0;
	set_pev(g_iUserEntityTimer[id], pev_classname, "death_timer");
	set_pev(g_iUserEntityTimer[id], pev_origin, vecOrigin);
	set_pev(g_iUserEntityTimer[id], pev_iuser1, IUSER1_DEATH_TIMER);
	set_pev(g_iUserEntityTimer[id], pev_iuser2, id);
	engfunc(EngFunc_SetModel, g_iUserEntityTimer[id], "sprites/death_timer.spr");
	fm_set_user_rendering(g_iUserEntityTimer[id], kRenderFxNone, 0.0, 0.0, 0.0, kRenderTransAdd, 255.0);
	set_pev(g_iUserEntityTimer[id], pev_solid, SOLID_NOT);
	set_pev(g_iUserEntityTimer[id], pev_movetype, MOVETYPE_NONE);
}

/////////////// SCOUT

public cmd_scoutday(id) {
	jail_open()
	g_nogamerounds = 0
	g_GameMode = GAME_ID_SCOUT
	g_BoxStarted = 0
	entity_set_int(g_Simon, EV_INT_body, 3)
	g_Simon = 0
	set_lights("d")
	new i
	server_cmd("jb_block_weapons")
	get_user_name(id, nick, 63)
	for(i = 1; i <= g_MaxClients; i++) 
	{
		if((is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_CT))
		{
			strip_user_weapons(i)
			give_item(i, "weapon_scout")
			set_user_health(i, 300)
			cs_set_user_bpammo(i, CSW_AWP, 30)
			give_item(id, "weapon_knife")
			set_user_maxspeed(i, 300.0)
			set_user_gravity(i, 0.8)
			set_user_footsteps(i, 1)
		}
		if(is_user_alive(i) && cs_get_user_team(i) == CS_TEAM_T)
		{
			strip_user_weapons(i)
			give_item(i, "weapon_scout")
			set_user_health(i, 150)
			cs_set_user_bpammo(i, CSW_AWP, 30)
			give_item(id, "weapon_knife")
			set_user_maxspeed(i, 300.0)
			set_user_gravity(i, 0.8)
			set_user_footsteps(i, 1)
		}
	}
	return PLUGIN_HANDLED
}

//---------------------------------RANDOM MUSIC-----------------------------------//
//--------------------------------------------------------------------------------//
//**ZAVRSENO
//**KOMANDA random_music(id)

public random_music(id)
{
switch(random_num(1,8))
{
case 1:
{
client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/zb_sparta.mp3")
}
case 2:
{
client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/snajper_igra.mp3")
}
case 3:
{
client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/presidentt.mp3")	
}
case 4:
{
client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/gang_day.mp3")
}
case 5:
{
client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/knajf.mp3")
}
case 6:
{
client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/zb_ghost.mp3")
}
case 7:
{
client_cmd(0, "mp3 play sound/UltimateJB/GamesNEW/ledeni_day.mp3")
}
}
}

public vote_day_l0ck(id)
{
   if (g_JailDay == 5 || g_JailDay == 11) 
   {
   has_used[id] = true;
	
   }
   return PLUGIN_HANDLED_MAIN
}

public menu_l0ck(id)
{
     has_used[id] = true; 
}

public menu_unl0ck(id)
{
     has_used[id] = false;
}

public Odledisveigrace()
{
    new i = 1;
    while (i <= g_MaxClients)
    {
        set_pev(i, pev_flags, pev(i, pev_flags) & -4097);
        set_pev(i, pev_takedamage, 1.00/*1065353216*/);
        UTIL_ScreenFade(i, 0, 0, 0, 0, 0, 0, 0, 1);
        i++;
    }
    return 0;
}



//=================================================================================================
//				Casino System - v0.0.1
//=================================================================================================

public IzaberiKvotu(id)
{
	new menu = menu_create("\rUltimate-JB \yKladionica^n\wIzaberi na sta zelis da se kladis:","Functions")
	menu_additem(menu,"\wKladionica: \ySport")
	menu_additem(menu,"\wKocka: \yJackPot")
	menu_display(id, menu);
}	

public Functions(id ,menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_CONTINUE;
	}
	switch(item)
	{
		case 0:
		{
			Pobednik(id);
		}
		case 1:
		{
			VasBroj(id);
                } 
	}
	return PLUGIN_CONTINUE
}

public Pobednik(id)
{
	new menu = menu_create("\rUltimate-JB \ySport Kladionica^n\wIzaberi tim koji ce da pobedi:","Izabrao")
	menu_additem(menu,"\wBarcelona \rVS \wJuventus \yBarca dobija")
	menu_additem(menu,"\wBarcelova \rVS \wJuventus \yJuventus dobija")
	menu_display(id, menu);
}

public Izabrao(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_CONTINUE;
	}
	switch(item)
	{
		case 0:
		{
			set_task(0.5, "RandomP", id);
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Uspesno ste izabrali da ce ^4Barcelona dobiti Juventus. ^3SRETNO!");
		}
		case 1:
		{
			set_task(0.5, "RandomP", id);
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Uspesno ste izabrali da ce ^4Juventus dobiti Barcelonu. ^3SRETNO!");
		}
	}
	return PLUGIN_CONTINUE;
}

public RandomP(id)
{
	new rand = random_num(0,4);

	switch(rand)
	{
		case 0:
		{
			cs_set_user_money(id, cs_get_user_money(id) + 16000)
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^3CESTITAMO ! ^1Pogodili ste Barcelona je pobedila JUVENTUS ! ^4Vasa nagrada: 16000$");
		}
		case 1:
		{
			cs_set_user_money(id, cs_get_user_money(id) + 16000)
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^3CESTITAMO ! ^1Pogodili ste Juventus je pobedio BARCELONU ! ^4Vasa nagrada: 16000$");
		}
		case 2:
		{
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^3ZAO NAM JE ! ^1Niste pogodili ishod, Rezultat je bio neresen. ^4Probajte sledeci put !");
		}
		case 3:
		{
			cs_set_user_money(id, 0)
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^3ZAO NAM JE ! ^1Ali otkriveno je da ste varali ! Zbog toga uzimamo sve pare ! ^4Vas Gubitak: SVE");
		}
	}
	return PLUGIN_HANDLED;
}

public VasBroj(id)
{
	new menu = menu_create("\rUltimate-JB \yKockica^n\wIzaberi broj koji zelis da igras:","OdaberiBroj")
	menu_additem(menu,"\wKocka Broj \y1")
	menu_additem(menu,"\wKocka Broj \y2")
	menu_additem(menu,"\wKocka Broj \y3")
	menu_additem(menu,"\wKocka Broj \y4")
        menu_additem(menu,"\wKocka Broj \y5")
	menu_display(id, menu);
}

public OdaberiBroj(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_CONTINUE;
	}
	switch(item)
	{
		case 0:
		{
			set_task(0.5, "Spin", id);
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Uspesno ste izabrali broj: ^4[ 1 ].");
		}
		case 1:
		{
			set_task(0.5, "Spin", id);
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Uspesno ste izabrali broj: ^4[ 2 ].");
		}
		case 2:
		{
			set_task(0.5, "Spin", id);
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Uspesno ste izabrali broj: ^4[ 3 ].");
		}
		case 3:
		{
			set_task(0.5, "Spin", id);
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Uspesno ste izabrali broj: ^4[ 4 ].");
		}
                case 4:
                {
			set_task(0.5, "Spin", id);
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^1Uspesno ste izabrali broj: ^4[ 5 ].");
		}
	}
	return PLUGIN_CONTINUE;
}

public Spin(id)
{
	ColorChat(id, RED, "^4[^1Ultimate-JB^4] ^1Dobitni broj je: ^4[^3 1 ^4| ^1 2 ^4| ^1 3 ^4| ^1 4 ^4| ^1 5 ^4]");
	set_task(1.0, "broj1")
}

public broj1(id)
{
	ColorChat(id, RED, "^4[^1Ultimate-JB^4] ^1Dobitni broj je: ^4[^1 1 ^4| ^3 2 ^4| ^1 3 ^4| ^1 4 ^4| ^1 5 ^4]");
	set_task(1.0, "broj2")
}

public broj2(id)
{
	ColorChat(id, RED, "^4[^1Ultimate-JB^4] ^1Dobitni broj je: ^4[^1 1 ^4| ^1 2 ^4| ^3 3 ^4| ^1 4 ^4| ^1 5 ^4]");
	set_task(1.0, "broj3")
}

public broj3(id)
{
	ColorChat(id, RED, "^4[^1Ultimate-JB^4] ^1Dobitni broj je: ^4[^1 1 ^4| ^1 2 ^4| ^1 3 ^4| ^3 4 ^4| ^1 5 ^4]");
	set_task(1.0, "broj4")
}

public broj4(id)
{
	ColorChat(id, RED, "^4[^1Ultimate-JB^4] ^1Dobitni broj je: ^4[^1 1 ^4| ^1 2 ^4| ^1 3 ^4| ^1 4 ^4| ^3 5 ^4]");
	set_task(10.0, "Kocka")
}


public Kocka(id)
{
	new rand = random_num(0,5);

	switch(rand)
	{
		case 0:
		{
			cs_set_user_money(id, cs_get_user_money(id) + 16000)
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^3CESTITAMO ! ^1Pogodili ste broj 1! ^4Vasa nagrada: 16000$");
		}
		case 1:
		{
			cs_set_user_money(id, 0)
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^3ZAO NAM JE ! ^1Niste pogodili broj ! ^4Gubite sve !");
		}
		case 2:
		{
			cs_set_user_money(id, cs_get_user_money(id) + 16000)
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^3CESTITAMO ! ^1Pogodili ste broj 2! ^4Vasa nagrada: 16000$");
		}
		case 3:
		{
			cs_set_user_money(id, 0)
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^3ZAO NAM JE ! ^1Niste pogodili broj ! ^4Gubite sve !");
		}
		case 4:
		{
			cs_set_user_money(id, cs_get_user_money(id) + 16000)
			ColorChat(id, TEAM_COLOR, "^4[^1Ultimate-JB^4] ^3CESTITAMO ! ^1Pogodili ste broj 3! ^4Vasa nagrada: 16000$");
		}
	}
	return PLUGIN_CONTINUE;
}

 public blokirajBacanjeOruzja(id)
{
    if (g_GameMode == GAME_ID_SCOUT || g_GameMode == GAME_ID_LEDENI || g_GameMode == GAME_ID_RODJOS || g_GameMode == GAME_ID_GHOST || g_GameMode == GAME_ID_KNIFE || g_GameMode == GAME_ID_GANG || g_GameMode == GAME_ID_PRESIDENT || g_GameMode == GAME_ID_SNAJPER || g_GameMode == GAME_ID_SPARTA)
    {
        
        ColorChat(id, TEAM_COLOR, "^4[Ultimate] ^3Ne mozete bacati oruzje na igrama.");
        return PLUGIN_HANDLED; 
    }
    return PLUGIN_CONTINUE; 
}
	

//=================================================================================================
//				Banka Podesavanja
//=================================================================================================

public PrikaziSpisakIgraca(id) {
    new menu = menu_create("Izaberi igraca za transfer:", "IzborIgracaHandler");
    new name[32];
    new count = 0;
    for (new i = 0; i < MAX_PLAYERS; i++) {
        g_PlayerMenuChoices[id][i] = 0;
    }
    for (new i = 1; i <= MAX_PLAYERS; i++) {
        if (is_user_connected(i) && i != id) {
            get_user_name(i, name, sizeof(name));
            menu_additem(menu, name, "", count);
            g_PlayerMenuChoices[id][count] = i;
            count++;
        }
    }
    menu_display(id, menu, 0);
}

public Meni(id) {
    if (!g_BankaAktivna) {
        ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Banka je trenutno neaktivna.");
        return;
    }
    new playerBalance[32], balanceStr[128];
    new pid[32];
    get_user_authid(id, pid, sizeof(pid));
    nvault_get(g_vault, pid, playerBalance, sizeof(playerBalance));
    new currentBalance = str_to_num(playerBalance);
    
    format(balanceStr, sizeof(balanceStr), "\wUltimate Banka - \yLimit Banke \w[\r%d$ / \r30,000$\w]\r", currentBalance);
    new menu = menu_create(balanceStr, "Handler");
    
    menu_additem(menu, "\wStavi pare u banku\w[\yMax:\r16.000$\w]\r", "0");
    menu_additem(menu, "\wPodigni pare iz banke\w[\yMax:\r10.000$\w]\r", "1");
    menu_additem(menu, "\wPrebaci novac igracu\w[\yMax:\r6.000$\w]\r", "2");
    
    menu_display(id, menu, 0);
}

public Handler(id, menu, item) {
    menu_destroy(menu);
    switch(item) {
        case 0: {
            client_cmd(id,"messagemode deposit")
            
        }
        case 1: {
            client_cmd(id,"messagemode withdraw") 
            
        }
        case 2: {
            PrikaziSpisakIgraca(id);
            
        }
    }
}

public IzborIgracaHandler(id, menu, item) {
    menu_destroy(menu);
    if (item != MENU_EXIT) {
        new chosenPlayerID = g_PlayerMenuChoices[id][item];
        g_TransferTarget[id] = chosenPlayerID;
        ShowTransferAmountMenu(id);
    }
}

public ShowTransferAmountMenu(id) {
    new subMenu = menu_create("Izaberi iznos za transfer:", "IzborIznosaHandler");
    g_TransferAmounts[id][0] = 1000;
    g_TransferAmounts[id][1] = 3000;
    g_TransferAmounts[id][2] = 6000;
    g_TransferAmounts[id][3] = 0; // Custom amount
    
    menu_additem(subMenu, "1,000", "", 0);
    menu_additem(subMenu, "3,000", "", 1);
    menu_additem(subMenu, "6,000", "", 2);
    menu_additem(subMenu, "Unesi iznos", "", 3);
    
    menu_display(id, subMenu, 0);
}

public IzborIznosaHandler(id, menu, item) {
    menu_destroy(menu);
    if (item == 3) {
        // Ako je izabran unos prilagodenog iznosa.
        client_cmd(id, "messagemode customamount");
    } else {
        // Ako je izabran jedan od predefinisanih iznosa.
        new amount = g_TransferAmounts[id][item];
        TransferNovca(id, g_TransferTarget[id], amount);
    }
}

public chat_handler(id, input[]) {
    if (equal(input, "/customamount")) {
        new amountString[10];
        read_args(amountString, sizeof(amountString) - 1);
        if (!amountString[0]) {
            client_print(id, print_chat, "Molimo unesite iznos nakon komande. Npr: /customamount 500");
            return PLUGIN_HANDLED;
        }
        new amount = str_to_num(amountString);
        if (amount < 1 || amount > TRANSFER_LIMIT) {
            client_print(id, print_chat, "Nevazeci iznos. Molimo unesite iznos izmedu 1 i %d.", TRANSFER_LIMIT);
            return PLUGIN_HANDLED;
        }
        TransferNovca(id, g_TransferTarget[id], amount);
        return PLUGIN_HANDLED;
    }
    return PLUGIN_CONTINUE;
}

public TransferNovca(senderId, receiverId, amount) {
    if (!is_user_connected(senderId) || !is_user_connected(receiverId)) {
        ColorChat(senderId, TEAM_COLOR, "^4[Ultimate Banka] ^1Greska: Niste povezani ili primalac nije povezan.");
        return;
    }
    if (g_TransferredThisRound[senderId] + amount > TRANSFER_LIMIT) {
        ColorChat(senderId, TEAM_COLOR, "^4[Ultimate Banka] ^1Ne mozete slati vise od ^3$6000 ^1po rundi.");
        return;
    }
    if (!ImaDovoljnoNovca(senderId, amount)) {
        ColorChat(senderId, TEAM_COLOR, "^4[Ultimate Banka] ^3Nemate dovoljno sredstava za slanje ^4$%d.", amount);
        return;
    }
    if (!MozePrimitiNovac(receiverId, amount)) {
        ColorChat(senderId, TEAM_COLOR, "^4[Ultimate Banka] ^3Primalac ne moze prihvatiti ^4$%d ^3zbog limita balansa.");
        return;
    }
    SkiniNovac(senderId, amount);
    DodajNovac(receiverId, amount);
    new senderName[32], receiverName[32];
    get_user_name(senderId, senderName, sizeof(senderName));
    get_user_name(receiverId, receiverName, sizeof(receiverName));
    ColorChat(senderId, TEAM_COLOR, "^4[Ultimate Banka] ^3Uspesno ste prebacili ^4$%d ^3korisniku ^2%s.", amount, receiverName);
    ColorChat(receiverId, TEAM_COLOR, "^4[Ultimate Banka] ^4%s ^3vam je poslao ^4$%d ^3preko bankovnog transfera.", senderName, amount);
    g_TransferredThisRound[senderId] += amount;
}



public unosiznosa(id) {
    new amountString[10];
    read_argv(1, amountString, sizeof(amountString));
    new amount = str_to_num(amountString);
    
    if (amount < 1 || amount > TRANSFER_LIMIT) {
        ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^1Unesite validan iznos izmedju 1 i ^3$6000.");
        return;
    }

    if (g_TransferredThisRound[id] + amount > TRANSFER_LIMIT) {
        ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^1Ne mozete slati vise od ^3$6000 ^1po rundi.");
        return;
    }

    TransferNovca(id, g_TransferTarget[id], amount);
}


public ImaDovoljnoNovca(id, amount) {
    new pid[32], bmoney[32], bmoney2;
    get_user_authid(id, pid, sizeof(pid));
    nvault_get(g_vault, pid, bmoney, sizeof(bmoney));
    bmoney2 = str_to_num(bmoney);

    return bmoney2 >= amount;
}
public MozePrimitiNovac(id, amount) {
    new pid[32], bmoney[32], bmoney2;
    get_user_authid(id, pid, sizeof(pid));
    nvault_get(g_vault, pid, bmoney, sizeof(bmoney));
    bmoney2 = str_to_num(bmoney);

    return (bmoney2 + amount) <= BANK_MAX_BALANCE;
}
public SkiniNovac(id, amount) {
    new pid[32], bmoney[32], bmoney2, novi_iznos[32];
    get_user_authid(id, pid, sizeof(pid));
    nvault_get(g_vault, pid, bmoney, sizeof(bmoney));
    bmoney2 = str_to_num(bmoney);

    bmoney2 -= amount;
    num_to_str(bmoney2, novi_iznos, sizeof(novi_iznos));
    nvault_set(g_vault, pid, novi_iznos);
}
public DodajNovac(id, amount) {
    new pid[32], bmoney[32], bmoney2, novi_iznos[32];
    get_user_authid(id, pid, sizeof(pid));
    nvault_get(g_vault, pid, bmoney, sizeof(bmoney));
    bmoney2 = str_to_num(bmoney);

    bmoney2 += amount;
    num_to_str(bmoney2, novi_iznos, sizeof(novi_iznos));
    nvault_set(g_vault, pid, novi_iznos);
}


public ubaci(id) 
{ 
    if(get_cvar_num("brs_warmup") == 0) 
    { 
        new suma[32], suma2, broj_para;
        read_argv(1, suma, 31); 
        suma2 = str_to_num(suma); 
        broj_para = cs_get_user_money(id); 

        if(suma2 <= 0) 
        {
            ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Ne mozete staviti negativan iznos ili nulu.");
            return;
        }

        if(suma2 + g_DepositedThisRound[id] > DEPOSIT_LIMIT) 
        {
            ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Maksimalni iznos koji mozete staviti po rundi je ^4%d$.", DEPOSIT_LIMIT);
            return;
        }
        
        if(suma2 > broj_para) 
        {
           ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Nemate dovoljno novca da stavite ^4%d$ ^1u banku.", suma2);
        }
        else 
        { 
            new pid[32], bmoney[32], bmoney2;
            get_user_authid(id, pid, 31); 
            nvault_get(g_vault, pid, bmoney, 31); 
            bmoney2 = str_to_num(bmoney); 

            if(bmoney2 + suma2 > BANK_MAX_BALANCE) 
            {
                ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Ne mozete imati vise od ^3%d$ ^4u banci.", BANK_MAX_BALANCE);
            }
            else 
            {
                new xxx[32];
                bmoney2 += suma2; 
                num_to_str(bmoney2, xxx, 31); 
                nvault_set(g_vault, pid, xxx); 
                cs_set_user_money(id, broj_para - suma2); 
                g_DepositedThisRound[id] += suma2; 
                ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Uspesno ste stavili ^4%d$ ^3u banku. ^3Trenutno stanje: ^4%d$", suma2, bmoney2);
            } 
        } 
    } 
    else 
    {
        ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Ne mozete staviti pare za vrijeme zagrijavanja.");
    } 
}
public podigni(id) 
{ 
    if(get_cvar_num("brs_warmup") == 0) 
    { 
        new suma[32], suma2, broj_para, broj_bpara[32], broj_bpara2, pid[32], xxx[32]; 
        read_argv(1, suma, 31); 
        suma2 = str_to_num(suma); 
        broj_para = cs_get_user_money(id); 
        get_user_authid(id, pid, 31); 
        nvault_get(g_vault, pid, broj_bpara, 31); 
        broj_bpara2 = str_to_num(broj_bpara); 

        if(suma2 < 0 || g_WithdrawnThisRound[id] + suma2 > WITHDRAW_LIMIT) 
        {
            ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Ne mozete podici vise od ^4%d$ ^3 po rundi.", WITHDRAW_LIMIT);
            return;
        }

        if(suma2 > broj_bpara2) 
        {
           ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Nemate dovoljno srdstva na racunu.");
        }
        else if(suma2 + broj_para > 16000) 
        {
	    ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Ne mozete nositi vise od ^4$16000.");
        }
        else 
        {
            cs_set_user_money(id, broj_para + suma2); 
            num_to_str(broj_bpara2 - suma2, xxx, 31); 
            nvault_set(g_vault, pid, xxx); 
            ColorChat(id, TEAM_COLOR, "^4[Ultimate Banka] ^3Podigli ste ^4$%d.", suma2); 
            g_WithdrawnThisRound[id] += suma2;
        }
    }
    else 
    {
        ColorChat(id, RED, "[Ultimate Banka] Nije moguce podizati novac za vrijeme zagrijavanja.");
    }
}


bool:pf_have_simon_access(id)
{
	new flagz[3]
	get_pcvar_string(cvar_simon_menu_flag, flagz, charsmax(flagz))
		
	if((id == g_Simon) || has_flag(id, flagz))
	{
		return true;
	}
	
	return false;
}

//=================================================================================================
//				HappyVIP Time 
//=================================================================================================

stock bool:HappyVreme()
{
	static Hours, Minutes, Seconds;
        time( Hours, Minutes, Seconds);

	new HappyPocetak = 22
        new HappyZavrsetak = 10

	if(HappyPocetak == HappyZavrsetak)
		return false;

	if(HappyPocetak > HappyZavrsetak && (Hours >= HappyPocetak || Hours < HappyZavrsetak))
		return true;
	if(HappyPocetak < HappyZavrsetak && (Hours >= HappyPocetak || Hours < HappyZavrsetak))
		return true;

	return false;
}

public Provera()
{
	if(HappyVreme () ) set_cvar_string( "amx_default_access", "t" );
 	
	if(!HappyVreme() ) set_cvar_string( "amx_default_access", "z" );
}

//=================================================================================================
//					Save Client Data
//=================================================================================================

stock UTIL_ScreenFade(pPlayer, iDuration, iHoldTime, iFlags, iRed, iGreen, iBlue, iAlpha, iReliable = 0) /// FIXANO
{
	switch(pPlayer)
	{
		case 0:
		{
			message_begin(iReliable ? MSG_ALL : MSG_BROADCAST, MsgId_ScreenFade);
			write_short(iDuration);
			write_short(iHoldTime);
			write_short(iFlags);
			write_byte(iRed);
			write_byte(iGreen);
			write_byte(iBlue);
			write_byte(iAlpha);
			message_end();
		}
		default:
		{
			engfunc(EngFunc_MessageBegin, iReliable ? MSG_ONE : MSG_ONE_UNRELIABLE, MsgId_ScreenFade, {0.0, 0.0, 0.0}, pPlayer);
			write_short(iDuration);
			write_short(iHoldTime);
			write_short(iFlags);
			write_byte(iRed);
			write_byte(iGreen);
			write_byte(iBlue);
			write_byte(iAlpha);
			message_end();
		}
	}
}

stock UTIL_WeaponAnimation(pPlayer, iAnimation)
{
	set_pev(pPlayer, pev_weaponanim, iAnimation);
	engfunc(EngFunc_MessageBegin, MSG_ONE_UNRELIABLE, SVC_WEAPONANIM, {0.0, 0.0, 0.0}, pPlayer);
	write_byte(iAnimation);
	write_byte(0);
	message_end();
}

public fog(bool: on, r, g, b) {
	if (on) {
		message_begin(MSG_ALL, get_user_msgid("Fog"), { 0, 0, 0 }, 0)
		write_byte(r) // R
		write_byte(g) // G
		write_byte(b) // B
		write_byte(10) // SD
		write_byte(41) // ED
		write_byte(95) // D1
		write_byte(59) // D2
		message_end()
		
		} else {
		message_begin(MSG_ALL, get_user_msgid("Fog"), {	0, 0, 0 }, 0)
		write_byte(0) // R
		write_byte(0) // G
		write_byte(0) // B
		write_byte(0) // SD
		write_byte(0) // ED
		write_byte(0) // D1
		write_byte(0) // D2
		message_end()
	}
}


public beacon(id)
{
	if(g_DuelOn==0)
		return;
	
	if(cs_get_user_team(id) == CS_TEAM_CT)
	{
		static origin[3]
		get_user_origin(id, origin)
		message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
		write_byte(TE_BEAMCYLINDER)	// TE id
		write_coord(origin[0])	 	// x
		write_coord(origin[1])		// y
		write_coord(origin[2]-20)	// z
		write_coord(origin[0])    	// x axis
		write_coord(origin[1])    	// y axis
		write_coord(origin[2]+200)	// z axis
		write_short(beacon_sprite)	// sprite
		write_byte(0)			// startframe   
		write_byte(1)			// framerate   
		write_byte(6)			// life
		write_byte(2)  			// width
		write_byte(1)   			// noise    
		write_byte(0)  			// red  
		write_byte(0)   			// green 
		write_byte(250) 		// blue
		write_byte(200)			// brightness
		write_byte(0)			// speed
		message_end()
	}
	else if(cs_get_user_team(id) == CS_TEAM_T)
	{
		static origin[3]
		get_user_origin(id, origin)
		message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
		write_byte(TE_BEAMCYLINDER)	// TE id
		write_coord(origin[0])	 	// x
		write_coord(origin[1])		// y
		write_coord(origin[2]-20)	// z
		write_coord(origin[0])    	// x axis
		write_coord(origin[1])    	// y axis
		write_coord(origin[2]+200)	// z axis
		write_short(beacon_sprite)	// sprite
		write_byte(0)			// startframe   
		write_byte(1)			// framerate   
		write_byte(6)			// life
		write_byte(2)  			// width
		write_byte(1)   			// noise    
		write_byte(250)			// red  
		write_byte(0)   			// green 
		write_byte(0) 			// blue
		write_byte(200)			// brightness
		write_byte(0)			// speed
		message_end()
	}
	set_task(1.0, "beacon", id)
	
}
jbe_duel_ended()
{
new Players[32] 	

new playerCount, i 
get_players(Players, playerCount, "c") 
for (i=0; i<playerCount; i++) 
	
	if(is_user_alive(Players[i])) {
		g_DuelOn =0 
		CREATE_KILLPLAYERATTACHMENTS(g_DuelA);
		CREATE_KILLPLAYERATTACHMENTS(g_DuelB);
	}
}
public show_sprite(id)
{	
	if(g_DuelOn==0)
		return;
	
	message_begin(MSG_ALL,SVC_TEMPENTITY)
	write_byte(124)
	write_byte(id)
	write_coord(65)
	write_short(arrow_sprite)
	write_short(32767)
	message_end()
	
}
stock LoopResetDuel()
{
	for (new id=1; id <= g_maxPlayers; id++)
	{
		if(is_user_connected(id))
		{
			if(InDuel[id])
			{
				FullAmmo[id] = false
				InDuel[id] = false
			}
		}
	}
}
stock Color_Print(const id, const input[], any:...)
{
new count = 1, players[32]
static msg[191]
vformat(msg, 190, input, 3)
	
replace_all(msg, 190, "!g", "^4") // Green Color
replace_all(msg, 190, "!y", "^1") // Default Color
replace_all(msg, 190, "!team", "^3") // Team Color
	
if (id) players[0] = id; else get_players(players, count, "ch")
{
	for (new i = 0; i < count; i++)
	{
		if (is_user_connected(players[i]))
		{
			message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, players[i])
			write_byte(players[i]);
			write_string(msg);
			message_end();
		}
	}
}
}

stock CREATE_SPRITETRAIL(const Float:fOrigin[3], pSprite, iCount, iLife, iScale, iVelocityAlongVector, iRandomVelocity) {
message_begin(MSG_BROADCAST, SVC_TEMPENTITY);
write_byte(TE_SPRITETRAIL);
engfunc(EngFunc_WriteCoord, fOrigin[0]);
engfunc(EngFunc_WriteCoord, fOrigin[1]);
engfunc(EngFunc_WriteCoord, fOrigin[2]);
engfunc(EngFunc_WriteCoord, fOrigin[0]);
engfunc(EngFunc_WriteCoord, fOrigin[1]);
engfunc(EngFunc_WriteCoord, fOrigin[2]);
write_short(pSprite);
write_byte(iCount);
write_byte(iLife); // 0.1's
write_byte(iScale);
write_byte(iVelocityAlongVector);
write_byte(iRandomVelocity);
message_end(); 
}


stock CREATE_BREAKMODEL(const Float:fOrigin[3], Float:fSize[3] = {16.0, 16.0, 16.0}, Float:fVelocity[3] = {25.0, 25.0, 25.0}, iRandomVelocity, pModel, iCount, iLife, iFlags) {
message_begin(MSG_BROADCAST, SVC_TEMPENTITY);
write_byte(TE_BREAKMODEL);
engfunc(EngFunc_WriteCoord, fOrigin[0]);
engfunc(EngFunc_WriteCoord, fOrigin[1]);
engfunc(EngFunc_WriteCoord, fOrigin[2] + 24);
engfunc(EngFunc_WriteCoord, fSize[0]);
engfunc(EngFunc_WriteCoord, fSize[1]);
engfunc(EngFunc_WriteCoord, fSize[2]);
engfunc(EngFunc_WriteCoord, fVelocity[0]);
engfunc(EngFunc_WriteCoord, fVelocity[1]);
engfunc(EngFunc_WriteCoord, fVelocity[2]);
write_byte(iRandomVelocity);
write_short(pModel);
write_byte(iCount); // 0.1's
write_byte(iLife); // 0.1's
write_byte(iFlags);
message_end();
}

stock fm_set_user_rendering(id, iRenderFx, Float:flRed, Float:flGreen, Float:flBlue, iRenderMode,  Float:flRenderAmt)
{
new Float:fRenderColor[3];
fRenderColor[0] = flRed;
fRenderColor[1] = flGreen;
fRenderColor[2] = flBlue;
set_pev(id, pev_renderfx, iRenderFx);
set_pev(id, pev_rendercolor, fRenderColor);
set_pev(id, pev_rendermode, iRenderMode);
set_pev(id, pev_renderamt, flRenderAmt);
}

stock fm_give_item(id, const szItem[])
{
new iEntity = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, szItem));
if(!pev_valid(iEntity)) return 0;
new Float:fOrigin[3];
pev(id, pev_origin, fOrigin);
set_pev(iEntity, pev_origin, fOrigin);
set_pev(iEntity, pev_spawnflags, pev(iEntity, pev_spawnflags) | SF_NORESPAWN);
dllfunc(DLLFunc_Spawn, iEntity);
new iSolid = pev(iEntity, pev_solid);
dllfunc(DLLFunc_Touch, iEntity, id);
if(pev(iEntity, pev_solid) == iSolid)
{
	engfunc(EngFunc_RemoveEntity, iEntity);
	return -1;
}
return iEntity;
}

stock fm_strip_user_weapons(id, iType = 0)
{
new iEntity;
static iszWeaponStrip = 0;
if(iszWeaponStrip || (iszWeaponStrip = engfunc(EngFunc_AllocString, "player_weaponstrip"))) iEntity = engfunc(EngFunc_CreateNamedEntity, iszWeaponStrip);
if(!pev_valid(iEntity)) return 0;
if(iType && get_user_weapon(id) != CSW_KNIFE)
{
	engclient_cmd(id, "weapon_knife");
	message_begin(MSG_ONE_UNRELIABLE, MsgId_CurWeapon, _, id);
	write_byte(1);
	write_byte(CSW_KNIFE);
	write_byte(0);
	message_end();
}
dllfunc(DLLFunc_Spawn, iEntity);
dllfunc(DLLFunc_Use, iEntity, id);
engfunc(EngFunc_RemoveEntity, iEntity);

return 1;
}

stock fm_set_user_bpammo(id, iWeapon, iAmount)
{
	new iOffset;
	switch(iWeapon)
	{
		case CSW_AWP: iOffset = 377; // ammo_338magnum
		case CSW_SCOUT, CSW_AK47, CSW_G3SG1: iOffset = 378; // ammo_762nato
		case CSW_M249: iOffset = 379; // ammo_556natobox
		case CSW_FAMAS, CSW_M4A1, CSW_AUG, CSW_SG550, CSW_GALI, CSW_SG552: iOffset = 380; // ammo_556nato
		case CSW_M3, CSW_XM1014: iOffset = 381; // ammo_buckshot
		case CSW_USP, CSW_UMP45, CSW_MAC10: iOffset = 382; // ammo_45acp
		case CSW_FIVESEVEN, CSW_P90: iOffset = 383; // ammo_57mm
		case CSW_DEAGLE: iOffset = 384; // ammo_50ae
		case CSW_P228: iOffset = 385; // ammo_357sig
		case CSW_GLOCK18, CSW_MP5NAVY, CSW_TMP, CSW_ELITE: iOffset = 386; // ammo_9mm
		case CSW_FLASHBANG: iOffset = 387;
		case CSW_HEGRENADE: iOffset = 388;
		case CSW_SMOKEGRENADE: iOffset = 389;
		case CSW_C4: iOffset = 390;
		default: return;
	}
	set_pdata_int(id, iOffset, iAmount);
}

stock CREATE_WORLDDECAL(Float:vecOrigin[3], pDecal) {
message_begin(MSG_BROADCAST, SVC_TEMPENTITY);
write_byte(TE_WORLDDECAL);
engfunc(EngFunc_WriteCoord, vecOrigin[0]);
engfunc(EngFunc_WriteCoord, vecOrigin[1]);
engfunc(EngFunc_WriteCoord, vecOrigin[2]);
write_byte(pDecal);
message_end();
}

public KillerTimerCountDown( ) {
if( g_RoundEndTimer <= 0 ) {
	for(new iPlayer = 1; iPlayer <= get_maxplayers(); iPlayer ++ )
		user_kill( iPlayer );
		} else {
		g_RoundEndTimer --;
		set_task(1.0, "KillerTimerCountDown", TASK_KILLER_TIMER);
	}
}
stock CREATE_KILLPLAYERATTACHMENTS(pPlayer)
{
	message_begin(MSG_ALL, SVC_TEMPENTITY);
	write_byte(TE_KILLPLAYERATTACHMENTS);
	write_byte(pPlayer);
	message_end();
}
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1033\\ f0\\ fs16 \n\\ par }
*/
