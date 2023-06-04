if SERVER then return end
local modelScramble = ClientsideModel( "models/aegis_scanner/aegis_scanner.mdl" )
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

-- TODO : Faire l'effet de vision si possible proche comme dans le film SCP.
-- TODO : Trouver un moyen de cacher le visage de SCP 096.