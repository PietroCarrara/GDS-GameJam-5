extends Node2D

export var nextLevel: PackedScene;
	
func _ready():
	connectNodes(self);

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

# Should load a 'Contatulations!' UI into the scene
# It must have the options:
# 	- Exit
# 	- NextLevel
func win():
	print('You win!');
	
func restart():
	pass
