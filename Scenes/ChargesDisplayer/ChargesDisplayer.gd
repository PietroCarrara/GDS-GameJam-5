extends Node2D

export var icon: Texture;

func _ready():
	var player = get_parent().find_node("Player");
	player.connect("ChargesChanged", self, "playerChargesChanged");

func playerChargesChanged(n):
	clearCharges();
	for i in range(n):
		addCharge();
	
func addCharge():
	var img = TextureRect.new();
	var size = Vector2(128, 229) * 0.25;
	img.set_texture(icon);
	img.set_custom_minimum_size(size);
	img.set_size(size);
	img.set_expand(true);
	$HBoxContainer.add_child(img);

func clearCharges():
	for child in $HBoxContainer.get_children():
    	child.queue_free();