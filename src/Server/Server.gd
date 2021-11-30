extends Node2D


func _ready():
	if OS.get_cmdline_args().size() > 1:
		server()
	else:
		client()
	
	get_tree().connect("network_peer_connected", self, "_player_connected")


func client():
	print("Creating client")
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client('127.0.0.1', 6969)
	get_tree().network_peer = peer
	
	var id = get_tree().get_network_unique_id()
	create_player(id)


func server():
	print("Server listening")
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(6969, 10)
	get_tree().network_peer = peer

	#get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	#get_tree().connect("connected_to_server", self, "_connected_ok")
	#get_tree().connect("connection_failed", self, "_connected_fail")
	#get_tree().connect("server_disconnected", self, "_server_disconnected")

func _player_connected(id):
	print("Connected ", id)
	
	if id != 1:
		create_player(id)


func create_player(id):
	var p = preload("res://src/Player/Player.tscn").instance()
	p.name = 'P' + str(id)
	add_child(p)
	
	var i = preload("res://src/Player/Input/Input.tscn").instance()
	i.set_network_master(id)
	i.connect("moved", self, "_on_Input_moved")
	p.add_child(i)


func _on_Input_moved(pos):
	rpc('rpc_client_moved', pos)


remotesync func rpc_client_moved(pos: Vector2):
	var id = "P" + str(get_tree().get_rpc_sender_id())
	var node = get_node_or_null(id)
	print (id, 'move', pos)
	
	if node:
		node.target = pos

