extends Control


@onready var boot_anim: AnimationPlayer = $boot_anim


func _ready() -> void:
	boot_anim.play("boot_anim")
	
	
