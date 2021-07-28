-- Created By Bapes#1111 --
-- Please do not distrubute without consent --

local name = "Bapes TODO Rotation"
local version = "v1.0"
local Tinkr = ...
local Routine = Tinkr.Routine
local UI = {}
local player = "player"
local target = "target"

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
Tinkr:require("scripts.wowex.libs.AceAddon30.AceAddon30", UI)
Tinkr:require("scripts.wowex.libs.AceConsole30.AceConsole30", UI)
Tinkr:require("scripts.wowex.libs.AceDB30.AceDB30", UI)
Tinkr:require("scripts.cromulon.system.storage", UI)
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
