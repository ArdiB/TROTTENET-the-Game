extends "res://Scenes/Saves/PersistentProperties.gd"


var sound_volume: float = 3 setget _set_sound_volume
var music_volume: float = 3 setget _set_music_volume



func _init():
	# override filename
	filepath = 'user://settings.json'


# set soundeffect volume on AudioServer
func _set_sound_volume(new_value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Sound"),
		linear2db(new_value)
	)
	sound_volume = new_value

# set music volume on AudioServer
func _set_music_volume(new_value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"), 
		linear2db(new_value)
	)
	music_volume = new_value

