extends CharacterBody3D
class_name Killable
var heath:int=100
@onready var player : CharacterBody3D =  get_tree().get_nodes_in_group("player_gro")[0]
var SPEED :float= 13
var JUMP_VELOCITY:int = 10
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D


func _process(_delta: float) -> void:
	if heath <= 0:
		queue_free()



	if not is_on_floor():
		velocity += get_gravity() * _delta


	move_and_slide()

func damage():
	var _damage = randi_range(50,70)
	heath -= _damage
	print(_damage)
