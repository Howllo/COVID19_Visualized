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
local CovidInformationPopup = require("src.UserInterface.CovidInformationPopup")

function Load.new()
    local self = {}
    -- Variables
    local dataLocation = "data\\new_covid_al.csv"
    local path = system.pathForFile( dataLocation, system.ResourceDirectory )
    local covidDots = {}
    local covidGroup = display.newGroup()
    local popup = CovidInformationPopup.new()
    local popupGroup = popup.getGroup()
    popupGroup.isVisible = false

    local function DotsHandler(event)
        if popup == nil then print("Error: Popup is nil") return end
        popup.SetInformation(event.target:GetLocation(), event.target:GetZipcode(), event.target:GetCurrentCase(), 
                                event.target:GetCurrentDeath(), event.target:GetCaseOrDeath(), event.target.Absorb)
        popupGroup.isVisible = true
    end

    function self.CreateDots()
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
                                                {1, 1, 1}, i)
                    dot:addEventListener("tap", DotsHandler)
                    table.insert(covidDots, dot)
                    dot.isVisible = false
                    dot.ChildDot = false
                    dot.Slidered = false
                    dot.Searched = false
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