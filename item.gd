extends Resource
class_name item
@export var itemId :int = 1
@export var description : String = "Onion"
@export var type : int = 3
@export var price : int = 200
@export var salePrice: int = 300
@export var texture : String = "res://Sprites/UI/Onion.png"

func _init(_itemId := itemId, _description := description, _type:= type, _price:= price, _salesPrice:= salePrice, _texture:= texture) -> void:
	itemId = _itemId
	description = _description
	type = _type
	price = _price
	salePrice = _salesPrice
	texture = _texture
