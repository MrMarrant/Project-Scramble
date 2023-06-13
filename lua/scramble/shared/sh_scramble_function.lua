/*
* Return true if the entity will be detected SCP 096.
*/
function scramble.IsDetectedBySCP096()
    local percent = GetConvar("Scramble_Percent"):GetFloat()
    assert(percent >= 0 and percent <= 100)
    return percent >= math.Rand(1, 100)
end