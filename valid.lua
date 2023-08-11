local module = {}

local function avoid_shop_at(x, y, l)
    local rx, ry = get_room_index(x, y)
    local template = get_room_template(rx, ry, l)
    return template ~= ROOM_TEMPLATE.SHOP
    and template ~= ROOM_TEMPLATE.SHOP_ATTIC
    and template ~= ROOM_TEMPLATE.SHOP_ATTIC_LEFT
    and template ~= ROOM_TEMPLATE.SHOP_BASEMENT
    and template ~= ROOM_TEMPLATE.SHOP_BASEMENT_LEFT
    and template ~= ROOM_TEMPLATE.SHOP_ENTRANCE_DOWN
    and template ~= ROOM_TEMPLATE.SHOP_ENTRANCE_DOWN_LEFT
    and template ~= ROOM_TEMPLATE.SHOP_ENTRANCE_UP
    and template ~= ROOM_TEMPLATE.SHOP_ENTRANCE_UP_LEFT
    and template ~= ROOM_TEMPLATE.SHOP_JAIL_BACKLAYER
    and template ~= ROOM_TEMPLATE.SHOP_LEFT
    and template ~= ROOM_TEMPLATE.DICESHOP
    and template ~= ROOM_TEMPLATE.DICESHOP_LEFT
    and template ~= ROOM_TEMPLATE.VAULT
end

local function avoid_entrance_at(x, y, l)
    local rx, ry = get_room_index(x, y)
    local template = get_room_template(rx, ry, l)
    return template ~= ROOM_TEMPLATE.ENTRANCE
    and template ~= ROOM_TEMPLATE.ENTRANCE_DROP
end

function module.forcefield(x, y, l)
    return get_grid_entity_at(x, y, l) ~= -1
    and get_grid_entity_at(x, y+1, l) == -1
    and get_grid_entity_at(x, y+2, l) == -1
    and get_grid_entity_at(x, y+3, l) == -1
    and get_grid_entity_at(x, y+4, l) == -1
    and avoid_entrance_at(x, y, l)
    and avoid_shop_at(x, y, l)
end
function module.bouncetrap(x, y, l)
    return get_grid_entity_at(x, y, l) == -1
    and get_grid_entity_at(x, y+1, l) == -1
    and get_grid_entity_at(x, y+2, l) == -1
    and get_grid_entity_at(x, y+3, l) == -1
    -- and avoid_entrance_at(x, y, l)
    and avoid_shop_at(x, y, l)
end

function module.ground(x, y, l)
    return get_grid_entity_at(x, y-1, l) ~= -1
    and get_grid_entity_at(x, y, l) == -1
    and avoid_entrance_at(x, y, l)
    and avoid_shop_at(x, y, l)
end

function module.ceiling(x, y, l)
    local above = get_grid_entity_at(x, y+1, l)
    if above == -1 then
        return false
    end

    above = get_entity(above)
    if test_flag(above.flags, ENT_FLAG.IS_PLATFORM) then return false end

    return get_grid_entity_at(x, y, l) == -1
    and avoid_entrance_at(x, y, l)
    and avoid_shop_at(x, y, l)
end

function module.turret(x, y, l)
    return module.ceiling(x, y, l)
    and get_grid_entity_at(x, y-1, l) == -1
end

return module