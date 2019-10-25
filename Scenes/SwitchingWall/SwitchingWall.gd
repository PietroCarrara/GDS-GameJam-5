extends StaticBody2D

export var startsBlack: bool = false;

onready var sprite: Sprite = $"Sprite";
onready var collisionShape: CollisionShape2D = $"CollisionShape2D";

func _ready():
	var rect: RectangleShape2D = collisionShape.shape
	
	var wallSize = rect.extents
	var spriteSize = sprite.texture.get_size()
	
	sprite.scale = wallSize / (spriteSize / 2); # Don't ask me why /2, it works
	sprite.visible = true;
	
	$ColorSwitcher.setIsBlack(startsBlack);