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

local function RunTimeHandle(event)
   if event.phase == "ended" then
      composer.gotoScene("src.Scenes.Scene1", {effect = "fade", time = 500})
   end
end

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

   -- Set up Runtime Listener
   --bg:addEventListener("touch", RunTimeHandle)
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then

      -- Absorb Dots Handler
      AbsorbDot.Absorb(covidDots, absorbApproved, 25)

      -- Get Absorb Approve
      absorbApproved = composer.getVariable("AbsorbApproved");

      -- Remove
      --bg:removeEventListener("touch", RunTimeHandle)
   elseif ( phase == "did" ) then
      for _,dot in ipairs(covidDots) do
         if dot.ChildDot == false then
            dot.isVisible = true
         end
      end

      -- Menu
      menu = MenuSceneTwo.new(sceneGroup, covidDots, absorbApproved)

      -- Set up Runtime Listener
      --bg:addEventListener("touch", RunTimeHandle)
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

      for _,dot in ipairs(covidDots) do
         dot:Reset()
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