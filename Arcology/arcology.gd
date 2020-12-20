extends Node

var location = "Asia"
var _name = "Arcology X-4"
var size = 7
var structure #not being used properly
var selected_terra
var selected_building
const ARCOLOGY_VIEW = 0
const TERRA_VIEW = 1
var view = "arcology"
onready var GUI = get_tree().get_root().get_node("Game/GUI")
onready var dock = GUI.get_node("Dock")
onready var camera = get_node('Cambase/Camera')
onready var highlight_white = load('res://Arcology/Materials/white.material')
onready var highlight_cyan = load('res://Arcology/Materials/cyan.material')

func _ready():
	get_tree().get_root().connect('size_changed',self,'resize')
	var position = 0
	#new arc is being generated anyway
	if not structure:
		for terra in get_node('New Arcology').generate(size):
			terra.translation[1] = position
			$Structure.add_child(terra)
			position -= 1.5
	show_ownership_outlines()
	update_header(_name)
	resize()

func update_header(text):
	var header = GUI.get_node("Header/Arcology/Title")
	header.set_text(text)

func show_ownership_outlines():
	for terra in $Structure.get_children():
		if terra.name != "Penthouse" and terra.name != "Basement":
			for ring in terra.get_children():
				for sector in ring.get_children():
					var building = ArcUtils.get_building(sector)
					if not building.owned:
						sector.get_node("Mesh/NotOwned").show()

func outline_terra(terra,material):
	for ring in terra.get_children():
		for sector in ring.get_children():
			outline_sector(sector,material)

func outline_building(sector,material):
	sector = ArcUtils.get_building(sector)
	var building_size = 1
	var building = []
	if sector.get("size"):
		building_size = sector.size
	for section in building_size:
		building.append(sector.get_parent().get_child((sector.get_index()+section+12)%12))
	for section in building:
		outline_sector(section,material)

func outline_sector(sector,material):
	sector.get_node('Mesh/Selected').set_material_override(material)
	if material:
		sector.get_node('Mesh/Selected').show()
	else:
		sector.get_node('Mesh/Selected').hide()

func view_arcology():
	var t_start = camera.translation
	var t_modify = $Structure.get_node(selected_terra).translation[1]
	var t_end = Vector3(0, -8.5, 16)
	var r_start = camera.rotation_degrees
	var r_end = Vector3(-4, cam_offset, 0)
	for terra in $Structure.get_children():
		terra.show()
		if terra.name == selected_terra:
			outline_terra(terra,highlight_white)
			for ring in terra.get_children():
				for sector in ring.get_children():
					ArcUtils.get_building(sector).selected = false
	selected_building = null
	view = "arcology"
	$ChangeView.show()
	$ChangeView.set_text("View Terra")
	$ChangeView.margin_left = 0 #refresh size
	update_header(_name + "  -  " + selected_terra)
	animate_camera(t_start,t_end,r_start,r_end)
	if dock.mode != "ManageTerra":
		dock.set_mode("ManageTerra")

func view_terra():
	if not selected_terra: #prevents rapid left/right click bug
		return
	var t_start = camera.translation
	var t_modify = $Structure.get_node(selected_terra).translation[1]
	var t_end = Vector3(0, t_modify+2, 9)
	var r_start = camera.rotation_degrees
	var r_end = Vector3(-40, 0, 0)
	for terra in $Structure.get_children():
		outline_terra(terra,null)
		if terra.name != selected_terra:
			terra.hide()
	view = "terra"
	$ChangeView.set_text("View Arcology")
	$ChangeView.margin_left = 0 #refresh size
	update_header(selected_terra)
	animate_camera(t_start,t_end,r_start,r_end)

func _data():
	var structure = {}
	for terra in $Structure.get_children():
		structure[terra.name] = {}
		for ring in terra.get_children():
			structure[terra.name][ring.name] = {}
			for sector in ring.get_children():
				structure[terra.name][ring.name][sector.name] = sector._data()
	return {
		name = _name,
		location = location,
		structure = structure}

func _load(structure):
	var position = 0
	for node in $Structure.get_children():
		$Structure.remove_child(node)
		node.queue_free()
	for terra in structure:
		var terra_name
		if not terra in ["Penthouse","Basement","Terra A","Terra B"]:
			terra_name = "Fill"
		else:
			terra_name = terra
		var new_terra = get_node("Library/Terras/%s"%terra_name).duplicate()
		new_terra.name = terra
		new_terra.translation[1] = position
		position -= 1.5
		$Structure.add_child(new_terra)
		for ring in structure[terra]:
			for sector in structure[terra][ring]:
				var array = structure[terra][ring].keys()
				var index = $Structure.get_node("%s/%s"%[terra,ring]).get_child(array.find(sector))
				var new_sector = get_node("Library/Sectors/%s"%ArcUtils.sector_name(sector)).duplicate()
				for property in structure[terra][ring][sector]:
					new_sector.set(property,structure[terra][ring][sector][property])
				ArcUtils.swap_sectors(index,new_sector)
	show_ownership_outlines()

func connect_sector_signals(sector):
	sector.connect('input_event',self,'arc_input_event',[sector])
	sector.connect('mouse_entered',self,'sector_mouse_entered',[sector])
	sector.connect('mouse_exited',self,'sector_mouse_exited',[sector])
	var methods = ["tick","minute","hour","day","week","quarter","year"]
	for method in methods:
		if sector.has_method(method):
			time.connect(method,sector,method)

func _on_ChangeView_pressed():
	if view == "arcology":
		view_terra()
	elif view == "terra":
		view_arcology()

var mouse_over_sector = false
func sector_mouse_entered(sector):
	mouse_over_sector = true
	if view == "arcology":
		var terra = sector.get_node('../../')
		if terra.name != selected_terra:
			outline_terra(terra,highlight_cyan)
	elif view == "terra":
		if not ArcUtils.get_building(sector) == selected_building:
			outline_building(sector,highlight_cyan)

func sector_mouse_exited(sector):
	mouse_over_sector = false
	if view == "arcology":
		var terra = sector.get_node('../../')
		if terra.name != selected_terra:
			outline_terra(terra,null)
	elif view == "terra":
		if not ArcUtils.get_building(sector) == selected_building:
			outline_building(sector,null)

var motion_detected
func arc_input_event(camera,event,click_position,click_normal,shape_idx,sector):
	
	if event.is_action_released("ui_accept"):
		if not game.get_gui().mouse_over_gui:
			if not motion_detected:
				if view == "arcology":
					for terra in $Structure.get_children():
						outline_terra(terra,null)
					var terra = sector.get_node('../../')
					outline_terra(terra,highlight_white)
					if selected_terra != terra.name:
						selected_terra = terra.name
						GUI.get_node("SidePanel/ManageTerra").update()
						dock.set_mode("ManageTerra")
						update_header(_name + "  -  " + selected_terra)
						$ChangeView.show()
				elif view == "terra":
					for ring in sector.get_node('../../').get_children():
						for sector in ring.get_children():
							outline_sector(sector,null)
							sector.selected = false
					outline_building(sector,highlight_white)
					var terra_index = sector.get_node("../../").get_index()
					var ring_index = sector.get_parent().get_index()
					var sector_index = sector.get_index()
					var address = ArcUtils.to_address(terra_index,ring_index,sector_index)
					var sector_name = ArcUtils.sector_name(sector.name).capitalize()
					if selected_building != ArcUtils.get_building(sector):
						update_header(address + "  -  " + sector_name)
						selected_building = ArcUtils.get_building(sector)
						sector.selected = true
						GUI.get_node("SidePanel/ManageBuilding").update()
						if not dock.side_panel.open:
							dock.set_mode("ManageBuilding",false)
						else:
							dock.set_mode("ManageBuilding")
	if event.is_class("InputEventMouseMotion"):
		motion_detected = true
	else:
		motion_detected = false
	
	if not event.is_pressed():
		return
	if not event.is_class("InputEventScreenTouch"):
		if event.button_index:
			if event.button_index != 1:
				return
	if view == "arcology":
#		for terra in $Structure.get_children():
#			outline_terra(terra,null)
#		var terra = sector.get_node('../../')
#		outline_terra(terra,highlight_white)
#		selected_terra = terra.name
#		update_header(_name + "  -  " + selected_terra)
#		GUI.get_node("SidePanel/ManageTerra").update()
#		dock.set_mode("ManageTerra")
#		$ChangeView.show()
		if event.doubleclick:
			_on_ChangeView_pressed()
	elif view == "terra":
#		for ring in sector.get_node('../../').get_children():
#			for sector in ring.get_children():
#				outline_sector(sector,null)
#				sector.selected = false
#		outline_building(sector,highlight_white)
#		var terra_index = sector.get_node("../../").get_index()
#		var ring_index = sector.get_parent().get_index()
#		var sector_index = sector.get_index()
#		var address = ArcUtils.to_address(terra_index,ring_index,sector_index)
#		var sector_name = ArcUtils.sector_name(sector.name).capitalize()
#		update_header(address + "  -  " + sector_name)
#		selected_building = ArcUtils.get_building(sector)
#		sector.selected = true
#		GUI.get_node("SidePanel/ManageBuilding").update()
		if event.doubleclick:
			if not dock.side_panel.open:
				dock.set_mode("ManageBuilding",false)
				dock._on_ActionButton_pressed()
#		else:
#			if not dock.side_panel.open:
#				dock.set_mode("ManageBuilding",false)
#			else:
#				dock.set_mode("ManageBuilding")

var camera_rotation = 0.0
func _input(event):
	if not self.visible:
		return
	var calendar = GUI.get_node("Navigation/Time/Calendar")
	if calendar.is_visible():
		return
	if event.is_class("InputEventMouseMotion"):
		if event.button_mask&(BUTTON_MASK_LEFT):
			camera_rotation += event.relative.x * 0.005
			get_node("Cambase").set_rotation(Vector3(0, -1*camera_rotation, 0))
	elif event.is_action_pressed('ui_back') or event.is_action_pressed("stationary_select") and not mouse_over_sector:
		if view == "arcology":
			if selected_terra:
				get_tree().set_input_as_handled()
				selected_terra = null
				update_header(_name)
				if dock.mode != "ManageArcology":
					dock.set_mode("ManageArcology")
				$ChangeView.hide()
				for terra in $Structure.get_children():
					outline_terra(terra,null)
			elif event.is_action_pressed('ui_back'):
				if GUI.get_node("SidePanel").open:
					dock._on_ActionButton_pressed()
		elif view == "terra":
			get_tree().set_input_as_handled()
			selected_building = null
			for ring in $Structure.get_node(selected_terra).get_children():
				for sector in ring.get_children():
					if sector.selected:
						outline_building(sector,null)
						sector.selected = false
						update_header(selected_terra)
						dock.set_mode("ManageTerra")
						return
			if event.is_action_pressed("stationary_select") and not mouse_over_sector:
				return
			view_arcology()

func animate_camera(translation_start,translation_end,rotation_start,rotation_end):
	$Tween.interpolate_property(
		camera,
		'translation',
		translation_start,
		translation_end,
		0.8,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	$Tween.interpolate_property(
		camera,
		'rotation_degrees',
		rotation_start,
		rotation_end,
		0.8,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	$Tween.start()

export var offset_str = 16
var cam_offset = 0
func resize():
	if view == "arcology":
		cam_offset = clamp(offset_str/display.scale_x-offset_str,0,10.5)
		camera.rotation_degrees.y = cam_offset
