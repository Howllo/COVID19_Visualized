--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- main.lua
--***********************************************************************************************

-- Requirements
local composer = require( "composer" )

-- Hide the Status Bar
display.setStatusBar(display.HiddenStatusBar)

-- Go to Scene 1
composer.gotoScene("src.Scenes.Scene1", {effect = "fade", time = 500})