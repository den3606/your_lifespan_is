local function secondToFrame(second)
  return second * 60
end

local function frameToSecond(frame)
  return math.floor(frame / 60)
end

-- Easiest place to test new stuff, in reality the code could be anywhere.
function OnPlayerSpawned(player_entity_id)
  dofile("mods/your_lifespan_is/files/scripts/ui.lua")
  EntityLoadToEntity("mods/your_lifespan_is/files/entities/death_judge.xml", player_entity_id)
end

function OnWorldPostUpdate()
  local current_frame = GameGetFrameNum()
  local lifetime = tonumber(math.floor(ModSettingGet("your_lifespan_is.LIFETIME"))) * 60
  local remaining_time = math.floor(lifetime - frameToSecond(current_frame))

  local show_life_time = ModSettingGet("your_lifespan_is.SHOW_LIMIT_TIME")
  if draw_gui and show_life_time then
    draw_gui(remaining_time)
  end
end
