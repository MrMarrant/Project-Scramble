-- Functions
scramble = {}
-- Global Variable
SCRAMBLE_CONFIG = {}
-- RootFolder path
SCRAMBLE_CONFIG.RootFolder = "scramble/"

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
print("Project SCRAMBLE Loaded!")