extends CharacterBody3D


var sens := 0.1
var neck_x := 0.0
var SPEED :int= 13
var JUMP_VELOCITY:int = 10
var screen_dir = Vector2.ZERO
@onready var head: Node3D = $neck


#------------------------------------------------------------------

func _unhandled_input(_event: InputEvent) -> void:
	if _event is InputEventScreenDrag:
		screen_dir.y -= _event.relative.x
		screen_dir.x -= _event.relative.y

func _physics_process(_delta: float) -> void:
	head.rotation.x = screen_dir.x * _delta*sens
	self.rotation.y = screen_dir.y *_delta *sens

	if not is_on_floor():
		velocity += get_gravity() * _delta

	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
#
	move_and_slide()
