extends Node


var Enemies: = {
	"Vman": {
		"looks": preload("res://art/vman2.0.png"),
		"battleTheme": preload("res://music/dirtTastingDirt.mp3"),
		"Speed": 30.0,
		"damage": 2,
		"HP": 5,
		"Def": 0
	},
	"You": {
		"looks": preload("res://art/battlePortagonist.png"),
		"battleTheme": preload("res://music/don'tForgetToRemenber.mp3"),
		"Speed": 60,
		"damage": 10,
		"HP": 30,
		"Def": 1
	}
}
