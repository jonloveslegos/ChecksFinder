class_name ChecksFinderConfigManager extends APConfigManager

const CHECKSFINDER_CONFIG_VERSION := 0
var ip: String = "archipelago.gg" :
	set(val):
		if val != ip:
			ip = val
			save_cfg()
			config_changed.emit()
var port: String = "" :
	set(val):
		if val != port:
			port = val
			save_cfg()
			config_changed.emit()
var slot: String = "" :
	set(val):
		if val != slot:
			slot = val
			save_cfg()
			config_changed.emit()

class CustomVolumeStorage:
	signal changed_volume
	const master = "Master"
	const music = "Music"
	const sound_effects = "Sound Effects"
	var _dict = {
		master: 0.75,
		music: 1.0,
		sound_effects: 1.0,
	}
	func set_volume(bus_name: String, value: float) -> void:
		if _dict[bus_name] != value:
			_dict[bus_name] = value
			changed_volume.emit()
	func get_volume(bus_name: String) -> float:
		return _dict[bus_name]

var volume_storage := CustomVolumeStorage.new()

func _ready():
	volume_storage.changed_volume.connect(_on_update)
	load_cfg()
	Archipelago.creds.updated.connect(update_credentials)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(volume_storage.master),
		volume_storage.get_volume(volume_storage.master))
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(volume_storage.music),
		volume_storage.get_volume(volume_storage.music))
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(volume_storage.sound_effects),
		volume_storage.get_volume(volume_storage.sound_effects))

func _on_update() -> void:
	save_cfg()
	config_changed.emit()

func _load_cfg(file: FileAccess) -> bool:
	if not super(file):
		return false
	var _vers := file.get_32()                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
	ip = file.get_pascal_string()
	port = file.get_pascal_string()
	slot = file.get_pascal_string()
	Archipelago.creds.update(ip, port, slot, "")
	volume_storage.set_volume(volume_storage.master, file.get_float())
	volume_storage.set_volume(volume_storage.music, file.get_float())
	volume_storage.set_volume(volume_storage.sound_effects, file.get_float())
	return true

func _save_cfg(file: FileAccess) -> void:
	super(file)
	file.store_32(CHECKSFINDER_CONFIG_VERSION)
	file.store_pascal_string(ip)
	file.store_pascal_string(port)
	file.store_pascal_string(slot)
	file.store_float(volume_storage.get_volume(volume_storage.master))
	file.store_float(volume_storage.get_volume(volume_storage.music))
	file.store_float(volume_storage.get_volume(volume_storage.sound_effects))

func update_credentials(creds: APCredentials) -> void:
	_pause_saving = true
	ip = creds.ip
	port = creds.port
	slot = creds.slot
	_pause_saving = false
	save_cfg()
