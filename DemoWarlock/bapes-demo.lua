-- Created By Bapes#1111 --
-- Please do not distrubute without consent --

local name = "Bapes Demo Rotation"
local version = "v1.1"
local Tinkr = ...
local Routine = Tinkr.Routine
local UI = {}
local player = "player"
local target = "target"
local pet = "pet"

-- CROMULON --

Tinkr:require("scripts.cromulon.libs.Libdraw.Libs.LibStub.LibStub", UI)
Tinkr:require("scripts.cromulon.libs.Libdraw.LibDraw", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.AceGUI30", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-BlizOptionsGroup", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-DropDownGroup", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-Frame", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-InlineGroup", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-ScrollFrame", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-SimpleGroup", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-TabGroup", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-TreeGroup", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-Window", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Button", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-CheckBox", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-ColorPicker", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-DropDown", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-DropDown-Items", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-EditBox", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Heading", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Icon", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-InteractiveLabel", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Keybinding", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Label", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-MultiLineEditBox", UI)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Slider", UI)
Tinkr:require("scripts.cromulon.system.configs", UI)
Tinkr:require("scripts.wowex.libs.AceAddon30.AceAddon30", UI)
Tinkr:require("scripts.wowex.libs.AceConsole30.AceConsole30", UI)
Tinkr:require("scripts.wowex.libs.AceDB30.AceDB30", UI)
Tinkr:require("scripts.cromulon.system.storage", UI)
Tinkr:require("scripts.cromulon.libs.libCh0tFqRg.libCh0tFqRg", UI)
Tinkr:require("scripts.cromulon.libs.libNekSv2Ip.libNekSv2Ip", UI)
Tinkr:require("scripts.cromulon.libs.CallbackHandler10.CallbackHandler10", UI)
Tinkr:require("scripts.cromulon.libs.HereBeDragons.HereBeDragons-20", UI)
Tinkr:require("scripts.cromulon.libs.HereBeDragons.HereBeDragons-pins-20", UI)
Tinkr:require("scripts.cromulon.interface.uibuilder", UI)
Tinkr:require("scripts.cromulon.interface.buttons", UI)
mybuttons.On = false
mybuttons.Cooldowns = false
mybuttons.MultiTarget = false
mybuttons.Interupts = false
mybuttons.Settings = false

-- END CROMULON --

-- Print name and version
print("|cFFFFD700[Bapes Scripts]|cFF8A2BE2 " .. name .. " " .. version)

Routine:RegisterRoutine(function()
    if gcd() > latency() then
        return
    end

    if not latencyCheck() then
        return
    end

    if mounted() then
        return
    end

    -- COMBAT --
    local function do_combat()
        local mana = power()

        -- SETTINGS --

        local useHealthStone = UI.config.read("useHealthStone", "true")
        local healthstonePercentage = UI.config.read("healthstonePercentage", 40)

        local lifeTapPercentage = UI.config.read("lifeTapPercentage", 40)

        local useWand = UI.config.read("useWand", "true")
        local drainSoulPercentage = UI.config.read("drainSoulPercentage", 5)

        -- END SETTINGS --

        -- SPELLS --

        local lifeTap = highestrank(1454)

        local wand = highestrank(5019)

        local agony = highestrank(980)
        local corruption = highestrank(172)
        local drainLife = highestrank(689)
        local drainSoul = highestrank(1120)

        -- END SPELLS --

        -- ITEMS --

        local healthstones = {
            19005,
            19004,
            5512,
            19007,
            19006,
            5511,
            19009,
            19008,
            19011,
            19010,
            5510,
            19013,
            19012,
            9421,
            22105,
            22104,
            22103
        }

        local soulShard = 6265;

        -- END ITEMS --

        -- HEALING --

        -- Healthstone
        if health() <= healthstonePercentage and useHealthStone then
            for _, healthstone in pairs(healthstones) do
                if itemInBags(healthstone) and usable(healthstone) then
                    return useItem(healthstone, player)
                end
            end
        end

        -- END HEALING --

        -- BUFFS --

        if mana <= lifeTapPercentage and castable(lifetap, player) then
            cast(lifeTap, player)
        end

        -- END BUFFS --

        -- ATTACK START --

        if useWand and castable(wand, target) and not IsAutoRepeatSpell(wand) then
            return cast(wand, target)
        end

        if not UnitIsDeadOrGhost(pet) and IsPetActive() then
            Eval("PetAttack()", "t")
        end

        -- END ATTACK START --

        -- ROTATION --

        -- Curse of Agony
        if health(target) > drainSoulPercentage and not debuff(agony, target) and castable(agony, target) then
            return cast(agony, target)
        end

        -- Corruption
        if health(target) > drainSoulPercentage and not debuff(corruption, target) and castable(corruption, target) then
            return cast(corruption, target)
        end

        -- Drain Life
        if health(target) > drainSoulPercentage and not debuff(drainLife, target) and castable(drainLife, target) then
            return cast(drainLife, target)
        end

        -- Drain Soul
        if health(target) <= drainSoulPercentage and itemcount(soulShard) < 5 and not debuff(drainSoul, target) and castable(drainSoul, target) then
            return cast(drainSoul, target)
        end

        -- END ROTATION --
    end

    -- RESTING --
    local function do_resting()
        if UnitIsDeadOrGhost(player) or UnitIsDeadOrGhost(target) or IsEatingOrDrinking() then
            return
        end

        -- SETTINGS --

        local useHealthStone = UI.config.read("useHealthStone", "true")
        local useSoulstone = UI.config.read("useSoulstone", "true")

        -- END SETTINGS --

        -- SPELLS --

        local summonFelguard = highestrank(30146)
        local createHealthstone = highestrank(6201)
        local createSoulstone = highestrank(693)

        local soulLink = highestrank(19028)

        -- END SPELLS --

        -- ITEMS --

        local healthstones = {
            19005,
            19004,
            5512,
            19007,
            19006,
            5511,
            19009,
            19008,
            19011,
            19010,
            5510,
            19013,
            19012,
            9421,
            22105,
            22104,
            22103
        }

        local soulstones = {
            [5232] = 20707,
            [16892] = 20762,
            [16895] = 20764,
            [16896] = 20765,
            [22116] = 27239
        }

        -- END ITEMS --

        -- PET --

        -- Summon Pet
        if (UnitIsDeadOrGhost(pet) or not IsPetActive()) and castable(summonFelguard, player) then
            return cast(summonFelguard, player)
        end

        -- END PET --

        -- STONES --

        -- Healthstone
        if useHealthStone and castable(createHealthstone, player) then
            for _, healthstone in pairs(healthstones) do
                if itemInBags(healthstone) then
                    break
                end
            end

            return cast(createHealthstone, player)
        end

        -- Soulstone
        if useSoulstone and castable(createSoulstone, player) then
            for _, soulstoneItem in pairs(soulstones) do
                if itemInBags(soulstoneItem) then
                    break
                end
            end

            return cast(createSoulstone, player)
        end

        -- END STONES --

        -- BUFFS --

        -- Fel Armor
        if castable(FelArmor, player) and not buff(FelArmor, player) then
            return cast(FelArmor, player)
        end

        -- Soul Link
        if castable(soulLink, player) and not buff(25228, player) then
            return cast(soulLink, player)
        end

        -- Soulstone
        if useSoulstone then
            for soulstoneBuff, soulstoneItem in pairs(soulstones) do
                if itemInBags(soulstoneItem) and not buff(soulstoneBuff, player) and usable(soulstoneItem) then
                    return useItem(soulstoneItem, player)
                end
            end
        end

        -- END BUFFS --

        -- Pet Attack
        if UnitExists(target) and alive(target) and distance(player, target) <= math.random(30, 40) then
            Eval("PetAttack()", "t")
        end
    end

    if combat(player) then
        do_combat()
        return
    else
        do_resting()
        return
    end

end, Routine.Classes.Warlock, "bapes-demo")
Routine:LoadRoutine("bapes-demo")

local bapesDemo_settings = {
    key = "bapes_demo_config",
    title = "Bapes Scripts",
    width = 400,
    height = 300,
    color = "F58CBA",
    resize = false,
    show = false,
    table = {
        {
            key = "heading",
            type = "heading",
            text = name .. " " .. version
        },
        -- Healing --
        {
            key = "heading",
            type = "heading",
            text = "Healing"
        },
        -- Healthstone
        {
            key = "useHealthStone",
            type = "checkbox",
            text = "Use Healthstone"
        },
        -- Healthstone Percentage
        {
            key = "healthstonePercentage",
            type = "slider",
            text = "Healthstone Percentage",
            label = "Healthstone %",
            min = 5,
            max = 95,
            step = 5
        },
        -- Buffs --
        {
            key = "heading",
            type = "heading",
            text = "Buffs"
        },
        -- Soulstone
        {
            key = "useSoulstone",
            type = "checkbox",
            text = "Use Soulstone"
        },
        -- Life Tap Percentage
        {
            key = "lifeTapPercentage",
            type = "slider",
            text = "Life Tap Percentage",
            label = "Life Tap %",
            min = 1,
            max = 100,
            step = 5
        },
        -- Combat Options --
        {
            key = "heading",
            type = "heading",
            text = "Combat Options"
        },
        -- Wand
        {
            key = "useWand",
            type = "checkbox",
            text = "Use Wand"
        },
        -- Drain Soul Percentage
        {
            key = "drainSoulPercentage",
            type = "slider",
            text = "Drain Soul Percentage",
            label = "Drain Soul %",
            min = 5,
            max = 95,
            step = 5
        }
    }
}

UI.build_rotation_gui(bapesDemo_settings)

local bapesDemo_buttons = {
}

UI.button_factory(bapesDemo_buttons)