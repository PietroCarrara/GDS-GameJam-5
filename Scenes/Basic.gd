extends Node2D

func _ready():
	connectPortalPairs(self);

# Scans recursively for PortalPairs
# and listens for their events
func connectPortalPairs(node):
	if node is PortalPair:
		node.connect("SwitchAllExcept", self, "SwitchAllExcept");
	
	for n in node.get_children():
		connectPortalPairs(n);

func SwitchAllExcept(except):
	changeColors(self, except);
	
func changeColors(n, except):
	if except.has(n):
		return;
	
	for child in n.get_children():
		changeColors(child, except);
		if (child.name == "ColorSwitcher"):
			child.switchColor();
