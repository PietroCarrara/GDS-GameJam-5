class_name Goal
extends Node2D

onready var area = $Area2D;

signal Win(goal);

func _ready():
	area.connect("body_entered", self, "bodyEntered");

func bodyEntered(b):
	# Player can't win if the back is black
	if b.name == "Player" && !getWallColor().isBlack:
		emit_signal("Win", self);
		# remove goal from scene
		self.call_deferred("free");

func getWallColor():
	var bodies = area.get_overlapping_bodies();
	for body in bodies:
		if body.name != "Player":
			return body.get_node("ColorSwitcher");
	return null;
