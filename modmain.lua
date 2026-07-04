local _G = GLOBAL

local ENHANCED_RANGE = 20
local EXTRA_SNOWBALLS = 3
local EXTRA_SHOT_INTERVAL = 3 * _G.FRAMES
local VANILLA_RANGE = _G.TUNING.FIRE_DETECTOR_RANGE or 15
local VANILLA_PLACER_SCALE = 1.55
local ENHANCED_PLACER_SCALE = VANILLA_PLACER_SCALE * (ENHANCED_RANGE / VANILLA_RANGE)

_G.TUNING.FIRE_DETECTOR_RANGE = ENHANCED_RANGE

local function ApplyEnhancedRange(inst)
    if inst ~= nil and inst.components.firedetector ~= nil then
        inst.components.firedetector.range = ENHANCED_RANGE
    end
end

local function SpawnEnhancedSnowball(inst, targetx, targety, targetz)
    local x, y, z = inst.Transform:GetWorldPosition()
    local projectile = _G.SpawnPrefab("snowball")
    projectile.Transform:SetPosition(x, y, z)

    local dx = targetx - x
    local dz = targetz - z
    projectile.components.complexprojectile:SetGravity(-25)
    projectile.components.complexprojectile:SetHorizontalSpeedForDistance(math.sqrt(dx * dx + dz * dz), 18)
    projectile.components.complexprojectile:Launch(_G.Vector3(targetx, targety, targetz), inst, inst)
end

local function LaunchProjectileEnhanced(inst, targetpos)
    local targetx, targety, targetz = targetpos:Get()
    SpawnEnhancedSnowball(inst, targetx, targety, targetz)

    for i = 1, EXTRA_SNOWBALLS do
        inst:DoTaskInTime(EXTRA_SHOT_INTERVAL * i, function()
            if inst ~= nil and inst:IsValid() then
                SpawnEnhancedSnowball(inst, targetx, targety, targetz)
            end
        end)
    end
end

local function ApplyHelperScale(inst)
    if inst ~= nil and inst.helper ~= nil and inst.helper.Transform ~= nil then
        inst.helper.Transform:SetScale(ENHANCED_PLACER_SCALE, ENHANCED_PLACER_SCALE, ENHANCED_PLACER_SCALE)
    end
end

AddPrefabPostInit("firesuppressor", function(inst)
    if inst ~= nil and inst.components.deployhelper ~= nil then
        local original = inst.components.deployhelper.onenablehelper
        inst.components.deployhelper.onenablehelper = function(helper_inst, enabled)
            if original ~= nil then
                original(helper_inst, enabled)
            end
            if enabled then
                ApplyHelperScale(helper_inst)
            end
        end
    end

    if _G.TheWorld.ismastersim then
        inst.LaunchProjectile = LaunchProjectileEnhanced
        inst:DoTaskInTime(0, function()
            ApplyEnhancedRange(inst)
            ApplyHelperScale(inst)
        end)
    end
end)

AddComponentPostInit("firedetector", function(self)
    if self ~= nil and self.inst ~= nil and self.inst.prefab == "firesuppressor" then
        self.range = ENHANCED_RANGE
    end
end)

AddPrefabPostInit("firesuppressor_placer", function(inst)
    if inst ~= nil and inst.Transform ~= nil then
        inst.Transform:SetScale(ENHANCED_PLACER_SCALE, ENHANCED_PLACER_SCALE, ENHANCED_PLACER_SCALE)
    end
end)
