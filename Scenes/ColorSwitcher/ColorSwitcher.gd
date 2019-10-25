extends Node2D

onready var parent : Sprite = $".."
var isBlack : bool = false

func switchColor():
	if isBlack:
		parent.modulate = Color.white;
	else:
		parent.modulate = Color.black;
	isBlack = !isBlack;