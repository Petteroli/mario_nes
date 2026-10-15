extends Item
class_name Mushroom



const OFFSET_SELF: Vector2 = Vector2(8, 8)
const OFFSET_COLLIDER: Vector2 = Vector2(-2, 1)
const OFFSET_SPRITE: Vector2 = Vector2(0, 0)

var sprite: Sprite2D



func _init():
	global_position = OFFSET_SELF
	var collider = CollisionShape2D.new()
	collider.shape = preload("res://item_shape.tres")
	add_child(collider)
	collider.position = OFFSET_COLLIDER

	sprite = Sprite2D.new()
	add_child(sprite)
	sprite.texture = preload("res://tilesprites-kopi/mushroom_sprite.png")
	sprite.position = OFFSET_SPRITE
	
	collision_layer = COLLISION_LAYER_ITEM
	collision_mask = COLLISION_LAYER_ITEM



func _physics_process(delta: float) -> void:
	pass
	
func collect():
	sprite.texture = null;
	#Score.INSTANCE.addCoins(1)
	self.queue_free()
	

##class special block:
	#tilemap: reference
	#content: u3
	#type: bricks / mystery / invisible
