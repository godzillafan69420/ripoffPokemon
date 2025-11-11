extends Area2D

class_name enemySpawn
@export var enemyGoingToSpawn: Array[String]
var playerInZone: bool = false

var player: CharacterBody2D

@export var limits: int = -1
var kills: int = 0
var attackEnemyProbability: int
var enemyChosen: int

var location: PackedScene = PackedScene.new()

func _ready() -> void:
	kills = GlobalPlayerData.kills
	location.pack(get_tree().current_scene)
	GlobalPlayerData.playerLocation = location
	for i in get_tree().get_nodes_in_group("Player"):
		player = i
		
func _process(_delta: float) -> void:
	if limits == -1:
		attackEnemyProbability = randi_range(1, 300)
		if attackEnemyProbability == 1 and playerInZone:
			GlobalPlayerData.playerCords = player.position
			GlobalPlayerData.playerLocation = location
			enemyChosen = randi_range(0, len(enemyGoingToSpawn) - 1)
			GlobalPlayerData.enemyKey = enemyGoingToSpawn[enemyChosen]
			get_tree().change_scene_to_file("res://scenes/battle.tscn")
	elif (limits > kills) :
		attackEnemyProbability = randi_range(1, 300)
		if attackEnemyProbability == 1 and playerInZone:
			GlobalPlayerData.playerCords = player.position
			GlobalPlayerData.playerLocation = location
			enemyChosen = randi_range(0, len(enemyGoingToSpawn) - 1)
			GlobalPlayerData.enemyKey = enemyGoingToSpawn[enemyChosen]
			get_tree().change_scene_to_file("res://scenes/battle.tscn")
			
			
	
	
		


func _on_body_entered(body: Node2D) -> void:
	if body in  get_tree().get_nodes_in_group("Player"):
		playerInZone = true


func _on_body_exited(body: Node2D) -> void:
	if body in  get_tree().get_nodes_in_group("Player"):
		playerInZone = false
