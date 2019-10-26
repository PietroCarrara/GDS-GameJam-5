extends Node2D

export var nextLevel: PackedScene;

export var charges: int;

signal ChangeLevel(level);
	
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

func win():
	# Goal sound effect
	$Goal.play();
	if nextLevel != null:
		emit_signal("ChangeLevel", nextLevel);

func restart():
	var scene = load(self.owner.filename);
	emit_signal("ChangeLevel", scene);
	
