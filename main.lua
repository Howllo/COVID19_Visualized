--***********************************************************************************************
-- Tony Hardiman
-- Assignment 3
-- main.lua
--***********************************************************************************************

-- Requirements
local CovidDot = require("lib.CovidDot")
local csv = require("lib.csv")

-- Hide the Status Bar
display.setStatusBar(display.HiddenStatusBar)

-- Variables
local dataLocation = "data\\new_covid_al.csv"
local path = system.pathForFile( dataLocation, system.ResourceDirectory )
local covidDotGroup = display.newGroup()
local covidDots = {}

-- Background
local bg = display.newImage ("data/al_map.png", display.contentCenterX, display.contentCenterY);
bg.xScale = display.contentWidth / bg.width; 
bg.yScale = display.contentHeight / bg.height;

local function CreateDots()
    local fields = csv.open(path)

    if fields then 
        for field in  fields:lines() do 
            print("Field 1: " .. field[1] .. " Field 2: " .. field[2] .. " Field 3: " .. field[3] .. " Field 4: " 
            .. field[4] .. " Field 5: " .. field[5] .. " Field 6: " .. field[6])
        end
    else 
        print("Error: File not found at location " .. path)
    end
 end

local function Start()
    CreateDots()
end

Start()


local function update()
end

timer.performWithDelay( 20, update, 0 )