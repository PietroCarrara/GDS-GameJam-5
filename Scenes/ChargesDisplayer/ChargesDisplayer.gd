extends Node2D

func _ready():
	var player = get_parent().find_node("Player");
	player.connect("ChargesChanged", self, "playerChargesChanged");

func playerChargesChanged(n):
	get_node("box").set_bbcode("Remaining Charges: [color=#f50]"+str(n)+"[/color]");