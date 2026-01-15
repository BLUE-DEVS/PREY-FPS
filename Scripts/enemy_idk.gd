extends CharacterBody3D

class_name Enemy

@onready var player = get_tree().get_nodes_in_group("player_gro")[0]
@onready var ani: AnimationPlayer = $"../AnimationPlayer"
var bullet = preload("res://Scenes/bullet.tscn")
var health :int=100

func _ready() -> void:
	var _time_diff:float=randf_range(0.1,0.5)
	ani_dece()
	spawn_bul()
	await get_tree().create_timer(_time_diff).timeout
	spawn_bul2()

func _process(_delta: float) -> void:

	if health <= 0:
		queue_free()

	look_at(player.global_position)

func ani_dece():
	var _ani_ply = randi_range(1,2)
	if _ani_ply == 1:
		ani.play("ran_mov1")
	else:
		ani.play("ran_mov2")

func _on_timer_timeout() -> void:
	ani_dece()


func spawn_bul():
	var _bul_scene = bullet.instantiate()
	add_child(_bul_scene)
	_bul_scene.global_position = $"Assault Rifle".global_position
	_bul_scene.transform.basis = $"Assault Rifle".transform.basis
	$"../AudioStreamPlayer3D".play()

func spawn_bul2():
	var _bul_scene = bullet.instantiate()
	add_child(_bul_scene)
	_bul_scene.global_position = $"Assault Rifle2".global_position
	_bul_scene.transform.basis = $"Assault Rifle2".transform.basis
	$"../AudioStreamPlayer3D".play()

func _on_timer_2_timeout() -> void:
	var _time_diff:float=randf_range(0.1,0.5)
	spawn_bul()
	await get_tree().create_timer(_time_diff).timeout
	spawn_bul2()


func damage(_amount:int):
	health -= _amount
	
	$CollisionShape3D.position.z += 0.3
	$MeshInstance3D.position.z += 0.3
	$"Assault Rifle".position.z += 0.3
	$"Assault Rifle2".position.z += 0.3
	$"Bot Drone".position.z += 0.3

	$CollisionShape3D.rotate_x(deg_to_rad(30))
	$MeshInstance3D.rotate_x(deg_to_rad(30))
	$"Assault Rifle".rotate_x(deg_to_rad(30))
	$"Assault Rifle2".rotate_x(deg_to_rad(30))
	$"Bot Drone".rotate_x(deg_to_rad(30))

	await get_tree().create_timer(0.2).timeout

	$CollisionShape3D.position.z -= 0.3
	$MeshInstance3D.position.z -= 0.3
	$"Assault Rifle".position.z -= 0.3
	$"Assault Rifle2".position.z -= 0.3
	$"Bot Drone".position.z -= 0.3

	$CollisionShape3D.rotate_x(deg_to_rad(-30))
	$MeshInstance3D.rotate_x(deg_to_rad(-30))
	$"Assault Rifle".rotate_x(deg_to_rad(-30))
	$"Assault Rifle2".rotate_x(deg_to_rad(-30))
	$"Bot Drone".rotate_x(deg_to_rad(-30))
