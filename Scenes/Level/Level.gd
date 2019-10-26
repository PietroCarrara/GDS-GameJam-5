extends Node2D

export var nextLevel: PackedScene;

export var minTeleports: int;

signal ChangeLevel(level);
	
func _ready():
	connectNodes(self);
	for portal in get_tree().get_nodes_in_group("portals"):
		portal.connect("Teleport", self, "onTeleport");
	get_node("OptimalBonus").changeNumber(minTeleports);

func onTeleport(player):
	minTeleports -= 1;
	get_node("OptimalBonus").changeNumber(minTeleports);

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
	pass
