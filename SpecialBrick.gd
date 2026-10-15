extends StaticBody2D
class_name SpecialBrick

var tilemap: TileMap
var tile_pos: Vector2i
var content: int
var type: int
var sprite: Sprite2D

var VALUE_CONTENT_COIN = 1
var VALUE_CONTENT_MUSHROOM = 2
var VALUE_CONTENT_BEAN = 5

const TILE_SCALE = 16.0


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
	collider.position += Vector2(SpecialBrick.TILE_SCALE / 2.0, SpecialBrick.TILE_SCALE / 2.0)
	
	if type == 1:
		sprite = Sprite2D.new()
		add_child(sprite)
		sprite.texture = preload("res://tilesprites-kopi/sprite_brick_brick.png")
		sprite.position += Vector2(SpecialBrick.TILE_SCALE / 2.0, SpecialBrick.TILE_SCALE / 2.0)
		
	elif type == 2:
		sprite = Sprite2D.new()
		add_child(sprite)
		sprite.texture = preload("res://tilesprites-kopi/sprite_brick_mystery.png")
		sprite.position += Vector2(SpecialBrick.TILE_SCALE / 2.0, SpecialBrick.TILE_SCALE / 2.0)
	
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate_block():
	"""
	switch content:
		item: spawn item
		coin: collect coin
		vine: generate vine
	gå fra ? til tom



	gå fra ? til tom:
		v write empty to tilemap at position
		queue_free()
	
	collect coin:
		increment coin counter in score ckass

	
	"""
	
	if content == VALUE_CONTENT_COIN:
		Coin.new().collect()
		#Lage ny coin
		#collect coin

	elif content == VALUE_CONTENT_BEAN:
		pass

	tile_pos = Vector2i(global_position.x / TILE_SCALE, global_position.y / TILE_SCALE )

	tilemap.set_cell(0, tile_pos, 1, Vector2i(4, 0))
	# tilemap.set_cell(0, tile_pos, -1, Vector2i(4, 0))
	queue_free()



##class special block:
	#tilemap: reference
	#content: u3
	#type: bricks / mystery / invisible
