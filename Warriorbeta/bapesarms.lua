-- Created By Bapes#1111 --
-- Please do not distrubute without consent --

local name = "Bapes Arms Rotation"
local version = "v1.0-beta"
local Tinkr = ...
local Routine = Tinkr.Routine
local player = "player"
local target = "target"

-- Print name and version
print("|cFFFFD700[Bapes Scripts]|cFF8A2BE2 " .. name .. " " .. version)

Routine:RegisterRoutine(function()
    if gcd() > latency() then
      return
    end

    if not latencyCheck() then
      return
    end

    -- COMBAT --
    local function do_combat()
      -- SETTINGS --

      -- END SETTINGS --

      -- SPELLS --

      local attack = highestrank(88163)
      local battleShout = highestrank(6673)

      local bloodrage = highestrank(2687)

      local deathWish = highestrank(12292)
      local recklessness = highestrank(1719)
      local sweepingStrikes = highestrank(12328)

      local execute = highestrank(5308)
      local mortalStrike = highestrank(12294)
      local slam = highestrank(1464)

      -- END SPELLS --

      -- Auto Attack
      if UnitExists(target) and not UnitIsDeadOrGhost(target) and enemy(target) then
        Eval("StartAttack()", "t")
      end

      -- HEALING --

      -- END HEALING --

      -- BUFFS --

      if enemies(target, 10) >= 2 then
        if castable(sweepingStrikes, player) then
          return cast(sweepingStrikes, player)
        end
      end

      if not buff(bloodrage, player) and castable(bloodrage, player) then
        return cast(bloodrage, player)
      end

      if not buff(deathWish, player) and castable(deathWish, player) then
        return cast(deathWish, player)
      end

      if not buff(recklessness, player) and castable(recklessness, player) then
        return cast(recklessness, player)
      end

      if not buff(battleShout, player) and castable(battleShout, player) then
        return cast(battleShout, player)
      end

      -- END BUFFS --

      -- DEBUFFS --

      -- END DEBUFFS --

      -- ROTATION --

      -- Execute
      if health(target) < 20 and castable(execute, target) then
        return cast(execute, target)
      end

      -- Slam into Mortal Strike
      if spellisspell(lastspell(), slam) then
        return cast(mortalStrike, target)
      end

      -- Attack into Slam
      if spellisspell(lastspell(), attack) then
        return cast(slam, target)
      end

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

      local battleShout = highestrank(6673)

      -- END SPELLS --

      -- HEALING --

      -- END HEALING --

      -- BUFFS --

      if not buff(battleShout, player) and castable(battleShout, player) then
        return cast(battleShout, player)
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

  end, Routine.Classes.Warrior, "bapes-arms")
  Routine:LoadRoutine("bapes-arms")

  local bapesArms_settings = {
    key = "bapes_arms_config_config",
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
        }
    }
}

UI.build_rotation_gui(bapesArms_settings)

local bapesArms_buttons = {}

UI.button_factory(bapesArms_buttons)
