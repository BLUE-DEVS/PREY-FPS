extends CharacterBody3D
class_name Killable
var heath:int=100
var SPEED :float= randi_range(6,10)
var JUMP_VELOCITY:int = 17
@onready var nav_agen: NavigationAgent3D = $NavigationAgent3D
@onready var player = get_tree().get_nodes_in_group("player_gro")[0]
@onready var ani: AnimationPlayer = $"ninja again/AnimationPlayer"
@onready var ray: RayCast3D = $RayCast3D
var _can_jump :bool = true
var run:bool=true       

func _process(_delta: float) -> void:

	if ray.is_colliding():
		_can_jump = true
		if _can_jump and ani.current_animation != "jump":
			_can_jump = false
			run = false
			ani.current_animation = "jump"
			rotation.y += 90
			await ani.animation_finished
			ani.current_animation = "run"
			_can_jump = true
			run = true

	process_move()

	if heath <= 0:
		run = false
		_can_jump = false
		player = self
		ani.current_animation = "diee"
		await ani.animation_finished
		queue_free()

	nav_agen.set_target_position(player.global_position)
	look_at(Vector3(player.global_position.x,1,player.global_position.z))
func _physics_process(_delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * _delta

	move_and_slide()

func damage():
	var _damage = randi_range(50,70)
	heath -= _damage
	print(_damage)

func process_move() -> void:
	if run:
		ani.current_animation = "run"
	
	if nav_agen.is_navigation_finished():
		return
	var next_posi: Vector3 = nav_agen.get_next_path_position()
	velocity = global_position.direction_to(next_posi) * SPEED


func _on_timer_timeout() -> void:
	SPEED = randi_range(6,13)


func _on_timer_2_timeout() -> void:
	var _slide_ran :int=randi_range(1,2)
	if _slide_ran == 1 and ani.current_animation != "jump" or ani.current_animation != "jump":
		run = false
		_can_jump = false
		ani.current_animation = "slide"
		await ani.animation_finished
		run = true
	else:
		run = false
		_can_jump=false
		ani.current_animation = "jump"
		await ani.animation_finished
		run = true
