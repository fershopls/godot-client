extends Node


func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if Input.is_action_pressed("ctrl"):
		if Input.is_action_just_pressed("breakpoint"):
			breakpoint
	
