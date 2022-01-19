function getPlayerEntity()
  local players = EntityGetWithTag("player_unit")
  if #players == 0 then
    return
  end

  return players[1]
end

function killPlayer(message)
  EntityInflictDamage(getPlayerEntity(), 999, "DAMAGE_SLICE", message, "BLOOD_EXPLOSION", 0, 0)
end
