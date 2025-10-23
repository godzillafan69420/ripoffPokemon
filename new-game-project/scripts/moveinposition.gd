extends  Node2D

func _ready() -> void:
	for i in get_children():
		i.z_index = i.position.y
