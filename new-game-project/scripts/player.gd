extends CharacterBody2D

var speed : float = 250
	
func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2(Input.get_axis("left","right"), Input.get_axis("up", "down"))
	velocity = direction.normalized() * speed
	move_and_slide()
