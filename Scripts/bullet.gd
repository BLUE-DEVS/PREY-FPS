extends Area3D
const SPEED = 60

func _process(_delta: float) -> void:
	position += -transform.basis.z * SPEED * _delta

func _on_body_entered(_body: Node3D) -> void:
	queue_free()

func _on_body_shape_entered(_body_rid: RID, _body: Node3D, _body_shape_index: int, _local_shape_index: int) -> void:
	if _body is CharacterBody3D or _body.is_in_group("player_group"):
		UnivarsalScript.ply_helath -= randi_range(6,13)
