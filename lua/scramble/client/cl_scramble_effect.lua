if SERVER then return end

-- TODO : Trouver un moyen de cacher le visage de SCP 096.
-- TODO : Essayer avec submaterial et en récupérant l'id du bone de la tête.

-- game.AddParticles( "particles/blood_impact.pcf" )
-- PrecacheParticleSystem( "BloodImpact" )

-- local effectdata = EffectData()
-- local offsetvec = Vector( 3, -10, 0 )
-- local offsetang = Angle( 0, 0, 0 )


-- hook.Add( "PostPlayerDraw" , "PostPlayerDraw.Censor_Scramble" , function( ent )
--     local ply = LocalPlayer()
--     if (ent:IsPlayer() and ent != ply and ent:Alive()) then
--         if (SCRAMBLE_CONFIG.ClassEntities[team.GetName( ent:Team() )]) then
--                         -- Get the game's camera angles
--             local angle = EyeAngles()

--             -- Only use the Yaw component of the angle
--             -- angle = Angle( -90, angle.y, angle.r )
--             angle = Angle( -90, -50, 0 )
--             -- Apply some animation to the angle
--             -- angle.y = angle.y + math.sin( CurTime() ) * 10

            
--             local boneid = ent:LookupBone( "ValveBiped.Bip01_Head1" )
--             local matrix = ent:GetBoneMatrix( boneid )
--             local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )
--             newpos.x = newpos.x-11
--             newpos.y = newpos.y+15
--             newpos.z = newpos.z-5
--             -- Correct the angle so it points at the camera
--             -- This is usually done by trial and error using Up(), Right() and Forward() axes
--             angle:RotateAroundAxis( angle:Up(), -90 )
--             angle:RotateAroundAxis( angle:Forward(), 90 )

--             -- Raise the hitpos off the ground by 20 units and apply some animation
--             --newpos = newpos + Vector( 0, 0, math.cos( CurTime() / 2 ) + 20 )
--             --newpos = newpos + Vector( 0, 0, angle.r/180 )
--             -- Notice the scale is small, so text looks crispier
--             cam.Start3D2D( newpos, angle, 0.05 )
--                 -- Get the size of the text we are about to draw
--                 local text = "Testing"
--                 surface.SetFont( "Default" )
--                 local tW, tH = surface.GetTextSize( "Testing" )

--                 -- This defines amount of padding for the box around the text
--                 local pad = 200

--                 -- Draw a rectable. This has to be done before drawing the text, to prevent overlapping
--                 -- Notice how we start drawing in negative coordinates
--                 -- This is to make sure the 3d2d display rotates around our position by its center, not left corner
--                 surface.SetDrawColor( 0, 0, 0, 255 )
--                 surface.DrawRect( 0, 0, pad, pad )

--                 -- Draw some text
--                 --draw.SimpleText( "Testing", "Default", -tW / 2, 0, color_white )
--             cam.End3D2D()
--         end
--     end
-- end)


-- hook.Add( "PostPlayerDraw" , "PostPlayerDraw.Censor_Scramble" , function( ent )
--     local ply = LocalPlayer()
--     if (ent:IsPlayer() and ent != ply and ent:Alive()) then
--         if (SCRAMBLE_CONFIG.ClassEntities[team.GetName( ent:Team() )]) then
--             local boneid = ent:LookupBone( "ValveBiped.Bip01_Head1" )
--             local matrix = ent:GetBoneMatrix( boneid )
--             local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )
--             effectdata:SetOrigin( newpos )
--             util.Effect( "BloodImpact", effectdata )
--         end
--     end
-- end)


-- hook.Add( "PostPlayerDraw" , "PostPlayerDraw.Scramble_Censor" , function( ent )
--     --TODO : check s'il porte les scramble
--     local ply = LocalPlayer()
--     if (ent:IsPlayer() and ent != ply and ent:Alive()) then
--         if (SCRAMBLE_CONFIG.ClassEntities[team.GetName( ent:Team() )]) then
--             PrintTable(ent:GetMaterials())
--             ent:SetSubMaterial( 1, "" )
--         end
--     end
-- end)

local function IsInFieldOfView(ply, ent)
    local plyAngles = ply:EyeAngles()
    local viewVector = plyAngles:Forward()

    local entPos = ent:GetPos()
    local entDir = (entPos - ply:EyePos()):GetNormalized()
    
    return viewVector:Dot(entDir) >= math.cos(math.rad(75)) -- Angle de vue de 75 degrés
end

local function IsVisible(ply, ent)
    local tr = util.TraceLine({
        start = ply:EyePos(),
        endpos = ent:GetPos(),
        mask = MASK_SOLID_BRUSHONLY -- Vérifie uniquement les collisions avec les brosses solides (murs)
    })

    return not tr.Hit
end

local function GetVisibleEntities()
    local ply = LocalPlayer()

    local visibleEntities = {}
    for _, ent in pairs(ents.GetAll()) do
        if ent != ply and IsValid(ent) and ent:IsPlayer() then -- Vous pouvez modifier cette condition selon vos besoins
            if IsInFieldOfView(ply, ent) and IsVisible(ply, ent) then
                table.insert(visibleEntities, ent)
            end
        end
    end

    return visibleEntities
end

-- Exemple d'utilisation
hook.Add("Think", "Think.Scramble_CheckEntSound", function()
    local visibleEntities = GetVisibleEntities()

    if ((#visibleEntities >= 1)) then
        if (!ply.Scramble_LoopingSound) then
            ply.Scramble_LoopingSound = ply:StartLoopingSound( "scramble/detect_scp096.wav" )
        end
    elseif (ply.Scramble_LoopingSound) then
        ply:StopSound("scramble/detect_scp096.wav")
        ply.Scramble_LoopingSound = nil
    end
end)

--[[ hook.Add( "Think" , "Think.Scramble_CheckEntSound" , function( )
    local ply = LocalPlayer()
    local PlayerFounded, EntsFounded = scramble.GetPlayersInCone(ply, 1000)
    print(#PlayerFounded)
    if ((#PlayerFounded >= 1 or #EntsFounded >= 1)) then
        if (!ply.Scramble_LoopingSound) then
            ply.Scramble_LoopingSound = ply:StartLoopingSound( "scramble/detect_scp096.wav" )
        end
    elseif (ply.Scramble_LoopingSound) then
        ply:StopSound("scramble/detect_scp096.wav")
        ply.Scramble_LoopingSound = nil
    end
end) ]]

local ModelGlitch1 = ClientsideModel( "models/hunter/blocks/cube05x05x05.mdl" )
ModelGlitch1:SetMaterial("models/wireframe")
ModelGlitch1:SetModelScale(0.6)
ModelGlitch1:SetNoDraw( true )

local ModelGlitch2 = ClientsideModel( "models/hunter/blocks/cube05x05x05.mdl" )
ModelGlitch2:SetMaterial("models/rendertarget")
ModelGlitch2:SetModelScale(0.6)
ModelGlitch2:SetNoDraw( true )

hook.Add( "PostPlayerDraw" , "PostPlayerDraw.Scramble_Censor" , function( ent )
    --TODO : check s'il porte les scramble
    local ply = LocalPlayer()
    if (ent:IsPlayer() and ent != ply and ent:Alive()) then
        if (SCRAMBLE_CONFIG.ClassEntities[team.GetName( ent:Team() )]) then
            local offsetvec = Vector( 0, 1, 3 )
            local offsetang = Angle( 0, 90, 90 )
            local boneid = ent:LookupBone( "ValveBiped.Bip01_Head1" )
            
            if not boneid then
                return
            end
            
            local matrix = ent:GetBoneMatrix( boneid )
            
            if not matrix then 
                return 
            end
            
            local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )

            local RandAng = AngleRand()
            local AngRandom = Angle(newang.p, RandAng.y, RandAng.r)

            ModelGlitch2:SetPos( newpos )
            ModelGlitch2:SetAngles( AngRandom )
            ModelGlitch2:SetupBones()
            ModelGlitch2:DrawModel()

            if (5 >= math.Rand(1, 100)) then
                RandAng = AngleRand()
                AngRandom = Angle(newang.p, newang.y, RandAng.r)
                ModelGlitch1:SetPos( newpos )
                ModelGlitch1:SetAngles( AngRandom )
                ModelGlitch1:SetupBones()
                ModelGlitch1:DrawModel()
            end
        end
    end
end)