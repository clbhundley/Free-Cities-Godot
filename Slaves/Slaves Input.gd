extends Spatial

onready var gui = game.get_gui()

var active_input

var cam_pos = 7.0
var min_camera_pos = 7
var max_camera_pos = 0.0

func _input(event):
	if not is_visible_in_tree():
		return
	if game.popup_is_visible():
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
			cam_pos -= event.relative.x * 0.015
			slide = true
	elif event.is_action_pressed('ui_page_up'):# and not mouse_over_ui_panel:
		if not mouse_over_ui_panel:
			cam_pos -= 2
			slide = true
		else:
			active_input = false
	elif event.is_action_pressed('ui_page_down'):# and not mouse_over_ui_panel:
		if not mouse_over_ui_panel:
			cam_pos += 2
			slide = true
		else:
			active_input = false
	if slide and active_input:
		var active_collection = get("active_collection")
		max_camera_pos = SlaveUtils.slave_count(active_collection.name)*5+0.7
		if SlaveUtils.slave_count(active_collection.name) == 1:
			max_camera_pos *= 1.3
		call("clamp_camera_position")
		call("slide_camera")
