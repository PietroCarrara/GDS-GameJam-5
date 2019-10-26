extends Node2D

onready var area = $Area2D;

signal Teleport(player);

func _process(delta):
	if Input.is_action_just_pressed("player_interact"):
		# Check if player is in the interaction zone
		var bodies = area.get_overlapping_bodies();
		for body in bodies:
			if body.name != "Player": continue;
			emit_signal("Teleport", body);
			$AudioStreamPlayer.play();

func getWall():
	var bodies = area.get_overlapping_bodies();
	for body in bodies:
		if body.name != "Player":
			return body;
	return null;