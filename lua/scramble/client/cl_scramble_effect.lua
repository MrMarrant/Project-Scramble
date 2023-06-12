if SERVER then return end

local ModelGlitch1 = ClientsideModel( "models/hunter/blocks/cube05x05x05.mdl" )
ModelGlitch1:SetMaterial("models/wireframe")
ModelGlitch1:SetModelScale(0.6)
ModelGlitch1:SetNoDraw( true )

local ModelGlitch2 = ClientsideModel( "models/hunter/blocks/cube05x05x05.mdl" )
ModelGlitch2:SetMaterial("models/rendertarget")
ModelGlitch2:SetModelScale(0.6)
ModelGlitch2:SetNoDraw( true )

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

    local playerEntities = {}
    local npcEntities = {}
    for _, ent in pairs(ents.GetAll()) do
        if ent != ply and IsValid(ent) and (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then -- Vous pouvez modifier cette condition selon vos besoins
            if IsInFieldOfView(ply, ent) and IsVisible(ply, ent) then
                local ParamsModel = SCRAMBLE_CONFIG.ModelName[ent:GetModel()]
                if (ParamsModel) then
                    if (ent:IsPlayer()) then
                        table.insert(playerEntities, ent)
                    end
                    if (ent:IsNPC() or ent:IsNextBot()) then
                        table.insert(npcEntities, ent)
                    end
                end
            end
        end
    end

    return playerEntities, npcEntities
end

local function SetCensorEffect(ent, params)
    local offsetvec = Vector( params.x, params.y, params.z )
    local offsetang = Angle( 0, 90, 90 )
    local boneid = ent:IsNextBot() and ent:LookupBone( "head" ) or ent:LookupBone( "ValveBiped.Bip01_Head1" )
    
    if not boneid then
        for var = 1, ent:GetBoneCount() do
            print(ent:GetBoneName( var ))
        end
        return
    end

    local matrix = ent:GetBoneMatrix( boneid )
    if not matrix then
        return 
    end
    
    local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )
    print(ent:GetPos())
    print(newpos)
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

-- TODO : Fonctionne pas pour les NPC
hook.Add("Think", "Think.Scramble_CheckEntSound", function()
    local ply = LocalPlayer()
    if (ply:GetNWInt("nvg", 0) == 7 and ply:GetNWBool("nvg_on", false)) then
        local playerEntities, npcEntities = GetVisibleEntities()
        if ((#playerEntities >= 1 or #npcEntities >= 1)) then
            if (!ply.Scramble_LoopingSound) then
                ply.Scramble_LoopingSound = ply:StartLoopingSound( "scramble/detect_scp096.wav" )
            end
            if (#npcEntities >= 1) then
                for key, value in ipairs(npcEntities) do
                    local ParamsModel = SCRAMBLE_CONFIG.ModelName[value:GetModel()]
                    SetCensorEffect(value, ParamsModel)
                end
            end
        elseif (ply.Scramble_LoopingSound) then
            ply:StopSound("scramble/detect_scp096.wav")
            ply.Scramble_LoopingSound = nil
        end
    else
        if (ply.Scramble_LoopingSound) then ply:StopSound("scramble/detect_scp096.wav")
            ply.Scramble_LoopingSound = nil
        end
    end
end)

hook.Add( "PostPlayerDraw" , "PostPlayerDraw.Scramble_Censor" , function( ent )
    local ply = LocalPlayer()
    if (ply:GetNWInt("nvg", 0) == 7 and ply:GetNWBool("nvg_on", false)) then
        if (ent:IsPlayer() and ent != ply and ent:Alive()) then
            local ParamsModel = SCRAMBLE_CONFIG.ModelName[ent:GetModel()]
            if (ParamsModel) then
                SetCensorEffect(ent, ParamsModel)
            end
        end
    end
end)

net.Receive(SCRAMBLE_CONFIG.ScrambleUpdateParamArctic, function ( )
    local isEnabled = net.ReadBool()
    local typeNVG = net.ReadUInt( 5 )
    local ply = LocalPlayer()
    ply:SetNWInt("nvg", typeNVG)
    ply:SetNWBool("nvg_on", isEnabled)
end)