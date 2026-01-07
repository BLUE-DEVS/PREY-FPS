extends Control


func _ready() -> void:
	$ui_bg_muisc.play(1)

#Bhai plx UI ko accha bnana ;_; or accha banao and setting menu me fov sensitivityect daal dena

## play button logic
func _on_play_button_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			Input.action_press("play")
		else:
			Input.action_release("play")


## when play pressed scene changed!
func _input(event: InputEvent) -> void:
	if event is InputEvent == Input.is_action_just_pressed("play"):
		get_tree().change_scene_to_file("res://Scenes/lobby.tscn")
