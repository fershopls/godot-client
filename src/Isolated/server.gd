extends SceneTree

func _init():
	var port = 6969
	var ip = "0.0.0.0"
	
	var done = false

	var socket = PacketPeerUDP.new()
	if(socket.listen(port,ip) != OK):
		print("An error occurred listening on port", port)
		done = true;
	else:
		print("Listening on ", ip,":",port)

	while(done != true):
		if(socket.get_available_packet_count() > 0):
			var data = socket.get_packet().get_string_from_ascii()
			if(data == "quit"):
				done = true
			else:
				print("Data received: " + data)
	
	socket.close()        
	print("Exiting application")    
	self.quit()
