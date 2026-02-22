extends Node
class_name item
var itemId = 1
var description
var type
var price = 200
var salePrice = 300
@onready var texture = preload("res://Sprites/UI/Onion.png")

func _init(_itemId, _description, _type, _price, _salesPrice, _texture) -> void:
	itemId = _itemId
	description = _description
	type = _type
	price = _price
	salePrice = _price
	texture = _texture
