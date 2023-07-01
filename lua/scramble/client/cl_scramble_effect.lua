if SERVER then return end

local ModelCensorBlack = ClientsideModel( "models/hunter/blocks/cube05x05x05.mdl" )
ModelCensorBlack:SetMaterial("models/wireframe")
ModelCensorBlack:SetModelScale(0.7)
ModelCensorBlack:SetNoDraw( true )

local ModelCensorGlitch = ClientsideModel( "models/hunter/blocks/cube05x05x05.mdl" )
ModelCensorGlitch:SetMaterial("models/rendertarget")
ModelCensorGlitch:SetModelScale(0.7)
ModelCensorGlitch:SetNoDraw( true )


/*
* Function that return a bool if an entity is in the angle of view of the player or not.
* @Player ply The player where we have to check the side line.
* @Entity ent The entioty to check if it is detected in the range of the trace
*/
local function IsInFieldOfView(ply, ent)
    local plyAngles = ply:EyeAngles()
    local viewVector = plyAngles:Forward()

    local entPos = ent:GetPos()
    local entDir = (entPos - ply:EyePos()):GetNormalized()
    
    return viewVector:Dot(entDir) >= math.cos(math.rad(75)) -- Angle de vue de 75 degrés
end

/*
* Function that return a bool if an entity is visible by the player or not.
* @Player ply The player where we have to check the side line.
* @Entity ent The entioty to check if it is detected in the range of the trace
*/
local function IsVisible(ply, ent)
    local tr = util.TraceLine({
        start = ply:EyePos(),
        endpos = ent:GetPos(),
        mask = MASK_SOLID_BRUSHONLY
    })

    return not tr.Hit
end

/*
* Function that return 2 table with the players and the NPC/NextBot detected with a trace.
*/
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

/*
* Function that apply on the head of a player model a censor effect.
* @Entity ent The ent to apply the censor effect
* @table params Parameter that is define according to the model
*/
local function SetCensorEffect(ent, params)
    local offsetvec = Vector( params.x, params.y, params.z )
    local offsetang = Angle( 0, 90, 90 )
    local boneid = ent:LookupBone( params.head )

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

    ModelCensorGlitch:SetPos( newpos )
    ModelCensorGlitch:SetAngles( AngRandom )
    if (params.scale) then ModelCensorGlitch:SetModelScale(params.scale) end
    ModelCensorGlitch:SetupBones()
    ModelCensorGlitch:DrawModel()

    if (5 >= math.Rand(1, 100)) then
        RandAng = AngleRand()
        AngRandom = Angle(newang.p, newang.y, RandAng.r)
        ModelCensorBlack:SetPos( newpos )
        ModelCensorBlack:SetAngles( AngRandom )
        if (params.scale) then ModelCensorBlack:SetModelScale(params.scale) end
        ModelCensorBlack:SetupBones()
        ModelCensorBlack:DrawModel()
    end
end

-- For NPC & Nexbot
--? I can put the player version into it aswell, but it is less precise because in certain angle with walls, the censor effect 
--? don't work very well, if PostPlayerDraw for NPC exist, i would have done it another way.
hook.Add("RenderScreenspaceEffects","RenderScreenspaceEffects.Scramble_Censor",function()
    local ply = LocalPlayer()
    if (ply:GetNWInt("nvg", 0) == 7 and ply:GetNWBool("nvg_on", false)) then
        local playerEntities, npcEntities = GetVisibleEntities()
        if (#npcEntities >= 1) then
            for key, value in ipairs(npcEntities) do
                local ParamsModel = SCRAMBLE_CONFIG.ModelName[value:GetModel()]
                cam.Start3D()
                    SetCensorEffect(value, ParamsModel)
                cam.End3D()
            end
        end
    end
end)

-- For emit the sound effect when a 096 is detected
hook.Add("Think", "Think.Scramble_CheckEntSound", function()
    local ply = LocalPlayer()
    if (ply:GetNWInt("nvg", 0) == 7 and ply:GetNWBool("nvg_on", false)) then
        local playerEntities, npcEntities = GetVisibleEntities()
        if ((#playerEntities >= 1 or #npcEntities >= 1)) then
            if (!ply.Scramble_LoopingSound) then
                ply.Scramble_LoopingSound = ply:StartLoopingSound( "scramble/detect_scp096.wav" )
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

-- For Detect Player
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

-- Update ClientSide Var Artic
net.Receive(SCRAMBLE_CONFIG.ScrambleUpdateParamArctic, function ( )
    local isEnabled = net.ReadBool()
    local typeNVG = net.ReadUInt( 5 )
    local ply = LocalPlayer()
    ply:SetNWInt("nvg", typeNVG)
    ply:SetNWBool("nvg_on", isEnabled)
end)