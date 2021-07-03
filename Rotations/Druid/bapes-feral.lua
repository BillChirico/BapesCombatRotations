-- Created By Bapes#1111 --
-- Plesae do not distrubute without concent --

local Tinkr = ...
local Routine = Tinkr.Routine
local AceGUI = Tinkr.Util.AceGUI
local Config = Tinkr.Util.Config
local config = Config:New('bapes-feral')
local HTTP = Tinkr.Util.HTTP
local player = "player"
local target = "target"
local authenticated = false

-- AUTH --

local function do_auth()
    local url = 'https://avaliddomain.getgud.cc'

    local body = '{"license":"'.. config:Read('license', '') ..'", "lock":"bapesTest"}'
    local headers = {
        "Content-type: application/json"
    }

    HTTP:POST(url, body, headers, function(status, buffer)
        if (status == 200) then
            authenticated = true
            print('|cFFFFD700[Bapes Scripts]|cFF00FF00 You are authenticated to use Bapes Feral Rotation! Enjoy and please send feedback / support requests to Bapes#1111 on Discord')
        else
            authenticated = false
            print('|cFFFFD700[Bapes Scripts]|cFFFF0000 Ut oh! You do not have access to this script, please purchase it before continuing and make sure you have entered the license correctly. For support DM Bapes#1111 on Discord |cFF00FF00')
        end
    end)
end

do_auth()

-- END AUTH --

-- UI --

local function DrawUI()
    local frame = AceGUI:Create("Window")
    frame:SetTitle("Bapes Feral Rotation")
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
    license:SetText(config:Read('license', 'Input license here'))
    license:SetCallback("OnTextChanged", function(self, event, text)
        config:Write('license', text)
    end)
    license:SetCallback("OnEnterPressed", function(self, event, text)
        do_auth()
    end)

    buttonGroup:AddChild(license)

    frame:AddChild(buttonGroup)
end

DrawUI()

-- END UI --

Routine:RegisterRoutine(function()
    -- Check to make sure the user is authenticated
    if not authenticated then
        return
    end

    if gcd() > latency() then return end

    if not latencyCheck() then return end

    if mounted() then return end

    -- COMBAT --
    local function do_combat()
        local mana = power()
        local comboPoints = GetComboPoints(player, target)

        -- SPELLS --

        local barkSkin = highestrank(22812)
        local regrowth = highestrank(8936)
        local rejuvenation = highestrank(774)

        local innervate = highestrank(29166)
        local faerieFire = highestrank(16857)

        local rake = highestrank(1822)
        local mangle = highestrank(33876)
        local rip = highestrank(1079)
        local ferociousBite = highestrank(22568)
        local shred = highestrank(5221)

        -- END SPELLS --

        -- Auto Attack
        if UnitExists(target) and not UnitIsDeadOrGhost(target) and enemy(target) then
            Eval('StartAttack()', 't')
        end

        -- HEALING --

        if health() <= 40 and castable(barkSkin) then
            return cast(barkSkin, player)
        end

        if health() <= 40 and castable(rejuvenation) and not buff(rejuvenation, player) then
            return cast(rejuvenation, player)
        end

        if health() <= 40 and castable(regrowth) then
            return cast(regrowth, player)
        end

        -- END HEALING --

        -- BUFFS --

        if mana <= 45 and castable(innervate) then
            return cast(innervate, player)
        end

        -- Feral Cat Form
        if not buff(768) and castable(768) then
            return cast(768)
        end

        -- END BUFFS --

        -- DEBUFFS --

        if not debuff(faerieFire, target) then
            return cast(faerieFire, target)
        end

        -- END DEBUFFS --

        -- ROTATION --

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

        -- END ROTATION --

    end

    -- RESTING --
    local function do_resting()
        if UnitIsDeadOrGhost(player) or UnitIsDeadOrGhost(target) then
            return
        end

        -- SPELLS --

        local motw = highestrank(1126)
        local thorns = highestrank(467)
        local omenOfClarity = highestrank(16864)

        local stealth = highestrank(5215)
        local dash = highestrank(1850)
        local pounce = highestrank(9005)

        -- END SPELLS --

        -- BUFFS --
        
        -- MOTW
        if castable(motw) and not buff(motw, player) then
            return cast(motw, player)
        end

        -- Thorns
        if castable(thorns) and not buff(thorns, player) then
            return cast(thorns, player)
        end

        -- Omen of Clarity
        if castable(omenOfClarity) and not buff(omenOfClarity, player) then
            return cast(omenOfClarity, player)
        end

        -- END BUFFS --

        -- Feral Cat Form
        if UnitExists(target) and alive(target) and not buff(768) and castable(768) and distance(player, target) <= math.random(30, 40) then
            return cast(768)
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

end, Routine.Classes.Druid, 'bapes-feral')
Routine:LoadRoutine('bapes-feral')