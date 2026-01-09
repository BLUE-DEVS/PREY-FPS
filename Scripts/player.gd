extends CharacterBody3D

enum hand_state {blank,with_sniper,with_smg}
@onready var shoot_dec: RayCast3D = $"neck/shoot detecter"
@onready var sniper: Node3D= $"neck/Sniper Rifle"
var neck_x := 0.0
var SPEED :float= 13
var JUMP_VELOCITY:int = 10
var screen_dir = Vector2.ZERO
@onready var head: Node3D = $neck
var sliding:bool = false
@onready var ani: AnimationPlayer = $AnimationPlayer
var sliding_time:float= 0.0
var max_sliding_time:float= 1.0
var slide_sp:int=17
var _crouching :bool 
var can_wall_jump :bool= true
var current_hand_state = hand_state.blank
@onready var smg: Node3D = $"neck/Assault Rifle"
var is_reloading:bool=false


#DO NO TOUCH OR CHANGE abhi me or bhi kaam karuga! ;D
## ok bro nhi karunaga bas dekh raha hu :D
#or ye Fullscreen ko hata do plzz😭😭
#I added wall jumping (particals apka kaam h :)

#------------------------------------------------------------------

func _ready() -> void:
	ani.current_animation = "idle"
	$CollisionShape3D.scale.y = 1
	head.position.y = 0
	current_hand_state = hand_state.with_sniper

func _unhandled_input(_event: InputEvent) -> void:
	if _event is InputEventScreenDrag:
		screen_dir.y -= _event.relative.x
		screen_dir.x -= _event.relative.y

func _physics_process(_delta: float) -> void:

	if Input.is_action_just_pressed("slide") and Input.is_action_pressed("w") and is_on_floor() and not sliding:
		slide()

	if current_hand_state == hand_state.with_sniper:
		sniper.show()
		smg.hide()
		$CanvasLayer/shoot_butt.show()
		ani.current_animation = "gun hold"
	elif current_hand_state == hand_state.with_smg:
		sniper.hide()
		smg.show()
		ani.current_animation = "gun hold"
		$CanvasLayer/shoot_butt.show()
	else:
		smg.hide()
		sniper.hide()
		$CanvasLayer/shoot_butt.hide()
		if Input.is_action_pressed("w"):
			ani.current_animation = "run"

	if sliding:
		sliding_time -= _delta
		velocity.x = move_toward(velocity.x, 0, _delta * 6)
		velocity.z = move_toward(velocity.z, 0, _delta * 6)

		if sliding_time <= 0:
			end_slide()

	if Input.is_action_just_pressed("shift") and not sliding:
		_crouching = not _crouching
		if _crouching:
			SPEED = 7
			$CollisionShape3D.scale.y = 0.6
			head.position.y = -0.6
		elif  not _crouching:
			SPEED = 13
			$CollisionShape3D.scale.y = 1
			head.position.y = 0


	if Input.is_action_pressed("w"):
		var _tween = get_tree().create_tween()
		_tween.tween_property($neck/Camera3D,"fov",90,0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)



	if Input.is_action_just_released("w"):
		var _tween = get_tree().create_tween()
		_tween.tween_property($neck/Camera3D,"fov",75,0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		ani.current_animation = "idle"

	head.rotation.x = screen_dir.x * _delta* UnivarsalScript.sensivity
	self.rotation.y = screen_dir.y *_delta * UnivarsalScript.sensivity

	if not is_on_floor():
		velocity += get_gravity() * _delta

	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("ui_accept") and is_on_wall_only() and can_wall_jump:
		velocity.y = JUMP_VELOCITY
		can_wall_jump = false
		await get_tree().create_timer(2).timeout
		can_wall_jump=true


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
	velocity.x = forward_dir.x * slide_sp
	velocity.z = forward_dir.z * slide_sp
	JUMP_VELOCITY = 10
	$CollisionShape3D.scale.y -= 0.4
	head.position.y = -0.9

func end_slide():
	sliding = false
	JUMP_VELOCITY = 10
	ani.current_animation = "idle"
	$CollisionShape3D.scale.y = 1
	head.position.y = 0

## setting button here
func _on_texture_button_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			$CanvasLayer/ui_bg_muisc.play()
			$CanvasLayer/click_sound.play()
			player_settings_visible()
			get_tree().paused = true
			Input.action_press("settings_while_playing")
		else:
			Input.action_release("settings_while_playing")

func _on_back_button_pla_gui_input(_event: InputEvent) -> void:
	if _event is InputEventScreenTouch:
		if _event.pressed:
			$CanvasLayer/ui_bg_muisc.stop()
			$CanvasLayer/click_sound.play()
			get_tree().paused = true
			Input.action_press("back")
			player_setting_unvisible()
			get_tree().paused = false
		else:
			Input.action_release("back")
	

func _on_quit_game_gui_input(_event: InputEvent) -> void:
	if _event is InputEventScreenTouch:
		if _event.pressed:
			$CanvasLayer/ui_bg_muisc.stop()
			get_tree().paused = false
			Input.action_press("quit")
			player_setting_unvisible()
			player_setting_unvisible()
			get_tree().change_scene_to_file("res://Scenes/main_ui.tscn")
		else:
			Input.action_release("quit")

func player_settings_visible():
	$CanvasLayer/quit_game.visible = true
	$CanvasLayer/gamesettings.visible = true
	$CanvasLayer/back_button_pla.visible = true
	
func player_setting_unvisible():
	$CanvasLayer/quit_game.visible = false
	$CanvasLayer/gamesettings.visible = false
	$CanvasLayer/back_button_pla.visible = false

func _on_shoot_butt_pressed() -> void:
	if shoot_dec.is_colliding() and not is_reloading:
		var _collider = shoot_dec.get_collider()
		if _collider is Killable:
			_collider.damage()
	_reload()


func _reload():
	is_reloading = true
	#ani.current_animation = "sniper_reload"
	await get_tree().create_timer(1).timeout
	is_reloading = false
