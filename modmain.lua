local _G = GLOBAL

local ENHANCED_RANGE = 20
local VANILLA_RANGE = _G.TUNING.FIRE_DETECTOR_RANGE or 15
local VANILLA_PLACER_SCALE = 1.55
local ENHANCED_PLACER_SCALE = VANILLA_PLACER_SCALE * (ENHANCED_RANGE / VANILLA_RANGE)

_G.TUNING.FIRE_DETECTOR_RANGE = ENHANCED_RANGE

local function ApplyEnhancedRange(inst)
    if inst ~= nil and inst.components.firedetector ~= nil then
        inst.components.firedetector.range = ENHANCED_RANGE
    end
end

AddPrefabPostInit("firesuppressor", function(inst)
    if _G.TheWorld.ismastersim then
        inst:DoTaskInTime(0, ApplyEnhancedRange)
    end
end)

AddPrefabPostInit("firesuppressor_placer", function(inst)
    if inst ~= nil and inst.Transform ~= nil then
        inst.Transform:SetScale(ENHANCED_PLACER_SCALE, ENHANCED_PLACER_SCALE, ENHANCED_PLACER_SCALE)
    end
end)
