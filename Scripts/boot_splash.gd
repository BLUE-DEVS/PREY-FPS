extends Control


@onready var boot_anim: AnimationPlayer = $boot_anim


func _ready() -> void:
	boot_anim.play("boot_anim")
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://Scenes/game_map.tscn")
	
	
