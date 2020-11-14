extends Node

var location = "Asia"
var _name = "Arcology X-4"
var size = 7
var structure #not being used properly
var selected_terra
const ARCOLOGY_VIEW = 0
const TERRA_VIEW = 1
var view = "arcology"
onready var title = get_node('Display/Title')
onready var subtitle = get_node('Display/Subtitle')
onready var camera = get_node('Cambase/Camera')
onready var highlight_blue = load('res://Arcology/blue.material')
onready var highlight_orange = load('res://Arcology/orange.material')

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
	var header = get_tree().get_root().get_node("Game/GUI/Header/Arcology/Title")
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

export var offset_strength = 16
var cam_offset = 0
func resize():
	if view == "arcology":
		cam_offset = clamp(offset_strength/display.scale_x-offset_strength,0,10.5)
		camera.rotation_degrees.y = cam_offset

func _highlight_terra(terra,material):
	for ring in terra.get_children():
		for sector in ring.get_children():
			sector.get_node('Mesh').set_material_override(material)

func connect_sector_signals(sector):
	sector.connect('input_event',self,'sector_input_event',[sector])
	sector.connect('mouse_entered',self,'sector_mouse_entered',[sector])
	sector.connect('mouse_exited',self,'sector_mouse_exited',[sector])
	var methods = ["tick","minute","hour","day","week","quarter","year"]
	for method in methods:
		if sector.has_method(method):
			time.connect(method,sector,method)

func sector_input_event(camera, event, click_position, click_normal, shape_idx, sector):  #two separate input handlers?
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
		#subtitle.set_text(terra.name)
		update_header(terra.name)
		$Button.show()
	elif view == "terra":
		for ring in sector.get_node('../../').get_children():
			for sector in ring.get_children():
				sector.get_node('Mesh').set_material_override(null)
				sector.selected = false
		sector.get_node('Mesh').set_material_override(highlight_orange)
		#subtitle.set_text(ArcUtils.sector_name(sector.name))
		update_header(ArcUtils.sector_name(sector.name))
		sector.selected = true

func sector_mouse_entered(node):
	if view == "Arcology":
		var terra = node.get_node('../../')
		if terra.name != selected_terra:
			_highlight_terra(terra,highlight_blue)
	elif view == "terra":
		if not node.selected:
			node.get_node('Mesh').set_material_override(highlight_blue)

func sector_mouse_exited(node):
	if view == "arcology":
		var terra = node.get_node('../../')
		if terra.name != selected_terra:
			_highlight_terra(terra,null)
	elif view == "terra":
		if not node.selected:
			node.get_node('Mesh').set_material_override(null)

func _on_Button_pressed():
	var t_start = camera.translation
	var t_modify = $Structure.get_node(selected_terra).translation[1]
	var t_end = Vector3(0, t_modify+2, 9)
	var r_start = camera.rotation_degrees
	var r_end = Vector3(-40, 0, 0)
	update_header(selected_terra)
	$Button.hide()
	view = "terra"
	for terra in $Structure.get_children():
		_highlight_terra(terra,null)
		if terra.name != selected_terra:
			terra.hide()
	$Tween.interpolate_property(camera,'translation',t_start,t_end,1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.interpolate_property(camera,'rotation_degrees',r_start,r_end,1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()

var camrot = 0.0
func _input(event):
	if not self.visible:
		return
	if get_tree().get_root().get_node('Game/GUI/AI Panel').is_visible_in_tree():
		return
	var calendar = get_tree().get_root().get_node("Game/GUI//Navigation/Time/Calendar")
	if calendar.is_visible():
		return
	if (event.is_class("InputEventMouseMotion")):
		if (event.button_mask&(BUTTON_MASK_LEFT)):
			camrot += event.relative.x * 0.005
			get_node("Cambase").set_rotation(Vector3(0, -1*camrot, 0))
	elif event.is_action_pressed('ui_back'):
		if view == "arcology":
			if selected_terra:
				selected_terra = null
				update_header("")
				$Button.hide()
				for terra in $Structure.get_children():
					_highlight_terra(terra,null)
		elif view == "terra":
			for ring in $Structure.get_node(selected_terra).get_children():
				for sector in ring.get_children():
					if sector.selected:
						sector.get_node('Mesh').set_material_override(null)
						sector.selected = false
						update_header(selected_terra)
						return
			var t_start = camera.translation
			var t_modify = $Structure.get_node(selected_terra).translation[1]
			var t_end = Vector3(0, -8.5, 16)
			var r_start = camera.rotation_degrees
			var r_end = Vector3(-4, cam_offset, 0)
			update_header(selected_terra)
			$Button.show()
			view = "arcology"
			for terra in $Structure.get_children():                             #show arcology
				terra.show()
				if terra.name == selected_terra:
					_highlight_terra(terra,highlight_orange)
			$Tween.interpolate_property(camera,'translation',t_start,t_end,1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			$Tween.interpolate_property(camera,'rotation_degrees',r_start,r_end,1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			$Tween.start()

#func sector_ownership(): #needs reworked before being used
#	for terra in $Structure.get_children():
#		for sector in terra.get_children().size():
#			if terra.get_child(sector).get('owned') != null:
#				if terra.get_child(sector).owned:
#					terra.get_child(sector).set_modulate('d42a2a')
#				else:
#					terra.get_child(sector).set_modulate('36953d')
#			elif _name(terra.get_child(sector).name).ends_with("_b"):
#				if terra.get_children()[sector-1].get('owned') != null:
#					if terra.get_children()[sector-1].owned:
#						terra.get_child(sector).set_modulate('d42a2a')
#					else:
#						terra.get_child(sector).set_modulate('36953d')
#			elif _name(terra.get_child(sector).name).ends_with("_c"):
#				if terra.get_children()[sector-2].get('owned') != null:
#					if terra.get_children()[sector-2].owned:
#						terra.get_child(sector).set_modulate('d42a2a')
#					else:
#						terra.get_child(sector).set_modulate('36953d')
#			elif terra.get_child(sector).name == "Inner" or terra.get_child(sector).name == "Outer":
#				for _sec in terra.get_child(sector).get_children().size():
#					if terra.get_child(sector).get_child(_sec).get('owned') != null:
#						if terra.get_child(sector).get_child(_sec).owned:
#							terra.get_child(sector).get_child(_sec).set_modulate('d42a2a')
#						else:
#							terra.get_child(sector).get_child(_sec).set_modulate('36953d')
#					elif _name(terra.get_child(sector).get_child(_sec).name).ends_with("_b"):
#						if terra.get_child(sector).get_children()[_sec-1].get('owned') != null:
#							if terra.get_child(sector).get_children()[_sec-1].owned:
#								terra.get_child(sector).get_child(_sec).set_modulate('d42a2a')
#							else:
#								terra.get_child(sector).get_child(_sec).set_modulate('36953d')
#					elif _name(terra.get_child(sector).get_child(_sec).name).ends_with("_c"):
#						if terra.get_child(sector).get_children()[_sec-2].get('owned') != null:
#							if terra.get_child(sector).get_children()[_sec-2].owned:
#								terra.get_child(sector).get_child(_sec).set_modulate('d42a2a')
#							else:
#								terra.get_child(sector).get_child(_sec).set_modulate('36953d')
