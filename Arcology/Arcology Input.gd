extends Spatial

onready var gui = game.gui
onready var dock = gui.get_node("Dock")

var view = "arcology"

var selected_terra
var selected_building

var mouse_motion_detected
var mouse_over_sector
var active_input

var camera_rotation = 0.0

func _input(event):
	if not is_visible_in_tree():
		return
	if game.popup_is_visible():
		return
	if event.is_action_pressed('ui_back'):
		active_input = true
	var mouse_over_ui_panel = game.gui.mouse_over_ui_panel()
	if mouse_over_ui_panel and not active_input:
		return
	if Input.is_action_just_pressed("ui_accept") and not mouse_over_ui_panel:
		active_input = true
	elif event.is_action_released("ui_accept"):
		active_input = false
	if event.is_class("InputEventMouseMotion") and active_input:
		if event.button_mask&(BUTTON_MASK_LEFT):
			camera_rotation += event.relative.x * 0.005
			get_node("Cambase").set_rotation(Vector3(0, -1*camera_rotation, 0))
	elif event.is_action_pressed('ui_back') and gui.get_node("Navigation/Time/TimePanel").is_visible_in_tree():
			gui.get_node("Navigation/Time")._on_Button_toggled(false)
			gui.get_node("Navigation/Time/Button").set_pressed(false)
	elif event.is_action_pressed('ui_back') or event.is_action_pressed("stationary_select") and not mouse_over_sector:
		if view == "arcology":
			gui.mouse_over_gui = false
			if selected_terra:
				selected_terra = null
				call("update_header",get("arcology_name"))
				if dock.mode != "ManageArcology":
					dock.set_mode("ManageArcology")
				get_node("ChangeView").hide()
				for terra in $Structure.get_children():
					call("outline_terra",terra,null)
			elif event.is_action_pressed('ui_back'):
				if gui.get_node("SidePanel").is_open:
					dock._on_ActionButton_pressed()
		elif view == "terra":
			selected_building = null
			for ring in $Structure.get_node(selected_terra).get_children():
				for sector in ring.get_children():
					if sector.selected:
						call("outline_building",sector,null)
						sector.selected = false
						call("update_header",selected_terra)
						dock.set_mode("ManageTerra")
						return
			if event.is_action_pressed("stationary_select") and not mouse_over_sector:
				return
			call("view_arcology")

func arc_input_event(camera,event,click_position,click_normal,shape_idx,sector):
	if event.is_action_released("ui_accept"):
		if not gui.mouse_over_gui:
			if not mouse_motion_detected:
				if view == "arcology":
					for terra in $Structure.get_children():
						call("outline_terra",terra,null)
					var terra = sector.get_node('../../')
					call("outline_terra",terra,get("highlight_white"))
					if selected_terra != terra.name:
						selected_terra = terra.name
						gui.get_node("SidePanel/ManageTerra").refresh()
						dock.set_mode("ManageTerra")
						call("update_header",get("arcology_name")+"  -  "+selected_terra)
						get_node("ChangeView").show()
				elif view == "terra":
					for ring in sector.get_node('../../').get_children():
						for sector in ring.get_children():
							call("outline_sector",sector,null)
							sector.selected = false
					call("outline_building",sector,get("highlight_white"))
					var terra_index = sector.get_node("../../").get_index()
					var ring_index = sector.get_parent().get_index()
					var sector_index = sector.get_index()
					var address = ArcUtils.to_address(terra_index,ring_index,sector_index)
					var sector_name = ArcUtils.sector_name(sector.name).capitalize()
					if selected_building != ArcUtils.get_building(sector):
						call("update_header",address + "  -  " + sector_name)
						selected_building = ArcUtils.get_building(sector)
						sector.selected = true
						gui.get_node("SidePanel/ManageBuilding").refresh()
						if not dock.side_panel.is_open:
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
	if view == "arcology":
		if event.doubleclick:
			_on_ChangeView_pressed()
	elif view == "terra":
		if event.doubleclick:
			if not dock.side_panel.is_open:
				dock.set_mode("ManageBuilding",false)
				dock._on_ActionButton_pressed()

func _on_ChangeView_pressed():
	if view == "arcology":
		call("view_terra")
	elif view == "terra":
		call("view_arcology")

func sector_mouse_entered(sector):
	mouse_over_sector = true
	if view == "arcology":
		var terra = sector.get_node('../../')
		if terra.name != selected_terra:
			call("outline_terra",terra,get("highlight_cyan"))
	elif view == "terra":
		if not ArcUtils.get_building(sector) == selected_building:
			call("outline_building",sector,get("highlight_cyan"))

func sector_mouse_exited(sector):
	mouse_over_sector = false
	if view == "arcology":
		var terra = sector.get_node('../../')
		if terra.name != selected_terra:
			call("outline_terra",terra,null)
	elif view == "terra":
		if not ArcUtils.get_building(sector) == selected_building:
			call("outline_building",sector,null)
