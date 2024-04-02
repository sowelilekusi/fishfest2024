class_name SaveFile extends Resource

const SAVE_PATH: String = "user://save.tres"

@export var catfish_name: String
@export var accepted_fish: Array[FishProfile]


func save_to_disk() -> void:
	ResourceSaver.save(self, SAVE_PATH)
static func load_profile_from_disk() -> SaveFile:
	if ResourceLoader.exists(SAVE_PATH):
		return ResourceLoader.load(SAVE_PATH)
	return SaveFile.new()
