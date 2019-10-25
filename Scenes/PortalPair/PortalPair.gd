extends Node2D

var portalA;
var portalB;

func _ready():
	var children = get_children();
	portalA = children[0];
	portalB = children[1];

	portalA.connect("Teleport", self, "teleportFromAtoB")
	portalB.connect("Teleport", self, "teleportFromBtoA")

func teleport(what, where):
	what.position = where.position;

func teleportFromAtoB(player):
	teleport(player, portalB);
	
func teleportFromBtoA(player):
	teleport(player, portalA);