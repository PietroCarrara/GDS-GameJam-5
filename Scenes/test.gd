extends Sprite

onready var colorSwitcher = $ColorSwitcher;

func _process(delta):
	if Input.is_action_just_pressed("test_toggle"):
		colorSwitcher.switchColor();