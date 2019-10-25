extends Node

onready var colorSwitcher = find_node("ColorSwitcher");

func _process(delta):
	if Input.is_action_just_pressed("test_toggle"):
		colorSwitcher.switchColor();