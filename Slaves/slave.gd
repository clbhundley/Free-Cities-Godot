extends "res://Slaves/Slave Properties.gd"

onready var model = $Model
onready var stats = $Stats
onready var ui = $UI

func _ready():
	if not action:
		action = $Actions/Idle
	if not assignment:
		assignment = "Resting"
	if health == 0:
		die()
	if not for_sale:
		activate()
		yield(game.get_gui(),"ready")
		game.get_gui().get_node("SidePanel/Regimen").load_settings(self)
	else:
		ui.hide()
	ui.set_level()
	_load(_data())
	model._ready()

func activate():
	if not time.is_connected("tick",self,"tick"):
		time.connect('tick',self,'tick')
	ui.get_node("Activity")._ready()

func deactivate():
	if time.is_connected("tick",self,"tick"):
		time.disconnect('tick',self,'tick')

func tick():
	action.tick()

func inseminate():
	if pregnancy or regimen.has("Contraception"):
		return
	if randi()%10000 > round(fertility * 1000): # 0%-10% chance
		return
	var due = time.get_forward_time(
		randi()%60,
		randi()%60,
		randi()%24,
		randi()%7,
		int(math.gaussian(39,1)))
	var babies = 1
	if randi()%1000 == 0:
		babies = 5
	elif randi()%250 == 0:
		babies = 4
	elif randi()%100 == 0:
		babies = 3
	elif randi()%50 == 0:
		babies = 2
	pregnancy = {
		"conceived":time.get_timestamp(),
		"due":due,
		"babies":babies}
	$Effects/Pregnancy.activate()

func die():
	pregnancy = null
	$Effects.deactivate_all()
	deactivate()
	$UI/Top/Status.set_text("Deceased")
	$UI/Top/Status.set_modulate("860000")
	$UI/Panel/Buttons/Assignment.disabled = true

func _action_ended():
	get_node('Assignments/'+assignment).next_action()
	get_node('UI/Activity/Time').set_text("Done")
	get_node('UI/Activity/Action').set_text("")

func _data():
	var slave_data = _get_properties(self)
	var model_data = _get_properties(model)
	var action_data = {action.name:_get_properties(action)}
	slave_data.erase("flags")
	model_data.erase("model_data")
	if queued_action:
		slave_data['queued_action'] = queued_action.name
	return {
		'slave_data':slave_data,
		'model_data':model_data,
		'action_data':action_data}

func _load(_data):
	var slave_data = _data["slave_data"]
	for setting in slave_data:
		if setting == "health": #prevents death notification when loading game
			health = slave_data[setting]
		elif setting == "queued_action" and slave_data["queued_action"]:
			queued_action = get_node('Actions/'+slave_data["queued_action"])
		else:
			set(setting, slave_data[setting])
	$Model.model_data = _data['model_data']
	var action_name = _data['action_data'].keys()[0]
	action = get_node('Actions/'+action_name)
	var action_data = _data['action_data'].values()[0]
	for setting in action_data:
		action.set(setting, action_data[setting])
	if action.total_time:
		get_node('UI/Activity/ProgressBar').max_value = action.total_time
		get_node('UI/Activity/ProgressBar').value = action.current_time

func _get_properties(object):
	var properties_full = object.get_property_list()
	var property_list = []
	for index in properties_full.size():
		property_list.append(properties_full[index].name)
	var slice = property_list.find('Script Variables') + 1
	var properties = {}
	for index in range(slice,property_list.size()):
		properties[property_list[index]] = object.get(property_list[index])
	var nodes = []
	for item in properties:
		if typeof(properties[item]) == TYPE_OBJECT:
			if properties[item].is_class("Node"):
				nodes.append(item)
			else:
				properties[item] = _get_properties(properties[item])
	for item in nodes:
		properties.erase(item)
	return properties

#var breasts = Breasts.new()
#class Breasts:
#	var flesh
#	var nipples
#	var implant
#	enum shape {normal, saggy, perky, torpedo_shaped, downward_facing, wide_set}
#	enum implant_type {normal, string, gatling_laser}
#	enum nipples_piercing {none, ring, stud, gatling, chain, pasties}
#	var areolae
#	enum areolae_shape {circle, star, heart}
#	enum areolae_piercing {}
#	var lactation
#	var tattoo
#	var skill
#	var count
#	func _init():
#		flesh = "normal"
#		nipples = floor(rand_range(-1,11))
#		areolae = math.gaussian(4,1)
#	func volume():
#		return self.flesh+self.implant

#var penis = Penis.new()
#class Penis:
#	var length
#	var girth
#	var size = math.gaussian(5.5,1)
#	var foreskin = 3
#	enum shape {normal, curved, horse, canine}
#	enum head_piercing {none, stud, ring, smart}
#	enum shaft_percing {none, studs, rings}
#	enum accessory {none, chastity, perm_chastity}
#	var tattoo
