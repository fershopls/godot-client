extends Node

signal moved (position)

func _ready():
	if not is_network_master():
		set_process(false)


func _process(delta):
	if Input.is_action_pressed("ads"):
		var position = get_viewport().get_mouse_position()
		emit_signal('moved', position)

