--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- CovidDot.lua
--***********************************************************************************************

--Module
CovidDot = {}

--[[
Object / Constructor

Create new dots. Color = Color of Dot, x = x location, y = y location, case = number of cases

Death = number of deaths, zip = zipcode, location = city
]]--
function CovidDot.new(group, zip, x, y, location, case, death, color)
    local self = display.newCircle(group, 0, 0, 5 );

    -- Variables
    self:setFillColor( color[1], color[2], color[3] )
    self.alpha = 0.5
    self.x = x
    self.y = y
    local zipcode = zip
    local location = location
    local case = case
    local death = death
    
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
end

return CovidDot