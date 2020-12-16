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
onready var camera = get_node('Cambase/Camera')
onready var highlight_blue = load('res://Arcology/blue.material')
onready var highlight_orange = load('res://Arcology/orange.material')
onready var highlight_cyan = load('res://Arcology/cyan.material')
onready var highlight_lime = load('res://Arcology/lime.material')
onready var highlight_violet = load('res://Arcology/violet.material')

func _ready():
	get_tree().get_root().connect('size_changed',self,'resize')
	var position = 0
	#new arc is being generated anyway
	if not structure:
		for terra in get_node('New Arcology').generate(size):
			terra.translation[1] = position
			$Structure.add_child(terra)
			position -= 1.5
	update_header(_name)
	resize()

func update_header(text):
	var header = GUI.get_node("Header/Arcology/Title")
	header.set_text(text)

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
		if not terra in ["Penthouse","Terra 0","Terra 1","Terra 2"]:
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

export var offset_str = 16
var cam_offset = 0
func resize():
	if view == "arcology":
		cam_offset = clamp(offset_str/display.scale_x-offset_str,0,10.5)
		camera.rotation_degrees.y = cam_offset

func _highlight_terra(terra,material):
	for ring in terra.get_children():
		for sector in ring.get_children():
			sector.get_node('Mesh').set_material_override(material)

func _highlight_building(sector,material):
	sector = ArcUtils.get_building(sector)
	#clear_highlight_terra(sector)
	var building_size = 1
	var sectors = []
	if sector.get("size"):
		building_size = sector.size
	for section in building_size:
		sectors.append(sector.get_parent().get_child((sector.get_index()+section+12)%12))
	for section in sectors:
		section.get_node('Mesh').set_material_override(material)

func clear_highlight_terra(sector):
	for ring in sector.get_node('../../').get_children():
		for sector in ring.get_children():
			sector.get_node('Mesh').set_material_override(null)
			sector.selected = false

func clear_highlight_arcology():
	for terra in $Structure.get_children():
		_highlight_terra(terra,null)

func connect_sector_signals(sector):
	sector.connect('input_event',self,'arc_input_event',[sector])
	sector.connect('mouse_entered',self,'sector_mouse_entered',[sector])
	sector.connect('mouse_exited',self,'sector_mouse_exited',[sector])
	var methods = ["tick","minute","hour","day","week","quarter","year"]
	for method in methods:
		if sector.has_method(method):
			time.connect(method,sector,method)

func arc_input_event(camera,event,click_position,click_normal,shape_idx,sector):
	if not event.is_pressed():
		return
	if not event.is_class("InputEventScreenTouch"):
		if event.button_index:
			if event.button_index != 1:
				return
	if view == "arcology":
		for terra in $Structure.get_children():
			_highlight_terra(terra,null)
		var terra = sector.get_node('../../')
		_highlight_terra(terra,highlight_orange)
		selected_terra = terra.name
		update_header(_name + "  -  " + selected_terra)
		if GUI.get_node("Dock").mode != "ManageTerra":
			GUI.get_node("Dock").set_mode("ManageTerra")
		$ChangeView.show()
		if event.doubleclick:
			_on_ChangeView_pressed()
	elif view == "terra":
		var primary = ArcUtils.get_neighbors(sector)["primary"]
		var secondary = ArcUtils.get_neighbors(sector)["secondary"]
		var tertiary = ArcUtils.get_neighbors(sector)["tertiary"]
		for ring in sector.get_node('../../').get_children():
			for sector in ring.get_children():
				sector.get_node('Mesh').set_material_override(null)
				sector.selected = false
		for building in primary:
			_highlight_building(building,highlight_cyan)
		for building in secondary:
			_highlight_building(building,highlight_lime)
		for building in tertiary:
			_highlight_building(building,highlight_violet)
		_highlight_building(sector,highlight_orange)
		update_header(selected_terra + "  -  " + ArcUtils.sector_name(sector.name))
		GUI.get_node("Dock").set_mode("ManageBuilding")
		selected_building = ArcUtils.get_building(sector)
		sector.selected = true

var mouse_over_sector = false
func sector_mouse_entered(sector):
	mouse_over_sector = true
	if view == "Arcology":
		var terra = sector.get_node('../../')
		if terra.name != selected_terra:
			_highlight_terra(terra,highlight_blue)
	elif view == "terra":
		if not sector.selected:
			_highlight_building(sector,highlight_blue)

func sector_mouse_exited(sector):
	mouse_over_sector = false
	if view == "arcology":
		var terra = sector.get_node('../../')
		if terra.name != selected_terra:
			_highlight_terra(terra,null)
	elif view == "terra":
		if not sector.selected:
			sector.get_node('Mesh').set_material_override(null)

func _on_ChangeView_pressed():
	if view == "arcology":
		view_terra()
	elif view == "terra":
		view_arcology()

func view_terra():
	var t_start = camera.translation
	var t_modify = $Structure.get_node(selected_terra).translation[1]
	var t_end = Vector3(0, t_modify+2, 9)
	var r_start = camera.rotation_degrees
	var r_end = Vector3(-40, 0, 0)
	for terra in $Structure.get_children():
		_highlight_terra(terra,null)
		if terra.name != selected_terra:
			terra.hide()
	view = "terra"
	$ChangeView.set_text("View Arcology")
	$ChangeView.margin_left = 0 #refresh size
	update_header(selected_terra)
	animate_camera(t_start,t_end,r_start,r_end)

func view_arcology():
	var t_start = camera.translation
	var t_modify = $Structure.get_node(selected_terra).translation[1]
	var t_end = Vector3(0, -8.5, 16)
	var r_start = camera.rotation_degrees
	var r_end = Vector3(-4, cam_offset, 0)
	for terra in $Structure.get_children():
		terra.show()
		if terra.name == selected_terra:
			_highlight_terra(terra,highlight_orange)
	view = "arcology"
	$ChangeView.show()
	$ChangeView.set_text("View Terra")
	$ChangeView.margin_left = 0 #refresh size
	update_header(_name + "  -  " + selected_terra)
	animate_camera(t_start,t_end,r_start,r_end)
	GUI.get_node("Dock").set_mode("ManageArcology")

func animate_camera(t_start,t_end,r_start,r_end):
	$Tween.interpolate_property(
		camera,
		'translation',
		t_start,
		t_end,
		0.8,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	$Tween.interpolate_property(
		camera,
		'rotation_degrees',
		r_start,
		r_end,
		0.8,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	$Tween.start()

func click_in_place():
	pass
	#if selected:
		#press back

var camrot = 0.0
func _input(event):
	if not self.visible:
		return
	var calendar = GUI.get_node("Navigation/Time/Calendar")
	if calendar.is_visible():
		return
	
	if event.is_class("InputEventMouseMotion"):
		if event.button_mask&(BUTTON_MASK_LEFT):
			camrot += event.relative.x * 0.005
			get_node("Cambase").set_rotation(Vector3(0, -1*camrot, 0))
	elif event.is_action_pressed('ui_back') or event.is_action_pressed("stationary_select") and not mouse_over_sector:
		if view == "arcology":
			if selected_terra:
				get_tree().set_input_as_handled()
				selected_terra = null
				update_header(_name)
				if GUI.get_node("Dock").mode != "ManageArcology":
					GUI.get_node("Dock").set_mode("ManageArcology")
				$ChangeView.hide()
				for terra in $Structure.get_children():
					_highlight_terra(terra,null)
		elif view == "terra":
			get_tree().set_input_as_handled()
			selected_building = null
			for ring in $Structure.get_node(selected_terra).get_children():
				for sector in ring.get_children():
					if sector.selected:
						sector.get_node('Mesh').set_material_override(null)
						sector.selected = false
						update_header(selected_terra)
						GUI.get_node("Dock").set_mode("ManageTerra")
						return
			if event.is_action_pressed("stationary_select") and not mouse_over_sector:
				return
			view_arcology()
