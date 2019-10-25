# Every level should have this as a script
extends Node2D

func ChangeLevel(level):
	# Remove the current level
	var child = self.get_node("Level");
	self.remove_child(child);
	child.call_deferred("free");
	
	# Add the next level
	var nextLevel = level.instance();
	self.add_child(nextLevel);
