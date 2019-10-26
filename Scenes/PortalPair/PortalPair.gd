class_name PortalPair
extends Node2D

var portals = [];

# Switch all colors of the scene
signal SwitchAllExcept(n);

func _ready():
	var children = get_children();
	for portal in children:
		portals.append(portal);
		portal.connect("Teleport", self, "teleport", [portal]);

func teleport(what, portal):
	var index = portals.find(portal);
	var where = portals[(index+1)%portals.size()]; # Get next portal, looping at 0
	
	var wallColor = where.getWall().get_node("ColorSwitcher");
	var playerColor = what.get_node("ColorSwitcher");
	
	if (wallColor.isBlack != playerColor.isBlack):
		wallColor.switchColor();
	else:
		emit_signal("SwitchAllExcept", [what, where.getWall()]);
	
	what.position = where.position;
	playerColor.switchColor();
	