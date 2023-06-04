AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/aegis_scramble/aegis_scanner.mdl" ) -- TODO : Changer le nom du modèle/matériel
	self:SetModelScale( 1 )
	self:PhysicsInit( SOLID_VPHYSICS ) 
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid( SOLID_VPHYSICS ) 
	self:SetUseType(SIMPLE_USE)
	self:PhysWake()
end

function ENT:Use(ply)
	if (!ply.scramble_Wear) then
		aegis.UpdateBoolClient(ply, "scramble_Wear", true)
		aegis.SetTableClient(ply, "PlayersWearingScramble", true)
		ply:EmitSound("scramble/equip.mp3")
		self:Remove()
	else
		-- TODO : Gérer les traductions.
		--ply:ChatPrint(toucanlib.TranslateLanguage(LANGUAGE_AEGIS, "NotAllowedToTakeCure"))
	end
end

function ENT:PhysicsCollide(data, phys)
	if data.DeltaTime > 0.2 then
		if data.Speed > 250 then
			self:EmitSound("physics/metal/metal_grenade_impact_hard" .. math.random(1, 3) .. ".wav", 75, math.random(90,110), 0.5)
		else
			self:EmitSound("physics/metal/metal_grenade_impact_soft" .. math.random(1, 3) .. ".wav", 75, math.random(90,110), 0.2)
		end
	end
end