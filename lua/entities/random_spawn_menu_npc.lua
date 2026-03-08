AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Random Spawn Menu NPC"
ENT.Author = "Zippy"

if CLIENT then
    language.Add("random_spawn_menu_npc", ENT.PrintName)
end

if !SERVER then return end

function ENT:Initialize()
    self:SetMaterial("models/wireframe")
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    self:DrawShadow(false)
    
    local randomNPC, key = table.Random(RandomSpawnMenu.AddonSpawnList_NPC)
    self.SpawnMenuClassToSpawn = key

    local lifetime = 3

    -- SafeRemoveEntityDelayed(self, lifetime)

    conv.getEntInfo( randomNPC.Class, function(npc)
        if !IsValid(self) then return end
        if !IsValid(npc) then return end

        self:SetModel(npc:GetModel())
        self:PhysicsInitStatic(SOLID_OBB)
        self:SetPos(self:GetPos() + self:GetUp()*math.abs(self:OBBMins().z))

        -- Apply generic model if npcs model is redundant
        self:CONV_CallNextTick(function() 
            if !IsValid(self:GetPhysicsObject()) then
                self:SetModel("models/props_junk/wood_crate001a.mdl")
            end
        end)

        local pos, nrm = self:GetPos(), self:GetUp()
        pos = pos + Vector(0, 0, self:OBBMaxs().z)

        conv.display3DText( "RandomSpawnMenuNPC"..self:EntIndex(), 
                pos + nrm*50, lifetime, randomNPC.Name, color_white, 0.75 )
        conv.display3DText( "RandomSpawnMenuNPC_Class"..self:EntIndex(), 
                pos + nrm*30, lifetime, randomNPC.Class, color_white, 0.5 )
    end)

    self:CONV_TimerSimple(3, function()
        local own = self:GetCreator()
        self:TakeDamage(1, conv.thisEntOrWorld( own ), conv.thisEntOrWorld( own ))
    end)
end

function ENT:OnTakeDamage(dmginfo)
    if dmginfo:GetAttacker() == self:GetCreator() then
        local npc = conv.createSpawnMenuNPC( self.SpawnMenuClassToSpawn, self:GetPos() )
        if IsValid(npc) then
            npc:SetAngles(self:GetAngles())
            npc:SetCreator(self:GetCreator())
            undo.ReplaceEntity(self, npc)
            cleanup.ReplaceEntity(self, npc)
        end
        
        self:Remove()
    end
end

function ENT:OnRemove()
    conv.remove3DText("RandomSpawnMenuNPC"..self:EntIndex())
    conv.remove3DText("RandomSpawnMenuNPC_Class"..self:EntIndex())
end
