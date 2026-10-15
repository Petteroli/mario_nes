extends Node

class_name Score

static var INSTANCE: Score = null

const LABEL_TEXT_COIN = "Coins: "



var coin_count: int
var life_count: int

@export var label: Label

func _init():
	if INSTANCE != null:
		var a = [0]
		a[1] = 0
		#freaky array
		
	coin_count = 0
	life_count = 0
	
	INSTANCE = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func addCoins(count: int) -> void:
	coin_count += count
	life_count += int(coin_count / 100)
	coin_count %= 100
	
	print(coin_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var label_text = ""
	label_text += LABEL_TEXT_COIN + str(coin_count)
	label.text = label_text
