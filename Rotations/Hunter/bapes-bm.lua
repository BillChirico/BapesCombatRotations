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

    -- COMBAT --
    local function do_combat()
        local mana = power()

        -- SETTINGS --

        local mendPetInCombat = UI.config.read("mendPetInCombat", "true")
        local mendPetPercentage = UI.config.read("mendPetPercentage", 50)
        local useTraps = UI.config.read("useTraps", "true")

        -- END SETTINGS --

        -- SPELLS --

        local autoShot = highestrank(75)
        local huntersMark = highestrank(1130)
        local concussiveShot = highestrank(5116)
        local snakeTrap = highestrank(34600)
        local explosiveTrap = highestrank(13813)
        local misdirection = highestrank(34477)

        local raptorStrike = highestrank(32915)
        local mongooseBite = highestrank(1495)
        local steadyShot = highestrank(34120)
        local killCommand = highestrank(34026)
        local multiShot = highestrank(2643)

        local rapidFire = highestrank(36828)
        local intimidation = highestrank(19577)
        local bestialWrath = highestrank(19574)

        local mendPet = highestrank(136)

        -- END SPELLS --

        -- HEALING --

        -- Mend Pet
        if mendPetInCombat and not UnitIsDeadOrGhost(pet) and IsPetActive() then
            if health(pet) <= mendPetPercentage and not buff(mendPet, pet) and castable(mendPet, pet) then
                return cast(mendPet, pet)
            end
        end

        -- END HEALING --

        -- BUFFS --

        -- Bestial Wrath
        if health(target) > 50 and castable(bestialWrath, player) and not buff(bestialWrath, player) then
            return cast(bestialWrath, player)
        end

        -- Intimidation
        if health(target) > 30 and castable(intimidation, target) then
            return cast(intimidation, target)
        end

        -- Rapid Fire
        if health(target) > 50 and castable(rapidFire, player) and not buff(rapidFire, player) then
            return cast(rapidFire, player)
        end

        -- END BUFFS --

        -- ATTACK START --

        if not melee() and castable(autoShot, target) and not IsAutoRepeatSpell(autoShot) then
            return cast(autoShot, target)
        end

        if melee() and not IsPlayerAttacking(target) then
            Eval("StartAttack()", "t")
        end

        if not UnitIsDeadOrGhost(pet) and IsPetActive() then
            Eval("PetAttack()", "t")
        end

        -- END ATTACK START --

        -- Rotation --

        -- Hunter's Mark
        if not immune(target, huntersMark) and castable(huntersMark, target) and not debuff(huntersMark, target) then
            return cast(huntersMark, target)
        end

        -- Concussive Shot
        if moving(target) and not melee() and UnitIsUnit(player, "targettarget") and castable(concussiveShot, target) then
            return cast(concussiveShot, target)
        end

        -- Traps
        if useTraps and melee() then
            if enemies(target, 20) >= 2 then
                if castable(explosiveTrap, target) then
                    return cast(explosiveTrap, target)
                end
            else
                if castable(snakeTrap, target) then
                    return cast(snakeTrap, target)
                end
            end
        end

        -- Misdirection
        if UnitIsUnit(player, "targettarget") and castable(misdirection, pet) then
            return cast(misdirection, pet)
        end

        -- Kill Command
        if castable(killCommand, target) then
            return cast(killCommand, target)
        end

        -- Multi Shot
        if enemies(target, 20) >= 2 and castable(multiShot, target) then
            return cast(multiShot, target)
        end

        -- Steady Shot
        if (spellisspell(lastspell(), autoShot) or not spellisspell(lastspell(), steadyShot)) and castable(steadyShot, target) then
            return cast(steadyShot, target)
        end

        -- Mongoose Bite
        if castable(mongooseBite, target) then
            return cast(mongooseBite, target)
        end

        -- Raptor Strike
        if castable(raptorStrike, target) then
            return cast(raptorStrike, target)
        end

        -- END ROTATION --
    end

    -- RESTING --
    local function do_resting()
        if UnitIsDeadOrGhost(player) or UnitIsDeadOrGhost(target) or IsEatingOrDrinking() then
            return
        end

        -- SETTINGS --

        local aspect = UI.config.read("aspect", "Viper")

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
        if UnitIsDeadOrGhost(pet) and castable(revivePet) then
            return cast(revivePet, player)
        end

        -- Call Pet
        if not IsPetActive() and castable(callPet, player) then
            return cast(callPet, player)
        end

        -- END PET --

        -- HEALING --

        -- Mend Pet
        if not UnitIsDeadOrGhost(pet) and IsPetActive() then
            if health(pet) < 90 and not buff(mendPet, pet) and castable(mendPet, pet) then
                return cast(mendPet, pet)
            end
        end

        -- END HEALING --

        -- BUFFS --

        -- Aspect
        if aspect == "Viper" and castable(aspectViper) and not buff(aspectViper, player) then
            return cast(aspectViper, player)
        else
            if aspect == "Hawk" and castable(aspectHawk) and not buff(aspectHawk, player) then
                return cast(aspectHawk, player)
            end
        end

        -- END BUFFS --

        -- Pet Attack
        if UnitExists(target) and alive(target) and distance(player, target) <= math.random(35, 45) then
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
        -- Mend Pet in Combat
        {
            key = "mendPetInCombat",
            type = "checkbox",
            text = "Mend Pet in Combat"
        },
        -- Mend Pet Percentage
        {
            key = "mendPetPercentage",
            type = "slider",
            text = "Mend Pet Percentage",
            label = "Mend Pet %",
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
        -- Aspect
        {
            key = "aspect",
            -- width = 130,
            label = "Aspect",
            type = "dropdown",
            options = {"Viper", "Hawk"}
        },
        -- Combat Options --
        {
            key = "heading",
            type = "heading",
            text = "Combat Options"
        },
        -- Use Traps
        {
            key = "useTraps",
            type = "checkbox",
            text = "Use Traps"
        }
    }
}

UI.build_rotation_gui(bapesBM_settings)

local bapesBM_buttons = {
}

UI.button_factory(bapesBM_buttons)