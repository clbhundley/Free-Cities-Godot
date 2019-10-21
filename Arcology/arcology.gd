extends Node

var location = "Asia"
var _name = "Arcology X-4"
var size = 7
var structure_data
var view = "Arcology"
onready var structure = get_node('Structure')
onready var title = get_node('Display/Title')
onready var subtitle = get_node('Display/Subtitle')
onready var button = get_node('Display/Button')
onready var camera = get_node('Cambase/Camera')
onready var tween = get_node('Tween')
onready var highlight_blue = load('res://Arcology/blue.material')
onready var highlight_orange = load('res://Arcology/orange.material')

func _ready():
	get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'quick_save')
	var position = 0
	if not structure_data:
		for terra in get_node('New Arcology').generate(size):
			terra.translation[1] = position
			structure.add_child(terra)
			position -= 1.5
	title.set_text(_name)

func sector_ownership():
	for terra in structure.get_children():
		for sector in terra.get_children().size():
			if terra.get_child(sector).get('owned') != null:
				if terra.get_child(sector).owned:
					terra.get_child(sector).set_modulate('d42a2a')
				else:
					terra.get_child(sector).set_modulate('36953d')
			elif _name(terra.get_child(sector).name).ends_with("_b"):
				if terra.get_children()[sector-1].get('owned') != null:
					if terra.get_children()[sector-1].owned:
						terra.get_child(sector).set_modulate('d42a2a')
					else:
						terra.get_child(sector).set_modulate('36953d')
			elif _name(terra.get_child(sector).name).ends_with("_c"):
				if terra.get_children()[sector-2].get('owned') != null:
					if terra.get_children()[sector-2].owned:
						terra.get_child(sector).set_modulate('d42a2a')
					else:
						terra.get_child(sector).set_modulate('36953d')
			elif terra.get_child(sector).name == "Inner" or terra.get_child(sector).name == "Outer":
				for _sec in terra.get_child(sector).get_children().size():
					if terra.get_child(sector).get_child(_sec).get('owned') != null:
						if terra.get_child(sector).get_child(_sec).owned:
							terra.get_child(sector).get_child(_sec).set_modulate('d42a2a')
						else:
							terra.get_child(sector).get_child(_sec).set_modulate('36953d')
					elif _name(terra.get_child(sector).get_child(_sec).name).ends_with("_b"):
						if terra.get_child(sector).get_children()[_sec-1].get('owned') != null:
							if terra.get_child(sector).get_children()[_sec-1].owned:
								terra.get_child(sector).get_child(_sec).set_modulate('d42a2a')
							else:
								terra.get_child(sector).get_child(_sec).set_modulate('36953d')
					elif _name(terra.get_child(sector).get_child(_sec).name).ends_with("_c"):
						if terra.get_child(sector).get_children()[_sec-2].get('owned') != null:
							if terra.get_child(sector).get_children()[_sec-2].owned:
								terra.get_child(sector).get_child(_sec).set_modulate('d42a2a')
							else:
								terra.get_child(sector).get_child(_sec).set_modulate('36953d')

func _name(input):
	if "@" in input:
		var s = input.split("@")
		return s[1]
	else:
		return input

func swap(old,new):
	new.get_node('Collision').translation[2] = round(old.get_node('Collision').translation[2])
	new.get_node('Mesh').translation[2] = round(old.get_node('Mesh').translation[2])
	new.rotation_degrees[1] = round(old.rotation_degrees[1])
	for children in old.get_children():
		children.queue_free()
	old.replace_by(new)

var selected_terra
func input_event(node,event):
	if event.is_pressed() and event.button_index == 1:
		if view == "Arcology":
			for terra in structure.get_children():
				for sector in terra.get_children():
					if sector.name == "Inner" or sector.name == "Outer":
						for _sector in sector.get_children():
							_sector.get_node('Mesh').set_material_override(null)
					else:
						sector.get_node('Mesh').set_material_override(null)
			if node.get_parent().name == "Inner" or node.get_parent().name == "Outer":
				for section in node.get_node('../../').get_children():
					for sector in section.get_children():
						sector.get_node('Mesh').set_material_override(highlight_orange)
				selected_terra = node.get_node('../../').name
				button.show()
				subtitle.set_text(node.get_node('../../').name)
			else:
				for sector in node.get_parent().get_children():
					sector.get_node('Mesh').set_material_override(highlight_orange)
				selected_terra = node.get_parent().name
				button.show()
				subtitle.set_text(node.get_parent().name)
		elif view == "Terra":
			if node.get_parent().name == "Inner" or node.get_parent().name == "Outer":
				for section in node.get_node('../../').get_children():
					for sector in section.get_children():
						sector.get_node('Mesh').set_material_override(null)
						sector.selected = false
			else:
				for sector in node.get_parent().get_children():
					sector.get_node('Mesh').set_material_override(null)
					sector.selected = false
			node.get_node('Mesh').set_material_override(highlight_orange)
			subtitle.set_text(_name(node.name))
			node.selected = true

func mouse_entered(node):
	if view == "Arcology":
		if node.get_parent().name == "Inner" or node.get_parent().name == "Outer":
			if selected_terra != node.get_node('../../').name:
				for section in node.get_node('../../').get_children():
					for sector in section.get_children():
						sector.get_node('Mesh').set_material_override(highlight_blue)
		else:
			if selected_terra != node.get_parent().name:
				for sector in node.get_parent().get_children():
					sector.get_node('Mesh').set_material_override(highlight_blue)
	elif view == "Terra":
		if not node.selected:
			node.get_node('Mesh').set_material_override(highlight_blue)

func mouse_exited(node):
	if view == "Arcology":
		if node.get_parent().name == "Inner" or node.get_parent().name == "Outer":
			if selected_terra != node.get_node('../../').name:
				for section in node.get_node('../../').get_children():
					for sector in section.get_children():
						sector.get_node('Mesh').set_material_override(null)
		else:
			if selected_terra != node.get_parent().name:
				for sector in node.get_parent().get_children():
					sector.get_node('Mesh').set_material_override(null)
	elif view == "Terra":
		if not node.selected:
			node.get_node('Mesh').set_material_override(null)

func _on_Button_pressed():
	var t_start = camera.translation
	var t_modify = structure.get_node(selected_terra).translation[1]
	var t_end = Vector3(2, t_modify+2, 9)
	var r_start = camera.rotation_degrees
	var r_end = Vector3(-40, 0, 0)
	title.set_text(selected_terra)
	subtitle.set_text("")
	button.hide()
	view = "Terra"
	for terra in structure.get_children():
		if terra.get_children().size() == 2:
			for section in terra.get_children():
				for sector in section.get_children():
					sector.get_node('Mesh').set_material_override(null)
		else:
			for sector in terra.get_children():
				sector.get_node('Mesh').set_material_override(null)
		if terra.name != selected_terra:
			terra.hide()
	tween.interpolate_property(camera,'translation',t_start,t_end,1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.interpolate_property(camera,'rotation_degrees',r_start,r_end,1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()

var camrot = 0.0
func _input(event):
	if self.visible and not get_tree().get_root().get_node('Game/GUI/AI Panel').is_visible_in_tree():
		if (event.is_class("InputEventMouseMotion")):
			if (event.button_mask&(BUTTON_MASK_LEFT)):
				#print(event.relative.x)
				camrot += event.relative.x*0.005
				get_node("Cambase").set_rotation(Vector3(0, -1*camrot, 0))
		elif event.is_action_pressed('ui_back'):
			if view == "Arcology":
				if selected_terra:
					selected_terra = null
					subtitle.set_text("")
					button.hide()
					for terra in structure.get_children():
						for sector in terra.get_children():
							if sector.name == "Inner" or sector.name == "Outer":
								for _sector in sector.get_children():
									_sector.get_node('Mesh').set_material_override(null)
							else:
								sector.get_node('Mesh').set_material_override(null)
			elif view == "Terra":
				if structure.get_node(selected_terra).get_child_count() == 2:
					for section in structure.get_node(selected_terra).get_children():
						for sector in section.get_children():
							if sector.selected:
								sector.get_node('Mesh').set_material_override(null)
								sector.selected = false
								subtitle.set_text("")
								return
				else:
					for sector in structure.get_node(selected_terra).get_children():
						if sector.selected:
							sector.get_node('Mesh').set_material_override(null)
							sector.selected = false
							subtitle.set_text("")
							return
				var t_start = camera.translation
				var t_modify = structure.get_node(selected_terra).translation[1]
				var t_end = Vector3(0, -8.5, 16)
				var r_start = camera.rotation_degrees
				var r_end = Vector3(-4, -20, 0)
				title.set_text(_name)
				subtitle.set_text(selected_terra)
				button.show()
				view = "Arcology"
				for terra in structure.get_children():
					terra.show()
					if terra.name == selected_terra:
						if terra.get_children().size() == 2:
							for section in terra.get_children():
								for sector in section.get_children():
									sector.get_node('Mesh').set_material_override(highlight_orange)
						else:
							for sector in terra.get_children():
								sector.get_node('Mesh').set_material_override(highlight_orange)
				tween.interpolate_property(camera,'translation',t_start,t_end,1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
				tween.interpolate_property(camera,'rotation_degrees',r_start,r_end,1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
				tween.start()

func quick_save():
	var file = File.new()
	var path = 'user://Data/Slot %s/Arcology.json'%game.data_slot
	file.open(path,File.WRITE)
	file.store_line(to_json(_save()))
	file.close()

func _save():
	return {
		name = _name,
		location = location,
		structure_data = structure_data}
