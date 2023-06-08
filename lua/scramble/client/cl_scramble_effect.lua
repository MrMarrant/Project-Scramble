if SERVER then return end

-- TODO : Trouver un moyen de cacher le visage de SCP 096.
-- TODO : Essayer avec submaterial et en récupérant l'id du bone de la tête.

-- game.AddParticles( "particles/blood_impact.pcf" )
-- PrecacheParticleSystem( "BloodImpact" )

-- local effectdata = EffectData()
-- local offsetvec = Vector( 3, -10, 0 )
-- local offsetang = Angle( 0, 0, 0 )

-- hook.Add( "Think" , "PostPlayerDraw.Censor_Scramble" , function(  )
--     local ply = LocalPlayer()
--     local boneid = ply:LookupBone( "ValveBiped.Bip01_Head1" )
--     local matrix = ply:GetBoneMatrix( boneid )
--     local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )
--     effectdata:SetOrigin( newpos )
--     util.Effect( "BloodImpact", effectdata )
-- end)
