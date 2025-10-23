extends Node2D

var randomDialogues: int
var choosingDialogues :bool = true
func _ready() -> void:
	$".".visible = false

func dialogueViariation(randomness, dialogueKey):
	if $"..".enemiesTurn == true and choosingDialogues == true:
		randomDialogues = randi_range(0,randomness)
		choosingDialogues = false
	if $"..".enemiesTurn == true and choosingDialogues == false:
		$".".visible = true
		$".".get_node("dialogues").text = DialogList.diologs[dialogueKey][randomDialogues]
		$".".get_node("dialogues").visible_characters += 1
	else:
		$".".get_node("dialogues").visible_characters = 0
		$".".visible = false
		choosingDialogues = true
func _process(delta: float) -> void:
	dialogueViariation(2,"GraveyardEnemyDialogue")
