extends Node

onready var p = get_parent()
onready var GUI = game.get_gui()

func _input(event):
	if not p.is_visible_in_tree():
		return
	var calendar = GUI.get_node("Navigation/Time/Calendar")
	if calendar.is_visible():
		return
	p.max_camera_pos = SlaveUtils.slave_count(p.active_collection.name) * 5.4
	if SlaveUtils.slave_count(p.active_collection.name) == 1:
		p.max_camera_pos *= 1.3
	if event.is_class("InputEventMouseMotion"): # add android swipe here?
		if event.button_mask&(BUTTON_MASK_LEFT):
			p.cam_pos -= event.relative.x * 0.015
	elif event.is_action_pressed('ui_page_up'):
			p.cam_pos -= 2
	elif event.is_action_pressed('ui_page_down'):
			p.cam_pos += 2
	elif event.is_action_pressed('ui_back'):
		if GUI.get_node("SidePanel").open:
			GUI.get_node("Dock")._on_ActionButton_pressed()
	else:
		return
	p.clamp_camera_position()
	p.slide_camera()
