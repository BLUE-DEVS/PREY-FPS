extends Node3D
class_name gameworld


@onready var player: CharacterBody3D = $Player
@onready var moneymusic: AudioStreamPlayer = $moneymusic


func _ready() -> void:
	$Player/neck.rotation = Vector3.ZERO
	$Player/neck/Camera3D.rotation = Vector3.ZERO

func when_player_touch_line(_body: Node3D) -> void:
	if _body.name == "Player":
		UnivarsalScript.money += 500
		moneymusic.play()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/game_map.tscn")
		



func _on_teleporter_body_entered(_body: Node3D) -> void:
	if _body.name == "Player":
		UnivarsalScript.chances -= 1
		player.global_position = Vector3(57.519,6.889,-17.15)
		if UnivarsalScript.chances == 0:
			get_tree().change_scene_to_file("res://Scenes/game_map.tscn")


func _on_airplaintime_timeout() -> void:
	var randnum : int = randi_range(1,4)
	if randnum == 1:
		$airplainanimton.play("airplainanim1") 
		$airplain/AudioStreamPlayer3D.play(2)
