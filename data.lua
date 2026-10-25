local mod_name = '__ConnectionBox_fx__'
local name = 'connection-box'
local icon = mod_name .. '/graphics/icons/'..name..'.png'

local entity = 
{
	type = "electric-pole",
	name = name,
	icon = icon,
	icon_size = 32,

	-- 2.0 - SA
	quality_indicator_scale = 0.75,
	auto_connect_up_to_n_wires = 0, -- version 2.1.3
	-- /2.0 - SA



--	flags = {"placeable-neutral", "player-creation", "fast-replaceable-no-build-while-moving"},
	flags = {"placeable-neutral", "player-creation"}, -- 2.0 SA
	minable = {hardness = 0.2, mining_time = 2, result = name},
	max_health = 100,
	corpse = "small-remnants",
	collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	drawing_box = {{-0.5, -0.5}, {0.5, 0.5}},
	maximum_wire_distance = 9.5,
	supply_area_distance = 1.5,
	vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
	track_coverage_during_build_by_moving = false,
	fast_replaceable_group = "electric-pole",
	pictures =
	{
		filename = mod_name .. '/graphics/entity/'..name..'.png',
		priority = "extra-high",
		width = 128,
		height = 128,
		direction_count = 1,
		scale = 0.5,
		hr_version = 
		{
			filename = mod_name .. '/graphics/entity/hr-'..name..'.png',
			priority = "extra-high",
			width = 256,
			height = 256,
			direction_count = 1,
			scale = 0.25
		}
	},
	connection_points =
	{
		{
			wire =
			{
				copper = {      0, -84/256}, -- {0, -0.375},
				red =    {-74/256,  32/256},
				green =  { 72/256,  32/256}
			},
			shadow =
			{
				copper = {114/256,  18/256},
				red =    { 42/256, 134/256},
				green =  {186/256, 134/256}
			},
		}
	},
	radius_visualisation_picture =
	{
		filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
		width = 12,
		height = 12,
		priority = "extra-high-no-scale"
	}
}

local item = 
{
	type = "item",
	name = name,
	icon = icon,
	icon_size = 32,
	-- flags = {"goes-to-quickbar"}, -- was for 0.17
	-- subgroup = "energy-pipe-distribution", -- was for 0.18
	subgroup = "circuit-network", -- added in 1.2.1 for 1.0 and SchallCircuitGroup
	-- https://mods.factorio.com/mod/SchallCircuitGroup
	-- order = "a[energy]-z",
	order = "b[wires]-c[connection-box]",
	place_result = name,
	stack_size = 50
}

local recipe = 
{
	type = "recipe",
	name = name,
	ingredients =
	{
		-- changed item from simple to full for 2.0 SA
		{type = "item", name = "concrete", amount =2},
		{type = "item", name = "copper-cable", amount = 2}
	},
--    result = name,
	results = {
		-- changed item from simple to full for 2.0 SA
		{type = "item", name = name, amount = 10},
	},
}

-- 2.0 - SA

local recycling

if mods['quality'] then
	recycling	= {
		type = "recipe",
		name = name.."-recycling",

		subgroup = "other",
		category = "recycling",
		results = {
			{type = "item", name = "concrete", amount = 0.125, extra_count_fraction = 0.125},
			{type = "item", name = "copper-cable", amount = 0.125, extra_count_fraction = 0.125},
		},
		ingredients = {
			{type = "item", name = name, amount = 1},
		},
		energy_required = 0.0625,
		hidden = true,
		allow_decomposition = false,
		unlock_results = false,

		localised_name = {
			"recipe-name.recycling",
			{"entity-name."..name},
		},

		icons = {
			{icon = "__quality__/graphics/icons/recycling.png"},
			{icon = icon, scale = 0.4},
			{icon = "__quality__/graphics/icons/recycling-top.png"},
		},

		crafting_machine_tint = {
			primary = {0.5, 0.5, 0.5, 0.5},
			secondary = {0.5, 0.5, 0.5, 0.5},
			tertiary = {0.5, 0.5, 0.5, 0.5},
			quaternary = {0.5, 0.5, 0.5, 0.5},
		},
	}
end

-- /2.0 - SA


if data.raw["item-subgroup"] and data.raw["item-subgroup"]["circuit-connection"] then
	item.subgroup = "circuit-connection"
end


data:extend({entity, item, recipe})

if recycling then
	data:extend({entity, item, recipe, recycling})
end