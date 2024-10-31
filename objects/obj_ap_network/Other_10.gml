/// @description Create client and connect
global.client = network_create_socket(network_socket_ws)
network_connect_raw_async(global.client, global.ap.server, global.ap.port)