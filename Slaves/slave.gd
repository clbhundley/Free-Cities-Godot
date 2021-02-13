extends Spatial

var ethnicity
var skin_color
var tissue_color
var hair_color_natural
var hair_color
var hair_style
var gender
var genitals
var penis_size
var testicles_size
var vagina
var chest
var age
var height
var weight
var health
var fatigue
var is_awake
var hunger
var bathroom
var arousal
var libido
var male_attraction
var female_attraction
var intelligence
var devotion
var trust
var happiness
var social
var face
var figure
var hips
var voice
var sexual_skill
var oral_skill
var anal_skill
var vaginal_skill
var penis_skill
var prostitution_skill
var entertainment_skill
var combat_skill
var assignment
var action
var queued_action
var current_time
var for_sale = false

var flags = {}

var quarters = "P5"
var location
var destination
var travel_mode

onready var stats = get_node("Scripts/Stats")
onready var ui = get_node("UI")

func _ready():
	get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'tick')
	if not action:
		action = "Idle"
	if not assignment:
		assignment = "Resting"

func tick():
	if not for_sale:
		get_node('Scripts/Actions/'+action).tick()
		for effect in get_node('Scripts/Effects').get_children():
			if effect.active:
				effect.tick()

func _action_ended():
	get_node('Scripts/Assignments/'+assignment).next_action()
	get_node('UI/Activity/Time').set_text("Done")
	get_node('UI/Activity/Action').set_text("")

func _data():
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
			assignment = assignment,
			action = action,
			current_time = get_node('Scripts/Actions/'+action).current_time,
			total_time = get_node('Scripts/Actions/'+action).total_time,
			quarters = quarters,
			location = location,
			destination = destination,
			travel_mode = travel_mode,
			queued_action = queued_action},
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
	for setting in _data["slave_data"]:
		set(setting, _data["slave_data"][setting])
	$Model.model_data = _data["model_data"]
#	for setting in _data["model_data"]:
#		$Model.set(setting, _data["model_data"][setting])
	get_node('Scripts/Actions/'+action).current_time = _data["slave_data"]['current_time']
	get_node('Scripts/Actions/'+action).total_time = _data["slave_data"]['total_time']
	if get_node('Scripts/Actions/'+action).total_time:
		get_node('UI/Activity/ProgressBar').max_value = get_node('Scripts/Actions/'+action).total_time
		get_node('UI/Activity/ProgressBar').value = get_node('Scripts/Actions/'+action).current_time

func _get_properties(input):
	var properties = input.get_property_list()
	var array = []
	for i in properties.size():
		array.append(properties[i].name)
	var slice = array.find('Script Variables')+1
	var dict = {}
	for i in range(slice,array.size()):
		dict[array[i]] = input.get(array[i])
	return dict

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
