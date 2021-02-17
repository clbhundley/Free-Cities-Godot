extends Node

onready var p = get_parent()
onready var gui = game.get_gui()
onready var dock = gui.get_node("Dock")

var mouse_motion_detected
var mouse_over_sector

var camera_rotation = 0.0
func _input(event):
	if not p.visible:
		return
	var calendar = gui.get_node("Navigation/Time/Calendar")
	if calendar.is_visible():
		return
	if event.is_class("InputEventMouseMotion"):
		if event.button_mask&(BUTTON_MASK_LEFT):
			camera_rotation += event.relative.x * 0.005
			get_node("../Cambase").set_rotation(Vector3(0, -1*camera_rotation, 0))
	elif event.is_action_pressed('ui_back') or event.is_action_pressed("stationary_select") and not mouse_over_sector:
		if p.view == "arcology":
			gui.mouse_over_gui = false
			if p.selected_terra:
				#get_tree().set_input_as_handled()
				p.selected_terra = null
				p.update_header(p._name)
				if dock.mode != "ManageArcology":
					dock.set_mode("ManageArcology")
				get_node("../ChangeView").hide()
				for terra in get_node("../Structure").get_children():
					p.outline_terra(terra,null)
			elif event.is_action_pressed('ui_back'):
				if gui.get_node("SidePanel").open:
					dock._on_ActionButton_pressed()
		elif p.view == "terra":
			#get_tree().set_input_as_handled()
			p.selected_building = null
			for ring in get_node("../Structure").get_node(p.selected_terra).get_children():
				for sector in ring.get_children():
					if sector.selected:
						p.outline_building(sector,null)
						sector.selected = false
						p.update_header(p.selected_terra)
						dock.set_mode("ManageTerra")
						return
			if event.is_action_pressed("stationary_select") and not mouse_over_sector:
				return
			p.view_arcology()

func arc_input_event(camera,event,click_position,click_normal,shape_idx,sector):
	if event.is_action_released("ui_accept"):
		if not game.get_gui().mouse_over_gui:
			if not mouse_motion_detected:
				if p.view == "arcology":
					for terra in get_node("../Structure").get_children():
						p.outline_terra(terra,null)
					var terra = sector.get_node('../../')
					p.outline_terra(terra,p.highlight_white)
					if p.selected_terra != terra.name:
						p.selected_terra = terra.name
						gui.get_node("SidePanel/ManageTerra").update()
						dock.set_mode("ManageTerra")
						p.update_header(p._name + "  -  " + p.selected_terra)
						get_node("../ChangeView").show()
				elif p.view == "terra":
					for ring in sector.get_node('../../').get_children():
						for sector in ring.get_children():
							p.outline_sector(sector,null)
							sector.selected = false
					p.outline_building(sector,p.highlight_white)
					var terra_index = sector.get_node("../../").get_index()
					var ring_index = sector.get_parent().get_index()
					var sector_index = sector.get_index()
					var address = ArcUtils.to_address(terra_index,ring_index,sector_index)
					var sector_name = ArcUtils.sector_name(sector.name).capitalize()
					if p.selected_building != ArcUtils.get_building(sector):
						p.update_header(address + "  -  " + sector_name)
						p.selected_building = ArcUtils.get_building(sector)
						sector.selected = true
						gui.get_node("SidePanel/ManageBuilding").update()
						if not dock.side_panel.open:
							dock.set_mode("ManageBuilding",false)
						else:
							dock.set_mode("ManageBuilding")
	if event.is_class("InputEventMouseMotion"):
		mouse_motion_detected = true
	else:
		mouse_motion_detected = false
	if not event.is_pressed():
		return
	if not event.is_class("InputEventScreenTouch"):
		if event.button_index:
			if event.button_index != 1:
				return
	if p.view == "arcology":
		if event.doubleclick:
			_on_ChangeView_pressed()
	elif p.view == "terra":
		if event.doubleclick:
			if not dock.side_panel.open:
				dock.set_mode("ManageBuilding",false)
				dock._on_ActionButton_pressed()

func _on_ChangeView_pressed():
	if p.view == "arcology":
		p.view_terra()
	elif p.view == "terra":
		p.view_arcology()

func sector_mouse_entered(sector):
	mouse_over_sector = true
	if p.view == "arcology":
		var terra = sector.get_node('../../')
		if terra.name != p.selected_terra:
			p.outline_terra(terra,p.highlight_cyan)
	elif p.view == "terra":
		if not ArcUtils.get_building(sector) == p.selected_building:
			p.outline_building(sector,p.highlight_cyan)

func sector_mouse_exited(sector):
	mouse_over_sector = false
	if p.view == "arcology":
		var terra = sector.get_node('../../')
		if terra.name != p.selected_terra:
			p.outline_terra(terra,null)
	elif p.view == "terra":
		if not ArcUtils.get_building(sector) == p.selected_building:
			p.outline_building(sector,null)
