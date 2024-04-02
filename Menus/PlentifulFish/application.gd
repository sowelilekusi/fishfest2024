class_name Application extends PanelContainer

@export var application_name: String = "Plentiful Fish"
@export var player_name_text: Label
@export var fish_card_scene: PackedScene
@export var messages_scene: PackedScene
@export var fish_profiles: Array[FishProfile]
@export var discarded_fish_profiles: Array[FishProfile]
@export var contents_page: Control
var has_current_fish: bool = false
var save_file: SaveFile
var current_card: int = 0
var window: DEWindow


func setup_window_integration():
	pass


func _ready() -> void:
	player_name_text.text = save_file.catfish_name
	_on_fish_pressed()


func load_profile() -> void:
	if has_current_fish or fish_profiles.size() <= current_card:
		return
	var fish_card = fish_card_scene.instantiate() as FishCard
	fish_card.set_display(fish_profiles[current_card])
	fish_card.swiped.connect(process_fish_profile.bind(fish_card))
	contents_page.add_child(fish_card)
	has_current_fish = true


func process_fish_profile(outcome: bool, card: FishCard):
	current_card += 1
	has_current_fish = false
	if outcome:
		save_file.accepted_fish.append(card.profile)
	else:
		discarded_fish_profiles.append(card.profile)
	if discarded_fish_profiles.size() > 0 and current_card >= fish_profiles.size():
		$Timer.start()
	load_profile()


func recycle_profiles() -> void:
	fish_profiles = discarded_fish_profiles
	current_card = 0


func _on_fish_pressed() -> void:
	for node: Node in contents_page.get_children():
		node.queue_free()
	load_profile()


func _on_messages_pressed() -> void:
	has_current_fish = false
	for node: Node in contents_page.get_children():
		node.queue_free()
	var messages: MessageMenu = messages_scene.instantiate() as MessageMenu
	contents_page.add_child(messages)


func _on_profile_pressed() -> void:
	has_current_fish = false
	for node: Node in contents_page.get_children():
		node.queue_free()
