extends Node

onready var slaves = get_parent()
onready var gui = game.get_gui()

var active_input

func _input(event):
	if not slaves.is_visible_in_tree():
		return
	var active_camera = get_viewport().get_camera()
	if active_camera.get_parent().name != "Slaves":
		if not event.is_action_pressed('ui_back'):
			return
	var active_events = ['ui_back','ui_page_up','ui_page_down']
	for _event in active_events:
		if event.is_action_pressed(_event):
			active_input = true
	var mouse_over_ui_panel = game.get_gui().mouse_over_ui_panel()
	if mouse_over_ui_panel and not active_input:
		return
	if Input.is_action_just_pressed("ui_accept") and not mouse_over_ui_panel:
		active_input = true
	elif event.is_action_released("ui_accept"):
		active_input = false
	var slide
	if event.is_action_pressed('ui_back'):
		if gui.get_node("Navigation/Time/TimePanel").is_visible_in_tree():
			gui.get_node("Navigation/Time")._on_Button_toggled(false)
			gui.get_node("Navigation/Time/Button").set_pressed(false)
		elif gui.get_node("SidePanel").is_open or gui.get_node("SidePanel").is_hidden:
			if gui.get_node("Dock").mode == "PurchaseSlave":
				active_camera.deactivate()
			else:
				gui.get_node("Dock")._on_ActionButton_pressed()
		elif active_camera.get_parent().name != "Slaves":
			gui.get_node("Dock/ActionButton/Tag").hide()
			active_camera.deactivate()
	elif event.is_class("InputEventMouseMotion") and active_input: # add android swipe here?
		if event.button_mask&(BUTTON_MASK_LEFT):
			slaves.cam_pos -= event.relative.x * 0.015
			slide = true
	elif event.is_action_pressed('ui_page_up'):# and not mouse_over_ui_panel:
		if not mouse_over_ui_panel:
			slaves.cam_pos -= 2
			slide = true
		else:
			active_input = false
	elif event.is_action_pressed('ui_page_down'):# and not mouse_over_ui_panel:
		if not mouse_over_ui_panel:
			slaves.cam_pos += 2
			slide = true
		else:
			active_input = false
	if slide and active_input:
		slaves.max_camera_pos = SlaveUtils.slave_count(slaves.active_collection.name)*5+0.7
		if SlaveUtils.slave_count(slaves.active_collection.name) == 1:
			slaves.max_camera_pos *= 1.3
		slaves.clamp_camera_position()
		slaves.slide_camera()
