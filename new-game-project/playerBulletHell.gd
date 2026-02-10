extends Node2D
const SetSpeed: float = 4
const SetSlowSpeed :float = 2
var direction: Vector2
var Speed :float = 5.5

func _process(_delta: float) -> void:
	if Input.is_action_pressed("left") and position.x > 176:
		direction = Vector2(-1, direction.y)
	elif Input.is_action_pressed("right") and position.x < 468:
		direction = Vector2(1, direction.y)
	else:
		direction = Vector2(0, direction.y)
	if Input.is_action_pressed("up") and position.y > 136:
		direction = Vector2(direction.x, -1)
	elif Input.is_action_pressed("down") and position.y < 292:
		direction = Vector2(direction.x, 1)
	else:
		direction = Vector2(direction.x, 0)

	position += direction.normalized() * Speed
	if Input.is_action_pressed("slowDown"):
		Speed = SetSlowSpeed
	else:
		Speed = SetSpeed
	
