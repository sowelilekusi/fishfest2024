class_name FishCard extends PanelContainer

signal swiped(outcome: bool)

var profile: FishProfile
@export var pfp_display: TextureRect
@export var fish_label: Label


func set_display(new_profile: FishProfile):
	profile = new_profile
	pfp_display.texture = profile.picture
	fish_label.text = profile.fish_name


func _on_no_pressed() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	var dest: Vector2 = position + Vector2(-600, 0)
	tween.tween_property(self, "position", dest, 0.6)
	tween.tween_callback(set_visible.bind(false))
	tween.tween_callback(func(): swiped.emit(false))
	tween.tween_callback(queue_free)


func _on_yes_pressed() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	var dest: Vector2 = position + Vector2(600, 0)
	tween.tween_property(self, "position", dest, 0.6)
	tween.tween_callback(set_visible.bind(false))
	tween.tween_callback(func(): swiped.emit(true))
	tween.tween_callback(queue_free)
