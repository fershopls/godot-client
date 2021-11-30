extends Node2D


func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("connection_failed", self, "_connection_failed")
	
	if Auth.is_server:
		server()
	else:
		client()


func client():
	print("Creating client")
	var peer = NetworkedMultiplayerENet.new()
	var result = peer.create_client(Auth.server, int(Auth.port))
	get_tree().network_peer = peer
	
	var id = get_tree().get_network_unique_id()
	create_player(id)


func server():
	print("Server listening")
	var peer = NetworkedMultiplayerENet.new()
	peer.set_bind_ip('134.122.117.174')
	peer.create_server(6969, 10)
	get_tree().network_peer = peer

	#get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	#get_tree().connect("connected_to_server", self, "_connected_ok")
	#get_tree().connect("connection_failed", self, "_connected_fail")



func _connection_failed():
	print ('failed')
	get_tree().change_scene("res://src/UI/Connect/Connect.tscn")


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

