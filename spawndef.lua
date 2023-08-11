local alienlordlib = require("alienlord")
local alientanklib = require("alientank")
local laser_turretlib = require("laser_turret")
local validlib = require("valid")

-- extra spawn 50 ufos on every level
-- restricted from spawning in areas where it would interfere with specific bosses
local extra_ufo = define_extra_spawn(function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_UFO, x, y, l) end, validlib.ceiling, 50, 10)
-- local chance_ufo = define_procedural_spawn("ufo", function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_UFO, x, y, l) end, validlib.ceiling)

-- random chance to spawn laser turrets
local chance_turret = define_procedural_spawn("turret", laser_turretlib.spawn_turret, validlib.turret)

-- random chance to spawn alien tanks
-- requires an empty tile above a floor tile
-- 1 tile of clearance
local chance_alientank = define_procedural_spawn("alientank", alientanklib.create_alientank, validlib.ground)

-- random chance to spawn aliens
-- requires an empty tile above a floor tile
-- 1 tile of clearance
local chance_alien = define_procedural_spawn("alien", function(x, y, l) spawn_entity_snapped_to_floor(ENT_TYPE.MONS_ALIEN, x, y, l) end, validlib.ground)

-- replace large enemies with alien lords

-- replace large bosses with alien queens

-- random chance to replace floor with laser emitters
-- requires a floor tile
-- 4 tiles of clearance

-- random chance to spawn bounce traps
-- requires an empty tile above a floor tile
-- 3 tiles of clearance
local chance_bouncetrap = define_procedural_spawn("bouncetrap", function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_SPRING_TRAP, x, y, l) end, validlib.bouncetrap)

set_callback(function (room_gen_ctx)
	for _, chance in pairs({
		PROCEDURAL_CHANCE.ADD_GOLD_BAR,
		PROCEDURAL_CHANCE.ADD_GOLD_BARS,
		PROCEDURAL_CHANCE.ARROWTRAP_CHANCE,
		PROCEDURAL_CHANCE.BAT,
		PROCEDURAL_CHANCE.BEE,
		PROCEDURAL_CHANCE.BEEHIVE_CHANCE,
		PROCEDURAL_CHANCE.BIGSPEARTRAP_CHANCE,
		PROCEDURAL_CHANCE.CAT,
		PROCEDURAL_CHANCE.CAVEMAN,
		PROCEDURAL_CHANCE.CHAIN_BLOCKS_CHANCE,
		PROCEDURAL_CHANCE.COBRA,
		PROCEDURAL_CHANCE.CRABMAN,
		PROCEDURAL_CHANCE.CRITTERANCHOVY,
		PROCEDURAL_CHANCE.CRITTERBUTTERFLY,
		PROCEDURAL_CHANCE.CRITTERCRAB,
		PROCEDURAL_CHANCE.CRITTERDRONE,
		PROCEDURAL_CHANCE.CRITTERDUNGBEETLE,
		PROCEDURAL_CHANCE.CRITTERFIREFLY,
		PROCEDURAL_CHANCE.CRITTERFISH,
		PROCEDURAL_CHANCE.CRITTERLOCUST,
		PROCEDURAL_CHANCE.CRITTERPENGUIN,
		PROCEDURAL_CHANCE.CRITTERSLIME,
		PROCEDURAL_CHANCE.CRITTERSNAIL,
		PROCEDURAL_CHANCE.CROCMAN,
		PROCEDURAL_CHANCE.CRUSHER_TRAP_CHANCE,
		PROCEDURAL_CHANCE.DIAMOND,
		PROCEDURAL_CHANCE.EGGSAC_CHANCE,
		PROCEDURAL_CHANCE.ELEVATOR,
		PROCEDURAL_CHANCE.EMERALD,
		PROCEDURAL_CHANCE.FEMALE_JIANGSHI,
		PROCEDURAL_CHANCE.FIREBUG,
		PROCEDURAL_CHANCE.FIREFROG,
		PROCEDURAL_CHANCE.FISH,
		PROCEDURAL_CHANCE.FROG,
		PROCEDURAL_CHANCE.GIANTFLY,
		PROCEDURAL_CHANCE.GIANTSPIDER,
		PROCEDURAL_CHANCE.HANGSPIDER,
		PROCEDURAL_CHANCE.HERMITCRAB,
		PROCEDURAL_CHANCE.HORNEDLIZARD,
		PROCEDURAL_CHANCE.IMP,
		PROCEDURAL_CHANCE.JIANGSHI,
		PROCEDURAL_CHANCE.JUNGLE_SPEAR_TRAP_CHANCE,
		PROCEDURAL_CHANCE.LANDMINE,
		PROCEDURAL_CHANCE.LASERTRAP_CHANCE,
		PROCEDURAL_CHANCE.LAVAMANDER,
		PROCEDURAL_CHANCE.LEPRECHAUN,
		PROCEDURAL_CHANCE.LEPRECHAUN_CHANCE,
		PROCEDURAL_CHANCE.LIONTRAP_CHANCE,
		PROCEDURAL_CHANCE.LITWALLTORCH,
		PROCEDURAL_CHANCE.MANTRAP,
		PROCEDURAL_CHANCE.MINISTER_CHANCE,
		PROCEDURAL_CHANCE.MOLE,
		PROCEDURAL_CHANCE.MONKEY,
		PROCEDURAL_CHANCE.MOSQUITO,
		PROCEDURAL_CHANCE.NECROMANCER,
		PROCEDURAL_CHANCE.OCTOPUS,
		PROCEDURAL_CHANCE.OLMITE,
		PROCEDURAL_CHANCE.PUSHBLOCK_CHANCE,
		PROCEDURAL_CHANCE.RED_SKELETON,
		PROCEDURAL_CHANCE.ROBOT,
		PROCEDURAL_CHANCE.RUBY,
		PROCEDURAL_CHANCE.SAPPHIRE,
		PROCEDURAL_CHANCE.SKULLDROP_CHANCE,
		PROCEDURAL_CHANCE.SNAKE,
		PROCEDURAL_CHANCE.SNAP_TRAP_CHANCE,
		PROCEDURAL_CHANCE.SORCERESS,
		PROCEDURAL_CHANCE.SPARKTRAP_CHANCE,
		PROCEDURAL_CHANCE.SPIDER,
		PROCEDURAL_CHANCE.SPIKE_BALL_CHANCE,
		PROCEDURAL_CHANCE.SPRINGTRAP,
		PROCEDURAL_CHANCE.STICKYTRAP_CHANCE,
		PROCEDURAL_CHANCE.TADPOLE,
		PROCEDURAL_CHANCE.TIKIMAN,
		PROCEDURAL_CHANCE.TOTEMTRAP_CHANCE,
		PROCEDURAL_CHANCE.UFO,
		PROCEDURAL_CHANCE.VAMPIRE,
		PROCEDURAL_CHANCE.WALLTORCH,
		PROCEDURAL_CHANCE.WITCHDOCTOR,
		PROCEDURAL_CHANCE.YETI,
	}) do
		room_gen_ctx:set_procedural_spawn_chance(chance, 0)
	end

	room_gen_ctx:set_num_extra_spawns(extra_ufo, 50, 0)
	-- room_gen_ctx:set_procedural_spawn_chance(chance_ufo, 50)
	room_gen_ctx:set_procedural_spawn_chance(chance_alientank, 50)
	room_gen_ctx:set_procedural_spawn_chance(chance_alien, 40)
	room_gen_ctx:set_procedural_spawn_chance(chance_bouncetrap, 100)
	room_gen_ctx:set_procedural_spawn_chance(chance_turret, 70)
end, ON.POST_ROOM_GENERATION)