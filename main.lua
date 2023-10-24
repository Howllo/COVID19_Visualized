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

-- Test
local covidDotGroup = display.newGroup()
local covidDots = {}

-- Background
local bg = display.newImage ("data/al_map.png", display.contentCenterX, display.contentCenterY);
bg.xScale = display.contentWidth / bg.width; 
bg.yScale = display.contentHeight / bg.height;

local function CreateDots()
    local fields = csv.open("data/new_covid_al.csv")

    if fields ~= nil then
        for field in  fields:lines() do 
            print(field)
        end
    else
        print("Error: No data found")
    end
 end

local function Start()
    CreateDots()
end

Start()


local function update()
end

timer.performWithDelay( 20, update, 0 )