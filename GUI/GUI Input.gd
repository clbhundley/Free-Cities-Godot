extends Node

onready var p = get_parent()
onready var AI_panel = get_node('../AI Panel')
onready var time_display = get_node('../Navigation/Time')
onready var slider = get_node('../Navigation/Time/HSlider')
onready var calendar = get_node('../Navigation/Time/Calendar')
onready var timer = get_tree().get_root().get_node('Game/Clock')

var motion_detected
func is_input_stationary_select(event):
	if event.is_action_released("ui_accept"):
		if not p.mouse_over_gui:
			if not motion_detected:
				var ev = InputEventAction.new()
				ev.action = "stationary_select"
				ev.pressed = true
				Input.parse_input_event(ev)
	if event.is_class("InputEventMouseMotion"):
		motion_detected = true
	else:
		motion_detected = false

func _input(event):
	is_input_stationary_select(event)
	if event.is_action_pressed('speed'):
		if slider.value < 99:
			slider.value = 99
			if not calendar.is_visible_in_tree():
				time_display.animate_sml(time_display.get_node('rabbit'))
		else:
			slider.value = 0
			if not calendar.is_visible_in_tree():
				time_display.animate_sml(time_display.get_node('turtle'))
	elif event.is_action_pressed('pause'):
		if timer.is_paused():
			timer.set_paused(false)
			if not calendar.is_visible_in_tree():
				time_display.animate_sml(time_display.get_node('play'))
		else:
			timer.set_paused(true)
			if not calendar.is_visible_in_tree():
				time_display.animate_sml(time_display.get_node('pause'))
	elif event.is_action_pressed('ui_back'):
		var button = time_display.get_node('Button')
		if AI_panel.is_visible_in_tree():
			if button.is_pressed():
				p._on_Time_toggled(false)
				button.set_pressed(false)
			else:
				p._on_AI_pressed()
		elif calendar.is_visible_in_tree():
			p._on_Time_toggled(false)
			button.set_pressed(false)
