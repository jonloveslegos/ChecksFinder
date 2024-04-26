global.client = network_create_socket(network_socket_ws)
network_connect_raw_async(global.client, "localhost", 38281)