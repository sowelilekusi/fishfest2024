extends PanelContainer

@export var profile_name: LineEdit
@export var enter_button: TextureButton


func _ready() -> void:
	if Data.save_file.catfish_name:
		profile_name.text = Data.save_file.catfish_name
		enter_button.visible = true


func _on_texture_button_pressed() -> void:
	get_tree().quit()


func load_game() -> void:
	if profile_name.text.length() > 0:
		Data.save_file.catfish_name = profile_name.text
		get_tree().change_scene_to_file("res://Quinnsoft94/desktop.tscn")


func _on_line_edit_text_submitted(_new_text: String) -> void:
	load_game()


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.length() > 0:
		enter_button.visible = true
	else:
		enter_button.visible = false


func _on_enter_button_pressed() -> void:
	load_game()
