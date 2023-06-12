if SERVER then return end

-- Class, SWEP and job that are affected by the censor filter of the scramble.
SCRAMBLE_CONFIG.ClassEntities = {
    Citizen = true,
    Gangster = true,
    Police = true
}
SCRAMBLE_CONFIG.ModelName = {}

SCRAMBLE_CONFIG.ModelName["models/scp096anim/player/scp096pm_raf.mdl"] = {
    x = 0,
    y = 1,
    z = 3
}
SCRAMBLE_CONFIG.ModelName["models/shaklin/scp/096/scp_096.mdl"] = {
    x = 0,
    y = 0,
    z = 0
}