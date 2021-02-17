extends Node

onready var slaves = get_parent()
onready var GUI = game.get_gui()

func _input(event):
	if not slaves.is_visible_in_tree():
		return
	var calendar = GUI.get_node("Navigation/Time/Calendar")
	if calendar.is_visible():
		return
	var active_camera = get_viewport().get_camera()
	if active_camera.get_parent().name != "Slaves":
		if not event.is_action_pressed('ui_back'):
			return
	var slide
	if event.is_action_pressed('ui_back'):
		if GUI.get_node("SidePanel").open or GUI.get_node("SidePanel").hidden:
			GUI.get_node("Dock")._on_ActionButton_pressed()
		elif active_camera.get_parent().name != "Slaves":
			active_camera.deactivate()
	elif event.is_class("InputEventMouseMotion"): # add android swipe here?
		if event.button_mask&(BUTTON_MASK_LEFT):
			slaves.cam_pos -= event.relative.x * 0.015
			slide = true
	elif event.is_action_pressed('ui_page_up'):
		slaves.cam_pos -= 2
		slide = true
	elif event.is_action_pressed('ui_page_down'):
		slaves.cam_pos += 2
		slide = true
	if slide:
		slaves.max_camera_pos = SlaveUtils.slave_count(slaves.active_collection.name)*5+0.7
		if SlaveUtils.slave_count(slaves.active_collection.name) == 1:
			slaves.max_camera_pos *= 1.3
		slaves.clamp_camera_position()
		slaves.slide_camera()
