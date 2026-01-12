extends Node3D
@onready var player = get_tree().get_nodes_in_group("player_gro")[0]
@onready var ani: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	ani_dece()



func _process(_delta: float) -> void:

	look_at(player.global_position)
	



func ani_dece():
	var _ani_ply = randi_range(1,2)
	if _ani_ply == 1:
		ani.play("ran_mov1")
	else:
		ani.play("ran_mov2")

func _on_timer_timeout() -> void:
	ani_dece()
