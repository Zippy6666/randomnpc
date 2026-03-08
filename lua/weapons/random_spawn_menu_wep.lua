AddCSLuaFile()

SWEP.Base = "weapon_base"
SWEP.PrintName = "Random Weapon"
SWEP.Spawnable = true
SWEP.Category = "Random Weapon"
SWEP.IconOverride = "entities/zippyrandom.png"

if !SERVER then return end

function SWEP:OwnerChanged()
    local own = self:GetOwner()
    if !IsValid(own) then return end

    -- Give the random weapon
    local _, randomWeaponName = table.Random(RandomSpawnMenu.AddonSpawnList_WEP)
    local wep = own:Give(randomWeaponName)
    
    own:PrintMessage(HUD_PRINTCENTER, "You got "..randomWeaponName.."!")
    self:Remove()

    if IsValid(wep) then
        wep.FromRandomSpawnMenu = true
        own:CONV_CallNextTick("SelectWeapon", randomWeaponName)
    end
end