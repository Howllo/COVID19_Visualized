--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- Scene2.lua
--***********************************************************************************************

-- Requirements
local composer = require("composer")
local scene = composer.newScene()
local MenuSceneTwo = require("src.UserInterface.MenuSceneTwo")
local AbsorbDot = require("src.AbsorbDotAlgorithm")
 
-- Variables
local covidDots = {}
local bg = nil
local menu = nil
local popupGroup = nil
local absorbApproved = false
local doubleTouch = 0
local doubleTouchTimer = nil
local Absorb = nil

-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view

   -- Set popup group variable
   popupGroup = composer.getVariable("PopupGroup")

   -- Set Covid Dots
   covidDots = composer.getVariable("covidDots")
   
   -- Absorb
   Absorb = AbsorbDot.new(covidDots)

   -- Alabama Background
   bg = display.newImage (sceneGroup, "data/al_map.png", display.contentCenterX, display.contentCenterY);
   bg.xScale = display.contentWidth / bg.width; 
   bg.yScale = display.contentHeight / bg.height;
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then

      -- Absorb Dots Handler
      if Absorb ~= nil then
         Absorb:Absorb(absorbApproved, 25)
         Absorb:ResizeDot()
      end

      -- Get Absorb Approve
      absorbApproved = composer.getVariable("AbsorbApproved");
   elseif ( phase == "did" ) then  
      --Reset Dots for Scene
      for _,dot in ipairs(covidDots) do
         dot.isVisible = true
         dot.Absorb = absorbApproved
      end

      -- Menu
      menu = MenuSceneTwo.new(sceneGroup, covidDots, absorbApproved)
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Hide Popup menu when switching to scene oen.
      if popupGroup ~= nil then
         popupGroup.isVisible = false
      end

      -- Reset Menu
      if menu ~= nil then 
         menu:Destroy()
         menu = nil
      end

      -- Clean Dots for next Scene
      for _,dot in ipairs(covidDots) do
         dot:Reset()
      end

      -- Resize Dots for next Scene
      if Absorb ~= nil then
         Absorb:ResizeDot()
      end
   elseif ( phase == "did" ) then
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
   local sceneGroup = self.view
end

local function resetDoubleTouch()
   doubleTouch = 0
end

local function RunTimeHandle(event)
   if event.phase == "ended" then
      doubleTouch = doubleTouch + 1
      -- Slower than human reaction time, but fast enough to not be annoying.
      doubleTouchTimer = timer.performWithDelay(300, resetDoubleTouch)
      if doubleTouch == 2 then
         timer.cancel(doubleTouchTimer)
         composer.gotoScene("src.Scenes.Scene1", {effect = "fade", time = 500})
      end
   end
end

 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
Runtime:addEventListener("touch", RunTimeHandle)
 
---------------------------------------------------------------------------------
 
return scene