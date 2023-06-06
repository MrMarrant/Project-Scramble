AddCSLuaFile()

ENT.Author = "MrMarrant"
ENT.PrintName = "Scramble"
ENT.Spawnable = true
ENT.Category = "Arctic's Night Vision"
ENT.Type = "anim"
ENT.Base = "arctic_nvg_base"

ENT.Model = "models/arctic_nvgs/nvg_gpnvg.mdl"
ENT.Gives = "nvg_scramble"

function ENT:Use(activator, ent, usetype, val)
    if !IsValid(ent) then return end
    if !ent:IsPlayer() or self.PickedUp then return end
    if ent == self:GetOwner() and self.SpawnTime > (CurTime() - 1) then return end

    ArcticNVGs_SetPlayerGoggles(ent, self.Gives)

    self:Remove()
    self.PickedUp = true
    self:EmitSound("scramble/equip.wav")
end