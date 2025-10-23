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
var PLayerDef = 4
var EnemyattackChoice = 0
var EnemyDodgeChoice =0
var PLayerDodgeChoice = 0
var PlayerattackChoice =0 

var criticalDamageMinium = 0.9
var criticalDamageMultiplier 
var enemyCriticalDamageMultiplier
var furtureSightLvl = 1
var furtureSightSuccess
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
	if enemiesTurn:
		$UI/turnIndicator.text = "Enemy's turn"
	elif charging:
		$UI/turnIndicator.text = "Charging"
	else:
		$UI/turnIndicator.text = "Your turn"

	if enemiesTurn and !waitingForPlayer:
		enemyCriticalDamageMultiplier = randf_range(1, 3)
		if PLayerDef < 2:
			$UI/Panel/playerHPBar.value -= enemyDamage *enemyCriticalDamageMultiplier
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
		if PLayerDef >= 4:
			
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


func _on_button_button_down():
	if waitingForPlayer or enemiesTurn or PlayerCharge < 100 :
		return
	
	criticalDamageMultiplier = randf_range(criticalDamageMinium, 3.5)
	if (enemyDef == 1|| enemyDef == 0):
		$UI/enemyHPBar.value -= playerDamage * criticalDamageMultiplier
		charging = true
		PlayerCharge = 0
	if enemyDef == 2:
		EnemyDodgeChoice  = randi_range(1,2)
		furtureSightSuccess = randi_range(0,10)
		if furtureSightSuccess <= furtureSightLvl:

			match EnemyDodgeChoice:
				1:
					$UI/Panel/attackDirection/ATTACKUP.modulate= (Color.YELLOW)
				2:
					$UI/Panel/attackDirection/ATTACKDOWN.modulate= (Color.YELLOW)
				3:
					$UI/Panel/attackDirection/ATTACKLEFT.modulate= (Color.YELLOW)
				4:
					$UI/Panel/attackDirection/ATTACKRIGHT.modulate= (Color.YELLOW)
		$UI/Panel/attackDirection.visible = true
		$UI/Panel/attackDirection/ATTACKUP.visible = true
		$UI/Panel/attackDirection/ATTACKDOWN.visible = true
	if enemyDef == 3:
		EnemyDodgeChoice  = randi_range(1,3)
		furtureSightSuccess = randi_range(0,10)
		if furtureSightSuccess <= furtureSightLvl:

			match EnemyDodgeChoice:
				1:
					$UI/Panel/attackDirection/ATTACKUP.modulate= (Color.YELLOW)
				2:
					$UI/Panel/attackDirection/ATTACKDOWN.modulate= (Color.YELLOW)
				3:
					$UI/Panel/attackDirection/ATTACKLEFT.modulate= (Color.YELLOW)
				4:
					$UI/Panel/attackDirection/ATTACKRIGHT.modulate= (Color.YELLOW)
		$UI/Panel/attackDirection.visible = true
		$UI/Panel/attackDirection/ATTACKUP.visible = true
		$UI/Panel/attackDirection/ATTACKDOWN.visible = true
		$UI/Panel/attackDirection/ATTACKLEFT.visible = true
	if enemyDef >= 4:
		EnemyDodgeChoice  = randi_range(1,4)
		furtureSightSuccess = randi_range(0,10)
		if furtureSightSuccess <= furtureSightLvl:

			match EnemyDodgeChoice:
				1:
					$UI/Panel/attackDirection/ATTACKUP.modulate= (Color.YELLOW)
				2:
					$UI/Panel/attackDirection/ATTACKDOWN.modulate= (Color.YELLOW)
				3:
					$UI/Panel/attackDirection/ATTACKLEFT.modulate= (Color.YELLOW)
				4:
					$UI/Panel/attackDirection/ATTACKRIGHT.modulate= (Color.YELLOW)
		$UI/Panel/attackDirection.visible = true
		$UI/Panel/attackDirection/ATTACKUP.visible = true
		$UI/Panel/attackDirection/ATTACKDOWN.visible = true
		$UI/Panel/attackDirection/ATTACKLEFT.visible = true
		$UI/Panel/attackDirection/ATTACKRIGHT.visible = true
	
func dodging(dodgeInputs):
	if (dodgeInputs == EnemyattackChoice) and waitingForPlayer:
		var damageGonnaTake = enemyDamage *enemyCriticalDamageMultiplier
		$UI/PlayerDamagetaken.text = "taken -" + str(int(damageGonnaTake))
		$UI/Panel/playerHPBar.value -= damageGonnaTake
		$UI/Panel/dodgeDirection.visible = false
		$UI/Panel/dodgeDirection/UP.visible = false
		$UI/Panel/dodgeDirection/DOWN.visible = false
		$UI/Panel/dodgeDirection/LEFT.visible = false
		$UI/Panel/dodgeDirection/RIGHT.visible = false
		enemiesTurn = false
		charging = true
		waitingForPlayer = false
	elif (dodgeInputs != EnemyattackChoice) and waitingForPlayer:
		var damageGonnaTake =PlayerHP/(2*PLayerDef)
		$UI/PlayerDamagetaken.text = "blocked -" + str(int(damageGonnaTake))
		$UI/Panel/playerHPBar.value -= int(damageGonnaTake)
		$UI/Panel/dodgeDirection.visible = false
		$UI/Panel/dodgeDirection/UP.visible = false
		$UI/Panel/dodgeDirection/DOWN.visible = false
		$UI/Panel/dodgeDirection/LEFT.visible = false
		$UI/Panel/dodgeDirection/RIGHT.visible = false
		enemiesTurn = false
		charging = true
		waitingForPlayer = false
##dodging enemies
func _on_down_button_down() -> void:
	$UI/PlayerDamagetaken/DamageIndicatorCD.start()
	PLayerDodgeChoice = 2
	dodging(PLayerDodgeChoice)
	


func _on_up_button_down() -> void:
	$UI/PlayerDamagetaken/DamageIndicatorCD.start()
	PLayerDodgeChoice = 1
	dodging(PLayerDodgeChoice)

func _on_left_button_down() -> void:
	$UI/PlayerDamagetaken/DamageIndicatorCD.start()
	PLayerDodgeChoice = 3
	dodging(PLayerDodgeChoice)

func _on_right_button_down() -> void:
	$UI/PlayerDamagetaken/DamageIndicatorCD.start()
	PLayerDodgeChoice = 4
	dodging(PLayerDodgeChoice)

## attacking the enemy
func attackingEnemy(target):
	if target == EnemyDodgeChoice:
		var damage = playerDamage * criticalDamageMultiplier
		$UI/enemyDamagetaken.text = "hit -" + str(int(damage))
		$UI/enemyHPBar.value -= damage
		finishedPLayerAttack()
		charging = true
		
		
		PlayerCharge = 0
	else:
		var damage= (playerDamage/3*enemyDef)
		$UI/enemyDamagetaken.text = "ok ATk -" + str(int(damage))
		$UI/enemyHPBar.value -= damage
		finishedPLayerAttack()
		charging = true
		PlayerCharge = 0

func _on_attackup_button_down() -> void:
	$UI/enemyDamagetaken/DamageIndicatorCD.start()
	PlayerattackChoice = 1
	attackingEnemy(PlayerattackChoice)
		


func _on_attackdown_button_down() -> void:
	$UI/enemyDamagetaken/DamageIndicatorCD.start()
	PlayerattackChoice = 2
	attackingEnemy(PlayerattackChoice)


func _on_attackleft_button_down() -> void:
	$UI/enemyDamagetaken/DamageIndicatorCD.start()
	PlayerattackChoice = 3
	attackingEnemy(PlayerattackChoice)


func _on_attackright_button_down() -> void:
	$UI/enemyDamagetaken/DamageIndicatorCD.start()
	PlayerattackChoice = 4
	attackingEnemy(PlayerattackChoice)


func finishedPLayerAttack():
	$UI/Panel/attackDirection.visible = false
	$UI/Panel/attackDirection/ATTACKUP.visible = false
	$UI/Panel/attackDirection/ATTACKDOWN.visible = false
	$UI/Panel/attackDirection/ATTACKLEFT.visible = false
	$UI/Panel/attackDirection/ATTACKRIGHT.visible = false
	$UI/Panel/attackDirection/ATTACKUP.modulate= (Color.GHOST_WHITE)
	$UI/Panel/attackDirection/ATTACKDOWN.modulate= (Color.GHOST_WHITE)
	$UI/Panel/attackDirection/ATTACKLEFT.modulate= (Color.GHOST_WHITE)
	$UI/Panel/attackDirection/ATTACKRIGHT.modulate= (Color.GHOST_WHITE)


func _on_damage_indicator_cd_timeout() -> void:
	$UI/PlayerDamagetaken.text = ""
	$UI/enemyDamagetaken.text = ""
