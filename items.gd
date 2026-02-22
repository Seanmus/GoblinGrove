extends Node

#replace textures for herring and herring_seed
enum types {
	seed,
	tool,
	crop
}

var onion = item.new(1,"Stinky Onion",types.crop, 100, 100, preload("res://Sprites/UI/Onion.png"))
var onion_seed = item.new(2,"Onion Seed", types.seed, 50, 25, preload("res://Sprites/Plants/Onion/onion_1.png"))
var herring = item.new(3,"Pickeled Herring",types.crop, 250, 200, preload("res://Sprites/UI/fish_icon.png"))
var herring_seed = item.new(4,"Regular Old Herring",types.seed, 50, 200, preload("res://Sprites/Plants/Fish/fish_1.png"))
var wateringCan = item.new(5,"Vinegar Cans",types.tool, 0, 0, preload("res://Sprites/UI/vinegar_can.png"))

var items = {  1 :onion, 2 : onion_seed, 3 : herring, 4 : herring_seed, 5: wateringCan}
