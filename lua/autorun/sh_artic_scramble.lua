local thermalMat = Material("pp/texturize/plain.png")

local nvg_scramble = {
    ShortName = "nvg_scramble",
    VManipIn = "nvg_gpnvg_in",
    VManipOut = "nvg_gpnvg_out",
    Model = "models/arctic_nvgs/nvg_gpnvg.mdl",
    FullColor = false,
    EquipDelay = 1.325,
    ColorCorrectSettings = {
        ["$pp_colour_addr"] = -1,
        ["$pp_colour_addg"] = 0,
        ["$pp_colour_addb"] = -1,
        ["$pp_colour_brightness"] = 0,
        ["$pp_colour_contrast"] = 4.5,
        ["$pp_colour_colour"] = 1,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0,
    },
    EquipSound = "arctic_nvgs/nvg_on_1.wav",
    UnequipSound = "arctic_nvgs/nvg_off_1.wav",
    BloomSettings = {
        darken = 0,
        multiply = 1,
        sizex = 4,
        sizey = 4,
        passes = 1,
        colormultiply = 1,
        red = 1,
        green = 1,
        blue = 1,
    },
    ActiveLight = false,
    EffectFunction = nil,
    Overlay = Material("arctic_nvg/faint.png", "mips"),
    -- ScaleToSquare = false,
    Entity = "arctic_nvg_scramble",
    Offset = Vector(0, 0, 0),
    OffsetAngle = Angle(0, 0, 0)
}
local thermal_scramble = {
        ShortName = "nvg_t7_scramble",
        VManipIn = "nvg_t7_in",
        VManipOut = "nvg_t7_out",
        EquipDelay = 1.325,
        Model = "models/arctic_nvgs/nvg_t7.mdl",
        FullColor = true,
        ColorCorrectSettings = {
            ["$pp_colour_addr"] = 0,
            ["$pp_colour_addg"] = 0,
            ["$pp_colour_addb"] = 0,
            ["$pp_colour_brightness"] = 0.05,
            ["$pp_colour_contrast"] = 0.5,
            ["$pp_colour_colour"] = 0,
            ["$pp_colour_mulr"] = 0,
            ["$pp_colour_mulg"] = 0,
            ["$pp_colour_mulb"] = 0,
        },
        EquipSound = "arctic_nvgs/nvg_on_1.wav",
        UnequipSound = "arctic_nvgs/nvg_off_1.wav",
        BloomSettings = {
            darken = 0,
            multiply = 1,
            sizex = 4,
            sizey = 4,
            passes = 1,
            colormultiply = 1,
            red = 1,
            green = 1,
            blue = 1,
        },
        ThermalVision = true,
        ThermalHighlight = Color(255, 0, 0),
        ActiveLight = false,
        EffectFunction = function()
            DrawTexturize(1, thermalMat)
        end,
        Overlay = Material("arctic_nvg/binocular.png", "mips"),
        ScaleToSquare = false,
        Entity = "arctic_thermal_scramble",
        Offset = Vector(0, 0, 0),
        OffsetAngle = Angle(0, 0, 0)
}

table.insert( ArcticNVGs, nvg_scramble )
table.insert( ArcticNVGs, thermal_scramble )

for i, k in pairs(ArcticNVGs) do
    ArcticNVGs_ShortNameToID[k.ShortName or ""] = i
end