extends Control


func _ready():
	if OS.get_cmdline_args().size() > 1:
		var type = OS.get_cmdline_args()[1]
		Auth.is_server = type == 'server'
		go_game()


func _on_Button_button_up():
	Auth.server = $VBoxContainer/Server.text
	Auth.port = $VBoxContainer/Port.text
	Auth.username = $VBoxContainer/Username.text
	go_game()


func go_game():
	get_tree().change_scene("res://src/Server/Server.tscn")
