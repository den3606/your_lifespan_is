-- Easiest place to test new stuff, in reality the code could be anywhere.
function OnPlayerSpawned(player_entity_id)
  EntityLoadToEntity( "mods/your_lifespan_is/files/entities/death_judge.xml", player_entity_id )
end
