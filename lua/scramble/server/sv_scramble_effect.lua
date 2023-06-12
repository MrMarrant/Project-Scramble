if CLIENT then return end

function scramble.SetParamArtic(ply, typeNVG, isEnabled)
    ply:SetNWInt("nvg", typeNVG)
    ply:SetNWBool("nvg_on", isEnabled)
    net.Start(SCRAMBLE_CONFIG.ScrambleUpdateParamArctic, true)
        net.WriteBool(isEnabled)
        net.WriteUInt( typeNVG, 5 )
    net.Send(ply)
end

-- Hook for some swep to be detected by SCP 096
hook.Add( "vkxscp096:should_trigger", "Scramble_Detect_SCP096", function(target, ply) 
    if (ply:GetNWInt("nvg", 0) == 7 and ply:GetNWBool("nvg_on", false)) then
        if (!scramble.IsDetectedBySCP096()) then
            return false
        end
    end
end)

hook.Add( "PlayerDeath", "PlayerDeath_Scramble_Artic", function( victim, inflictor, attacker )
    scramble.SetParamArtic(victim, 0, false)
end )