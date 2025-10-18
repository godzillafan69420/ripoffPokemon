extends Node2D

var PlayerHP = 20
var playerDamage = 5
var enemyHP = 20
var enemyDamage = 2
var turn = 0
var enemiesTurn = false



var PlayerSpeed = 60
var PlayerCharge = 0
var enemySpeed = 40
var enemyCharge = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/enemyHPBar.max_value = enemyHP
	$UI/enemyHPBar.value = enemyHP
	$UI/Panel/playerHPBar.max_value = PlayerHP
	$UI/Panel/playerHPBar.value = PlayerHP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/Panel/playerChargeBar.value = PlayerCharge
	if PlayerCharge < 100 and enemyCharge < 100:
		
		PlayerCharge += PlayerSpeed * delta
		enemyCharge += enemySpeed * delta
	if PlayerCharge >= 100:
		enemiesTurn = false
	if enemyCharge >= 100:
		enemiesTurn = true
	if enemiesTurn:
		$UI/Panel/playerHPBar.value -= enemyDamage
		enemyCharge = 0
		enemiesTurn = false
		
	print(PlayerCharge)


func _on_button_button_down():
	if !enemiesTurn and PlayerCharge >= 100:
		$UI/enemyHPBar.value -= playerDamage
		print($UI/enemyHPBar.value)
		PlayerCharge = 0
		
	
		
	
