dofile_once("mods/your_lifespan_is/files/scripts/lib/utilities.lua")

your_lifespan_is_gui = your_lifespan_is_gui or GuiCreate()
local gui = your_lifespan_is_gui

local function secondToDisplayTime(second)
  local function addZeroIfNeed(time)
    if #time == 1 then
      return "0" .. time
    else
      return time
    end
  end

  local hours = addZeroIfNeed(tostring(math.floor(second / 3600)))
  local minutes = addZeroIfNeed(tostring(math.floor((second%3600) / 60)))
  local seconds = addZeroIfNeed(tostring(second % 60))

  return hours .. ":" .. minutes .. ":" .. seconds
end

function draw_gui(remaining_time)
  local player_entity_id = getPlayerEntity()
  if player_entity_id ~=nil then

    if gui ~= nil then
      GuiStartFrame( gui )
    end

    local inventory_gui = EntityGetFirstComponent(player_entity_id, "InventoryGuiComponent")
    if inventory_gui ~= nil then
      local is_open = ComponentGetValue(inventory_gui, "mActive") == "1"

      if is_open then
          GuiLayoutBeginHorizontal( gui, 3, 96 )
        else
          GuiLayoutBeginVertical( gui, 3, 12 )
      end
    end
    GuiText(gui, 0, 0, secondToDisplayTime(remaining_time))
    GuiLayoutEnd( gui )
  end
end
