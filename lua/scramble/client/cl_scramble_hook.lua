if SERVER then return end

local NextActionKey = CurTime()

-- For manage action player clientside if they try to call action on scramble.
hook.Add( "PlayerButtonDown", "PlayerButtonDown.Scramble_BindKey", function( ply, button )
    local KeyDrop = GetConVar( "bindkey_drop_scramble" ):GetString()
    local Keyname = string.upper( input.GetKeyName( button ) )
    local CurrentTime = CurTime()

    if (NextActionKey < CurrentTime) then
        NextActionKey = CurrentTime + 1 --? 1s cooldown between each key action.
        if ( Keyname == KeyDrop ) then
            net.Start(SCRAMBLE_CONFIG.CTSUpdateDrop)
            net.SendToServer()
        end
    end
end)