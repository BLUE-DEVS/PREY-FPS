extends CharacterBody3D

var sens := 0.1
var neck_x := 0.0
var SPEED :float= 13
var JUMP_VELOCITY:int = 10
var screen_dir = Vector2.ZERO
@onready var head: Node3D = $neck
var sliding:bool=false
@onready var ani: AnimationPlayer = $AnimationPlayer
var sliding_time:float= 0.0
var max_sliding_time:float= 1.0
var slide_sp:int=17

#DO NO TOUCH OR CHANGE abhi me or bhi kaam karuga! ;D
#------------------------------------------------------------------

func _ready() -> void:
	ani.current_animation = "idle"


func _unhandled_input(_event: InputEvent) -> void:
	if _event is InputEventScreenDrag:
		screen_dir.y -= _event.relative.x
		screen_dir.x -= _event.relative.y

func _physics_process(_delta: float) -> void:

	if Input.is_action_just_pressed("slide") and Input.is_action_pressed("w") and is_on_floor() and not sliding:
		slide()
	if Input.is_action_just_pressed("shift") and Input.is_action_pressed("w") and is_on_floor():
		SPEED = 7

	if sliding:
		sliding_time -= _delta
		velocity.x = move_toward(velocity.x, 0, _delta * 6)
		velocity.z = move_toward(velocity.z, 0, _delta * 6)

		if sliding_time <= 0:
			end_slide()

	if Input.is_action_pressed("shift") and not sliding:
		scale.y = 0.6

	if Input.is_action_just_released("shift"):
		scale.y = 1
		SPEED = 13


	if Input.is_action_pressed("w"):
		var _tween = get_tree().create_tween()
		_tween.tween_property($neck/Camera3D,"fov",90,0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		ani.current_animation = "run"


	if Input.is_action_just_released("w"):
		var _tween = get_tree().create_tween()
		_tween.tween_property($neck/Camera3D,"fov",75,0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		ani.current_animation = "idle"


	head.rotation.x = screen_dir.x * _delta*sens
	self.rotation.y = screen_dir.y *_delta *sens

	if not is_on_floor():
		velocity += get_gravity() * _delta

	if Input.is_action_pressed("ui_accept") and is_on_floor() and not sliding:
		velocity.y = JUMP_VELOCITY

	if not sliding:
		var input_dir := Input.get_vector("a", "d", "w", "s")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
func slide():
	sliding = true
	sliding_time = max_sliding_time
	var forward_dir = -global_transform.basis.z
	velocity.x = forward_dir.x * SPEED + slide_sp
	velocity.z = forward_dir.z * SPEED + slide_sp
	JUMP_VELOCITY = 0
	scale.y = 0.4

func end_slide():
	sliding = false
	JUMP_VELOCITY = 10
	ani.current_animation = "idle"
	scale.y = 1
