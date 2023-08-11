-- Implement randomly spawning mechs

-- All Levels are 5x5(?) and have no floor

-- Set World 1 to an Ice Caves theme
-- Level gen is S2's Ice Caves
-- 1-4 has a secret with the plasma cannon

-- Set World 2 to a mothership theme
-- Level gen is like HD's mothership
-- Swap entrance and exits
-- 2-4 is an alien queen boss fight

local theme_camp = CustomTheme:new(100, THEME.ICE_CAVES)
theme_camp:override(THEME_OVERRIDE.SPAWN_EFFECTS, THEME.ICE_CAVES)
theme_camp:override(THEME_OVERRIDE.SPAWN_BACKGROUND, THEME.ICE_CAVES)
theme_camp:override(THEME_OVERRIDE.SPAWN_DECORATION, THEME.ICE_CAVES)
theme_camp:override(THEME_OVERRIDE.SPAWN_DECORATION2, THEME.ICE_CAVES)
theme_camp.textures[DYNAMIC_TEXTURE.FLOOR] = TEXTURE.DATA_TEXTURES_FLOOR_ICE_0
theme_camp.textures[DYNAMIC_TEXTURE.BACKGROUND] = TEXTURE.DATA_TEXTURES_BG_ICE_0

local theme_ice_caves = CustomTheme:new(101, THEME.ICE_CAVES)
theme_ice_caves:override(THEME_OVERRIDE.SPAWN_EFFECTS, THEME.ICE_CAVES)
theme_ice_caves:override(THEME_OVERRIDE.SPAWN_BACKGROUND, THEME.ICE_CAVES)
theme_ice_caves:override(THEME_OVERRIDE.SPAWN_DECORATION, THEME.ICE_CAVES)
theme_ice_caves:override(THEME_OVERRIDE.SPAWN_DECORATION2, THEME.ICE_CAVES)
-- theme_ice_caves:override(THEME_OVERRIDE.LEVEL_HEIGHT, THEME.ICE_CAVES)
theme_ice_caves.textures[DYNAMIC_TEXTURE.FLOOR] = TEXTURE.DATA_TEXTURES_FLOOR_ICE_0
theme_ice_caves.textures[DYNAMIC_TEXTURE.BACKGROUND] = TEXTURE.DATA_TEXTURES_BG_ICE_0
theme_ice_caves:post(THEME_OVERRIDE.INIT_LEVEL, function ()
    state.width = 5
    state.height = 6
    -- # TODO: Force bottom rooms to be empty before path generation
    state.level_gen.themes[THEME.ICE_CAVES]:generate_path(false)
end)
theme_ice_caves:override(THEME_OVERRIDE.SPAWN_BORDER, THEME.ICE_CAVES)

local theme_mothership = CustomTheme:new(102, THEME.ICE_CAVES)
theme_mothership:override(THEME_OVERRIDE.SPAWN_EFFECTS, THEME.NEO_BABYLON)
theme_mothership:override(THEME_OVERRIDE.SPAWN_BACKGROUND, THEME.ICE_CAVES)
theme_mothership:override(THEME_OVERRIDE.SPAWN_DECORATION, THEME.ICE_CAVES)
theme_mothership:override(THEME_OVERRIDE.SPAWN_DECORATION2, THEME.ICE_CAVES)
theme_mothership:override(THEME_OVERRIDE.ENT_BORDER, THEME.NEO_BABYLON)
-- theme_mothership:override(THEME_OVERRIDE.LEVEL_HEIGHT, THEME.ICE_CAVES)
theme_mothership.textures[DYNAMIC_TEXTURE.FLOOR] = TEXTURE.DATA_TEXTURES_FLOOR_BABYLON_0
theme_mothership.textures[DYNAMIC_TEXTURE.BACKGROUND] = TEXTURE.DATA_TEXTURES_BG_MOTHERSHIP_0
theme_mothership:post(THEME_OVERRIDE.INIT_LEVEL, function ()
    state.width = 5
    state.height = 5
    state.level_gen.themes[THEME.ICE_CAVES]:generate_path(false)
end)

set_callback(function (ctx)
    if state.screen == SCREEN.INTRO
    or state.screen == SCREEN.CAMP then
        -- force_custom_theme(theme_camp)
    elseif state.screen == SCREEN.LEVEL then
        ctx:override_level_files({"generic.lvl", "icecavesarea.lvl"})
        if state.world == 1 then
            force_custom_theme(theme_ice_caves)
        elseif state.world == 2 then
            force_custom_theme(theme_mothership)
        end
    end
end, ON.PRE_LOAD_LEVEL_FILES)

-- fix ice caves not having an exit level
set_callback(
---@param ctx PostRoomGenerationContext
function (ctx)
    for x = 0, state.width - 1 do
        local template = get_room_template(x, 4, LAYER.FRONT)
        if template == ROOM_TEMPLATE.PATH_DROP then
            ctx:set_room_template(x, 4, LAYER.FRONT, ROOM_TEMPLATE.EXIT)
        elseif template == ROOM_TEMPLATE.PATH_DROP_NOTOP then
            ctx:set_room_template(x, 4, LAYER.FRONT, ROOM_TEMPLATE.EXIT_NOTOP)
        end
    end
end, ON.POST_ROOM_GENERATION)