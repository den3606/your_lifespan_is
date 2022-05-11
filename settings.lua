dofile("data/scripts/lib/mod_settings.lua") -- see this file for documentation on some of the features.

-- This file can't access other files from this or other mods in all circumstances.
-- Settings will be automatically saved.
-- Settings don't have access unsafe lua APIs.

-- Use ModSettingGet() in the game to query settings.
-- For some settings (for example those that affect world generation) you might want to retain the current value until a certain point, even
-- if the player has changed the setting while playing.
-- To make it easy to define settings like that, each setting has a "scope" (e.g. MOD_SETTING_SCOPE_NEW_GAME) that will define when the changes
-- will actually become visible via ModSettingGet(). In the case of MOD_SETTING_SCOPE_NEW_GAME the value at the start of the run will be visible
-- until the player starts a new game.
-- ModSettingSetNextValue() will set the buffered value, that will later become visible via ModSettingGet(), unless the setting scope is MOD_SETTING_SCOPE_RUNTIME.

function mod_setting_bool_custom(mod_id, gui, in_main_menu, im_id, setting)
  local value = ModSettingGetNextValue(mod_setting_get_id(mod_id, setting))
  local text = setting.ui_name .. " - " .. GameTextGet(value and "$option_on" or "$option_off")

  if GuiButton(gui, im_id, mod_setting_group_x_offset, 0, text) then
    ModSettingSetNextValue(mod_setting_get_id(mod_id, setting), not value, false)
  end

  mod_setting_tooltip(mod_id, gui, in_main_menu, setting)
end

function mod_setting_change_callback(mod_id, gui, in_main_menu, setting, old_value, new_value)
  print(tostring(new_value))
end

local mod_id = "your_lifespan_is" -- This should match the name of your mod's folder.
mod_settings_version = 2 -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value.
mod_settings = {{
  id = "LIFETIME",
  ui_name = "LIFETIME",
  ui_description = "Your life time is ... minutes.",
  value_default = 60,
  value_min = 1,
  value_max = 60 * 4,
  value_display_multiplier = 1,
  value_display_formatting = "+ $0 minute",
  scope = MOD_SETTING_SCOPE_NEW_GAME,
}, {
  id = "SHOW_LIMIT_TIME",
  ui_name = "Show Limit Time",
  ui_description = "You can see remaining life time.",
  value_default = true,
  scope = MOD_SETTING_SCOPE_RUNTIME,
}, {
  id = "DISPLAY_FLAVOR_TEXT",
  ui_name = "Display flavor text",
  ui_description = "At a certain period of time, you will receive a notification from the Grim Reaper..",
  value_default = true,
  scope = MOD_SETTING_SCOPE_RUNTIME,
}}

function ModSettingsUpdate(init_scope)
  local old_version = mod_settings_get_version(mod_id) -- This can be used to migrate some settings between mod versions.
  mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
  return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
  mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end
