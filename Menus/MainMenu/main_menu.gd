extends PanelContainer

@export var profile_name: LineEdit
@export var enter_button: TextureButton

var save: SaveFile


func _ready() -> void:
	save = SaveFile.load_profile_from_disk()
	if save.catfish_name:
		profile_name.text = save.catfish_name
		enter_button.visible = true


func _on_texture_button_pressed() -> void:
	get_tree().quit()


func load_game() -> void:
	if profile_name.text.length() > 0:
		save.catfish_name = profile_name.text
		save.save_to_disk()
		get_tree().change_scene_to_file("res://Quinnsoft94/desktop.tscn")


func _on_line_edit_text_submitted(new_text: String) -> void:
	load_game()


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.length() > 0:
		enter_button.visible = true
	else:
		enter_button.visible = false


func _on_enter_button_pressed() -> void:
	load_game()
