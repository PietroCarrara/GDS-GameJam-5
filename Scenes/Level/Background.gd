extends Sprite

func _ready():
	var player = get_parent().find_node("Player");
	player.connect("PlayerColorChanged", self, "playerColorChanged");

func playerColorChanged(color):
	if color.isBlack:
		var num = 0;
		self.modulate = Color(num, num, num);
	else:
		var num = 1;
		self.modulate = Color(num, num, num);