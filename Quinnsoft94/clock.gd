class_name ClockLabel extends Label


func _process(_delta: float) -> void:
	var time = Time.get_time_dict_from_system()
	var suffix = "am"
	if time.hour >= 12:
		suffix = "pm"
		if time.hour != 12:
			time.hour -= 12
	text = "%02d:%02d%s" % [time.hour, time.minute, suffix]
