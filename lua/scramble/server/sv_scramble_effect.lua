if CLIENT then return end

/*
* Function that update the state server/client side of the artic NVG
* @Player ply The ent to apply the censor effect
* @number typeNVG Indicate wich type is the NVG.
* @bool isEnabled Indictate if the NVG are Enabled or not.
*/
function scramble.SetParamArtic(ply, typeNVG, isEnabled)
    ply:SetNWInt("nvg", typeNVG)
    ply:SetNWBool("nvg_on", isEnabled)
    net.Start(SCRAMBLE_CONFIG.ScrambleUpdateParamArctic, true)
        net.WriteBool(isEnabled)
        net.WriteUInt( typeNVG, 5 )
    net.Send(ply)
end

/*
* Function used for drop NVG drom a player.
* @Player ply The player who wants to drop the NVG.
*/
function scramble.DropScramble(ply)
    local NVGId = ply:GetNWInt("nvg", 0)

    if (NVGId == 0 or !NVGId) then return end

    local DataNVG = ArcticNVGs[NVGId] or {}
    local TypeNVG = DataNVG.Entity

    if TypeNVG then
        local NVG = ents.Create(TypeNVG)
        NVG:SetPos(ply:EyePos())
        NVG:SetAngles(ply:EyeAngles())
        NVG:SetOwner(ply)
        NVG:Spawn()
        if (ply:GetNWBool("nvg_on", false)) then
            ply:EmitSound(DataNVG.UnequipSound or "arctic_nvgs/nvg_off_1.wav")
        end
        scramble.SetParamArtic(ply, 0, false)
    end
end

-- Net Message used when a player ask for drop NVG.
net.Receive(SCRAMBLE_CONFIG.CTSUpdateDrop, function (len, ply )
    if ( !IsValid( ply ) ) then return end
    scramble.DropScramble(ply)
end)