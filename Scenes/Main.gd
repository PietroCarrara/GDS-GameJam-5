# Every level should have this as a script
extends Node2D

# Tells if we are removing a level in the moment
var isRemoving = false

onready var oldLevel = $Root;

func _ready():
	listen();	
	fadeInSoundtrack();
	
func fadeInSoundtrack():
	var tween = Tween.new();
	self.add_child(tween);
	
	tween.interpolate_property(
		$Soundtrack,
		"volume_db",
		$Soundtrack.volume_db,
		-10,
		4,
		Tween.TRANS_LINEAR,
		false,
		0
	);
	
	tween.start();

func ChangeLevel(level):
	if isRemoving:
		return;
	
	isRemoving = true;
	
	var tweenNewLevel = Tween.new();
	var tweenOldLevel = Tween.new();
	call_deferred("add_child", tweenNewLevel);
	call_deferred("add_child", tweenOldLevel);
	
	# Add the next level
	var nextLevel = level.instance();
	nextLevel.position = Vector2(1280, 0);
	call_deferred("add_child", nextLevel);
	
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
	
	tweenOldLevel.connect("tween_all_completed", self, "doneRemoving");
	tweenOldLevel.connect(
		"tween_all_completed",
		self,
		"removeChildren",
		[ [tweenOldLevel, oldLevel] ]
	);
	tweenNewLevel.connect(
		"tween_all_completed",
		self,
		"removeChildren",
		[ [tweenNewLevel] ]
	);
	
	tweenNewLevel.start();
	tweenOldLevel.start();
	
	oldLevel = nextLevel;
	listen();

func removeChildren(children):
	for child in children:
		print(child)
		self.remove_child(child);
		child.call_deferred("free");
		
func doneRemoving():
	isRemoving = false;

func listen():
	oldLevel.get_node("Level").connect("ChangeLevel", self, "ChangeLevel");
