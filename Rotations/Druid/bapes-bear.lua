-- Created By Bapes#1111 --
-- Please do not distrubute without concent --

local Tinkr = ...
local Routine = Tinkr.Routine
local AceGUI = Tinkr.Util.AceGUI
local Config = Tinkr.Util.Config
local config = Config:New("bapes-bear")
local HTTP = Tinkr.Util.HTTP
local player = "player"
local target = "target"
local authenticated = false

-- AUTH --

local function do_auth()
    local url = "https://avaliddomain.getgud.cc"

    local body = '{"license":"'.. config:Read('license', '') ..'", "lock":"bapesBear"}'
    local headers = {
        "Content-type: application/json"
    }

    HTTP:POST(url, body, headers, function(status, buffer)
        if (status == 200) then
            authenticated = true
            print("|cFFFFD700[Bapes Scripts]|cFF00FF00 You are authenticated to use Bapes Bear Rotation! Enjoy and please send feedback / support requests to Bapes#1111 on Discord")
        else
            authenticated = false
            print("|cFFFFD700[Bapes Scripts]|cFFFF0000 Ut oh! You do not have access to this script, please purchase it before continuing and make sure you have entered the license correctly. For support DM Bapes#1111 on Discord")
        end
    end)
end

do_auth()

-- END AUTH --

-- UI --

local function DrawUI()
    local frame = AceGUI:Create("Window")
    frame:SetTitle("Bapes Bear Rotation")
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

-- END UI --

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
        local rage = power(PowerType.Rage)

        -- SPELLS --

        local frenziedRegeneration = highestrank(22842)

        local faerieFire = highestrank(16857)

        local feralCharge = highestrank(16979)
        local lacerate = highestrank(33745)
        local maul = highestrank(6807)
        local mangle = highestrank(33878)

        -- END SPELLS --

        -- Auto Attack
        if UnitExists(target) and not UnitIsDeadOrGhost(target) and enemy(target) then
            Eval('StartAttack()', 't')
        end

        -- BUFFS --

        -- Bear Form
        if not buff(9634) and castable(9634) then
            return cast(9634)
        else
            if not buff(5487) and castable(5487) then
                return cast(5487)
            end
        end        

        -- END BUFFS --

        -- HEALING --

        -- Frenzied Regeneration
        if health() <= 35 and castable(frenziedRegeneration) then
            return cast(frenziedRegeneration, player)
        end

        -- Frenzied Regeneration is still going to don't use abilities
        if buff(frenziedRegeneration) then
            return
        end

        -- END HEALING --

        -- DEBUFFS --

        if not debuff(faerieFire, target) then
            return cast(faerieFire, target)
        end

        -- END DEBUFFS --

        -- ROTATION --

        -- Feral Charge
        if UnitExists(target) and spellInRange(feralCharge) and castable(feralCharge) then
            return cast(feralCharge, target)
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
        if castable(mangle, target) then
            return cast(mangle, target)
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

        local feralCharge = highestrank(16979)

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

        -- Bear Form
        if UnitExists(target) and alive(target) and not buff(5487) and castable(5487) and distance(player, target) <= math.random(30, 40) then
            return cast(5487)
        end

        -- Feral Charge
        if UnitExists(target) and spellInRange(feralCharge) and castable(feralCharge) then
            return cast(feralCharge, target)
        end
    end

    if combat(player) then
        do_combat()
        return
    else
        do_resting()
        return
    end

end, Routine.Classes.Druid, "bapes-bear")
Routine:LoadRoutine("bapes-bear")