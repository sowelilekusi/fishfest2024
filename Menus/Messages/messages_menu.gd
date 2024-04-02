class_name MessageMenu extends ScrollContainer

@export var message_preview_scene: PackedScene
@export var vbox: VBoxContainer
var save: SaveFile


func _ready() -> void:
	var message = message_preview_scene.instantiate() as MessagePreview
	vbox.add_child(message)
