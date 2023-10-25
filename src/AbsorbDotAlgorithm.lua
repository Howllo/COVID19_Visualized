--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- AbsorbDotAlgorithm.lua
--***********************************************************************************************

-- Module
AbsorbDot = {}

-- Requirements
local covidDots = require("src.CovidDot")

function AbsorbDot.Absorb(covidDots, aproved)
    -- If distant to dot is greater than 50 pixel then do not absorb
    -- If distant is less than 50 pixel then absorb
    -- If the size of a the dot is larger than asorb into the larger dot
    -- Use data from the larger dot to populate the popup menu.

    if covidDots == nil then print("Error: Covid dot is nil. Algorithm Class.") return end

    -- Variables
    local inCaseMin, inCaseMax = 882, 114709
    local outCaseMin,outCaseMax = 8, 25
    local inDeathMin, inDeathMax = 27, 1924
    local outDeathMin, outDeathMax = 8, 25
    local maxDistance = 50

    local function distance(x1, y1, x2, y2)
        return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2)
    end

    -- Resize the dot to the current case or death
    local function ResizeDot()
        if covidDots == nil then print("Error: Resize Dot - covidDots is nil")return end
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

    -- Waste of time due to misreading of:
    --Utilize the provided table values and map.luafrom the exam package to remap a data value from one range to the 
    --aforementioned radius range for your circles. For instance, if a Case value for a zip code area is 50 within a 
    --range of 882 to 114709, it should be mapped to a range of 8 to 25 using the formula map(50, 822, 114709, 5, 20).
    --It is far too baked into the program now.
    if aproved == true then
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

    -- Resize all dots to the size of the current cases or deaths
    ResizeDot()
end

return AbsorbDot