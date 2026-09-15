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

SCRAMBLE_CONFIG.PastebinModelURL = "https://pastebin.com/raw/AWupxWnw"

http.Fetch(SCRAMBLE_CONFIG.PastebinModelURL, function(body)
    local data = util.JSONToTable(body)
    if not data then
        print("[SCRAMBLE Arctic] Invalid JSON received from pastebin model config.")
        return
    end

    for model, params in pairs(data) do
        SCRAMBLE_CONFIG.ModelName[model] = params
    end
end, function(err)
    print("[SCRAMBLE Arctic] Failed to fetch model config : "..err)
end)

scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder .. "server/")
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder .. "client/")
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder .. "shared/")