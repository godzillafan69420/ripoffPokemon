extends Node

var playerHP: float = 10
var playerLvl: int = 1
var playerXP: int = 1
var playerMaxXP: int = 10
var playerDamage:float = 3
var playerName: String = ""
var playerDef: int = 1
var playerSpeed: int = 2
var playerFutureSight: int = 1

var enemyKey: String = "Vman"

var playerLocation: PackedScene
var playerCords: Vector2 = Vector2(-1371.0, 177)

var kills = 0

func _process(delta: float) -> void:
	match playerLvl:
		1:
			playerMaxXP = 10
		2:
			playerMaxXP = 20
		3:
			playerMaxXP = 40
		4:
			playerMaxXP = 80
		5:
			playerMaxXP = 160
		6:
			playerMaxXP = 250
		7:
			playerMaxXP = 500
		8:
			playerMaxXP = 750
		9:
			playerMaxXP = 1000
		10:
			playerMaxXP = 1250
		11:
			playerMaxXP = 1500
		12:
			playerMaxXP = 2000
		13:
			playerMaxXP = 2250
		14:
			playerMaxXP = 2500
		15:
			playerMaxXP = 2750
		16:
			playerMaxXP = 3000
		17:
			playerMaxXP = 3250
		18:
			playerMaxXP = 3500
		19:
			playerMaxXP = 4000
		20:
			playerMaxXP = 100000000000000
		
