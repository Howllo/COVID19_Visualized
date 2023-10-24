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
function CovidDot.new(group, zip, x, y, location, case, death, color)
    -- Variables
    local zipcode = zip
    local location = location
    local case = case
    local death = death
    local caseOrdeath = b_caseOrdeath


    -- Covid Dot Information
    local self = display.newCircle(group, 0, 0, 8 )
    self:setFillColor(color[1], color[2], color[3])
    self.alpha = 0.6
    self.x = x
    self.y = y

    -- 882 Cases - Highest 114,709
    local function calculateDotSizeCase()
        
    end 

    -- Lower 27 - Highest 1924 Death
    local function calculateDotSizeDeath()

    end

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
    
    -- b_caseOrdeath = true if case, false if death
    function self:SetSizeOfDot(b_caseOrdeath)
        if (b_caseOrdeath == true) then
            calculateDotSizeCase()
        else 
            calculateDotSizeDeath()
        end
    end

    return self
end

return CovidDot