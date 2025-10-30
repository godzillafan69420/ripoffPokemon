extends Area2D

@export var dialogue: DialogueResource
@export var start: String = "start"
var player: CharacterBody2D
@export var alreadyPlayOnceEnable: bool = false
@export var interact: bool = false
var alreadyPlayOnce: bool = false

var pressKeyToInteract: bool = false


func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	for i in get_tree().get_nodes_in_group("Player"):
		player = i
func _on_body_entered(body: Node2D) -> void:
	if alreadyPlayOnce:
			return
	if body in get_tree().get_nodes_in_group("Player"):

		
		
		if !interact:
			player.canMove = false
			DialogueManager.show_dialogue_balloon(dialogue, start)
		else:
			pressKeyToInteract = true
			
			
			
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and interact and pressKeyToInteract:
			
			player.canMove = false
			DialogueManager.show_dialogue_balloon(dialogue, start)
			pressKeyToInteract = false
	
func _on_dialogue_ended(_resource: DialogueResource):
	pressKeyToInteract = false
	player.canMove = true
	if alreadyPlayOnceEnable:
			alreadyPlayOnce = true
func _on_body_exited(body: Node2D) -> void:
	pass
		
			
