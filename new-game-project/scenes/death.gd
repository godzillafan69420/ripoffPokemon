extends Control

var youDiedMessage = preload("res://dialogues/YouDied.dialogue")
var locationDied: PackedScene

func _ready() -> void:
	locationDied = GlobalPlayerData.playerLocation
	DialogueManager.show_dialogue_balloon(youDiedMessage, "start")
	DialogueManager.dialogue_ended.connect(reviveReal)
	
func reviveReal(youDiedMessage):
	$revive.grab_focus.call_deferred()


func _on_revive_button_down() -> void:
	get_tree().change_scene_to_packed(locationDied)
