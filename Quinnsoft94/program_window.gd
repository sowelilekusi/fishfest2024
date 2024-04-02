class_name DEWindow extends PanelContainer

signal closed()
signal minimized()

@export var title_label: Label
@export var game_holder: PanelContainer
@export var context_buttons: HBoxContainer
@export var sub_menu_parent: Control
var sub_menu_scene = preload("res://Quinnsoft94/window_sub_menu.tscn")
var application: Application
var dragging = false
var drag_offset
var sub_menus = {}


func set_program(program) -> void:
	application = program
	application.reparent(game_holder)
	application.window = self
	title_label.text = application.application_name
	application.setup_window_integration()


func create_sub_menu(menu_name: String):
	var menu = sub_menu_scene.instantiate()
	menu.visible = false
	sub_menus[menu_name] = menu
	sub_menu_parent.add_child(menu)
	var button = Button.new()
	button.text = menu_name
	context_buttons.add_child(button)
	button.pressed.connect(menu.set_visible.bind(true))
	context_buttons.get_parent().visible = true


func register_sub_menu_action(menu_name: String, button_text: String, function: Callable):
	var button = Button.new()
	button.text = button_text
	button.pressed.connect(func():
		function.call()
		sub_menus[menu_name].visible = false
	)
	sub_menus[menu_name].buttons.add_child(button)


func minimize():
	minimized.emit()
	visible = false


func close():
	closed.emit()
	queue_free()


func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() + drag_offset


func _on_margin_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = true
			move_to_front()
			drag_offset = global_position - get_global_mouse_position()
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			dragging = false

