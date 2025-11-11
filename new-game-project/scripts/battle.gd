extends Node2D

var playerData = GlobalPlayerData
var EmenyKey = GlobalPlayerData.enemyKey
var PlayerHP = playerData.playerHP
var playerDamage = playerData.playerDamage
var enemyHP 
var enemyDamage 
var turn = 0
var enemiesTurn = false
var waitingForPlayer = false
var charging = true
var playerCords
var plauerLocation

var PlayerSpeed = GlobalPlayerData.playerSpeed * 5 + 40
var PlayerCharge = 0
var enemySpeed = 40
var enemyCharge = 0

var enemyDef = 2
var PLayerDef = GlobalPlayerData.playerDef
var EnemyattackChoice = 0
var EnemyDodgeChoice =0
var PLayerDodgeChoice = 0
var PlayerattackChoice =0 

var criticalDamageMinium = 0.9
var criticalDamageMultiplier 
var enemyCriticalDamageMultiplier
var furtureSightLvl = GlobalPlayerData.playerFutureSight
var furtureSightSuccess

var defendWindow = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/Panel/playerLvl.text = "Lvl "+ str(GlobalPlayerData.playerLvl)
	playerCords = GlobalPlayerData.playerCords
	plauerLocation = GlobalPlayerData.playerLocation
	enemyHP = EnemyList.Enemies[EmenyKey]["HP"]
	enemyDamage = EnemyList.Enemies[EmenyKey]["damage"]
	enemyDef = EnemyList.Enemies[EmenyKey]["Def"]
	enemySpeed = EnemyList.Enemies[EmenyKey]["Speed"]
	$UI/EnemyName.text = EmenyKey
	$enemy.texture = EnemyList.Enemies[EmenyKey]["looks"]
	$UI/Panel/basicMenu/attack.grab_focus.call_deferred()
	$UI/enemyHPBar.max_value = enemyHP
	$UI/enemyHPBar.value = enemyHP
	$UI/Panel/playerHPBar.max_value = PlayerHP
	$UI/Panel/playerHPBar.value = PlayerHP
	$"Don'tForgetToRemenber".stream = EnemyList.Enemies[EmenyKey]["battleTheme"]
	$"Don'tForgetToRemenber".play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/Panel/playerChargeBar.value = PlayerCharge
	$UI/enemyChargeBar.value = enemyCharge
	if PlayerCharge < 100 and enemyCharge < 100 and charging:
		EnemyDodgeChoice  = randi_range(1,2)
		furtureSightSuccess = randi_range(0,10)
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
		charging = false
	elif charging:
		$UI/turnIndicator.text = "Charging"
		
	else:
		charging = false
		$UI/turnIndicator.text = "Your turn"
		if Input.is_action_just_pressed("goBack"):
			finishedPLayerAttack()
	if enemiesTurn and !waitingForPlayer:
		$dodging.startDodging = true
		$dodging.visible = true
		
		$dodging/dodgeWindow.start(defendWindow)
		
		enemyCharge = 0
		waitingForPlayer = true
	if $dodging.value == $dodging.maxValue and waitingForPlayer:
		$UI/enemyDamagetaken.text = "blocked"
		$UI/enemyDamagetaken/DamageIndicatorCD.start()
		$dodging.startDodging = false
		waitingForPlayer = false
		enemiesTurn = false
		charging = true
		$dodging.value  = 0
		
		
		
		
	if waitingForPlayer:
		enemyCharge = 0
	if $UI/Panel/playerHPBar.value <= 0:
		get_tree().change_scene_to_file("res://scenes/death.tscn")
	if $UI/enemyHPBar.value <= 0:
		GlobalPlayerData.playerXP += EnemyList.Enemies[EmenyKey]["XPGive"]
		if GlobalPlayerData.playerXP >= GlobalPlayerData.playerMaxXP:
			GlobalPlayerData.kills += 1
			GlobalPlayerData.playerLvl += 1
			GlobalPlayerData.playerXP -= GlobalPlayerData.playerMaxXP
			
		get_tree().change_scene_to_packed(plauerLocation)

func _on_button_button_down():

	
	if waitingForPlayer or enemiesTurn or PlayerCharge < 100 :
		return
	
	
	for i in $UI/Panel/basicMenu.get_children():
		i.visible = false
	$UI/Panel/attackDirection/ATTACKUP.grab_focus.call_deferred()

	$UI/Panel/attackDirection.visible = true
	$UI/Panel/attackDirection/ATTACKUP.visible = true
	$UI/Panel/attackDirection/ATTACKDOWN.visible = true
	$UI/Panel/attackDirection/ATTACKLEFT.visible = true
	$UI/Panel/attackDirection/ATTACKRIGHT.visible = true
	



## attacking the enemy
func attackingEnemy(Typedamge, speedLeft, critMax):
	criticalDamageMultiplier = randf_range(criticalDamageMinium,critMax)
	var damage = ((playerDamage*Typedamge)/enemyDef) * criticalDamageMultiplier
	$UI/enemyDamagetaken.text = "ok ATk -" + str(int(abs(damage)))
	$UI/enemyHPBar.value -= damage
	finishedPLayerAttack()
	charging = true
	PlayerCharge = speedLeft
	
func _on_attackup_button_down() -> void:
	$UI/enemyDamagetaken/DamageIndicatorCD.start()
	attackingEnemy(1, 75, 2.5)
		


func _on_attackdown_button_down() -> void:
	$UI/enemyDamagetaken/DamageIndicatorCD.start()
	attackingEnemy(2, 25, 1.5)


func _on_attackleft_button_down() -> void:
	$UI/enemyDamagetaken/DamageIndicatorCD.start()
	PlayerattackChoice = 3
	attackingEnemy(1, 60, 5)


func _on_attackright_button_down() -> void:
	$UI/enemyDamagetaken/DamageIndicatorCD.start()
	PlayerattackChoice = 4
	attackingEnemy(3, 0, 2.5)


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
	for i in $UI/Panel/basicMenu.get_children():
		i.visible = true
	$UI/Panel/basicMenu/attack.grab_focus.call_deferred()

func _on_damage_indicator_cd_timeout() -> void:
	$UI/PlayerDamagetaken.text = ""
	$UI/enemyDamagetaken.text = ""


func _on_dodge_window_timeout() -> void:
	if ($dodging.value != $dodging.maxValue) and waitingForPlayer:
		
		enemyCriticalDamageMultiplier = randf_range(1, 3)
		var damage = enemyDamage *enemyCriticalDamageMultiplier
		
		$dodging.startDodging = false
		$dodging.value  = 0
		$UI/PlayerDamagetaken.text = "-"+ str(int(damage))
		$UI/enemyDamagetaken/DamageIndicatorCD.start()
		$UI/Panel/playerHPBar.value -= damage
		charging = true
		waitingForPlayer = false
		enemiesTurn = false
		
		
