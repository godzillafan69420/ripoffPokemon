extends CharacterBody2D

var speed : float = 250
var canMove: bool = true

var mydic = {"sigma": {"me cool": 'i'}}

func _ready() -> void:
	add_to_group("Player")
	print(mydic["sigma"]["me cool"])
	
func _physics_process(_delta: float) -> void:
	if !canMove:
		return
	
	var direction: Vector2 = Vector2(Input.get_axis("left","right"), Input.get_axis("up", "down"))
	velocity = direction.normalized() * speed
	move_and_slide()
