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
local createMenuButton = nil

-- Sets covid dots table array.
function scene:SetCovidDots(dots)
   return covidDots
end

-- Returns covid dots table array.
function scene:GetCovidDots()
   return covidDots
end

-- "scene:create()"
function scene:create( event )
   local sceneGroup = self.view
   
   -- Load Data
   data = LoadData.new()
   covidDotsGroup = data.getGroup()
   covidDots = data.CreateDots()

   -- Set composer variables
   composer.setVariable("covidDots", covidDots)
   composer.setVariable( "PopupGroup",  data.GetPopupGroup())

   -- Create Menu
   createMenuButton = menuButton.new()
   createMenuButton:setCovidDots(covidDots)
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   elseif ( phase == "did" ) then
      if createMenuButton ~= nil then
         createMenuButton:SetVisible(true)
      end
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then

      if createMenuButton ~= nil then
         createMenuButton:SetVisible(false)
      end

      -- Waste of Time
      if createMenuButton ~= nil then
         composer.setVariable("AbsorbApproved", createMenuButton:GetAbsorbApproved())
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