extends CharacterBody2D

var speed : float = 250
var canMove: bool = true


func _ready() -> void:
	add_to_group("Player")
	
	
func _physics_process(_delta: float) -> void:
	if !canMove:
		return
	
	if Input.is_action_pressed("left"):
		$PlayerSprite.play("left")
	
	elif Input.is_action_pressed("right"):
		$PlayerSprite.play("right")
	elif Input.is_action_pressed("up"):
		$PlayerSprite.play("up")
	elif Input.is_action_pressed("down"):
		$PlayerSprite.play("down")
	else:
		$PlayerSprite.stop()
	var direction: Vector2 = Vector2(Input.get_axis("left","right"), Input.get_axis("up", "down"))
	velocity = direction.normalized() * speed
	move_and_slide()
