if SERVER then return end
-- Key Bind used for players to manage the scramble.
local bindkey_state_scramble = CreateClientConVar("bindkey_state_scramble", "L", true, false, scramble.TranslateLanguage(SCRAMBLE_LANG, "DescriptionBindKeyState"))
local bindkey_nvg_scramble = CreateClientConVar("bindkey_nvg_scramble", "O", true, false, scramble.TranslateLanguage(SCRAMBLE_LANG, "DescriptionBindKeyNVG"))
local bindkey_drop_scramble = CreateClientConVar("bindkey_drop_scramble", "J", true, false, scramble.TranslateLanguage(SCRAMBLE_LANG, "DescriptionBindKeyDrop"))

-- Cooldown for avoid players to spam key bind.
local NextActionKey = CurTime()

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

net.Receive(SCRAMBLE_CONFIG.SoundToPlayClientSide, function ( )
    local pathSound = net.ReadString()
    local isLoop = net.ReadBool()
    local ply = LocalPlayer()
    if (isLoop) then
        ply:StartLoopingSound(pathSound)
    else
        ply:EmitSound(pathSound)
    end
end)

hook.Add( "OnScreenSizeChanged", "OnScreenSizeChanged.Scramble_ScreenSizeChanged", function( oldWidth, oldHeight )
    SCRAMBLE_CONFIG.ScrW = ScrW()
    SCRAMBLE_CONFIG.ScrH = ScrH()
end )

-- For manage action player clientside if they try to call action on scramble.
hook.Add( "PlayerButtonDown", "PlayerButtonDown.ScrambleBindKey", function( ply, button )
	if SERVER then return end
    local KeyState = GetConVar( "bindkey_state_scramble" ):GetString()
    local KeyNVG = GetConVar( "bindkey_nvg_scramble" ):GetString()
    local KeyDrop = GetConVar( "bindkey_drop_scramble" ):GetString()
    local Keyname = string.upper( input.GetKeyName( button ) )
    local CurrentTime = CurTime()

    if (NextActionKey < CurrentTime) then
        NextActionKey = CurrentTime + 1 --? 1s cooldown between each key action.
        if ( Keyname == KeyState ) then
            net.Start(SCRAMBLE_CONFIG.CTSUpdateState)
            net.SendToServer()
        elseif ( Keyname == KeyNVG ) then
            net.Start(SCRAMBLE_CONFIG.CTSUpdateNVG)
            net.SendToServer()
        elseif ( Keyname == KeyDrop ) then
            net.Start(SCRAMBLE_CONFIG.CTSUpdateDrop)
            net.SendToServer()
        end
    end
end)