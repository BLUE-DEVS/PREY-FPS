extends Area3D
const SPEED = 90

func _process(_delta: float) -> void:
	position += -transform.basis.z * SPEED * _delta


func _on_body_entered(_body: Node3D) -> void:
	$hit_par.restart(true)
	queue_free()
