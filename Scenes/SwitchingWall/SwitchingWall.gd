extends StaticBody2D

export var startsBlack: bool = false;

onready var sprite: Sprite = $Sprite;
onready var back: Sprite = $Back;
onready var collisionShape: CollisionShape2D = $"CollisionShape2D";

func _ready():
	add_to_group("Walls");
	
	var rect: RectangleShape2D = collisionShape.shape
	
	var wallSize = rect.extents
	var spriteSize = sprite.texture.get_size()
	
	sprite.scale = wallSize / (spriteSize / 2); # Don't ask me why /2, it works
	back.scale = sprite.scale * 1.1; # 10% border
	
	sprite.visible = true;
	back.visible = true;
	
	$ColorSwitcher.connect("ColorChanged", self, "colorChanged");
	$ColorSwitcher.setIsBlack(startsBlack);

func colorChanged():
	if $ColorSwitcher.isBlack:
		back.modulate = Color.white;
	else:
		pass
		back.modulate = Color.black;