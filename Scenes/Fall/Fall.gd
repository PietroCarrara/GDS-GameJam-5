extends Node

func start():
	var tween = $Tween;
	var parent = get_parent();
	
	tween.interpolate_property(
		parent, 
		"position",
		parent.position,
		parent.position + Vector2(0, get_viewport().size.y),
		1,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN
	);
	
	tween.interpolate_property(
		parent, 
		"modulate",
		Color(1, 1, 1),
		Color(1, 1, 1, 0),
		1,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN
	);
	
	tween.start();

