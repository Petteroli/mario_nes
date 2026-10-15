extends StaticBody2D
class_name Item

const COLLISION_LAYER_ITEM = 0b00000000_000000000_00000000_00000010



func collect():
	pass


#content:
	#0: empty
	#1: coin
	#2: mushroom
	#3: flower
	#4: star
	#5: bean
	#
#type:
	#0: null
	#1: bricks
	#2: mystery
	#3: invisibles
