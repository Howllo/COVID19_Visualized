--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- AbsorbDotAlgorithm.lua
--***********************************************************************************************

-- Module
AbsorbDot = {}

-- Requirements
local covidDots = require("src.CovidDot")

function AbsorbDot.new(covidDot)
    if covidDot == nil then print("Error: Covid dot is nil. Algorithm Class.") return end

    local Self = {}

    -- Variables
    local inCaseMin, inCaseMax = 882, 114709
    local outCaseMin,outCaseMax = 8, 25
    local inDeathMin, inDeathMax = 27, 1924
    local outDeathMin, outDeathMax = 8, 25
    local covidDots = covidDot

    local function distance(x1, y1, x2, y2)
        return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2)
    end

    -- Resize the dot to the current case or death
    function Self:ResizeDot()
        if covidDots == nil then print("Error: Resize Dot - covidDots is nil") return end
        for _,dot in ipairs(covidDots) do
            if dot.GetCaseOrDeath() == true then
                local nR = (dot:GetCase() - inCaseMin) * (outCaseMax - outCaseMin) / (inCaseMax - inCaseMin) + outCaseMin
                dot:SetRadius(nR)
            else
                local nR = (dot:GetDeath() - inDeathMin) * (outDeathMax - outDeathMin) / (inDeathMax - inDeathMin) + outDeathMin
                dot:SetRadius(nR)
            end
        end
    end

    -- Waste of time due to misreading of the assignment. 
    -- But still going to use it.
    function Self:Absorb(approved, maxDistance)
        if approved == false then return end

        -- Reset Dots
        for _, dot in ipairs(covidDots) do
            dot:ResetAborbsDot(true)
        end

        for i = 1, #covidDots do
            for j = 1, #covidDots do
                local dist = distance(covidDots[i].x, covidDots[i].y, covidDots[j].x, covidDots[j].y)
                if covidDots[i]:GetCaseOrDeath() == true and i ~= j then
                    if dist <= maxDistance then
                        if covidDots[i]:GetCurrentCase() >= covidDots[j]:GetCurrentCase() then
                            covidDots[i]:AddToCurrent(covidDots[j])
                        elseif covidDots[i]:GetCurrentCase() < covidDots[j]:GetCurrentCase() then
                            covidDots[j]:AddToCurrent(covidDots[i])
                        end
                    end
                else 
                    if dist <= maxDistance then
                        if covidDots[i]:GetCurrentDeath() >= covidDots[j]:GetCurrentDeath() then
                            covidDots[i]:AddToCurrent(covidDots[j])
                        elseif covidDots[i]:GetCurrentDeath() < covidDots[j]:GetCurrentDeath() then
                            covidDots[j]:AddToCurrent(covidDots[i])
                        end
                    end
                end
            end
        end
    end

    return Self
end

return AbsorbDot