extends MarginContainer

signal NextLevelRequested();

func NextLevelPressed():
	emit_signal("NextLevelRequested");
