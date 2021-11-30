extends Control


func _on_Button_button_up():
	connect_to("127.0.0.1", 6969, "Ferchito")


func connect_to(server, port, username):
	var socket = PacketPeerUDP.new()
	socket.set_dest_address(server, port)
	socket.put_packet(username.to_ascii())
	get_tree().quit()

