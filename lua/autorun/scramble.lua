-- Functions
scramble = {}
-- Global Variable
SCRAMBLE_CONFIG = {}
-- Lang Text
SCRAMBLE_LANG = {}
-- RootFolder path
SCRAMBLE_CONFIG.RootFolder = "scramble/"
-- Config File path
SCRAMBLE_CONFIG.PathConfigFile = "data_scramble/scramble_config.json"
-- SCRAMBLE_CONFIG.
SCRAMBLE_CONFIG.ScramblePercent = CreateConVar( "Scramble_Percent", 0, FCVAR_PROTECTED, "Percent Detect By SCP 096", 0, 100 )

/*
* Allows to return the data of a file.
* @string path File path.
*/
function scramble.GetDataFromFile(path)
    local fileFind = file.Read(path) or ""
    local dataFind = util.JSONToTable(fileFind) or {}
    return dataFind
end

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

print("Project SCRAMBLE Loading . . .")
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."config/sh_scramble_config.lua", true)
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."config/sv_scramble_config.lua", true)
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."config/cl_scramble_config.lua", true)
print("Project SCRAMBLE Loaded!")