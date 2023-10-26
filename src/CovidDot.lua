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
function CovidDot.new(group, zip, x, y, in_Location, in_Case, in_Death, color, ID)
    -- Variables
    local UniqueID = ID
    local zipcode = zip
    local location = in_Location
    local case = tonumber(in_Case)
    local death = tonumber(in_Death)
    local currentCases = tonumber(in_Case)
    local currentDeath = tonumber(in_Death)
    local caseOrDeath = true
    local absorbDots = {}
    ChildDot = false
    Searched = false
    Slidered = false
    Absorb = false

    -- Covid Dot Information
    local self = display.newCircle(group, 0, 0, 8 )
    self:setFillColor(color[1], color[2], color[3])
    self.alpha = 0.6
    self.x = x
    self.y = y

    function self:SetColor(r, g, b)
        self:setFillColor( r, g, b )
    end

    function self:GetCovidDot()
        return self
    end

    function self:GetX()
        return self.x
    end

    function self:GetY()
        return self.y
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
    
    function self:GetDotSize()
        return self.radius
    end

    function self:GetUniqueID()
        return UniqueID
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
        dot.isVisible = false
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
        
        -- Radius is between 8 and 25
        local nR = (n_Radius - 8) * (5.0 - 1.0) / (25 - 8) + 1.0

        -- Set
        self.xScale = nR
        self.yScale = nR
    end

    -- Empty the absorbDots table
    function self:ResetAborbsDot(setVisible)
        absorbDots = {}
        currentCases = self:GetCase()
        currentDeath = self:GetDeath()
        self.ChildDot = false
        self.Searched = false
        self.Slidered = false
        
        if setVisible == true then
            self.isVisible = true
        else 
            self.isVisible = false
        end
    end

    -- Reset the dot
    function self:Reset()
        absorbDots = {}
        currentCases = self:GetCase()
        currentDeath = self:GetDeath()
        self.ChildDot = false
        self.isVisible = false
        self.Searched = false
        self.Slidered = false
    end

    return self
end

return CovidDot