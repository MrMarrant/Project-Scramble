SCRAMBLE_CONFIG.UpdateBoolClient = "SCRAMBLE_CONFIG.UpdateBoolClient"
SCRAMBLE_CONFIG.SetTableClient = "SCRAMBLE_CONFIG.SetTableClient"
SCRAMBLE_CONFIG.ScreenFadeNVG = "SCRAMBLE_CONFIG.ScreenFadeNVG"
SCRAMBLE_CONFIG.CTSUpdateState = "SCRAMBLE_CONFIG.CTSUpdateState"
SCRAMBLE_CONFIG.CTSUpdateNVG = "SCRAMBLE_CONFIG.CTSUpdateNVG"
SCRAMBLE_CONFIG.CTSUpdateDrop= "SCRAMBLE_CONFIG.CTSUpdateDrop"
SCRAMBLE_CONFIG.SoundToPlayClientSide = "SCRAMBLE_CONFIG.SoundToPlayClientSide"

-- Class, SWEP and job that are affected by the censor filter of the scramble.
SCRAMBLE_CONFIG.ClassEntities = {}
SCRAMBLE_CONFIG.ClassSwep = {}
SCRAMBLE_CONFIG.JobName = {}

-- Table that list all players wearinf and state of the scramble.
SCRAMBLE_CONFIG.PlayersWearingScramble = {}
SCRAMBLE_CONFIG.PlayersStateScramble = {}

scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."client/")
scramble.LoadDirectory(SCRAMBLE_CONFIG.RootFolder.."server/")