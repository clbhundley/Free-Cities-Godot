extends Node

onready var gui = get_parent()
onready var time_display = get_node('../Navigation/Time')
onready var clock_speed_slider = get_node('../Navigation/Time/TimePanel/Controls/Sliders/ClockSpeed')
onready var time_panel = get_node('../Navigation/Time/TimePanel')
onready var timer = get_tree().get_root().get_node('Game/Clock')

var motion_detected
func is_input_stationary_select(event):
	if event.is_action_released("ui_accept"):
		if not gui.mouse_over_gui:
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
		if clock_speed_slider.value < 99:
			clock_speed_slider.value = 99
			if not time_panel.is_visible_in_tree():
				time_display.animate_sml(time_display.get_node('rabbit'))
		else:
			clock_speed_slider.value = 0
			if not time_panel.is_visible_in_tree():
				time_display.animate_sml(time_display.get_node('turtle'))
	elif event.is_action_pressed('pause'):
		if timer.is_paused():
			timer.set_paused(false)
			if not time_panel.is_visible_in_tree():
				time_display.animate_sml(time_display.get_node('play'))
		else:
			timer.set_paused(true)
			if not time_panel.is_visible_in_tree():
				time_display.animate_sml(time_display.get_node('pause'))
