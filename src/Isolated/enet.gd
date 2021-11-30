extends SceneTree


func _init():
	var args = OS.get_cmdline_args()
	
	connect("network_peer_connected", self, "_on_network_peer_connected")
	
	var port = int(args[1])
	
	if args[0] == "server":
		server(port, 5)
	else:
		client('134.122.117.174', port)


func _on_network_peer_connected(id):
	print("P-%s says hi!" % id)


func server(port, players):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(port, players)
	network_peer = peer
	print ("Server hosted on port %s max players %s" % [port, players])


func client(ip, port):
	print ("Trying to connect to %s:%s" % [ip, port])
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	network_peer = peer
