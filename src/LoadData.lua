--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- LoadData.lua
--***********************************************************************************************

--Modules
Load = {}

-- Requirements
local CovidDot = require("src.CovidDot")
local csv = require("lib.csv")

function Load.new()
    local self = {}
    -- Variables
    local dataLocation = "data\\new_covid_al.csv"
    local path = system.pathForFile( dataLocation, system.ResourceDirectory )
    local covidDots = {}
    local covidGroup = display.newGroup()

    -- Create all dots from CSV file
    function self.CreateDots(popupGroup, popup)
        local fields = csv.open(path)
        local b_Test = false
        if fields ~= nil then 
            local i = 0
            for field in fields:lines() do 
                -- Skip the first line
                if field[1] == "zip" and b_Test == false then
                    b_Test = true
                else 
                    b_Test = false
                end
     
                -- Create the Covid Dot
                if b_Test == false then
                    local dot = CovidDot.new(covidGroup, field[1], field[2], field[3], field[4], field[5], field[6],
                                                {1, 1, 1}, i, popupGroup, popup)
                    table.insert(covidDots, dot)
                    dot:SetDotVisible(false)
                    dot.ChildDot = false
                end
                i = i + 1
            end
        else 
            print("Error: File not found at location " .. path)
        end
    
        return covidDots
     end

     function self.getGroup()
        return covidGroup
     end

     function self.GetPopupGroup()
        return popupGroup
     end

     return self
end

return Load