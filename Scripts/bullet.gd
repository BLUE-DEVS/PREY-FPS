extends Area3D
const SPEED = 60

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	position += -transform.basis.z * SPEED * _delta

func _on_body_entered(_body: Node3D) -> void:
	queue_free()

func _on_body_shape_entered(_body_rid: RID, _body: Node3D, _body_shape_index: int, _local_shape_index: int) -> void:
	if _body is CharacterBody3D:
		UnivarsalScript.ply_helath -= randi_range(10,20)
		print(UnivarsalScript.ply_helath)
