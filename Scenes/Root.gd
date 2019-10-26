# Every level should have this as a script
extends Node2D

func ChangeLevel(level):
	var tweenNewLevel = Tween.new();
	var tweenOldLevel = Tween.new();
	self.add_child(tweenNewLevel);
	self.add_child(tweenOldLevel);
	
	tweenOldLevel.connect(
		"tween_all_completed",
		self,
		"removeChildren",
		[ [tweenOldLevel, tweenOldLevel] ]
	);
	tweenNewLevel.connect(
		"tween_all_completed",
		self,
		"removeChildren",
		[ [tweenNewLevel] ]
	);
	
	# Add the next level
	var nextLevel = level.instance();
	self.add_child(nextLevel);
	
	var oldLevel = self.get_node("Level");
	
	tweenNewLevel.interpolate_property(
		nextLevel,
		"position",
		Vector2(1280, 0),
		Vector2(0, 0),
		1,
        Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	);
	tweenOldLevel.interpolate_property(
		oldLevel,
		"position",
		Vector2(0, 0),
		Vector2(-1280, 0),
		1,
        Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	);
	
	tweenNewLevel.start();
	tweenOldLevel.start();

func removeChildren(children):
	for child in children:
		self.remove_child(child);
		child.call_deferred("free");

func _ready():
	$Level.connect("ChangeLevel", self, "ChangeLevel");
