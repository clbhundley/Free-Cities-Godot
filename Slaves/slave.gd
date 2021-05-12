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
	elif not for_sale:
		activate()
		yield(game.get_gui(),"ready")
		game.get_gui().get_node("SidePanel/Regimen").load_settings(self)
	$UI.set_level()

func activate():
	if not time.is_connected("tick",self,"tick"):
		time.connect('tick',self,'tick')

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
	var _queued_action
	if queued_action:
		_queued_action = queued_action.name
	return {
		slave_data = {
			ethnicity = ethnicity,
			skin_color = skin_color,
			tissue_color = tissue_color,
			hair_color_natural = hair_color_natural,
			hair_color = hair_color,
			hair_style = hair_style,
			gender = gender,
			age = age,
			height = height,
			weight = weight,
			genitals = genitals,
			penis_size = penis_size,
			testicles_size = testicles_size,
			vagina = vagina,
			chest = chest,
			fertility = fertility,
			pregnancy = pregnancy,
			pregnancy_history = pregnancy_history,
			face = face,
			figure = figure,
			voice = voice,
			health = health,
			fatigue = fatigue,
			happiness = happiness,
			hunger = hunger,
			bathroom = bathroom,
			arousal = arousal,
			libido = libido,
			male_attraction = male_attraction,
			female_attraction = female_attraction,
			intelligence = intelligence,
			devotion = devotion,
			trust = trust,
			sexual_skill = sexual_skill,
			oral_skill = oral_skill,
			anal_skill = anal_skill,
			vaginal_skill = vaginal_skill,
			penis_skill = penis_skill,
			prostitution_skill = prostitution_skill,
			entertainment_skill = entertainment_skill,
			combat_skill = combat_skill,
			is_awake = is_awake,
			for_sale = for_sale,
			acquired = acquired,
			diet = diet,
			diet_base = diet_base,
			regimen = regimen,
			rules = rules,
			wardrobe = wardrobe,
			assignment = assignment,
			action = action.name,
			current_time = action.current_time,
			total_time = action.total_time,
			queued_action = _queued_action,
			quarters = quarters,
			location = location,
			destination = destination,
			travel_mode = travel_mode},
		model_data = {
			masculinity = $Model.masculinity,
			genitals_male_adjustment = $Model.genitals_male_adjustment,
			weight = $Model.weight,
			weight_round = $Model.weight_round,
			weight_pear = $Model.weight_pear,
			weight_fat = $Model.weight_fat,
			waist_size = $Model.waist_size,
			butt_size = $Model.butt_size,
			body_size = $Model.body_size,
			bodybuilder = $Model.bodybuilder,
			voluptuous = $Model.voluptuous,
			pregnant = $Model.pregnant,
			breasts_growth = $Model.breasts_growth,
			breasts_implants = $Model.breasts_implants,
			breasts_small = $Model.breasts_small,
			breasts_gone = $Model.breasts_gone,
			testicles_size = $Model.testicles_size,
			penis_length = $Model.penis_length,
			penis_thickness = $Model.penis_thickness,
			penis_micro = $Model.penis_micro}}

func _load(_data):
	var slave_data = _data["slave_data"]
	for setting in slave_data:
		if setting == "health":
			health = slave_data[setting]
		elif setting == "action":
			action = get_node('Actions/'+slave_data["action"])
		elif setting == "queued_action" and slave_data["queued_action"]:
			queued_action = get_node('Actions/'+slave_data["queued_action"])
		else:
			set(setting, slave_data[setting])
	$Model.model_data = _data["model_data"]
	action.current_time = _data["slave_data"]['current_time']
	action.total_time = _data["slave_data"]['total_time']
	if action.total_time:
		get_node('UI/Activity/ProgressBar').max_value = action.total_time
		get_node('UI/Activity/ProgressBar').value = action.current_time

#func _get_properties(input):
#	var properties = input.get_property_list()
#	var array = []
#	for i in properties.size():
#		array.append(properties[i].name)
#	var slice = array.find('Script Variables')+1
#	var dict = {}
#	for i in range(slice,array.size()):
#		dict[array[i]] = input.get(array[i])
#	return dict

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
