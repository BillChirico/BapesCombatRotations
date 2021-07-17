-- Created By Bapes#1111 --
-- Please do not distrubute without consent --

local name = "Bapes Combat Rotation"
local version = "v1.2"
local Tinkr = ...
local Routine = Tinkr.Routine
local AceGUI = Tinkr.Util.AceGUI
local Config = Tinkr.Util.Config
local config = Config:New("bapes-combat")
local HTTP = Tinkr.Util.HTTP
local UI = {}
local player = "player"
local target = "target"
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

    local body = '{"license":"'.. config:Read('license', '') ..'", "lock":"' .. GetAccountID() ..'"}'
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

    -- COMBAT --
    local function do_combat()
        local comboPoints = GetComboPoints(player, target)
        local energy = power(PowerType.Energy)

        -- SETTINGS --



        -- END SETTINGS --

        -- SPELLS --



        -- END SPELLS --

        -- Auto Attack
        if UnitExists(target) and not UnitIsDeadOrGhost(target) and enemy(target) then
            Eval('StartAttack()', 't')
        end

        -- HEALING --



        -- END HEALING --

        -- BUFFS --

        

        -- END BUFFS --

        -- DEBUFFS --



        -- END DEBUFFS --

        -- ROTATION --



        -- END ROTATION --
    end

    -- RESTING --
    local function do_resting()
        if UnitIsDeadOrGhost(player) or UnitIsDeadOrGhost(target) or IsEatingOrDrinking() then
            return
        end

        -- SETTINGS --


        -- END SETTINGS --

        -- SPELLS --


        -- END SPELLS --

        -- HEALING --

        
        -- END HEALING --

        -- BUFFS --


        -- END BUFFS --

        -- Cat Form
        if UnitExists(target) and alive(target) and not buff(catForm, player) and castable(catForm, player) and distance(player, target) <= math.random(25, 40) then
            return cast(catForm, player)
        end

        -- Stealth
        if UnitExists(target) and alive(target) and not buff(stealth, player) and castable(stealth, player) and distance(player, target) <= 15 then
            return cast(stealth, player)
        end

        -- Dash
        if not buff(dash, player) and castable(dash, player) then
            return cast(dash, player)
        end

        -- Pounce
        if UnitExists(target) and spellInRange(pounce) and castable(pounce) then
            return cast(pounce, target)
        end
    end

    if combat(player) then
        do_combat()
        return
    else
        do_resting()
        return
    end

end, Routine.Classes.Druid, "bapes-combat")
Routine:LoadRoutine("bapes-combat")

local bapesCombat_settings = {
    key = "bapes_combat_config",
    title = "Bapes Scripts",
    width = 400,
    height = 400,
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
        -- Heal in Combat
        {
            key = "healInCombat",
            type = "checkbox",
            text = "Heal in Combat"
        },
        -- Heal out of Combat
        {
            key = "healOutOfCombat",
            type = "checkbox",
            text = "Heal out of Combat"
        },
        -- Healing Percentage
        {
            key = "healPercentage",
            type = "slider",
            text = "Healing Percentage",
            label = "Healing %",
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
        -- Innervate
        {
            key = "useInnervate",
            type = "checkbox",
            text = "Use Innervate"
        },
        -- Forms --
        {
            key = "heading",
            type = "heading",
            text = "Forms"
        },
        -- Bear Form
        {
            key = "useBearForm",
            type = "checkbox",
            text = "Use Bear Form"
        },
        -- Bear Form Percentage
        {
            key = "bearFormPercentage",
            type = "slider",
            text = "Bear Form Percentage",
            label = "Bear Form %",
            min = 5,
            max = 95,
            step = 5
        },
    }
}

UI.build_rotation_gui(bapesCombat_settings)

local bapesCombat_buttons = {
}

UI.button_factory(bapesCombat_buttons)