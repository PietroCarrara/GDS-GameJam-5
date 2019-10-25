extends KinematicBody2D

const SPEED = 200.0;

export var startsBlack:bool = false

func _ready():
	$ColorSwitcher.setIsBlack(startsBlack);

func _physics_process(delta):
	move_and_slide(getMovementVector());

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

