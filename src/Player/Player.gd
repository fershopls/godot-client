extends Node2D


var target
var speed = 450


func _process(delta):
	if not target:
		return
	
	var distance = global_position.distance_to(target)
	
	if distance < 16:
		return
	
	var direction = global_position.direction_to(target)
	position += delta * speed * direction

