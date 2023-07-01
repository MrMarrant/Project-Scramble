SCRAMBLE_CONFIG.ScrambleUpdateParamArctic = "SCRAMBLE_CONFIG.ScrambleUpdateParamArctic"
SCRAMBLE_CONFIG.CTSUpdateDrop = "SCRAMBLE_CONFIG.CTSUpdateDrop"

-- DIRECTORY DATA FOLDER
if not file.Exists("data_scramble", "DATA") then
    file.CreateDir("data_scramble")
end

if not file.Exists(SCRAMBLE_CONFIG.PathConfigFile, "DATA") then
    file.Write(SCRAMBLE_CONFIG.PathConfigFile, util.TableToJSON( {}, true ))
end

SCRAMBLE_CONFIG.ModelName = scramble.GetDataFromFile(SCRAMBLE_CONFIG.PathConfigFile)

-- Default Model manage
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
SCRAMBLE_CONFIG.ModelName["models/scp_096/scp_096_final.mdl"] = {
    head = "head",
    x = 0,
    y = 0,
    z = 1
}
SCRAMBLE_CONFIG.ModelName["models/cpthazama/scp/096.mdl"] = {
    head = "head",
    x = 0,
    y = 2.5,
    z = 0,
    scale = 0.7
}
SCRAMBLE_CONFIG.ModelName["models/cpthazama/scp/096_old.mdl"] = {
    head = "Bone_077",
    x = 0,
    y = 0,
    z = 3,
    scale = 0.7
}

scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."server/")
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."client/")
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."shared/")