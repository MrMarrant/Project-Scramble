-- Functions
scramble = {}
-- Global Variable
SCRAMBLE_CONFIG = {}
-- Lang Text
SCRAMBLE_LANG = {}
-- RootFolder path
SCRAMBLE_CONFIG.RootFolder = "scramble/"
-- SCRAMBLE_CONFIG.
SCRAMBLE_CONFIG.ScramblePercent = CreateConVar( "Scramble_Percent", 1, FCVAR_PROTECTED, "Percent Detect By SCP 096", 0, 100 )

/*
* Allows you to load all the files in a folder.
* @string path of the folder to load.
* @bool isFile if the path is a file and not a folder.
*/
function scramble.LoadDirectory(pathFolder, isFile)
    if isFile then
        AddCSLuaFile(pathFolder)
        include(pathFolder)
    else
        local files, directories = file.Find(pathFolder.."*", "LUA")
        for key, value in pairs(files) do
            AddCSLuaFile(pathFolder..value)
            include(pathFolder..value)
        end
        for key, value in pairs(directories) do
            LoadDirectory(pathFolder..value)
        end
    end
end

-- DIRECTORY DATA FOLDER
if not file.Exists("data_scramble", "DATA") then
    file.CreateDir("data_scramble")
end

if (SERVER) then
    if not file.Exists(SCP_313_CONFIG.PathPercentEffect, "DATA") then
        local SERVER_VALUES = {}
        SERVER_VALUES.PercentEffect = 1.5
        file.Write(SCP_313_CONFIG.PathPercentEffect, util.TableToJSON(SERVER_VALUES, true))
    end

    local data = SCP_313.GetDataFromFile(SCP_313_CONFIG.PathPercentEffect)
    SCP_313_CONFIG.PercentEffect = data.PercentEffect
end

print("Project SCRAMBLE Loading . . .")
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."config/sh_scramble_config.lua", true)
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."config/sv_scramble_config.lua", true)
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."config/cl_scramble_config.lua", true)
print("Project SCRAMBLE Loaded!")