--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- CovidInformationPopup.lua
--***********************************************************************************************

-- Module
class = {}

-- Requirements
local widget = require("widget")

function class.new()
    self = {}
    local menuGroup = display.newGroup()
    local cityText = "XXXXXXXXXXXXXXXXX"
    local stateText = ", AL"
    local zipText = "99999"
    local caseText = "Cases: 999999"
    local deathText = "Deaths: 9999"

    -- Popup Background
    local UI = display.newRoundedRect(menuGroup, display.contentCenterX, display.contentCenterY, 450, 250, 12)
    UI:setFillColor(1, 0.6, 0)

    -- Exit Button
    local exitButton = display.newRoundedRect(menuGroup, display.contentCenterX + 220, display.contentCenterY - 120, 50, 50, 12)
    exitButton:setFillColor(1, 1, 0.00)
    exitButton:addEventListener("tap", function() menuGroup.isVisible = false end)

    local exitText = display.newText(menuGroup, "X", display.contentCenterX + 222, display.contentCenterY - 120, native.systemFont, 30)
    exitText:setFillColor(0, 0, 0)
    
    -- Covid Information Text
    local covidInformationText = display.newText(menuGroup, "Covid Information", display.contentCenterX, display.contentCenterY - 90, native.systemFont, 50)
    covidInformationText:setFillColor(1, 1, 1)

    -- State Information Text
    local cityInformationText = display.newText(menuGroup, cityText .. stateText .. " " .. zipText, display.contentCenterX, display.contentCenterY, native.systemFont, 40)
    cityInformationText:setFillColor(1, 1, 1)

    -- Case Information Text
    local caseInformationText = display.newText(menuGroup, caseText, display.contentCenterX, display.contentCenterY + 75, native.systemFont, 35)
    caseInformationText:setFillColor(1, 1, 1)

    -- Death Information Text
    local deathInformationText = display.newText(menuGroup, deathText, display.contentCenterX, display.contentCenterY + 75, native.systemFont, 35)
    deathInformationText:setFillColor(1, 1, 1)
    
    function self.SetInformation(city, zip, cases, deaths, caseOrdeath, absorbApproved)
        cityText = city
        zipText = zip
        caseText = "Cases: " .. cases
        deathText = "Deaths: " .. deaths

        cityInformationText.text = cityText .. stateText .. " " .. zipText
        caseInformationText.text = caseText
        deathInformationText.text = deathText

        if caseOrdeath == true then
            caseInformationText.isVisible = true
            deathInformationText.isVisible = false
            caseInformationText.x = display.contentCenterX
            cityInformationText.size = 35
        elseif caseOrdeath == false and absorbApproved == false then
            caseInformationText.isVisible = false
            deathInformationText.isVisible = true
            deathInformationText.x = display.contentCenterX
            deathInformationText.size = 35
        else
            caseInformationText.isVisible = true
            deathInformationText.isVisible = true
            cityInformationText.size = 33
            deathInformationText.size = 33
            caseInformationText.x = display.contentCenterX - 100
            deathInformationText.x = display.contentCenterX + 115
        end

        if #cityText < 10 then
            cityInformationText.size = 40
        elseif #cityText > 10 and #cityText < 14 then
            cityInformationText.size = 33
        else
            cityInformationText.size = 29
        end
    end

    function self.getGroup()
        return menuGroup
    end

    return self
end

return class