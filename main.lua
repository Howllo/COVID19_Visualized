--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- main.lua
--***********************************************************************************************

-- Requirements
local composer = require( "composer" )
local CovidInformationPopup = require("src.UserInterface.CovidInformationPopup")

-- Variables
local popup = CovidInformationPopup.new()
local popupGroup = popup.getGroup()
popupGroup.isVisible = false

-- Hide the Status Bar
display.setStatusBar(display.HiddenStatusBar)

-- Go to Scene 1
composer.setVariable("PopupGroup", popupGroup)
composer.setVariable("Popup", popup)
composer.gotoScene("src.Scenes.Scene1", {effect = "fade", time = 500})