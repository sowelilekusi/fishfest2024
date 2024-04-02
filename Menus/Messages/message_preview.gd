class_name MessagePreview extends MarginContainer

signal open_message()

@export var pfp: TextureRect
@export var fish_name_label: Label
@export var message_label: Label


func setup(profile: FishProfile, message: String):
	pfp.texture = profile.picture
	fish_name_label.text = profile.fish_name
	message_label.text = message


func _on_button_pressed() -> void:
	open_message.emit()
