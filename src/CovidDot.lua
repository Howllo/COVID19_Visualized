--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- CovidDot.lua
--***********************************************************************************************

--Module
CovidDot = {}

--[[
Object / Constructor

Group = Dot Group, zip = zipcode, x = x location, y = y location, 

location = city, case = number of cases, death = number of deaths, color = Color of Dot
]]--
function CovidDot.new(group, zip, x, y, in_Location, in_Case, in_Death, color, ID, in_popupGroup, in_popup)
    local self = {}

    -- Variables
    local UniqueID = ID
    local zipcode = zip
    local location = in_Location
    local case = tonumber(in_Case)
    local death = tonumber(in_Death)
    local currentCases = case
    local currentDeath = death
    local caseOrDeath = true
    local popupGroup = in_popupGroup
    local popup = in_popup
    local absorbDots = {}
    ChildDot = false

    -- Restore State Variables
    local originalX = x
    local originalY = y
    local orginalGroup = group
    local originalColor = color
    local originalAlpha = 0.6

    -- Covid Dot Information
    selfDot = display.newCircle(group, x, y, 8 )
    selfDot.myDot = self
    selfDot:setFillColor(color[1], color[2], color[3])
    selfDot.alpha = 0.6

    local function DotsHandler(event)
        if popup == nil then print("Error: Popup is nil") return end
        local dot = event.target.myDot
        popup.SetInformation(dot:GetLocation(), dot:GetZipcode(), dot:GetCurrentCase(), dot:GetCurrentDeath())
        popupGroup.isVisible = true
    end

    function self:SetColor(r, g, b)
        selfDot:setFillColor( r, g, b )
    end

    function self:GetX()
        return selfDot.x
    end

    function self:GetY()
        return selfDot.y
    end

    function self:GetZipcode()
        return zipcode
    end

    function self:GetLocation()
        return location
    end

    function self:GetCase()
        return case
    end

    function self:GetDeath()
        return death
    end

    function self:GetCurrentCase()
        return currentCases
    end

    function self:GetCurrentDeath()
        return currentDeath
    end

    function self:GetUniqueID()
        return UniqueID
    end

    function self:GetCircleDot()
        return selfDot
    end

    function self:SetDotVisible(b_Visible)
        selfDot.isVisible = b_Visible
    end

    -- Recalculate the current cases and deaths
    local function RecalculateCurrent()
        currentCases = 0
        currentDeath = 0
        local holderCases = {}
        local holderDeath = {}

        local sizeOfAbsorb = 0
        for _ in pairs(absorbDots) do sizeOfAbsorb = sizeOfAbsorb + 1 end

        if sizeOfAbsorb == 0 or #absorbDots == nil then return end

        -- Getting unique numbers to be added together.
        for k, dot in pairs(absorbDots) do
            if holderCases[dot:GetCase()] == nil then
                holderCases[dot:GetCase()] = dot:GetCase()
                currentCases = currentCases + dot:GetCase()
            end

            if holderDeath[dot:GetDeath()] == nil then
                holderDeath[dot:GetDeath()] = dot:GetDeath()
                currentDeath = currentDeath + dot:GetDeath()
            end
        end
    end

    -- Add a dot to the current dot and turns unused dots invisible
    function self:AddToCurrent(dot)        
        if dot == nil then print("Error: Dot is nil. CovidDot Class.") return end
        if self.ChildDot or dot:GetUniqueID() == self:GetUniqueID() == true then return end

        local oldAbsorb = dot:GetAbsorbDots()

        -- Edge Case - Turns parent dot into a child dot while adding the child dot to the new parent dot.
        if #oldAbsorb > 0 then
            for i = #oldAbsorb, 1, -1 do
                if oldAbsorb[i]:GetUniqueID() ~= self:GetUniqueID() then
                    local childDot = oldAbsorb[i]
                    table.remove(oldAbsorb, oldAbsorb[i]:GetUniqueID())

                    -- Unique Key
                    local key = childDot.GetLocation()

                    if absorbDots[key] ~= nil then
                        absorbDots[key] = childDot
                    end
                end
            end
        end

        dot.ChildDot = true
        --self:SetDotVisible(false)
        local key = dot.GetLocation()
        if absorbDots[key] == nil then
            absorbDots[key] = dot
        end

        -- Recalcuate the Current Cases and Deaths
        RecalculateCurrent()
    end

    -- b_caseOrdeath = true if case, false if death
    function self:SetCaseOrDeath(b_caseOrdeath)
        caseOrDeath = b_caseOrdeath
    end

    -- Get the case or death of the dots. 
    -- true = case, false = death
    function self:GetCaseOrDeath()
        return caseOrDeath
    end

    function self:GetAbsorbDots()
        return absorbDots
    end

    function self:SetRadius(n_Radius)
        if n_Radius == nil then print("Error: Radius is nil. CovidDot Class.") return end

        -- Remove Event Listener
        selfDot:removeEventListener("touch", DotsHandler)
        display.remove(selfDot)

        -- Create New Dot
        selfDot = display.newCircle(orginalGroup, originalX, originalY, n_Radius)
        selfDot.alpha = originalAlpha
        selfDot:setFillColor(originalColor[1], originalColor[2], originalColor[3])
        selfDot:addEventListener("touch", DotsHandler)
    end

    -- Empty the absorbDots table
    function self:ResetAborbsDot()
        absorbDots = {}
    end

    function self:Reset()
        self.isVisible = false
        self.ChildDot = false
        currentCases = self:GetCase()
        currentDeath = self:GetDeath()
        caseOrDeath = true
        self:SetRadius(8)
        self:ResetAborbsDot()
    end

    ---------------------------------------------------------------------------------
 
    -- Listener setup
    selfDot:addEventListener("touch", DotsHandler)
    ---------------------------------------------------------------------------------

    return self
end

return CovidDot