/*
* Return true if the entity will be detected SCP 096.
*/
function scramble.IsDetectedBySCP096()
    local percent = GetConvar("Scramble_Percent"):GetFloat()
    assert(percent >= 0 and percent <= 100)
    return percent >= math.Rand(1, 100)
end

/*
* Returns the registered model if it exists corresponding to the player's job, otherwise returns the default model.
* @Player ply The player owner of the weapon.
* @number range The Range to check in cone.
*/
-- TODO : Problème, renvoie toutes les entités, peut importe si elles sont derrière un mur.
function scramble.GetPlayersInCone(ply, range)
    if (!IsValid(ply) or type(range) != "number") then return {} end
    local eyetrace = ply:GetEyeTrace()

    local entities = ents.FindInCone( ply:GetPos(), ply:GetAimVector(), ply:GetPos():Distance( eyetrace.HitPos ), math.cos( math.rad( ply:GetFOV() ) ) )
    local PlayerFounded = {}
    local EntsFounded = {}
    if (#entities == 0) then return PlayerFounded, EntsFounded end

    for key, value in pairs(entities) do
        if (value:IsPlayer() and value != ply and value:Alive()) then
            if (SCRAMBLE_CONFIG.ClassEntities[team.GetName( value:Team() )]) then
                table.insert( PlayerFounded, value )
            end
        end
        -- TODO : Faire pour les entités/npc
    end
    return PlayerFounded, EntsFounded
end