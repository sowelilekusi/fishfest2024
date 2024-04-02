extends Node

var save_file: SaveFile


func _ready() -> void:
	save_file = SaveFile.load_profile_from_disk()


func save():
	save_file.save_to_disk()


func reset_fish():
	save_file.accepted_fish = []
