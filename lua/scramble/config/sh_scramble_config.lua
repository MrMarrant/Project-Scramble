SCRAMBLE_CONFIG.UpdateBoolClient = "SCRAMBLE_CONFIG.UpdateBoolClient"
SCRAMBLE_CONFIG.SetTableClient = "SCRAMBLE_CONFIG.SetTableClient"
SCRAMBLE_CONFIG.ScreenFadeNVG = "SCRAMBLE_CONFIG.ScreenFadeNVG"

SCRAMBLE_CONFIG.ClassEntities = {}
SCRAMBLE_CONFIG.ClassSwep = {}
SCRAMBLE_CONFIG.JobName = {}

scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."client/")
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."server/")