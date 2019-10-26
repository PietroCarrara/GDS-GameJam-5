extends Node2D

export var nextLevel: PackedScene;
export var charges: int;

signal ChangeLevel(level, slidingPos);

# Has a reference to all the goals in the scene
var goals = [];

func _ready():
	find_node("Player").setCharges(charges);
	connectNodes(self);

func _process(delta):
	if (Input.is_action_just_pressed("level_restart")):
		restart();

# Scans recursively for importante nodes
# and listens for their events
func connectNodes(node):
	if node is PortalPair:
		node.connect("SwitchAllExcept", self, "switchAllExcept");
	elif node is Goal:
		goals.append(node);
		node.connect("Win", self, "win");
	
	for n in node.get_children():
		connectNodes(n);

func switchAllExcept(except):
	changeColors(self, except);
	
func changeColors(n, except):
	if except.has(n):
		return;
	
	for child in n.get_children():
		changeColors(child, except);
		if (child.name == "ColorSwitcher"):
			child.switchColor();

func win(goal):
	goals.erase(goal);
	
	# Only win when all the goals have
	# been collected
	if goals.size() > 0:
		return;
	
	# Goal sound effect
	$Goal.play();
	if nextLevel != null:
		emit_signal("ChangeLevel", nextLevel, Vector2(1280, 0));
	else:
		var endingScreen = load("res://Scenes/EndingScreen.tscn");
		emit_signal("ChangeLevel", endingScreen, Vector2(1280, 0));

func restart():
	var scene = load(self.owner.filename);
	emit_signal("ChangeLevel", scene, Vector2(0, 720));

