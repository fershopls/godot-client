extends SceneTree

func _init():
	var server = "127.0.0.1"
	var port = 6969
	
	var socket = PacketPeerUDP.new()
	socket.set_dest_address(server, port)
	socket.put_packet("Hola".to_ascii())
	print("Exiting application")
	self.quit()

