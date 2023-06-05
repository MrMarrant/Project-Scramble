if CLIENT then return end

/*
* Function used for make a fade effect on screen.
* @Player ply The player to update the state.
*/
function scramble.ScreenFadeNVG(ply)
    if (!IsValid(ply)) then return end
    net.Start(SCRAMBLE_CONFIG.ScreenFadeNVG)
        net.WriteBool( ply.scramble_NVGEnable )
    net.Send(ply)
end
