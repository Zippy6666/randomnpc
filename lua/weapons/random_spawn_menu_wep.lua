AddCSLuaFile()

SWEP.Base = "weapon_base"
SWEP.PrintName = "Random Weapon"
SWEP.Spawnable = true
SWEP.Category = "Random Weapon"
SWEP.IconOverride = "entities/zippyrandom.png"

if !SERVER then return end

SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 0
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0

function SWEP:Initialize()
    local weptbl, key = table.Random(RandomSpawnMenu.AddonSpawnList_WEP)
    self.RandomWeaponClass = key
    self.RandomWeaponName = weptbl.PrintName

    local pos, nrm = self:GetPos(), self:GetUp()
    conv.display3DText( "RandomSpawnMenuent"..self:EntIndex(), 
            pos + nrm*80, 3, self.RandomWeaponName, color_white, 0.75 )
    conv.display3DText( "RandomSpawnMenuent_Class"..self:EntIndex(), 
            pos + nrm*50, 3, self.RandomWeaponClass, color_white, 0.5 )
end

function SWEP:OwnerChanged()
    local own = self:GetOwner()
    if !IsValid(own) then return end

    if !self.RandomWeaponClass then
        own:PrintMessage(HUD_PRINTCENTER, "No addon weapons available :(")
        self:Remove()
        return 
    end

    local wep = own:Give(self.RandomWeaponClass)
    -- own:GiveAmmo(100, wep:GetPrimaryAmmoType())
    -- own:GiveAmmo(100, wep:GetSecondaryAmmoType())
    
    own:PrintMessage(HUD_PRINTCENTER, "You got "..self.RandomWeaponClass.."!")
    self:Remove()

    if IsValid(wep) then
        wep.FromRandomSpawnMenu = true
        own:CONV_CallNextTick("SelectWeapon", self.RandomWeaponClass)
    end
end

function SWEP:OnRemove()
    conv.remove3DText("RandomSpawnMenuent"..self:EntIndex())
    conv.remove3DText("RandomSpawnMenuent_Class"..self:EntIndex())
end