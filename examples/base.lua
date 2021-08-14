-- Created By Bapes#1111 --
-- Please do not distrubute without consent --

local Tinkr, UI = ...
local name = "Bapes TODO Rotation"
local version = "v1.0"
local Routine = Tinkr.Routine
local player = "player"
local target = "target"

-- Bapes Dependencies --

Tinkr:require("scripts.cromulon.bapes.shared.imports.lua", UI)

-- Bapes Dependencies --

-- Print name and version
print("|cFFFFD700[Bapes Scripts]|cFF8A2BE2 " .. name .. " " .. version)

Routine:RegisterRoutine(
  function()
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

      -- END SPELLS --

      -- Auto Attack
      if UnitExists(target) and not UnitIsDeadOrGhost(target) and enemy(target) then
        Eval("StartAttack()", "t")
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
    end

    if combat(player) then
      do_combat()
      return
    else
      do_resting()
      return
    end
  end,
  Routine.Classes.TODO,
  "bapes-TODO"
)
Routine:LoadRoutine("bapes-TODO")

local bapesTODO_settings = {
  key = "bapes_TODO_config",
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
    }
  }
}

UI.build_rotation_gui(bapesTODO_settings)

local bapesTODO_buttons = {}

UI.button_factory(bapesTODO_buttons)
