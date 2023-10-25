--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- Scene1.lua
--***********************************************************************************************

-- Requirements
local composer = require("composer")
local scene = composer.newScene()

-- Modules
local menuButton = require("src.UserInterface.MenuButtons")  
local LoadData = require("src.LoadData")

-- Variables
local covidDots = {}
local data = nil
local covidDotsGroup = nil
local sceneSwitch = nil
local sceenSwitchText = nil
local createMenuButton = nil

-- "scene:create()"
function scene:create( event )
   local sceneGroup = self.view
   
   -- Load Data
   data = LoadData.new()
   covidDotsGroup = data.getGroup()
   covidDots = data.CreateDots(composer.getVariable("PopupGroup"), composer.getVariable("Popup"))

   -- Set composer variables
   composer.setVariable("covidDots", covidDots)
   composer.setVariable( "PopupGroup",  data.GetPopupGroup())

   -- Create Menu
   createMenuButton = menuButton.new()
   createMenuButton.setCovidDots(covidDots)
   
   -- Scene Switch
   sceneSwitch = display.newRect( sceneGroup, 700, 50, 75, 75)
   sceneSwitch:setFillColor(1, 0.6, 0)
   sceneSwitch:addEventListener("tap", function() 
      composer.gotoScene("src.Scenes.Scene2", {effect = "fade", time = 500}) 
   end)

   -- Scene Switch Text
   sceenSwitchText = display.newText(sceneGroup, "Scene 2", 700, 50, native.systemFont, 20)
   sceenSwitchText:setFillColor(0, 0, 0)
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   elseif ( phase == "did" ) then
      if createMenuButton ~= nil then
         createMenuButton.SetVisible(true)
      end
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then

      if createMenuButton ~= nil then
         createMenuButton.SetVisible(false)
      end

   elseif ( phase == "did" ) then
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene