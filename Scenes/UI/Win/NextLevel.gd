extends Button

signal NextLevelPressed();

func _pressed():
	emit_signal("NextLevelPressed");