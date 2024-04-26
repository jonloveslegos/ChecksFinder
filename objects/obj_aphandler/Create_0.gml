global.client = network_create_socket(network_socket_ws)
ip = get_string("IP Address of server", "wss://archipelago.gg")
port = get_integer("Port of server", 38281)
network_connect_raw_async(global.client, ip, port)