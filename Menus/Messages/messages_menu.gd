class_name MessageMenu extends ScrollContainer

@export var message_preview_scene: PackedScene
@export var vbox: VBoxContainer


func _ready() -> void:
	for profile: FishProfile in Data.save_file.accepted_fish:
		var message = message_preview_scene.instantiate() as MessagePreview
		message.setup(profile, "send a first message to " + str(profile.fish_name) + "!")
		vbox.add_child(message)
