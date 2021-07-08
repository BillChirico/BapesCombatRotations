-- Created By Bapes#1111 --
-- Please do not distrubute without concent --

local name = "Bapes Feral Rotation"
local version = "v1.1"
local Tinkr = ...
local Routine = Tinkr.Routine
local AceGUI = Tinkr.Util.AceGUI
local Config = Tinkr.Util.Config
local config = Config:New("bapes-feral")
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
        local comboPoints = GetComboPoints(player, target)
        local rage = power(PowerType.Rage)

        -- SETTINGS --

        local healInCombat = UI.config.read('healInCombat', 'true')
        local healPercentage = UI.config.read('healPercentage', 40)

        local useInnervate = UI.config.read('useInnervate', 'false')

        local useBearForm = UI.config.read('useBearForm', 'true')
        local bearFormPercentage = UI.config.read('bearFormPercentage', 50)

        -- END SETTINGS --

        -- SPELLS --

        local catForm = highestrank(768)
        local bearForm = highestrank(5487)

        -- Dire Bear
        if not bearForm then
            bearForm = highestrank(9634)
        end

        local barkSkin = highestrank(22812)
        local regrowth = highestrank(8936)
        local rejuvenation = highestrank(774)

        local innervate = highestrank(29166)
        local faerieFire = highestrank(16857)

        -- Cat
        local rake = highestrank(1822)
        local mangle = highestrank(33876)
        local rip = highestrank(1079)
        local ferociousBite = highestrank(22568)
        local shred = highestrank(5221)

        -- Bear
        local frenziedRegeneration = highestrank(22842)
        local lacerate = highestrank(33745)
        local maul = highestrank(6807)
        local bearMangle = highestrank(33878)

        -- END SPELLS --

        -- Auto Attack
        if UnitExists(target) and not UnitIsDeadOrGhost(target) and enemy(target) then
            Eval('StartAttack()', 't')
        end

        -- HEALING --

        if healInCombat and not buff(frenziedRegeneration) then
            if health() <= healPercentage and castable(barkSkin) then
                return cast(barkSkin, player)
            end

            if health() <= healPercentage and castable(rejuvenation) and not buff(rejuvenation, player) then
                return cast(rejuvenation, player)
            end

            if health() <= healPercentage and castable(regrowth) and not buff(regrowth, player) then
                return cast(regrowth, player)
            end
        end

        -- END HEALING --

        -- BUFFS --

        if mana <= 45 and castable(innervate) and useInnervate then
            return cast(innervate, player)
        end

        -- Bear Form
        if useBearForm and health() <= bearFormPercentage and not buff(bearForm) and castable(bearForm) then
            return cast(bearForm)
        else
            -- Cat Form
            if not buff(catForm) and castable(catForm) and not buff(bearForm) then
                return cast(catForm)
            end
        end

        -- END BUFFS --

        -- DEBUFFS --

        if not debuff(faerieFire, target) then
            return cast(faerieFire, target)
        end

        -- END DEBUFFS --

        -- CAT ROTATION --

        if buff(catForm) then
            -- Rake
            if not debuff(rake, target) and comboPoints < 5 and castable(rake) then
                return cast(rake, target)
            end

            -- Mangle Spam
            if comboPoints < 5 and castable(mangle, target)then
                return cast(mangle, target)
            end

            -- Rip
            if health(target) >= 40 and comboPoints >= 4 and castable(rip, target)  then
                return cast(rip, target)
            -- Ferocious Bite
            else if comboPoints >= 5 and castable(ferociousBite, target) then
                    return cast(ferociousBite, target)
                end
            end

            -- Shred with Clearcasting
            if castable(shred, target) and buff(16870, player) then
                return cast(shred, target)
            end
        end

        -- END CAT ROTATION --

        -- BEAR ROTATION --

        if buff(bearForm) then
            -- Frenzied Regeneration
            if health() <= 35 and castable(frenziedRegeneration) then
                return cast(frenziedRegeneration, player)
            end

            -- Frenzied Regeneration is still going so don't use abilities
            if buff(frenziedRegeneration) then
                return
            end

            if rage < 75 then
                -- Lacerate
                if castable(lacerate, target) then
                    return cast(lacerate, target)
                end
            else
                -- Maul
                if castable(maul, target) then
                    return cast(maul, target)
                end
            end
    
            -- Mangle Spam
            if castable(bearMangle, target) then
                return cast(bearMangle, target)
            end
        end

        -- END BEAR ROTATION --

    end

    -- RESTING --
    local function do_resting()
        if UnitIsDeadOrGhost(player) or UnitIsDeadOrGhost(target) then
            return
        end

        -- SETTINGS --

        local healOutOfCombat = UI.config.read('healOutOfCombat', 'true')

        -- END SETTINGS --

        -- SPELLS --

        local catForm = highestrank(768)

        local regrowth = highestrank(8936)
        local rejuvenation = highestrank(774)
        local healingTouch = highestrank(5185)

        local motw = highestrank(1126)
        local thorns = highestrank(467)
        local omenOfClarity = highestrank(16864)

        local stealth = highestrank(5215)
        local dash = highestrank(1850)
        local pounce = highestrank(9005)

        -- END SPELLS --

        -- HEALING --

        if healOutOfCombat then
            if health() <= 60 and castable(rejuvenation) and not buff(rejuvenation, player) then
                return cast(rejuvenation, player)
            end

            if health() <= 60 and castable(regrowth) and not buff(regrowth, player) then
                return cast(regrowth, player)
            end

            if health() <= 60 and castable(healingTouch) and not buff(healingTouch, player) then
                return cast(healingTouch, player)
            end
        end

        -- END HEALING --

        -- BUFFS --

        -- MOTW (Check for GOTW)
        if castable(motw) and not buff(motw, player) and not buff(21849, player) and not buff(21850, player) and not buff(26991, player) then
            return cast(motw, player)
        end

        -- Thorns (Check for all ranks)
        if castable(thorns) and not buff(thorns, player) and not buff(467, player) and not buff(782, player) and not buff(1075, player) and not buff(8914, player) and not buff(9756, player) and not buff(9910, player) and not buff(26992, player) then
            return cast(thorns, player)
        end

        -- Omen of Clarity
        if castable(omenOfClarity) and not buff(omenOfClarity, player) then
            return cast(omenOfClarity, player)
        end

        -- END BUFFS --

        -- Cat Form
        if UnitExists(target) and alive(target) and not buff(catForm) and castable(catForm) and distance(player, target) <= math.random(25, 40) then
            return cast(catForm)
        end

        -- Stealth
        if UnitExists(target) and alive(target) and not buff(stealth, player) and castable(stealth) and distance(player, target) <= 15 then
            return cast(stealth)
        end

        -- Dash
        if not buff(dash) and castable(dash) then
            return cast(dash)
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

end, Routine.Classes.Druid, "bapes-feral")
Routine:LoadRoutine("bapes-feral")

local bapesFeral_settings = {
    key = "bapes_feral_config",
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

UI.build_rotation_gui(bapesFeral_settings)

local bapesFeral_buttons = {
}

UI.button_factory(bapesFeral_buttons)