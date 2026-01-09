extends CSGBox3D
class_name Killable
var heath:int=100


func _process(_delta: float) -> void:
	if heath <= 0:
		queue_free()


func damage():
	var _damage = randi_range(50,70)
	heath -= _damage
	print(_damage)
