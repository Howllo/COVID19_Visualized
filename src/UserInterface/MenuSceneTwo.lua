--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- MenuSceneTwo.lua
--***********************************************************************************************

-- Module
Class = {}

-- Requirements
local widget = require("widget")
local composer = require("composer")

function Class.new(s_Group, covidDots)
    if s_Group == nil or covidDots == nil then
        print("Error: s_Group or covidDots is nil")
        return nil
    end

    Self = {}

    -- Variables
    local sliderBackground = nil
    local slider = nil
    local sliderText = nil
    local sceneSwitch = nil
    local UIText = nil
    local covidDots = covidDots
    local sceneGroup = s_Group

    local function sliderHandler(event)
        local value = event.value
        
        if covidDots[1].caseOrdeath == true then
            sliderText.text = "Selected: " .. value .. " cases."
        else 
            sliderText.text = "Selected: " .. value .. " deaths."
        end
    
        for _,dot in ipairs(covidDots) do
            dot.alpha = value / 100
        end
    end

    -- Slider Background
    sliderBackground = display.newRoundedRect(sceneGroup, 500, 1100, 450, 100, 12)
    sliderBackground:setFillColor(1, 0.6, 0)
    sliderBackground.alpha = 0.3

    -- Scene Switch
    sceneSwitch = display.newRect(sceneGroup, 700, 50, 75, 75)
    sceneSwitch:setFillColor(1, 0.6, 0)
    sceneSwitch:addEventListener("tap", function() composer.gotoScene("src.Scenes.Scene1", {effect = "fade", time = 500}) end)

    -- Scene Switch Text
    UIText = display.newText(sceneGroup, "Scene 1", 700, 50, native.systemFont, 20)
    UIText:setFillColor(0, 0, 0)
    
    -- Opacity Slider
    Self.slider = widget.newSlider(
        {
            x = 500,
            y = 1100,
            width = 400,
            value = 50,
            listener = sliderHandler
        }
    )

    sceneGroup:insert(Self.slider)

    -- Slider Text
    if slider ~= nil then
        sliderText = display.newText(sceneGroup, "Slider at " .. slider.value / 100, 500, 1130, native.systemFont, 25)
    else 
        sliderText = display.newText(sceneGroup, "Slider at 0.5%", 500, 1130, native.systemFont, 25)
    end 

    return Self
end

return Class