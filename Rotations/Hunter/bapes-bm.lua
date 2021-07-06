-- Created By Bapes#1111 --
-- Please do not distrubute without concent --

local name = "Bapes BM Rotation"
local version = "v1.0"
local Tinkr = ...
local Routine = Tinkr.Routine
local AceGUI = Tinkr.Util.AceGUI
local Config = Tinkr.Util.Config
local config = Config:New("bapes-bm")
local HTTP = Tinkr.Util.HTTP
local UI = {}
local player = "player"
local target = "target"
local authenticated = false

-- CROMULON --

Tinkr:require("scripts.cromulon.libs.Libdraw.Libs.LibStub.LibStub", UI) --! If you are loading from disk your rotaiton.
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
    frame:SetTitle(name " " .. version)
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
print("|cFFFFD700[Bapes Scripts]|CFF959697 " .. name .. " " .. version)

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


        -- END SETTINGS --

        -- SPELLS --

        local autoShot = highestrank(75)
        local concussiveShot = highestrank(5116)

        local aspectViper = highestrank(34074)
        local aspectHawk = highestrank(13165)

        local mendPet = highestrank(136)

        -- END SPELLS --

        -- HEALING --

        -- Mend Pet
        if not UnitIsDeadOrGhost("pet") and IsPetActive() then
            if health("pet") < 50 and not buff(mendPet, "pet") and castable(mendPet, "pet") then
                return cast(mendPet, "pet")
            end
        end

        -- END HEALING --

        -- ATTACK START --

        if not melee() and castable(autoShot, "target") and not IsAutoRepeatSpell(autoShot) then
            return cast(autoShot, "target")
        end

        if melee() and not IsPlayerAttacking("target") then
            Eval("StartAttack()", "t")
        end

        if not UnitIsDeadOrGhost("pet") and IsPetActive() then
            Eval("PetAttack()", "t")
        end

        -- END ATTACK START --

        -- Rotation --

        -- Concussive Shot
        if moving("target") and not melee() and UnitIsUnit("player", "targettarget") and castable(concussiveShot, 'target') then
            return cast(concussiveShot, "target")
        end

        -- END ROTATION --
    end

    -- RESTING --
    local function do_resting()
        if UnitIsDeadOrGhost(player) or UnitIsDeadOrGhost(target) then
            return
        end

        -- SETTINGS --


        -- END SETTINGS --

        -- SPELLS --

        local aspectViper = highestrank(34074)
        local aspectHawk = highestrank(13165)

        local mendPet = highestrank(136)
        local revivePet = highestrank(982)
        local callPet = highestrank(883)

        -- END SPELLS --

        -- PET --

        -- Revive Pet
        if UnitIsDeadOrGhost("pet") and castable(revivePet) then
            return cast(revivePet, player)
        end

        -- Call Pet
        if not IsPetActive() then
            return cast(callPet, player)
        end

        -- END PET --

        -- HEALING --

        -- Mend Pet
        if not UnitIsDeadOrGhost("pet") and IsPetActive() then
            if health("pet") < 90 and not buff(mendPet, "pet") and castable(mendPet, "pet") then
                return cast(mendPet, "pet")
            end
        end

        -- END HEALING --

        -- BUFFS --

        -- Aspect
        if castable(aspectViper) and not buff(aspectViper, player) then
            return cast(aspectViper, player)
        end

        -- END BUFFS --

        -- Pet Attack
        if UnitExists(target) and alive(target) and distance(player, target) <= math.random(20, 40) then
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

end, Routine.Classes.Hunter, "bapes-bm")
Routine:LoadRoutine("bapes-bm")

local bapesBM_settings = {
    key = "bapes_bm_config",
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
            text = name " " .. version
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

UI.build_rotation_gui(bapesBM_settings)

local bapesBM_buttons = {
}

UI.button_factory(bapesBM_buttons)