if SERVER then return end
-- It Set a bool variable on a player that receive the net message.
net.Receive(SCRAMBLE_CONFIG.UpdateBoolClient, function ( )
    local var = net.ReadString()
    local state = net.ReadBool()
    local ply = LocalPlayer()
    ply[var] = state
end)

-- It Set the table on client side of the player who receive the net message.
net.Receive(SCRAMBLE_CONFIG.SetTableClient, function ( )
    local var = net.ReadString()
    local state = net.ReadBool()
    local ent = net.ReadEntity()
    if (state) then
        SCRAMBLE_CONFIG[var][ent:EntIndex()] = ent:EntIndex()
    else
        SCRAMBLE_CONFIG[var][ent:EntIndex()] = nil
    end
end)