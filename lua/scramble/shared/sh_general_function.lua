/*
* Function used for drop the infected scanner if it is wear by a player.
* @Player ply The player who will emit the sound.
* @bool isCommand if it's used with a command line.
*/
function scramble.DropScramble(ply, isCommand)
    if (!IsValid(ply)) then return end

    if (ply.scramble_Wear and !ply:HasWeapon("swep_instance_scramble")) then
        if (ply.scramble_State) then
            ply:StopSound( "scramble/activate.mp3" )
            ply:StopSound( "scramble/onprocess.wav" )
            ply:EmitSound("scramble/desactivate.mp3")
        end

        scramble.UpdateBoolClient(ply, "scramble_Wear", false)
        scramble.UpdateBoolClient(ply, "scramble_State", false)
        scramble.SetTableClient(ply, "PlayersWearingScramble", false)
        scramble.SetTableClient(ply, "PlayersStateScramble", false)

        local ent = ents.Create( "infected_scanner_scramble" )
        ent:SetPos( ply:GetShootPos() + ply:GetAimVector() * 20 )
        ent:SetAngles( ply:EyeAngles() + Angle(0, 48, 0))
        ent:Spawn()
        ent:Activate()
    elseif (isCommand) then
        ply:ChatPrint(scramble.TranslateLanguage(SCRAMBLE_LANG, "NotAllowedToDropScramble"))
    end
end

/*
* Function used for update the state of the scramble.
* @Player ply The player to update the state.
*/
function scramble.UpdateStateScramble(ply)
    if (!IsValid(ply)) then return end

    ply:EmitSound("scramble/onclick.mp3")

    if (ply.scramble_State) then
        ply:StopSound( "scramble/activate.mp3" )
        ply:StopSound( "scramble/onprocess.wav" )
        ply:EmitSound("scramble/desactivate.mp3")
        scramble.SetTableClient(ply, "PlayersStateScramble", false)
    else
        ply:StopSound( "scramble/desactivate.mp3" )
        ply:EmitSound("scramble/activate.mp3")
        -- TODO : Faire la méthode coté client.
        --toucanlib.SoundToPlayClientSide(ply, "scramble/onprocess.wav", true)
        scramble.SetTableClient(ply, "PlayersStateScramble", true)
    end
    scramble.UpdateBoolClient(ply, "scramble_State", !ply.scramble_State)
end