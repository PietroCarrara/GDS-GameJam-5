extends Node2D

export var winUI: PackedScene;
export var nextLevel: PackedScene;

signal ChangeLevel(level);
	
func _ready():
	print('Nivel carregado!');
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

func nextLevelRequested():
	if nextLevel != null:
		emit_signal("ChangeLevel", nextLevel);

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
# 	- NextLevel
# TODO: Only add element once
func win():
	var ui = winUI.instance();
	ui.rect_size = Vector2(1024, 600);
	ui.connect("NextLevelRequested", self, "nextLevelRequested");
	self.add_child(ui);
	print('You win!!!');
	
func restart():
	pass
