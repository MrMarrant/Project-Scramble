if CLIENT then return end

-- Hook from Guth swep to be detected by SCP 096
hook.Add( "vkxscp096:should_trigger", "Scramble_Detect_SCP096", function(target, ply)
    if (target:GetNWInt("nvg", 0) == 7 and target:GetNWBool("nvg_on", false)) then
        if (!scramble.IsDetectedBySCP096()) then
            return false
        end
    end
end)

-- Hook for update the state of the artic NVG
hook.Add( "PlayerDeath", "PlayerDeath.Scramble_Artic_Update", function( victim, inflictor, attacker )
    scramble.SetParamArtic(victim, 0, false)
end )

hook.Add( "PlayerChangedTeam", "PlayerChangedTeam.Scramble_Artic_Update", function( ply )
    scramble.SetParamArtic(ply, 0, false)
end )