extends Area2D
class_name Coin



const offset: Vector2 = Vector2(4, 2)

var sprite: Sprite2D



func _init():
	global_position += offset
	var collider = CollisionShape2D.new()
	add_child(collider)
	collider.shape = preload("res://coin_shape.tres")

	sprite = Sprite2D.new()
	add_child(sprite)
	sprite.texture = preload("res://tilesprites-kopi/sprite_coin.png")
	sprite.global_position -= offset

	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func collect():
	pass

##class special block:
	#tilemap: reference
	#content: u3
	#type: bricks / mystery / invisible
