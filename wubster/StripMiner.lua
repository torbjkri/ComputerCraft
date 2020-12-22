-- Attempt at miner which strips local area for useful stuff


require "TurtleControl"

Stripper = TurtleControl:new()

local uselessStuff = {"air",
					  "stone",
					  "grass",
					  "dirt",
					  "cobblestone",
					  "bedrocks",
					  "sand",
					  "gravel",
					  }

local function getNickName(name)
	return string.sub(name.name, string.find(name.name,":")+1)
end

local function isUseless(name)
	local nick = getNickName(name)
	for i = 1,#uselessStuff do
		if nick == uselessStuff[i] then
			return true
		end
	end
	return false
end

local direction = {"forward", "up", "down", "left", "right", "back"}

local function removeFromList(list, el)
    for index, value in pairs(list) do
        if value == el then
            table.remove(list, value)
            return list
        end
    end
end

StripLocation = {needsSearch = {},
                 cameFrom = "",
                currentHeading = ""}

function StripLocation:new(o, from)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.needsSearch = direction
    self.cameFrome = from
    self.needsSearch = removeFromList(needsSearch, from)
    self.currentHeading = "forward"
    return o
end


function Stripper:new(o)
    o = o or TurtleControl:new(o)
    setmetatable(o, self)
    self.__index = self
    return o
end










function Stripper:strip()
    while
end
