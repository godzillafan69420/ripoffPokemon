extends TextureProgressBar

var addValue = GlobalPlayerData.playerDef
var maxValue = 10
var startDodging = false
func _ready() -> void:
	$".".max_value = maxValue
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_accept") and startDodging:
		$".".value += addValue
