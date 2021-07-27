-- Created By Bapes#1111 --
-- Please do not distrubute without consent --

local name = "Bapes Bear Rotation"
local version = "v1.0"
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

-- Print name and version
print("|cFFFFD700[Bapes Scripts]|CFF959697 " .. name .. " " .. version)

-- UI --

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

        local bearForm = highestrank(5487)

        -- Dire Bear
        if not bearForm then
            bearForm = highestrank(9634)
        end

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
        if not buff(bearForm) and castable(bearForm) then
            return cast(bearForm)
        end

        -- END BUFFS --

        -- HEALING --

        -- Frenzied Regeneration
        if health() <= 35 and castable(frenziedRegeneration) then
            return cast(frenziedRegeneration, player)
        end

        -- Frenzied Regeneration is still going so don't use abilities
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
        
        local omenOfClarity = highestrank(16864)

        local feralCharge = highestrank(16979)

        -- MOTW Ranks
        local motwRanks = {
            21849,
            21850,
            26991,
            1126,
            5232,
            8907,
            9884,
            9885,
            26990
        }

        -- Thorns Ranks
        local thornsRanks = {
            467,
            782,
            1075,
            8914,
            9756,
            9910,
            26992
        }

        -- END SPELLS --

        -- BUFFS --

        -- MOTW (Check for GOTW & all ranks)
        if castable(MarkOfTheWild, player) and not buff(MarkOfTheWild, player) and not buff(GiftOfTheWild, player) then
            for _, motwRank in pairs(motwRanks) do
                if buff(motwRank, player) then
                    break
                end
            end

            return cast(MarkOfTheWild, player)
        end

        -- Thorns (Check for all ranks)
        if castable(Thorns, player) and not buff(Thorns, player) then
            for _, thornRank in pairs(thornsRanks) do
                if buff(thornRank, player) then
                    break
                end
            end

            return cast(Thorns, player)
        end

        -- Omen of Clarity
        if castable(omenOfClarity) and not buff(omenOfClarity, player) then
            return cast(omenOfClarity, player)
        end

        -- END BUFFS --

        -- Bear Form
        if UnitExists(target) and alive(target) and not buff(5487) and castable(5487) and distance(player, target) <= math.random(25, 40) then
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