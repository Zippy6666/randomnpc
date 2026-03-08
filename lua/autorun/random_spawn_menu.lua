-- [[=========================== CONV MESSAGE START ===========================]]--
MissingConvMsg2 = CLIENT && function()

    Derma_Query(
        "This server does not have Zippy's Library installed, addons will function incorrectly!",

        "ZIPPY'S LIBRARY MISSING!",
        
        "Get Zippy's Library",

        function()
            gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=3146473253")
        end,

        "Close"
    )

end || nil

hook.Add("PlayerInitialSpawn", "MissingConvMsg2", function( ply )

    if file.Exists("autorun/conv.lua", "LUA") then return end

    local sendstr = 'MissingConvMsg2()'
    ply:SendLua(sendstr)

end)
-- [[============================ CONV MESSAGE END ============================]]--

RandomSpawnMenu = RandomSpawnMenu || {}

list.Set("ContentCategoryIcons", "Random NPC", "entities/zippyrandom.png")
list.Set("ContentCategoryIcons", "Random Weapon", "entities/zippyrandom.png")
list.Set("ContentCategoryIcons", "Random Vehicle", "entities/zippyrandom.png")
list.Set("ContentCategoryIcons", "Random Entity", "entities/zippyrandom.png")

list.Set("NPC", "random_spawn_menu_npc", {
    Name = "Random NPC",
    Category = "Random NPC",
    Class = "random_spawn_menu_npc",
    IconOverride = "entities/zippyrandom.png"
})

list.Set("Vehicles", "random_spawn_menu_veh", {
    Name = "Random Vehicle",
    Category = "Random Vehicle",
    Class = "random_spawn_menu_npc",
    IconOverride = "entities/zippyrandom.png"
})

-- Create spawn menu lists that contain only non-vanilla stuff after map start
hook.Add("InitPostEntity", "RandomSpawnMenu_CreateAddonOnlyLists", function()
    -- NPC LIST
    RandomSpawnMenu.AddonSpawnList_NPC = list.Get("NPC")
    RandomSpawnMenu.AddonSpawnList_NPC["random_spawn_menu_npc"] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_turret_ceiling'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_dog'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_alien_grunt'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_metropolice'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_turret_floor'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_turret_floor_resistance'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_fastzombie'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_sentry'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_headcrab_black'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_alien_slave'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['VortigauntUriah'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_antlion_grub'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_barnacle'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_hunter'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_headcrab'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_combine_s'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_alien_controller'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['Medic'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['CombineElite'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_bigmomma'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_vortigaunt'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_pigeon'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_antlion_worker'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_citizen_rebel_enemy'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_turret'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_headcrab'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_gargantua'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_gman'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_antlion'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_clawscanner'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['nb_example'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_tentacle'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['ShotgunSoldier'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['CombinePrison'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_human_grunt'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_bullchicken'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_snark'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_breen'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_fastzombie_torso'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_barney'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_human_assassin'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['VortigauntSlave'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_scientist'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['PrisonShotgunner'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_monk'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['Rebel'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_seagull'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_zombie'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_combinegunship'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_citizen'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_eli'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_alyx'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_strider'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_kleiner'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_cscanner'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_combine_camera'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_antlionguardian'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_stalker'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_helicopter'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_crow'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_babycrab'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_mossman'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_headcrab_fast'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_combinedropship'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_zombine'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_cockroach'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_manhack'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_magnusson'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['Refugee'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_fisherman'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_poisonzombie'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_antlionguard'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_rollermine_friendly'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_barney'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_nihilanth'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_miniturret'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_odessa'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_rollermine_hacked'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_rollermine'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['npc_zombie_torso'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_zombie'] = nil
    RandomSpawnMenu.AddonSpawnList_NPC['monster_houndeye'] = nil

    -- WEAPON LIST
    RandomSpawnMenu.AddonSpawnList_WEP = {}
    for k, v in pairs(list.Get("Weapon")) do
        -- Add only spawnable weapons
        if v.Spawnable then
            RandomSpawnMenu.AddonSpawnList_WEP[k] = v
        end
    end
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_handgrenade'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_rpg'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_crowbar'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_357_hl1'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_shotgun_hl1'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_smg1'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_egon'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_slam'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_357'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_crossbow'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_glock_hl1'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_base'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['gmod_camera'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_pistol'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_frag'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_stunstick'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_crossbow_hl1'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['gmod_tool'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_satchel'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_tripmine'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_fists'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_mp5_hl1'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_hornetgun'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_elitepolice_mp5k'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_snark'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_medkit'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['manhack_welder'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_shotgun'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_flechettegun'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_physcannon'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_ar2'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_crowbar_hl1'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_physgun'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['random_spawn_menu_wep'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_bugbait'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_gauss'] = nil
    RandomSpawnMenu.AddonSpawnList_WEP['weapon_rpg_hl1'] = nil

end)

-- for k, v in pairs(list.Get("Weapon")) do
--     MsgN("RandomSpawnMenu.AddonSpawnList_WEP['", k, "'] = nil")
-- end

PrintTable(RandomSpawnMenu.AddonSpawnList_WEP)