class_name Desktop extends ColorRect

@export var window_holder: Control
@export var taskbar: HBoxContainer
@export var desktop_icon_container: VBoxContainer

@export var pof_icon: Texture
@export var pof_scene: PackedScene

var window_scene = preload("res://Quinnsoft94/program_window.tscn")


func add_desktop_icon(icon: Texture, title: String, function: Callable):
	var button = Button.new()
	button.flat = true
	button.icon = icon
	button.text = title
	button.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	button.vertical_icon_alignment = VERTICAL_ALIGNMENT_TOP
	button.expand_icon = true
	button.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	button.custom_minimum_size = Vector2(96, 96)
	button.pressed.connect(function)
	desktop_icon_container.add_child(button)


func spawn_program(program_scene, icon):
	var window = window_scene.instantiate() as DEWindow
	window_holder.add_child(window)
	var program = program_scene.instantiate() as Application
	program.save_file = SaveFile.load_profile_from_disk()
	add_child(program)
	window.set_program(program)
	var button = Button.new()
	button.text = program.application_name
	button.icon = icon
	button.pressed.connect(window.set_visible.bind(true))
	taskbar.add_child(button)
	window.closed.connect(button.queue_free)


func _ready() -> void:
	add_desktop_icon(pof_icon, "Plentiful Fish", spawn_program.bind(pof_scene, pof_icon))
	#add_desktop_icon(uno_icon, "Uno", spawn_program.bind(uno_scene, uno_icon))
	#add_desktop_icon(snakes_and_ladders_icon, "Snakes and Ladders", spawn_program.bind(snakes_and_ladders_scene, snakes_and_ladders_icon))
