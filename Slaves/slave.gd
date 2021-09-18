extends "res://Slaves/Slave Properties.gd"

onready var activity = $Activity
onready var model = $Model
onready var stats = $Stats
onready var ui = $UI

var temp_model_data

func _ready():
	if not action:
		action = $Actions/Idle
	if not assignment:
		assignment = "Resting"
	if health == 0:
		die()
	if not for_sale and health > 0:
		activate()
		yield(game.gui,"ready")
		game.gui.get_node("SidePanel/Regimen").load_settings(self)
	else:
		ui.hide()
	ui.set_level()
	_load(_data()) #reloading all properties to fix model errors
	model._ready()

func activate():
	if not time.is_connected("second",self,"tick"):
		time.connect('second',self,'tick')
	$Effects.activate_primary_effects()
	ui.get_node("Activity")._ready()

func deactivate():
	if time.is_connected("second",self,"tick"):
		time.disconnect('second',self,'tick')
	$Effects.deactivate_all()

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
	self.pregnancy = {
		"conceived":time.get_timestamp(),
		"due":due,
		"babies":babies}
	$Effects/Pregnancy.activate()

func die():
	pregnancy = null
	deactivate()
	$UI/Top/Status.set_text("Deceased")
	$UI/Top/Status.set_modulate("860000")
	$UI/Panel/Buttons/Assignment.disabled = true

func _data(file_only=false):
	var slave_data = data.obj_to_dict(self)
	var model_data
	if file_only:
		model_data = temp_model_data
	else:
		model_data = data.obj_to_dict(model)
	var action_data
	if file_only:
		action_data = {"Idle":{"current_time":0,"total_time":null}}
	else:
		action_data = {action.name:data.obj_to_dict(action)}
	slave_data.erase('flags')
	slave_data.erase('temp_model_data')
	model_data.erase('model_data')
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
		elif get(setting) is Object:
			data.dict_to_obj(slave_data[setting],get(setting))
		else:
			set(setting,slave_data[setting])
	$Model.model_data = _data['model_data']
	var action_name = _data['action_data'].keys()[0]
	action = get_node('Actions/'+action_name)
	var action_data = _data['action_data'].values()[0]
	for setting in action_data:
		action.set(setting, action_data[setting])
	if action.total_time:
		get_node('UI/Activity/ProgressBar').max_value = action.total_time
		get_node('UI/Activity/ProgressBar').value = action.current_time

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
