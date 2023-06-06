if CLIENT then return end
/*
* Function used for drop the infected scanner if it is wear by a player.
* @Player ply The player who will emit the sound.
* @bool isCommand if it's used with a command line.
*/
function scramble.DropScramble(ply, isCommand)
    if (!IsValid(ply)) then return end

    if (!ply.scramble_Wear or !isCommand) then return end
    if (ply.scramble_State) then
        ply:StopSound( "scramble/activate.mp3" )
        ply:StopSound( "scramble/onprocess.wav" )
        ply:EmitSound("scramble/desactivate.mp3")
        if (ply.scramble_NVGEnable and ply:Alive()) then scramble.ScreenFadeNVG(ply, false) end
    end

    scramble.UpdateBoolClient(ply, "scramble_Wear", false)
    scramble.UpdateBoolClient(ply, "scramble_State", false)
    scramble.UpdateBoolClient(ply, "scramble_NVGEnable", false)
    scramble.SetTableClient(ply, "PlayersWearingScramble", false)
    scramble.SetTableClient(ply, "PlayersStateScramble", false)

    local ent = ents.Create( "project_scramble" )
    ent:SetPos( ply:GetShootPos() + ply:GetAimVector() * 20 )
    ent:SetAngles( ply:EyeAngles() + Angle(0, 48, 0))
    ent:Spawn()
    ent:Activate()
end

/*
* Function used for update the state of the scramble.
* @Player ply The player to update the state.
*/
function scramble.UpdateStateScramble(ply)
    if (!IsValid(ply)) then return end
    if (!ply.scramble_Wear) then return end
    ply:EmitSound("scramble/onclick.mp3")

    if (ply.scramble_State) then
        ply:StopSound( "scramble/activate.mp3" )
        ply:StopSound( "scramble/onprocess.wav" )
        ply:EmitSound("scramble/desactivate.mp3")
        scramble.SetTableClient(ply, "PlayersStateScramble", false)
        if (ply.scramble_NVGEnable) then 
            scramble.ScreenFadeNVG(ply, false)
        end
    else
        ply:StopSound( "scramble/desactivate.mp3" )
        ply:EmitSound("scramble/activate.mp3")
        scralbke.SoundToPlayClientSide(ply, "scramble/onprocess.wav", true)
        scramble.SetTableClient(ply, "PlayersStateScramble", true)
        if (ply.scramble_NVGEnable) then 
            scramble.ScreenFadeNVG(ply, true)
        end
    end
    scramble.UpdateBoolClient(ply, "scramble_State", !ply.scramble_State)
end

/*
* Function used for update the state of the nvg effect.
* @Player ply The player to update the state.
*/
function scramble.EnableNVG(ply)
    if (!IsValid(ply)) then return end
    if (!ply.scramble_Wear or !ply.scramble_State) then return end
    ply:EmitSound("scramble/onclick.mp3") -- TODO : Faire un son distinct pour le click des NVG ?
    scramble.ScreenFadeNVG(ply, ply.scramble_NVGEnable)
    scramble.UpdateBoolClient(ply, "scramble_NVGEnable", !ply.scramble_NVGEnable)
end

-- Action from clientside that call server side to check if the player can use the action.
net.Receive(SCRAMBLE_CONFIG.CTSUpdateState, function (len, ply )
    if ( !IsValid( ply ) ) then return end
    scramble.UpdateStateScramble(ply)
end)

net.Receive(SCRAMBLE_CONFIG.CTSUpdateNVG, function (len, ply )
    if ( !IsValid( ply ) ) then return end
    scramble.EnableNVG(ply)
end)

net.Receive(SCRAMBLE_CONFIG.CTSUpdateDrop, function (len, ply )
    if ( !IsValid( ply ) ) then return end
    scramble.DropScramble(ply, true)
end)