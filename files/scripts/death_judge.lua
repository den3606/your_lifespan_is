dofile_once("mods/your_lifespan_is/files/scripts/lib/utilities.lua")

local function secondToFrame(second)
  return second * 60
end

local function frameToSecond(frame)
  return math.floor(frame / 60)
end

local function announceLifeLimit(remaining_time)
  if remaining_time == 0 then
    -- GG
  elseif remaining_time <= 29 then
    GamePrint(remaining_time .. "...")
  elseif remaining_time == 30 then
    GamePrintImportant("You sense the presence of the Reaper.")
  elseif remaining_time == 60 then
    GamePrintImportant("The Reaper has found you.")
  elseif remaining_time == 60 * 5 then
    GamePrintImportant("You realized that you don't have much longer.")
  elseif remaining_time == 60 * 15 then
    GamePrintImportant("The Reaper is looking for you.")
  elseif remaining_time == 60 * 30 then
    GamePrintImportant("The Reaper has begun preparations.")
  elseif remaining_time % 60 * 60 == 0 then
    GamePrintImportant("Your lifetime is " .. remaining_time / 3600 .. " hours.")
  end
end

--------------
-- main
--------------
local current_frame = GameGetFrameNum()
local lifetime = tonumber(math.floor(ModSettingGet("your_lifespan_is.LIFETIME"))) * 60

local remaining_time = math.floor(lifetime - frameToSecond(current_frame))
local can_announce = ModSettingGet("your_lifespan_is.DISPLAY_FLAVOR_TEXT")

if can_announce then
  announceLifeLimit(remaining_time)
end

if remaining_time <= 0 then
  killPlayer("Your heart has given out")
end
