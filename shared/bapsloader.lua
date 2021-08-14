-- Created By Bapes#1111 --
-- Please do not distrubute without consent --

---@diagnostic disable: undefined-global, lowercase-global
local Tinkr = ...
local UI = {}
local OM = Tinkr.Util.ObjectManager
local Common = Tinkr.Common
local Draw = Tinkr.Util.Draw:New()
local AceGUI = Tinkr.Util.AceGUI
local Config = Tinkr.Util.Config
local config = Config:New("bapes-feral")
local Util = Tinkr.Util
local Evaluator = Util.Evaluator

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
Tinkr:require("scripts.rotationloader", UI)
mybuttons.On = false
mybuttons.Cooldowns = false
mybuttons.MultiTarget = false
mybuttons.Interupts = false
mybuttons.Settings = false


local function DrawUI()
    local frame = AceGUI:Create("Window")
    frame:SetTitle('|cFFFF0000Tinkr Rotation Loader')
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
    license:SetLabel("|cFF00FF00Paste your Bapes Token")
    license:SetWidth(200)
    license:DisableButton(false)
    license:SetText(config:Read('license', 'Paste Bapes Token Here'))
    license:SetCallback("OnTextChanged", function(self, event, value)
        config:Write("license", value)
    end)
    license:SetCallback("OnEnterPressed", function(self, event, text)
        --  do_auth()
    end)
    
    buttonGroup:AddChild(license)
    
    
    local rotationlist = AceGUI:Create("Dropdown")
    rotationlist:SetValue( "None")
    rotationlist:SetList({'Feral Druid', 'BM Hunter', 'Destro Warlock','Demo Warlock', 'Beta - Bear Druid' })
    rotationlist:SetWidth(200)
    rotationlist:SetText('Rotation')
    rotationlist:SetLabel('|cFF00FF00Select Rotation')
    rotationlist:SetCallback(
    "OnValueChanged",
    function(widget, event, value)
        local rota = ""
        
        if value == 1 then rota = 'Druid'
        elseif value == 2 then rota = 'Hunter'
        elseif value == 3 then rota = 'DestroWarlock'
        elseif value == 4 then rota = 'DemoWarlock'
        elseif value == 5 then rota = 'Druidbeta'
        end
        print ('You have selected: ' .. rota)
        frame:Hide() 
        print ('Bapes', rota,config:Read('license', 'Paste Bapes Token Here') )
        UI.LoadRotation('Bapes', rota, config:Read('license', 'Paste Bapes Token Here'))
    end
    )
    buttonGroup:AddChild(rotationlist)
    frame:AddChild(buttonGroup)

end
DrawUI()