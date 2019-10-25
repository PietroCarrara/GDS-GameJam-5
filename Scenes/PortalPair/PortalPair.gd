class_name PortalPair
extends Node2D

var portalA;
var portalB;

# Switch all colors of the scene
signal SwitchAllExcept(n);

func _ready():
	var children = get_children();
	portalA = children[0];
	portalB = children[1];

	portalA.connect("Teleport", self, "teleportFromAtoB")
	portalB.connect("Teleport", self, "teleportFromBtoA")

func teleport(what, where):
	var wallColor = where.getWall().get_node("ColorSwitcher");
	var playerColor = what.get_node("ColorSwitcher");
	
	if (wallColor.isBlack != playerColor.isBlack):
		wallColor.switchColor();
	else:
		emit_signal("SwitchAllExcept", [what, where.getWall()]);
	
	what.position = where.position;
	playerColor.switchColor();

func teleportFromAtoB(player):
	teleport(player, portalB);
	
func teleportFromBtoA(player):
	teleport(player, portalA);