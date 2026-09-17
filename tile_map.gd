extends TileMap



const SPECIAL_EMPTY_NULL = 0
const SPECIAL_EMPTY_COIN = 2
const TILE_SCALE = 16.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for tile_pos in get_used_cells(0):
		var tiledata = get_cell_tile_data(0, tile_pos)
		var special_data = tiledata.get_custom_data("Special_tile")
		if special_data == SPECIAL_EMPTY_NULL: continue
		
		if special_data == SPECIAL_EMPTY_COIN:
			var new_tile = Coin.new()
			add_child(new_tile)
			new_tile.global_position = tile_pos * TILE_SCALE
		else:
			var new_tile = SpecialBrick.new()
			new_tile.define(special_data, self, tile_pos)
			add_child(new_tile)
			new_tile.global_position = tile_pos * TILE_SCALE
		
		set_cell(0, tile_pos, -1)
			

#func get_tile_special():
	#
	#var data = get_cell_tile_data()
	#if data:
		#return data.get_custom_data("Special_tile")
	#else:
		#return 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
"""

block
	0:2, u2: type
	2:3, u3: content

type 2
content 0

A << B = A * 2^B

0001_1101 << 2

0111_0100

00011101 & 0x3
00000011
00000001 --> type

00011101 >> 2
00000111 & 0x7
00000111
00000111 --> content

ccc_tt

ccc << 2 + tt
ccc__ + tt
ccctt

content:
	0: empty
	1: coin
	2: mushroom
	3: flower
	4: star
	5: bean
	
type:
	0: null
	1: bricks
	2: mystery
	3: invisibles
	
	
	
for tile within map:
	tile.special is:
		empty bricks:
			create brick object with nothing inside with position tile.xy
			clear tile at tile.xy
			
		mushroom mystery:
			create mystery object with mushroom inside with position tile.xy
			clear tile at tile.xy
			
		default: skip



class coin:
	stuff

class special block:
	tilemap: reference
	content: u3
	type: bricks / mystery / invisible
	
	
	

"""
