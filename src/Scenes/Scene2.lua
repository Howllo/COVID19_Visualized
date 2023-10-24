--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- Scene2.lua
--***********************************************************************************************

-- Requirements
local composer = require("composer")
local scene = composer.newScene()
local MenuSceneTwo = require("src.UserInterface.MenuSceneTwo")
 
-- Variables
local dataLocation = "data\\new_covid_al.csv"
local path = system.pathForFile( dataLocation, system.ResourceDirectory )
local covidDots = {}
local covidDots = {}
local bg = nil
local menu = nil
local popupGroup = nil

-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   -- Set popup group variable
   popupGroup = composer.getVariable("PopupGroup")

   -- Set Covid Dots
   covidDots = composer.getVariable("covidDots")

   -- Alabama Background
   bg = display.newImage (sceneGroup, "data/al_map.png", display.contentCenterX, display.contentCenterY);
   bg.xScale = display.contentWidth / bg.width; 
   bg.yScale = display.contentHeight / bg.height;
   
   -- Menu
   menu = MenuSceneTwo.new(sceneGroup, covidDots)

   -- Set Dots Visible
   for _,dot in ipairs(covidDots) do
      dot.isVisible = true
   end
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.

      for _,dot in ipairs(covidDots) do
         dot.isVisible = true
      end
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      for _,dot in ipairs(covidDots) do
         dot.isVisible = false
      end

      popupGroup.isVisible = false
   elseif ( phase == "did" ) then
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene