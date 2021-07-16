-- Created By Bapes#1111 --
-- Please do not distrubute without consent --

local name = "Bapes Destro Rotation"
local version = "v1.1-beta"
local Tinkr = ...
local Routine = Tinkr.Routine
local AceGUI = Tinkr.Util.AceGUI
local Config = Tinkr.Util.Config
local config = Config:New("bapes-destro")
local HTTP = Tinkr.Util.HTTP
local UI = {}
local player = "player"
local target = "target"
local pet = "pet"
local authenticated = false

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

-- AUTH --

local function do_auth()
    local url = "https://avaliddomain.getgud.cc"

    local body = '{"license":"'.. config:Read('license', '') ..'", "lock":"' .. GetAccountID() ..'", "id":"1MVL4EIS2G"}'
    local headers = {
        "Content-type: application/json"
    }

    HTTP:POST(url, body, headers, function(status, buffer)
        if (status == 200) then
            authenticated = true
            print("|cFFFFD700[Bapes Scripts]|cFF00FF00 You are authenticated to use " .. name .. "! Enjoy and please send feedback / support requests to Bapes#1111 on Discord")
        else
            authenticated = false
            print("|cFFFFD700[Bapes Scripts]|cFFFF0000 Ut oh! You do not have access to this script, please purchase it before continuing and make sure you have entered the license correctly. For support DM Bapes#1111 on Discord")
        end
    end)
end

do_auth()

-- END AUTH --

-- LICENSE UI --

local function DrawUI()
    local frame = AceGUI:Create("Window")
    frame:SetTitle(name .. " " .. version)
    frame:EnableResize(false)
    frame:SetWidth(225)
    frame:SetHeight(140)
    frame:SetLayout("List")
    frame:SetCallback("OnClose", function(widget)
    end)

    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetFullWidth(true)
    buttonGroup:SetHeight(75)

    local license = AceGUI:Create("EditBox")
    license:SetLabel("License")
    license:SetWidth(200)
    license:DisableButton(false)
    license:SetText(config:Read("license", "Input license here"))
    license:SetCallback("OnTextChanged", function(self, event, text)
        config:Write("license", text)
    end)
    license:SetCallback("OnEnterPressed", function(self, event, text)
        do_auth()
    end)

    buttonGroup:AddChild(license)

    frame:AddChild(buttonGroup)
end

DrawUI()

-- END LICENSE UI --

-- Print name and version
print("|cFFFFD700[Bapes Scripts]|cFF8A2BE2 " .. name .. " " .. version)

Routine:RegisterRoutine(function()
    -- Check to make sure the user is authenticated
    if not authenticated then
        return
    end

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
        local lifeTapPercentage = UI.config.read("lifeTapPercentage", 30)

        local useWand = UI.config.read("useWand", "true")
        local useCorruption = UI.config.read("useCorruption", "true")
        local drainSoulPercentage = UI.config.read("drainSoulPercentage", 5)
        local shadowburnPercentage = UI.config.read("shadowburnPercentage", 5)
        local conflagratePercentage = UI.config.read("conflagratePercentage", 10)

        local curse = UI.config.read("curse", "Elements")

        -- END SETTINGS --

        -- SPELLS --

        local lifeTap = highestrank(1454)

        local wand = highestrank(5019)

        local elements = highestrank(1490)
        local recklessness = highestrank(704)
        local doom = highestrank(603)
        local agony = highestrank(980)
        local exhaustion = highestrank(18223)
        local tongues = highestrank(1714)

        local immolate = highestrank(348)
        local corruption = highestrank(172)
        local shadowBolt = highestrank(686)
        local shadowburn = highestrank(17877)
        local conflagrate = highestrank(17962)
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

        -- Life Tap
        if mana <= lifeTapPercentage and castable(lifeTap, player) then
            return cast(lifeTap, player)
        end

        -- END HEALING --

        -- BUFFS --

        -- END BUFFS --

        -- ATTACK START --

        if useWand and castable(wand, target) and not IsAutoRepeatSpell(wand) then
            return cast(wand, target)
        end

        -- END ATTACK START --

        -- ROTATION --

        -- Curse
        if curse == "Elements" then
            if not debuff(elements, target) and castable(elements, target) then
                return cast(elements, target)
            end
        elseif curse == "Recklessness" then
            if not debuff(recklessness, target) and castable(recklessness, target) then
                return cast(recklessness, target)
            end
        elseif curse == "Doom" then
            if not debuff(doom, target) and castable(doom, target) then
                return cast(doom, target)
            end
        elseif curse == "Agony" then
            if not debuff(agony, target) and castable(agony, target) then
                return cast(agony, target)
            end
        elseif curse == "Exhaustion" then
            if not debuff(exhaustion, target) and castable(exhaustion, target) then
                return cast(exhaustion, target)
            end
        elseif curse == "Tongues" then
            if not debuff(tongues, target) and castable(tongues, target) then
                return cast(tongues, target)
            end
        end

        -- Shadowburn
        if health(target) <= shadowburnPercentage and castable(shadowburn, target) then
            return cast(shadowburn, target)
        end

        -- Conflagrate
        if health(target) <= conflagratePercentage and castable(conflagrate, target) then
            return cast(conflagrate, target)
        end

        -- Drain Soul
        if health(target) <= drainSoulPercentage and itemcount(soulShard) < 5 and not debuff(drainSoul, target) and castable(drainSoul, target) then
            return cast(drainSoul, target)
        end

        -- Immolate
        if not debuff(immolate, target) and castable(immolate, target) then
            return cast(immolate, target)
        end

        -- Corruption
        if useCorruption and not debuff(corruption, target) and castable(corruption, target) then
            return cast(corruption, target)
        end

        -- Shadow Bolt
        if castable(shadowBolt, target) then
            return cast(shadowBolt, target)
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

        local summonSuccubus = highestrank(712)
        local createHealthstone = highestrank(6201)
        local createSoulstone = highestrank(693)

        local felArmor = highestrank(28176)
        local demonicSacrifice = highestrank(18788)
        local touchOfShadow = 18791

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
        if castable(summonSuccubus, player) and not exists(pet) and not buff(touchOfShadow, player) then
            return cast(summonSuccubus, player)
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
        if castable(felArmor, player) and not buff(felArmor, player) then
            return cast(felArmor, player)
        end

        -- Demonic Sacrifice
        if castable(demonicSacrifice, player) and not buff(touchOfShadow, player) then
            return cast(demonicSacrifice, player)
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
    end

    if combat(player) then
        do_combat()
        return
    else
        do_resting()
        return
    end

end, Routine.Classes.Warlock, "bapes-destro")
Routine:LoadRoutine("bapes-destro")

local bapesDestro_settings = {
    key = "bapes_destro_config",
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
        -- Life Tap Percentage
        {
            key = "lifeTapPercentage",
            type = "slider",
            text = "Life Tap Percentage",
            label = "Life Tap %",
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
        -- Corruption
        {
            key = "useCorruption",
            type = "checkbox",
            text = "Use Corruption"
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
        },
        -- Shadowburn Percentage
        {
            key = "shadowburnPercentage",
            type = "slider",
            text = "Shadowburn Percentage",
            label = "Shadowburn %",
            min = 5,
            max = 95,
            step = 5
        },
        -- Conflagrate Percentage
        {
            key = "conflagratePercentage",
            type = "slider",
            text = "Conflagrate Percentage",
            label = "Conflagrate %",
            min = 5,
            max = 95,
            step = 5
        },
        -- Curse
        {
            key = "curse",
            width = 130,
            label = "Curse",
            type = "dropdown",
            options = {"Elements", "Recklessness", "Doom", "Agony", "Exhaustion", "Tongues"}
        }
    }
}

UI.build_rotation_gui(bapesDestro_settings)

local bapesDestro_buttons = {
}

UI.button_factory(bapesDestro_buttons)