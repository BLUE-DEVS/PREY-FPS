extends Control

@onready var sesivity_slider: HSlider = $sesivity_slider

func _ready() -> void:
	sesivity_slider.value = UnivarsalScript.sensivity
	$ui_bg_muisc.play(1)

#Bhai plx UI ko accha bnana ;_; or accha banao and setting menu me fov sensitivityect daal dena
## ok bhai me univarsal logic ko global script bana raha hu don't khujli it


## play button logic
func _on_play_button_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			Input.action_press("play")
			$click_sound.play()
		else:
			Input.action_release("play")
			
func _on_back_button_gui_input(_event: InputEvent) -> void:
	if _event is InputEventScreenTouch:
		if _event.pressed:
			$click_sound.play()
			setting_not_vis()
			Input.action_press("back")
	else:
		Input.action_release("back")
	

func _on_settings_button_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			$click_sound.play()
			setting_visible()
			Input.action_press("settings")
	else:
		Input.action_release("settings")
		
func _on_quit_button_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			$click_sound.play()
			get_tree().quit()
			Input.action_press("quit")
	else:
		Input.action_release("quit")

## when play pressed scene changed!
func _input(event: InputEvent) -> void:
	if event is InputEvent == Input.is_action_just_pressed("play"):
		get_tree().change_scene_to_file("res://Scenes/lobby.tscn")
		
		
		

	
func setting_visible():
	$back_button.visible = true
	$MainUiBakground.visible = true
	$sensivity_labe.visible = true
	$music_labe.visible = true
	$sesivity_slider.visible = true
	$music_slider.visible = true
	
	
func setting_not_vis():
	$back_button.visible = false
	$MainUiBakground.visible = false
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
