if CLIENT then return end
/*
* Function to update the state of a variable client side.
* @Player ply The player to update the state.
* @string var String of the variable to update.
* @bool state Bool to set to the variable.
*/
function scramble.UpdateBoolClient(ply, var, state)
    if (!IsValid(ply) or type(var) != "string") then return end
    ply[var] = state
    net.Start(SCRAMBLE_CONFIG.UpdateBoolClient)
        net.WriteString(var)
        net.WriteBool( state )
    net.Send(ply)
end

/*
* Function to update the state of a table client side of all players of the server.
* @Player ply The player to update the state.
* @string var String of the variable to update.
* @bool state Bool to set to the variable.
*/
function scramble.SetTableClient(ply, var, state)
    if (!IsValid(ply) or type(var) != "string") then return end
    if (SCRAMBLE_CONFIG[var][ply:EntIndex()] and state) then return end
    if (state) then
        SCRAMBLE_CONFIG[var][ply:EntIndex()] = ply:EntIndex()
    else
        SCRAMBLE_CONFIG[var][ply:EntIndex()] = nil
    end
    net.Start(SCRAMBLE_CONFIG.SetTableClient)
        net.WriteString( var )
        net.WriteBool( state )
        net.WriteEntity( ply )
    net.Broadcast()
end

/*
* Function to synchronize the state of a table client side for a specific player.
* @Player ply The player to update the state.
* @string var String of the variable to update.
* @table tableToGet the table server side to update client side.
*/
function scramble.GetTableClient(ply, var, tableToGet)
    if (!IsValid(ply) or type(var) != "string" or type(tableToGet) != "table") then return end
    for key, value in ipairs(tableToGet) do
        net.Start(SCRAMBLE_CONFIG.SetTableClient)
            net.WriteString(var)
            net.WriteBool( true )
            net.WriteUInt( value, 11 )
        net.Send(ply)
    end
end

-- Impossible to pass net messages on the client side with the other events, so I end up doing this, no judgment please.
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn.LoadTableScramble", function(ply)
    scramble.GetTableClient(ply, "PlayersWearingScramble", SCRAMBLE_CONFIG.PlayersWearingScramble)
    scramble.GetTableClient(ply, "PlayersStateScramble", AEGIS_CONFIG.PlayersStateScramble) 
end)