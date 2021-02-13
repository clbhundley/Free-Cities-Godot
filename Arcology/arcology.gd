extends Node

var location = "Asia"
var _name = "Arcology X-4"
var size = 7
var structure #not being used properly
var selected_terra
var selected_building
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
	sector.connect('input_event',$Input,'arc_input_event',[sector])
	sector.connect('mouse_entered',$Input,'sector_mouse_entered',[sector])
	sector.connect('mouse_exited',$Input,'sector_mouse_exited',[sector])
	var methods = ["tick","minute","hour","day","week","quarter","year"]
	for method in methods:
		if sector.has_method(method):
			time.connect(method,sector,method)

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
