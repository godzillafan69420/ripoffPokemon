extends Node2D

var PlayerHP = 20
var playerDamage = 4
var enemyHP = 20
var enemyDamage = 3
var turn = 0
var enemiesTurn = false
var waitingForPlayer = false
var charging = true

var PlayerSpeed = 60
var PlayerCharge = 0
var enemySpeed = 40
var enemyCharge = 0

var enemyDef = 2
var PLayerDef = 3
var EnemyattackChoice = 0
var EnemyDodgeChoice =0
var PLayerDodgeChoice = 0
var PlayerattackChoice =0 

var criticalDamageMultiplier 
# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/enemyHPBar.max_value = enemyHP
	$UI/enemyHPBar.value = enemyHP
	$UI/Panel/playerHPBar.max_value = PlayerHP
	$UI/Panel/playerHPBar.value = PlayerHP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/Panel/playerChargeBar.value = PlayerCharge
	$UI/enemyChargeBar.value = enemyCharge
	if PlayerCharge < 100 and enemyCharge < 100 and charging:
		
		PlayerCharge += PlayerSpeed * delta
		enemyCharge += enemySpeed * delta
	if enemyCharge >= 100:
		charging = false
		enemiesTurn = true
	if PlayerCharge >= 100:
		charging = false
		enemiesTurn = false
	

	if enemiesTurn and !waitingForPlayer:
		
		if PLayerDef < 2:
			$UI/Panel/playerHPBar.value -= enemyDamage
			enemyCharge = 0
			enemiesTurn = false
			charging = true
			
		if PLayerDef == 2:
			
			EnemyattackChoice = randi_range(1,2)
			$UI/Panel/dodgeDirection.visible = true
			$UI/Panel/dodgeDirection/UP.visible = true
			$UI/Panel/dodgeDirection/DOWN.visible = true
			waitingForPlayer = true
			enemyCharge = 0
		if PLayerDef == 3:
			
			EnemyattackChoice = randi_range(1,3)
			$UI/Panel/dodgeDirection.visible = true
			$UI/Panel/dodgeDirection/UP.visible = true
			$UI/Panel/dodgeDirection/DOWN.visible = true
			$UI/Panel/dodgeDirection/LEFT.visible = true
			waitingForPlayer = true
			enemyCharge = 0
		if PLayerDef == 4:
			
			EnemyattackChoice = randi_range(1,4)
			$UI/Panel/dodgeDirection.visible = true
			$UI/Panel/dodgeDirection/UP.visible = true
			$UI/Panel/dodgeDirection/DOWN.visible = true
			$UI/Panel/dodgeDirection/LEFT.visible = true
			$UI/Panel/dodgeDirection/RIGHT.visible = true
			waitingForPlayer = true
			enemyCharge = 0
	if waitingForPlayer:
		enemyCharge = 0
	print(PlayerCharge)
	print(enemyCharge)


func _on_button_button_down():
	criticalDamageMultiplier = randf_range(0.9, 3.5)
	if !enemiesTurn and PlayerCharge >= 100 and (enemyDef == 1|| enemyDef == 0):
		$UI/enemyHPBar.value -= playerDamage * criticalDamageMultiplier
		charging = true
		PlayerCharge = 0
	if enemyDef == 2:
		EnemyDodgeChoice  = randi_range(1,2)
		$UI/Panel/attackDirection.visible = true
		$UI/Panel/attackDirection/ATTACKUP.visible = true
		$UI/Panel/attackDirection/ATTACKDOWN.visible = true
	if enemyDef == 3:
		EnemyDodgeChoice  = randi_range(1,3)
		$UI/Panel/attackDirection.visible = true
		$UI/Panel/attackDirection/ATTACKUP.visible = true
		$UI/Panel/attackDirection/ATTACKDOWN.visible = true
		$UI/Panel/attackDirection/ATTACKLEFT.visible = true
	if enemyDef == 4:
		EnemyDodgeChoice  = randi_range(1,4)
		$UI/Panel/attackDirection.visible = true
		$UI/Panel/attackDirection/ATTACKUP.visible = true
		$UI/Panel/attackDirection/ATTACKDOWN.visible = true
		$UI/Panel/attackDirection/ATTACKLEFT.visible = true
		$UI/Panel/attackDirection/ATTACKRIGHT.visible = true
	

##dodging enemies
func _on_down_button_down() -> void:
	PLayerDodgeChoice = 2
	if (PLayerDodgeChoice == EnemyattackChoice) and waitingForPlayer:
		$UI/Panel/playerHPBar.value -= enemyDamage
		$UI/Panel/dodgeDirection.visible = false
		$UI/Panel/dodgeDirection/UP.visible = false
		$UI/Panel/dodgeDirection/DOWN.visible = false
		$UI/Panel/dodgeDirection/LEFT.visible = false
		$UI/Panel/dodgeDirection/RIGHT.visible = false
		enemiesTurn = false
		charging = true
		waitingForPlayer = false
	elif (PLayerDodgeChoice != EnemyattackChoice) and waitingForPlayer:
		$UI/Panel/playerHPBar.value -= int(PlayerHP/(5*PLayerDef))
		$UI/Panel/dodgeDirection.visible = false
		$UI/Panel/dodgeDirection/UP.visible = false
		$UI/Panel/dodgeDirection/DOWN.visible = false
		$UI/Panel/dodgeDirection/LEFT.visible = false
		$UI/Panel/dodgeDirection/RIGHT.visible = false
		enemiesTurn = false
		charging = true
		waitingForPlayer = false


func _on_up_button_down() -> void:
	PLayerDodgeChoice = 1
	if (PLayerDodgeChoice == EnemyattackChoice) and waitingForPlayer:
		$UI/Panel/playerHPBar.value -= enemyDamage
		$UI/Panel/dodgeDirection.visible = false
		$UI/Panel/dodgeDirection/UP.visible = false
		$UI/Panel/dodgeDirection/DOWN.visible = false
		$UI/Panel/dodgeDirection/LEFT.visible = false
		$UI/Panel/dodgeDirection/RIGHT.visible = false
		enemiesTurn = false
		charging = true
		waitingForPlayer = false
	elif (PLayerDodgeChoice != EnemyattackChoice) and waitingForPlayer:
		$UI/Panel/playerHPBar.value -= int(PlayerHP/(5*PLayerDef))
		$UI/Panel/dodgeDirection.visible = false
		$UI/Panel/dodgeDirection/UP.visible = false
		$UI/Panel/dodgeDirection/DOWN.visible = false
		$UI/Panel/dodgeDirection/LEFT.visible = false
		$UI/Panel/dodgeDirection/RIGHT.visible = false
		enemiesTurn = false
		charging = true
		waitingForPlayer = false

func _on_left_button_down() -> void:
	PLayerDodgeChoice = 3
	if (PLayerDodgeChoice == EnemyattackChoice) and waitingForPlayer:
		
		$UI/Panel/playerHPBar.value -= enemyDamage
		$UI/Panel/dodgeDirection.visible = false
		$UI/Panel/dodgeDirection/UP.visible = false
		$UI/Panel/dodgeDirection/DOWN.visible = false
		$UI/Panel/dodgeDirection/LEFT.visible = false
		$UI/Panel/dodgeDirection/RIGHT.visible = false
		enemiesTurn = false
		charging = true
		waitingForPlayer = false
	elif (PLayerDodgeChoice != EnemyattackChoice) and waitingForPlayer:
		$UI/Panel/playerHPBar.value -= int(PlayerHP/(5*PLayerDef))
		$UI/Panel/dodgeDirection.visible = false
		$UI/Panel/dodgeDirection/UP.visible = false
		$UI/Panel/dodgeDirection/DOWN.visible = false
		$UI/Panel/dodgeDirection/LEFT.visible = false
		$UI/Panel/dodgeDirection/RIGHT.visible = false
		enemiesTurn = false
		charging = true
		waitingForPlayer = false

func _on_right_button_down() -> void:
	PLayerDodgeChoice = 4
	if (PLayerDodgeChoice == EnemyattackChoice) and waitingForPlayer:
		$UI/Panel/playerHPBar.value -= enemyDamage
		$UI/Panel/dodgeDirection.visible = false
		$UI/Panel/dodgeDirection/UP.visible = false
		$UI/Panel/dodgeDirection/DOWN.visible = false
		$UI/Panel/dodgeDirection/LEFT.visible = false
		$UI/Panel/dodgeDirection/RIGHT.visible = false
		enemiesTurn = false
		charging = true
		waitingForPlayer = false
	elif (PLayerDodgeChoice != EnemyattackChoice) and waitingForPlayer:
		$UI/Panel/playerHPBar.value -= int(PlayerHP/(5*PLayerDef))
		$UI/Panel/dodgeDirection.visible = false
		$UI/Panel/dodgeDirection/UP.visible = false
		$UI/Panel/dodgeDirection/DOWN.visible = false
		$UI/Panel/dodgeDirection/LEFT.visible = false
		$UI/Panel/dodgeDirection/RIGHT.visible = false
		enemiesTurn = false
		charging = true
		waitingForPlayer = false

## attacking the enem


func _on_attackup_button_down() -> void:
	PlayerattackChoice = 1
	if PlayerattackChoice == EnemyDodgeChoice:
		$UI/enemyHPBar.value -= playerDamage * criticalDamageMultiplier
		$UI/Panel/attackDirection.visible = false
		$UI/Panel/attackDirection/ATTACKUP.visible = false
		$UI/Panel/attackDirection/ATTACKDOWN.visible = false
		$UI/Panel/attackDirection/ATTACKLEFT.visible = false
		$UI/Panel/attackDirection/ATTACKRIGHT.visible = false
		charging = true
		PlayerCharge = 0
	else:
		$UI/enemyHPBar.value -= (playerDamage/enemyDef)
		$UI/Panel/attackDirection.visible = false
		$UI/Panel/attackDirection/ATTACKUP.visible = false
		$UI/Panel/attackDirection/ATTACKDOWN.visible = false
		$UI/Panel/attackDirection/ATTACKLEFT.visible = false
		$UI/Panel/attackDirection/ATTACKRIGHT.visible = false
		charging = true
		PlayerCharge = 0
		


func _on_attackdown_button_down() -> void:
	PlayerattackChoice = 2
	if PlayerattackChoice == EnemyDodgeChoice:
		$UI/enemyHPBar.value -= playerDamage * criticalDamageMultiplier
		$UI/Panel/attackDirection.visible = false
		$UI/Panel/attackDirection/ATTACKUP.visible = false
		$UI/Panel/attackDirection/ATTACKDOWN.visible = false
		$UI/Panel/attackDirection/ATTACKLEFT.visible = false
		$UI/Panel/attackDirection/ATTACKRIGHT.visible = false
		charging = true
		PlayerCharge = 0
	else:
		$UI/enemyHPBar.value -= (playerDamage/enemyDef)
		$UI/Panel/attackDirection.visible = false
		$UI/Panel/attackDirection/ATTACKUP.visible = false
		$UI/Panel/attackDirection/ATTACKDOWN.visible = false
		$UI/Panel/attackDirection/ATTACKLEFT.visible = false
		$UI/Panel/attackDirection/ATTACKRIGHT.visible = false
		charging = true
		PlayerCharge = 0


func _on_attackleft_button_down() -> void:
	PlayerattackChoice = 3
	if PlayerattackChoice == EnemyDodgeChoice:
		$UI/enemyHPBar.value -= playerDamage * criticalDamageMultiplier
		$UI/Panel/attackDirection.visible = false
		$UI/Panel/attackDirection/ATTACKUP.visible = false
		$UI/Panel/attackDirection/ATTACKDOWN.visible = false
		$UI/Panel/attackDirection/ATTACKLEFT.visible = false
		$UI/Panel/attackDirection/ATTACKRIGHT.visible = false
		charging = true
		PlayerCharge = 0
	else:
		$UI/enemyHPBar.value -= (playerDamage/enemyDef)
		$UI/Panel/attackDirection.visible = false
		$UI/Panel/attackDirection/ATTACKUP.visible = false
		$UI/Panel/attackDirection/ATTACKDOWN.visible = false
		$UI/Panel/attackDirection/ATTACKLEFT.visible = false
		$UI/Panel/attackDirection/ATTACKRIGHT.visible = false
		charging = true
		PlayerCharge = 0


func _on_attackright_button_down() -> void:
	PlayerattackChoice = 4
	if PlayerattackChoice == EnemyDodgeChoice:
		$UI/enemyHPBar.value -= playerDamage * criticalDamageMultiplier
		$UI/Panel/attackDirection.visible = false
		$UI/Panel/attackDirection/ATTACKUP.visible = false
		$UI/Panel/attackDirection/ATTACKDOWN.visible = false
		$UI/Panel/attackDirection/ATTACKLEFT.visible = false
		$UI/Panel/attackDirection/ATTACKRIGHT.visible = false
		charging = true
		PlayerCharge = 0
	else:
		$UI/enemyHPBar.value -= (playerDamage/enemyDef)
		$UI/Panel/attackDirection.visible = false
		$UI/Panel/attackDirection/ATTACKUP.visible = false
		$UI/Panel/attackDirection/ATTACKDOWN.visible = false
		$UI/Panel/attackDirection/ATTACKLEFT.visible = false
		$UI/Panel/attackDirection/ATTACKRIGHT.visible = false
		charging = true
		PlayerCharge = 0
