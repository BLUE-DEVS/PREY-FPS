extends Control

@onready var sesivity_slider: HSlider = $sesivity_slider
@onready var ui_animations: AnimationPlayer = $"../ui_animations"


func _ready() -> void:
	sesivity_slider.value = UnivarsalScript.sensivity
	$ui_bg_muisc.play(1)


## ok bhai me univarsal logic ko global script bana raha hu don't khujli it


## play button logic

## when play pressed scene changed!
func _input(event: InputEvent) -> void:
	if event is InputEvent == Input.is_action_just_pressed("play"):
		$"../ui_animations".play("game_start")
		await get_tree().create_timer(2.5).timeout
		get_tree().change_scene_to_file("res://Scenes/lobby.tscn")


func setting_visible():
	$play.visible = false
	$quit.visible = false
	$settings.visible = false
	$"Back from settings".visible = true
	$sensivity_labe.visible = true
	$music_labe.visible = true
	$sesivity_slider.visible = true
	$music_slider.visible = true
	
	
func setting_not_vis():
	$"Back from settings".visible = false
	$sensivity_labe.visible = false
	$music_labe.visible = false
	$sesivity_slider.visible = false
	$music_slider.visible = false


func _on_sesivity_slider_value_changed(_value: float) -> void:
	UnivarsalScript.sensivity = _value


func _on_music_slider_value_changed(_value: float) -> void:
	$ui_bg_muisc.volume_db = _value
	if _value == -19:
		$ui_bg_muisc.stream_paused = true
	else :
		$ui_bg_muisc.stream_paused = false


func _on_settings_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			$play.visible = false
			$quit.visible = false
			$settings.visible = false
			ui_animations.play("move_to_settings")
			$click_sound.play()
			await get_tree().create_timer(1.8).timeout
			setting_visible()
			Input.action_press("settings")
	else:
		Input.action_release("settings")


func _on_quit_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			$click_sound.play()
			get_tree().quit()
			Input.action_press("quit")
	else:
		Input.action_release("quit")


func _on_play_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			$click_sound.play()
			$play.visible = false
			$quit.visible = false
			$settings.visible = false
			
			Input.action_press("play")
			
		else:
			Input.action_release("play")


func _on_back_from_settings_gui_input(_event: InputEvent) -> void:
	if _event is InputEventScreenTouch:
		if _event.pressed:
			$click_sound.play()
			setting_not_vis()
			$"../ui_animations".play("back_from_settings")
			await get_tree().create_timer(1.9).timeout
			$play.visible = true
			$quit.visible = true
			$settings.visible = true
			Input.action_press("back")
			
	else:
		Input.action_release("back")
