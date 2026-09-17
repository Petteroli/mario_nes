extends CharacterBody2D

@export var acc_gravity: float
@export var acc_walk: float
@export var acc_run: float
@export var frx_air_run: float

@export var dur_jump: int
@export var acc_jump: float
@export var fce_jump: float

@export var frx_ground: float
@export var frx_air: float
@export var frx_turn: float
@export var cap_speed: float

@export var min_turncancelspeed: float

@export var ground_area: Area2D
@export var collision_area: Area2D

@export var animation: AnimatedSprite2D
@export var scl_anim_speed: float

var can_jump: bool
var is_grounded: bool
var dur_jump_current: int
var input_direction: float
var min_runspeed: float
var cap_speed_walk: float
var cap_speed_run: float
var is_turning: bool
var neutral_input_timer: int
var neutral_timer_threshold: int
var min_velocity: float
var debug_startposition: Vector2
var globalposition_actual: Vector2



func _ready() -> void:
	min_velocity = 1;
	can_jump = false
	is_grounded = true
	cap_speed_walk = cap_speed
	cap_speed_run = cap_speed * acc_run / acc_walk
	min_runspeed = cap_speed_walk
	is_turning = false
	neutral_input_timer = 0
	neutral_timer_threshold = 10
	debug_startposition = global_position
	

func _physics_process(delta: float) -> void:
	global_position = globalposition_actual
	debug_actions()
	check_grounded()
	input_direction = 0.0
	if Input.is_action_pressed("Left"):
		input_direction -= 1.0
	if Input.is_action_pressed("Right"):
		input_direction += 1.0
	move(input_direction, Input.is_action_pressed("Run"), Input.is_action_just_pressed("Jump"), Input.is_action_pressed("Jump"))
	check_collisions()
	animation_movement()
	move_and_slide()
	globalposition_actual = global_position
	global_position = round(global_position)
	
	
func move(_direction: float, _is_running: bool, _jumped: bool, _is_jumping: bool):
	var _air_debuff = frx_air_run 
	if is_grounded:
		_air_debuff = 1.0
		
	if input_direction == 0:
		if neutral_input_timer < 255:
			neutral_input_timer += 1
	else:
		neutral_input_timer = 0
		
	if input_direction == -sign(velocity.x) and abs(velocity.x) > min_runspeed:
		is_turning = true
	if input_direction == sign(velocity.x) or (input_direction == 0 and neutral_input_timer > neutral_timer_threshold) or abs(velocity.x) < min_turncancelspeed or (not is_grounded):
		is_turning = false
	
	if not is_turning:
		if _is_running:
			velocity.x += sign(_direction) * acc_run * _air_debuff
			if abs(velocity.x) > cap_speed_run:
				velocity.x = cap_speed_run * sign(velocity.x)
		else:
			velocity.x += sign(_direction) * acc_walk * _air_debuff
			if abs(velocity.x) > cap_speed_walk:
				velocity.x = cap_speed_walk * sign(velocity.x)

	if is_grounded:
		if is_turning:
			velocity.x *= frx_turn
		
		dur_jump_current = 0
		if _jumped:
			velocity.y -= fce_jump
			is_grounded = false
		
		if _direction == 0.0:
			velocity.x *= frx_ground
		if _direction != sign(velocity.x):
			velocity.x *= frx_ground
		#if _direction < cap_speed / 2:
			#velocity.x *= frx_ground
			#FIKS DETTE, LAGE BRA flipping animasjon, funker ikke
		
		
	else:
		velocity.y += acc_gravity
		if _direction == 0.0 or _direction != sign(velocity.x):
			velocity.x *= frx_air
			
		if dur_jump_current < dur_jump:
			if _is_jumping:
				dur_jump_current += 1
				velocity.y -= acc_jump
			else:
				dur_jump_current = dur_jump
				
	if abs(velocity.x) < min_velocity:
		velocity.x = 0
			
			
func check_grounded():
	is_grounded = false
	for _body in ground_area.get_overlapping_bodies():
		if _body is StaticBody2D:
			is_grounded = true
			
func animation_movement():
	check_grounded()
	if is_grounded == true:
		if velocity.x == 0:
			animation.play("idle", 1, true)
			return
		
		if is_turning:
			animation.play("turning", 1, true)
			return
			
		animation.play("walking", abs(velocity.x) * scl_anim_speed, true)
		animation.flip_h = velocity.x < 0
		return
	
	animation.play("jumping", abs(velocity.x) * scl_anim_speed, true)
	
	
	
func check_collisions():
	for _body in collision_area.get_overlapping_bodies():
		if _body is Coin:
			_body.collect()
			
			
			
			
			
func debug_actions():
	if Input.is_action_pressed("reset"):
		global_position = debug_startposition
		velocity.x = 0
		velocity.y = 0


	
	
	
