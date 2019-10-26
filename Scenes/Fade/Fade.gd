extends Node

# Fades in-out some element, displaying
# it for displayTime seconds

export var delayTime: float = 0;
export var transitionTime: float = 1;
export var displayTime: float = 1;


func _ready():
	$"..".modulate = Color(1, 1, 1, 0);
	$Timer.connect("timeout", self, "startIntro");
	$Timer.start(delayTime);

func startIntro():
	$Timer.disconnect("timeout", self, "startIntro");
	
	var parent = $"..";
	$Tween.connect("tween_all_completed", self, "introDone");

	$Tween.interpolate_property(
		parent,
		"position",
		parent.position - Vector2(200, 0),
		parent.position,
		transitionTime,
        Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	);
	$Tween.interpolate_property(
		parent,
		"modulate",
		Color(1, 1, 1, 0),
		Color(1, 1, 1, 1),
		transitionTime,
        Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	);
	
	$Tween.start();
	
func introDone():
	$Timer.connect("timeout", self, "displayDone");	
	$Timer.start(displayTime);

func displayDone():
	var parent = $"..";
	
	$OutTween.interpolate_property(
		parent,
		"position",
		parent.position,
		parent.position + Vector2(200, 0),
		transitionTime,
        Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	);
	$OutTween.interpolate_property(
		parent,
		"modulate",
		Color(1, 1, 1, 1),
		Color(1, 1, 1, 0),
		transitionTime,
        Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	);
	
	$OutTween.start();