extends Node

onready var parent : CanvasItem = $".."
export var isBlack : bool = false

func _ready():
	applyColor();

func switchColor():
	isBlack = !isBlack;
	applyColor();

func applyColor():
	if isBlack:
		parent.modulate = Color.black;
	else:
		parent.modulate = Color.white;