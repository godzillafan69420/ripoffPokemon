extends Node2D

var PlayerHP = 20
var playerDamage = 3
var enemyHP = 20
var turn = 0
var enemiesTurn = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/TextureProgressBar.max_value = enemyHP
	$UI/TextureProgressBar.value = enemyHP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	if !enemiesTurn:
		$UI/TextureProgressBar.value -= playerDamage
		print($UI/TextureProgressBar.value)
	
		
	
