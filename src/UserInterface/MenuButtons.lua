--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- MenuButtons.lua
--***********************************************************************************************

-- Module
local MenuButtons = {}

-- Requirements
local widget = require("widget")
local composer = require("composer")

function MenuButtons.new()
    local self = {}

    local menuGroup = display.newGroup()

    -- Background Case / Death Radio Buttons
    local UI = display.newRoundedRect(menuGroup, display.contentCenterX, display.contentCenterY, 400, 400, 25)
    UI:setFillColor(1, 0.6, 0)
    UI.alpha = 0.4

    -- Scene Switch
    local sceneSwitch = display.newRoundedRect( menuGroup, display.contentCenterX, display.contentCenterY + 150, 150, 65, 10)
    sceneSwitch:setFillColor(1, 0.6, 0)
    sceneSwitch:addEventListener("tap", function() 
    composer.gotoScene("src.Scenes.Scene2", {effect = "fade", time = 300}) end)

    -- Scene Switch Text
    local sceenSwitchText = display.newText(menuGroup, "Visualize", display.contentCenterX, display.contentCenterY + 150, native.systemFont, 30)
    sceenSwitchText:setFillColor(0, 0, 0)

    -- Variables
    local caseDeath = display.newGroup()
    local color = display.newGroup()
    local covidDots = {}
    local colorXOffset = 15;
    local colorTextXOffset = (colorXOffset * -1) - 5;
    local colorYOffset = 25;
    local absorbApproved = false

    -- Case / Death Radio Button Text
    local caseText = display.newText(menuGroup, "Case", display.contentCenterX - 65, display.contentCenterY - 100, native.systemFont, 20)
    caseText:setFillColor(1, 1, 1)

    local deathText = display.newText(menuGroup, "Death", display.contentCenterX, display.contentCenterY - 100, native.systemFont, 20)
    deathText:setFillColor(1, 1, 1)

    local deathText = display.newText(menuGroup, "Absorb", display.contentCenterX + 70, display.contentCenterY - 100, native.systemFont, 20)
    deathText:setFillColor(1, 1, 1)

    function CaseButtonHandler()
        for _, dot in ipairs(covidDots) do
            dot:SetCaseOrDeath(true)
        end
        absorbApproved = false
    end

    function DeathButtonHandler()
        for _, dot in ipairs(covidDots) do
            dot:SetCaseOrDeath(false)
        end
        absorbApproved = false
    end

    function AbsorbButtonHandler()
        for _, dot in ipairs(covidDots) do
            dot:SetCaseOrDeath(false)
        end
        absorbApproved = true
    end

    function WhiteButtonHandler()
        for _,dot in ipairs(covidDots) do
            dot:setFillColor(1, 1, 1)
        end
    end

    function RedButtonHandler()
        for _,dot in ipairs(covidDots) do
            dot:setFillColor(1, 0, 0)
        end
    end

    function GreenButtonHandler()
        for _,dot in ipairs(covidDots) do
            dot:setFillColor(0, 1, 0)
        end
    end

    function BlueButtonHandler()
        for _,dot in ipairs(covidDots) do
            dot:setFillColor(0.54, 0.81, 0.94)
        end
    end

    function YellowButtonHandler()
        for _,dot in ipairs(covidDots) do
            dot:setFillColor(1, 1, 0)
        end
    end

    -- Case Radio Button
    local caseRadioButton = widget.newSwitch( 
        {
            left = display.contentCenterX - 80,
            top = display.contentCenterY - 75,
            style = "radio",
            id = "caseRadioButton",
            initialSwitchState = true,
            onPress = CaseButtonHandler
        }
    )

    -- Death Radio Button
    local deathRadioButton = widget.newSwitch( 
        {
            left = display.contentCenterX - 15,
            top = display.contentCenterY - 75,
            style = "radio",
            id = "deathRadioButton",
            initialSwitchState = false,
            onPress = DeathButtonHandler
        }
    )

    -- Absorb Radio Button
    local absorbRadioButton = widget.newSwitch( 
        {
            left = display.contentCenterX + 50,
            top = display.contentCenterY - 75,
            style = "radio",
            id = "absorbRadioButton",
            initialSwitchState = false,
            onPress = AbsorbButtonHandler
        }
    )

    caseDeath:insert(caseRadioButton)
    caseDeath:insert(deathRadioButton)
    caseDeath:insert(absorbRadioButton)

    -- Color Radio Text
    local whiteText = display.newText(menuGroup, "White", display.contentCenterX - 110 + colorTextXOffset, display.contentCenterY + 25, native.systemFont, 20)
    whiteText:setFillColor(1, 1, 1)

    local redText = display.newText(menuGroup, "Red", display.contentCenterX - 45 + colorTextXOffset, display.contentCenterY + 25, native.systemFont, 20)
    redText:setFillColor(1, 1, 1)

    local greenText = display.newText(menuGroup, "Green", display.contentCenterX + 20 + colorTextXOffset, display.contentCenterY + 25, native.systemFont, 20)
    greenText:setFillColor(1, 1, 1)

    local blueText = display.newText(menuGroup, "Blue", display.contentCenterX + 80 + colorTextXOffset, display.contentCenterY + 25, native.systemFont, 20)
    blueText:setFillColor(1, 1, 1)

    local yellowText = display.newText(menuGroup, "Yellow", display.contentCenterX + 140 + colorTextXOffset, display.contentCenterY + 25, native.systemFont, 20)
    yellowText:setFillColor(1, 1, 1)

    -- Color Radio Buttons
    -- White
    local w_Radio = widget.newSwitch(
        {
            left = display.contentCenterX - 160 + colorXOffset,
            top = display.contentCenterY + 25 + colorYOffset,
            style = "radio",
            id = "w_Radio",
            initialSwitchState = true,
            onPress = WhiteButtonHandler
        }
    )

    local r_Radio = widget.newSwitch(
        {
            left = display.contentCenterX - 100 + colorXOffset,
            top = display.contentCenterY + 25 + colorYOffset,
            style = "radio",
            id = "r_Radio",
            initialSwitchState = false,
            onPress = RedButtonHandler
        }
    )

    local g_Radio = widget.newSwitch(
        {
            left = display.contentCenterX - 40 + colorXOffset,
            top = display.contentCenterY + 25 + colorYOffset,
            style = "radio",
            id = "g_Radio",
            initialSwitchState = false,
            onPress = GreenButtonHandler
        }
    )

    local b_Radio = widget.newSwitch(
        {
            left = display.contentCenterX + 20 + colorXOffset,
            top = display.contentCenterY + 25 + colorYOffset,
            style = "radio",
            id = "b_Radio",
            initialSwitchState = false,
            onPress = BlueButtonHandler
        }
    )

    local y_Radio = widget.newSwitch(
        {
            left = display.contentCenterX + 80 + colorXOffset,
            top = display.contentCenterY + 25 + colorYOffset,
            style = "radio",
            id = "y_Radio",
            initialSwitchState = false,
            onPress = YellowButtonHandler
        }
    )

    color:insert(w_Radio)
    color:insert(r_Radio)
    color:insert(g_Radio)
    color:insert(b_Radio)
    color:insert(y_Radio)

    function self:setCovidDots(dots)
        covidDots = dots
    end

    function self:getCaseRadioButton()
        return caseRadioButton
    end

    function self:getDeathRadioButton()
        return deathRadioButton
    end

    function self:getWhiteRadio()
        return w_Radio
    end

    function self:getRedRadio()
        return r_Radio
    end

    function self:getGreenRadio()
        return g_Radio
    end

    function self:getBlueRadio()
        return b_Radio
    end

    function self:getYellowRadio()
        return y_Radio
    end

    function self:SetVisible(setVis)
        if setVis == nil then print("Set Visible is nil") return end

        menuGroup.isVisible = setVis
        color.isVisible = setVis
        caseDeath.isVisible = setVis
    end

    function self:GetAbsorbApproved()
        return absorbApproved
    end

    return self
end


-- Return
return MenuButtons