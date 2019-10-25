extends Node2D

onready var area = $Area2D;

func _ready():
	area.connect("body_entered", self, "bodyEntered");

func bodyEntered(b):
	if b.name == "Player" && !getWallColor().isBlack:
		print('You Win!');

func getWallColor():
	var bodies = area.get_overlapping_bodies();
	for body in bodies:
		if body.name != "Player":
			return body.get_node("ColorSwitcher");
	return null;
