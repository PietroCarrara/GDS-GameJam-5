extends KinematicBody2D

const SPEED = 200.0;
export var startsBlack:bool = false;

func _ready():
	$ColorSwitcher.setIsBlack(startsBlack);

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