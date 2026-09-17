extends StaticBody2D
class_name SpecialBrick

var tilemap: TileMap
var tile_pos: Vector2i
var content: int
var type: int
var sprite: Sprite2D



func _init():
	pass
	
func define(data: int, _tilemap: TileMap, _tile_pos: Vector2i):
	tilemap = _tilemap
	tile_pos = _tile_pos
	content = (data >> 2) & 0b0000_0111
	type = data & 0b0000_0011
	
	var collider = CollisionShape2D.new()
	add_child(collider)
	collider.shape = preload("res://block_shape.tres")
	
	if type == 1:
		sprite = Sprite2D.new()
		add_child(sprite)
		sprite.texture = preload("res://tilesprites-kopi/sprite_brick_brick.png")
		
	elif type == 2:
		sprite = Sprite2D.new()
		add_child(sprite)
		sprite.texture = preload("res://tilesprites-kopi/sprite_brick_mystery.png")
	
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
##class special block:
	#tilemap: reference
	#content: u3
	#type: bricks / mystery / invisible
