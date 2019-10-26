extends Node2D



func _ready():
	pass
	
func changeNumber(n):
	if n < 0:
		$Fall.start()
	else:
		get_node("box").set_bbcode("Optimal Bonus: [color=#f50]"+str(n)+"[/color]");