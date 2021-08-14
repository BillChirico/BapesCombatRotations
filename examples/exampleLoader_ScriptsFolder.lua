-- Created By Bapes#1111 --
-- Please do not distrubute without consent --

---@diagnostic disable: undefined-global, lowercase-global
local Tinkr = ...
local Routine = Tinkr.Routine
local AceGUI = Tinkr.Util.AceGUI
local Config = Tinkr.Util.Config
local config = Config:New("demo")
local HTTP = Tinkr.Util.HTTP
local wowex = {}
local player = "player"
local target = "target"
local pet = "pet"
local authenticated = false
local name = "Demo Rotation"
local version = "v1.0-beta"
-- CROMULON --

Tinkr:require("scripts.cromulon.libs.Libdraw.Libs.LibStub.LibStub", wowex)
Tinkr:require("scripts.cromulon.libs.Libdraw.LibDraw", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.AceGUI30", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-BlizOptionsGroup", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-DropDownGroup", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-Frame", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-InlineGroup", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-ScrollFrame", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-SimpleGroup", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-TabGroup", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-TreeGroup", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-Window", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Button", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-CheckBox", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-ColorPicker", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-DropDown", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-DropDown-Items", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-EditBox", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Heading", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Icon", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-InteractiveLabel", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Keybinding", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Label", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-MultiLineEditBox", wowex)
Tinkr:require("scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Slider", wowex)
Tinkr:require("scripts.cromulon.system.configs", wowex)
Tinkr:require('scripts.wowex.libs.AceAddon30.AceAddon30' , wowex)
Tinkr:require('scripts.wowex.libs.AceConsole30.AceConsole30' , wowex)
Tinkr:require('scripts.wowex.libs.AceDB30.AceDB30' , wowex)
Tinkr:require('scripts.cromulon.system.storage' , wowex)
Tinkr:require("scripts.cromulon.libs.libCh0tFqRg.libCh0tFqRg", wowex)
Tinkr:require("scripts.cromulon.libs.libNekSv2Ip.libNekSv2Ip", wowex)
Tinkr:require("scripts.cromulon.libs.CallbackHandler10.CallbackHandler10", wowex)
Tinkr:require("scripts.cromulon.libs.HereBeDragons.HereBeDragons-20", wowex)
Tinkr:require("scripts.cromulon.libs.HereBeDragons.HereBeDragons-pins-20", wowex)
Tinkr:require("scripts.cromulon.interface.uibuilder", wowex)
Tinkr:require("scripts.cromulon.interface.buttons", wowex)
Tinkr:require("scripts.cromulon.interface.panels", wowex)
Tinkr:require('scripts.cromulon.interface.minimap' , wowex)
mybuttons.On = false
mybuttons.Cooldowns = false
mybuttons.MultiTarget = false
mybuttons.Interupts = false
mybuttons.Settings = false

