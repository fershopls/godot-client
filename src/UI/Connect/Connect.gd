extends Control


func _ready():
	Auth.is_server = OS.get_cmdline_args().size() > 1
	
	if Auth.is_server:
		go_game()


func _on_Button_button_up():
	Auth.server = $VBoxContainer/Server.text
	Auth.port = $VBoxContainer/Port.text
	Auth.username = $VBoxContainer/Username.text
	go_game()


func go_game():
	get_tree().change_scene("res://src/Server/Server.tscn")
