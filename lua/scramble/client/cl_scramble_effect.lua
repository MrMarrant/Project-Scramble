if SERVER then return end

-- When receive, do a fade effect when removing nvg
net.Receive(SCRAMBLE_CONFIG.ScreenFadeNVG, function ( )
    local ply = LocalPlayer()
    local state = net.ReadBool()
    if (state) then
        ply:ScreenFade(1, Color(255, 255, 255), 0.5, 0.2)
    else
        ply:ScreenFade(1, Color(0, 0, 0), 0.5, 0.2)
    end
end)

local modelScramble = ClientsideModel( "models/scramble/scramble.mdl" )
modelScramble:SetNoDraw( true )

-- Hook to manage the model infected scanner generate clientside on playermodel.
hook.Add( "PostPlayerDraw" , "PostPlayerDraw.Scramble_Wear" , function( ply )
    if (SCRAMBLE_CONFIG.PlayersWearingScramble[ply:EntIndex()]) then
        local x = SCRAMBLE_CONFIG.PlayersStateScramble[ply:EntIndex()] and 0 or 3
        local offsetvec = Vector( x, -5.6, 0 )
        local offsetang = Angle( 0, 90, 90 )
        local boneid = ply:LookupBone( "ValveBiped.Bip01_Head1" )
        
        if not boneid then
            return
        end
        
        local matrix = ply:GetBoneMatrix( boneid )
        
        if not matrix then 
            return 
        end
        
        local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )
        
        modelScramble:SetPos( newpos )
        modelScramble:SetAngles( newang )
        modelScramble:SetupBones()
        modelScramble:DrawModel()
    end
end)


hook.Add("PostDrawHUD", "PostDrawHUD.Scramble_NVGMaterial", function()
    local ply = LocalPlayer()
    if (ply.scramble_NVGEnable and ply.scramble_State) then
        DrawMaterialOverlay("scramble/nvg/nvg_filter.png", 0)
    end
end )

-- TODO : Faire l'effet de vision si possible proche comme dans le film SCP.
-- TODO :  Effet Vsison nocturne
-- TODO : Trouver un moyen de cacher le visage de SCP 096.