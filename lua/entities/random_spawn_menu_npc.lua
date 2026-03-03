AddCSLuaFile()

list.Set("NPC", "random_spawn_menu_npc", {
    Name = "Random NPC",
    Category = "Random NPC",
    Class = "random_spawn_menu_npc",
    IconOverride = "entities/zippyrandom.png"
})

list.Set("SpawnableEntities", "random_spawn_menu_ent", {
    Name = "Random Entity",
    Category = "Random Entity",
    Class = "random_spawn_menu_npc",
    IconOverride = "entities/zippyrandom.png"
})

list.Set("Vehicles", "random_spawn_menu_veh", {
    Name = "Random Vehicle",
    Category = "Random Vehicle",
    Class = "random_spawn_menu_npc",
    IconOverride = "entities/zippyrandom.png"
})

list.Set("Weapon", "random_spawn_menu_wep", {
    Name = "Random Weapon",
    Category = "Random Weapon",
    Class = "random_spawn_menu_npc",
    IconOverride = "entities/zippyrandom.png"
})

list.Set("ContentCategoryIcons", "Random NPC", "entities/zippyrandom.png")
list.Set("ContentCategoryIcons", "Random Weapon", "entities/zippyrandom.png")
list.Set("ContentCategoryIcons", "Random Vehicle", "entities/zippyrandom.png")
list.Set("ContentCategoryIcons", "Random Entity", "entities/zippyrandom.png")

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
    
    local npcList = list.Get("NPC")
    npcList["random_spawn_menu_npc"] = nil -- Remove the random NPC entry to avoid selecting it

    local randomNPC, key = table.Random(npcList)
    self.SpawnMenuClassToSpawn = key

    local lifetime = 3

    SafeRemoveEntityDelayed(self, lifetime)

    conv.getEntInfo( randomNPC.Class, function(npcPreview)
        if !IsValid(self) then return end
        if !IsValid(npcPreview) then return end

        self:SetModel(npcPreview:GetModel())
        self:PhysicsInitStatic(SOLID_OBB)
        self:SetPos(self:GetPos() + self:GetUp()*math.abs(self:OBBMins().z))

        local pos, nrm = self:GetPos(), self:GetUp()
        pos = pos + Vector(0, 0, self:OBBMaxs().z)

        conv.display3DText( "RandomSpawnMenuNPC"..self:EntIndex(), 
                pos + nrm*50, lifetime, randomNPC.Name, color_white, 0.75 )
        conv.display3DText( "RandomSpawnMenuNPC_Class"..self:EntIndex(), 
                pos + nrm*30, lifetime, randomNPC.Class, color_white, 0.5 )
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
