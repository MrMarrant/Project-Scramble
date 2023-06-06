if CLIENT then return end

/*
* Function used for make a fade effect on screen.
* @Player ply The player to update the state.
* @bool fade To manage wich fade to do on screen.
*/
function scramble.ScreenFadeNVG(ply, fade)
    if (!IsValid(ply)) then return end
    net.Start(SCRAMBLE_CONFIG.ScreenFadeNVG)
        net.WriteBool( fade )
    net.Send(ply)
end
