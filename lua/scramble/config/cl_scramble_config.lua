if SERVER then return end

--Models that are affected by the censor filter of the scramble.
SCRAMBLE_CONFIG.ModelName = {}

SCRAMBLE_CONFIG.ModelName["models/scp096anim/player/scp096pm_raf.mdl"] = {
    head = "ValveBiped.Bip01_Head1", -- BoneId
    x = 0, -- Pos Vector x adjustement depend on the model
    y = 1, -- Pos Vector y adjustement depend on the model
    z = 3  -- Pos Vector z adjustement depend on the model
}
SCRAMBLE_CONFIG.ModelName["models/shaklin/scp/096/scp_096.mdl"] = {
    head = "head",
    x = 0,
    y = 2,
    z = 0
}
SCRAMBLE_CONFIG.ModelName["models/player/scp096.mdl"] = {
    head = "ValveBiped.Bip01_Head1",
    x = 0,
    y = 0,
    z = 0
}