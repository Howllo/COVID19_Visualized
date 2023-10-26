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
local AbsorbDot = require("src.AbsorbDotAlgorithm")

function Class.new(s_Group, in_covidDots, in_absorbApproved)
    if s_Group == nil or in_covidDots == nil then
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
    local exerimental = nil
    local covidDots = in_covidDots
    local sceneGroup = s_Group
    local absorbApproved = in_absorbApproved
    local Absorb = AbsorbDot.new(covidDots)

    -- This filters the dots based on the slider value and if it case or not.
    local function filterDot(dot, caseOrDeath, value)
        if caseOrDeath == true then
            return dot:GetCase() >= value
        else 
            return dot:GetDeath() >= value
        end
    end

    -- This figures out whether the dot is searched or not.
    local function isSearchDot(dot, caseOrDeath, value)
        return filterDot(dot, caseOrDeath, value) and dot.Searched == true
    end

    local function absorbDot(value)
        if Absorb == nil then return end

        Absorb:Absorb(absorbApproved, value)
    end

    local function Search(dot, search, data )
        if string.sub(data, 1, string.len(search)) == search then
            if dot.Slidered == false then
                dot.isVisible = true
            end
            dot.Searched = true
        else
            dot.isVisible = false
            dot.Searched = false
        end
    end

    -- This handles the slider functionality.
    local function sliderHandler(event)
        if sliderText == nil then return end

        local valueMin, valueMax = 0, 100
        local outCaseMin,outCaseMax = 882, 114709
        local outDeathMin, outDeathMax = 27, 1924
        local aborbMin, absorbMax = 0, 50 
        local value = 0
        local caseOrDeath = covidDots[1]:GetCaseOrDeath()

        if caseOrDeath == true  and absorbApproved == false then
            value = (event.value - valueMin) * (outCaseMax - outCaseMin) / (valueMax - valueMin) + outCaseMin
            sliderText.text = "Selected: " .. math.floor(value) .. " cases."
        elseif absorbApproved == false then
            value = (event.value - valueMin) * (outDeathMax - outDeathMin) / (valueMax - valueMin) + outDeathMin
            sliderText.text = "Selected: " .. math.floor(value) .. " deaths."
        else 
            value = (event.value - valueMin) * (absorbMax - aborbMin) / (valueMax - valueMin) + aborbMin
            sliderText.text = "Selected: " .. math.floor(value) .. " radius."
        end
    
        if absorbApproved == true then
            absorbDot(value)
            return
        end

        local searchFileText = Self:GetSearchField().text
        local filter = searchFileText == "" and filterDot or isSearchDot

        for _, dot in ipairs(covidDots) do
            dot.isVisible = filter(dot, caseOrDeath, value)

            if dot.isVisible == false then
                dot.Slidered = true
            else
                dot.Slidered = false
            end
        end
    end

    -- This handles the search button functionality.
    local function searchHandler(event)
        local search = Self:GetSearchField().text
        for _, dot in ipairs(covidDots) do
            if tonumber(search) ~= nil then
                Search(dot, search, dot:GetZipcode())
            else
                Search(dot, string.upper(search), dot:GetLocation())
            end
        end
        return
    end

    local function sceneSwitchHandler(event)
        if sceneSwitch == nil then return end

        if event.phase == "began" then
            sceneSwitch:setFillColor(1, 0.6, 0.6)
        elseif event.phase == "ended" then
            sceneSwitch:setFillColor(1, 0.6, 0)
        end

        if exerimental ~= nil then
            exerimental.isVisible = false
        end
        
        composer.gotoScene("src.Scenes.Scene1", {effect = "fade", time = 500})
    end

    -- Slider Background
    sliderBackground = display.newRoundedRect(sceneGroup, 500, 1150, 450, 175, 12)
    sliderBackground:setFillColor(1, 0.6, 0)
    sliderBackground.alpha = 0.3

    -- Scene Switch
    sceneSwitch = display.newRoundedRect(sceneGroup, 650, 1190, 110, 50, 15)
    sceneSwitch:setFillColor(1, 0.6, 0)
    sceneSwitch:addEventListener("tap", sceneSwitchHandler)

    -- Scene Switch Text
    UIText = display.newText(sceneGroup, "Back", 650, 1190, native.systemFont, 25)
    UIText:setFillColor(0, 0, 0)
    
    -- Search Field
    local searchField = native.newTextField( 405, 1190, 200, 50 )
    searchField.placeholder = "Zip/City"
    searchField.font = native.newFont( native.systemFont, 25 )
    native.setKeyboardFocus( searchField )
    searchField:resizeFontToFitHeight()
    searchField:addEventListener( "userInput", searchHandler )
    sceneGroup:insert(searchField)


    -- Opacity Slider
    local slider = widget.newSlider(
        {
            x = 500,
            y = 1100,
            width = 400,
            value = 0,
            listener = sliderHandler
        }
    )

    sceneGroup:insert(slider)

    -- Slider Text
    if covidDots[1]:GetCaseOrDeath() == true and absorbApproved == false or absorbApproved == nil then
        sliderText = display.newText(sceneGroup, "Selected: 882 cases.", 500, 1130, native.systemFont, 25)
    elseif absorbApproved == false or absorbApproved == nil then
        sliderText = display.newText(sceneGroup, "Selected: 27 deaths.", 500, 1130, native.systemFont, 25)
    else
        exerimental =  display.newText(sceneGroup, "THIS IS EXPERIMENTAL", 500, 1045, native.systemFont, 30)
        sliderText = display.newText(sceneGroup, "Selected: 0 radius.", 500, 1130, native.systemFont, 25)
    end

    function Self:GetSearchField()
        return searchField
    end

    function Self:Destroy()
        display.remove(sliderBackground)
        display.remove(slider)
        display.remove(sliderText)
        display.remove(sceneSwitch)
        display.remove(UIText)
        display.remove(exerimental)
        display.remove(searchField)
        display.remove(searchButton)
        display.remove(SearchText)
    end

    return Self
end

return Class