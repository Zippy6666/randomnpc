AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Random Entity"
ENT.Author = "Zippy"
ENT.Category = "Random Entity"
ENT.Spawnable = true

if CLIENT then
    language.Add("random_spawn_menu_ent", ENT.PrintName)
end

if !SERVER then return end

hook.Add("PlayerSpawnedNPC", "random_spawn_menu_ent", function(ply, ent)
    if ent:GetClass() == "random_spawn_menu_ent" then
        ent.SpawnPool = RandomSpawnMenu.AddonSpawnList_NPC
        ent.SpawnType = "NPC"
    end
end)

hook.Add("PlayerSpawnedVehicle", "random_spawn_menu_ent", function(ply, ent)
    if ent:GetClass() == "random_spawn_menu_ent" then
        ent.SpawnPool = RandomSpawnMenu.AddonSpawnList_VEH
        ent.SpawnType = "Vehicle"
    end
end)

function ENT:Initialize()
    self:SetMaterial("models/wireframe")
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    self:DrawShadow(false)
    self.SpawnPool = RandomSpawnMenu.AddonSpawnList_ENT
    self.SpawnType = "ENT"
    self:CONV_CallNextTick("DecideSpawn")
end

function ENT:DecideSpawn()
    local spawnTbl, key = table.Random(self.SpawnPool)
    if !key then
        conv.callNextTick(function()
            local creator = self:GetCreator()
            if IsValid(creator) then
                creator:PrintMessage(HUD_PRINTCENTER, "No addon entities available :(")
            end
            self:Remove()
        end)
        return 
    end

    self.SpawnMenuClassToSpawn = key

    local spawnTblCls = spawnTbl.Class || spawnTbl.ClassName
    local spawnTblName = spawnTbl.Name || spawnTbl.PrintName

    -- Time until it is spawned unless prevented
    local lifetime = 3

    conv.getEntInfo( spawnTblCls, function(ent)
        if !IsValid(self) then return end
        if !IsValid(ent) then return end

        self:SetModel(ent:GetModel())
        self:PhysicsInitStatic(SOLID_OBB)
        self:SetPos(self:GetPos() + self:GetUp()*math.abs(self:OBBMins().z))

        -- Apply generic model if ents model is redundant
        self:CONV_CallNextTick(function() 
            if !IsValid(self:GetPhysicsObject()) then
                self:SetModel("models/props_junk/wood_crate001a.mdl")
            end
        end)

        local pos, nrm = self:GetPos(), self:GetUp()
        pos = pos + Vector(0, 0, self:OBBMaxs().z)

        conv.display3DText( "RandomSpawnMenuent"..self:EntIndex(), 
                pos + nrm*50, lifetime, spawnTblName, color_white, 0.75 )
        conv.display3DText( "RandomSpawnMenuent_Class"..self:EntIndex(), 
                pos + nrm*30, lifetime, spawnTblCls, color_white, 0.5 )
    end)

    -- This will trigger it to spawn
    self:CONV_TimerSimple(lifetime, function()
        self:TakeDamage(1, 
        conv.thisEntOrWorld( self:GetCreator() ), 
        conv.thisEntOrWorld( self:GetCreator() ))
    end)
end

function ENT:PerformSpawn()
    local creator = self:GetCreator()
    if !IsValid(creator) then return end

    if self.SpawnType == "NPC" then
        local npc = conv.createSpawnMenuNPC( self.SpawnMenuClassToSpawn, self:GetPos() )
        if IsValid(npc) then
            npc:SetAngles(self:GetAngles())
            npc:SetCreator(creator)
            undo.ReplaceEntity(self, npc)
            cleanup.ReplaceEntity(self, npc)
        end
    elseif self.SpawnType == "ENT" then
        local ent = ents.Create(self.SpawnMenuClassToSpawn)
        if IsValid(ent) then
            ent:SetPos(self:GetPos())
            ent:SetPos(self:GetPos())
            ent:SetAngles(self:GetAngles())
            ent:SetCreator(creator)
            ent:Spawn()
            ent:Activate()
            undo.ReplaceEntity(self, ent)
            cleanup.ReplaceEntity(self, ent)
        end
    end
end

function ENT:OnTakeDamage(dmginfo)
    if dmginfo:GetAttacker() == self:GetCreator() then
        self:PerformSpawn()
        self:Remove()
    end
end

function ENT:OnRemove()
    conv.remove3DText("RandomSpawnMenuent"..self:EntIndex())
    conv.remove3DText("RandomSpawnMenuent_Class"..self:EntIndex())
end
