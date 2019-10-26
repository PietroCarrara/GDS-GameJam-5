extends KinematicBody2D

const SPEED = 300.0;
export var startsBlack:bool = false;

signal PlayerColorChanged(color);
signal ChargesChanged(remaining);

var charges: int = 0;

func _ready():
	$ColorSwitcher.setIsBlack(startsBlack);
	emit_signal("PlayerColorChanged", $ColorSwitcher);

	$ColorSwitcher.connect("ColorChanged", self, "colorChanged");

func _physics_process(delta):
	var pos = position;
	
	move_and_slide(getMovementVector());
	
	if !isTotallyCovered():
		position = pos;

func getMovementVector():
	var mov = Vector2(0, 0);
	
	if Input.is_action_pressed("player_move_left"):
		mov.x = -1;
	elif Input.is_action_pressed("player_move_right"):
		mov.x = 1;
	
	if Input.is_action_pressed("player_move_down"):
		mov.y = 1;
	elif Input.is_action_pressed("player_move_up"):
		mov.y = -1;
	
	return mov.normalized() * SPEED;

func isTotallyCovered():
	var body_extents = $CollisionShape2D.shape.extents;
	var body_rect = Rect2(self.global_position - body_extents, body_extents * 2);

	var totalArea = 0;

	for wall in get_tree().get_nodes_in_group("Walls"):
		var area_extents = wall.get_node('CollisionShape2D').shape.extents;
		var area_rect = Rect2(wall.global_position - area_extents, area_extents * 2);
		
		totalArea += area_rect.clip(body_rect).get_area();
	
	return (body_rect.get_area() - totalArea) < 1;
	
func colorChanged():
	emit_signal("PlayerColorChanged", $ColorSwitcher);
	
func setCharges(value: int):
	charges = value;
	emit_signal("ChargesChanged", charges);
	
func getCharges():
	return charges;
	
func consumeCharge():
	setCharges(getCharges()-1);