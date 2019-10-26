extends Node

const BLACK_LAYER = 2;
const WHITE_LAYER = 1;

signal ColorChanged();

onready var parent : PhysicsBody2D = $".."
export var isBlack : bool = false

func _ready():
	applyColor();

func setIsBlack(val):
	isBlack = val;
	applyColor();

func switchColor():
	isBlack = !isBlack;
	applyColor();

func applyColor():
	emit_signal("ColorChanged");
	if isBlack:
		parent.collision_layer = BLACK_LAYER; # Is black
		parent.collision_mask = BLACK_LAYER; # Collides with black
		parent.modulate = Color.black;
	else:
		parent.collision_layer = WHITE_LAYER; # Is white
		parent.collision_mask = WHITE_LAYER; # Collides with white
		parent.modulate = Color.white;