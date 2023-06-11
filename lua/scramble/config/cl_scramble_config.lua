if SERVER then return end

-- Class, SWEP and job that are affected by the censor filter of the scramble.
SCRAMBLE_CONFIG.ClassEntities = {
    Citizen = true,
    Gangster = true,
    Police = true
}
SCRAMBLE_CONFIG.ClassSwep = {}
SCRAMBLE_CONFIG.JobName = {}