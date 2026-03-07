AddCSLuaFile()

SWEP.Base = "weapon_base"
SWEP.PrintName = "Random Weapon"
SWEP.Spawnable = true
SWEP.Category = "Random Weapon"
SWEP.IconOverride = "entities/zippyrandom.png"

if !SERVER then return end

-- If the player selects a random weapon again, remove the old random weapon
hook.Add("PlayerSwitchWeapon", "RandomSpawnMenu_RemoveOldRandomizedWep", function( ply, oldWep, newWep )
    if newWep:GetClass() == "random_spawn_menu_wep" && oldWep.FromRandomSpawnMenu then
        print(oldWep, "removing")
        oldWep:Remove()
    end
end)

function SWEP:OwnerChanged()
    local own = self:GetOwner()
    if !IsValid(own) then return end

    local _, randomWeaponName = table.Random(RandomSpawnMenu.AddonSpawnList_WEP)

    self:Remove()

    local wep = own:Give(randomWeaponName)
    wep.FromRandomSpawnMenu = true
    own:CONV_CallNextTick("SelectWeapon", randomWeaponName)
end