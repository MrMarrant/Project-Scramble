SCRAMBLE_CONFIG.ScrambleUpdateParamArctic = "SCRAMBLE_CONFIG.ScrambleUpdateParamArctic"

-- DIRECTORY DATA FOLDER
if not file.Exists("data_scramble", "DATA") then
    file.CreateDir("data_scramble")
end

if not file.Exists(SCRAMBLE_CONFIG.PathConfigFile, "DATA") then
    local SERVER_VALUES = {}
    SERVER_VALUES["models/scp096anim/player/scp096pm_raf.mdl"] = {
        head = "ValveBiped.Bip01_Head1", -- BoneId
        x = 0, -- Pos Vector x adjustement depend on the model
        y = 1, -- Pos Vector y adjustement depend on the model
        z = 3  -- Pos Vector z adjustement depend on the model
    }
    SERVER_VALUES["models/shaklin/scp/096/scp_096.mdl"] = {
        head = "head",
        x = 0,
        y = 2,
        z = 0
    }
    SERVER_VALUES["models/player/scp096.mdl"] = {
        head = "ValveBiped.Bip01_Head1",
        x = 0,
        y = 0,
        z = 0
    }
    file.Write(SCRAMBLE_CONFIG.PathConfigFile, util.TableToJSON(SERVER_VALUES, true))
end

SCRAMBLE_CONFIG.ModelName = scramble.GetDataFromFile(SCRAMBLE_CONFIG.PathConfigFile)

scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."server/")
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."client/")
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."shared/")