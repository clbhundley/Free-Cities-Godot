extends Control

var ethnicity
var skin_color
var tissue_color
var gender
var genitals
var penis_size
var testicles_size = 0
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
var time
var for_sale = false

func _ready():
	get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'tick')
#	get_node('Panel/Selling Buttons/Buy').connect('pressed',get_tree().get_root().get_node('Game/Slaves'),'buy',[self,get_parent()])
	if not action:
		action = "Idle"
	if not assignment:
		assignment = "Rest"
	get_node('Top/Text/Name').set_text(name)
	get_node('Top/Text/Status').set_text("Resting") # TEMP
	get_node('Activity/Action').set_text(action)
	get_node('Model').display(self)
	set_stats()
	if for_sale:
		get_node('Panel/Buttons').hide()
		get_node('Panel/Selling Buttons').show()

func tick():
	if not for_sale:
		get_node('Assignments/'+assignment).tick()
		get_node('Actions/'+action).tick()
		for status in get_node('Effects').get_children():
			if status.active:
				status.tick()
		get_node('Model').display(self)
		set_stats()
		quick_save()

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# rarely, one or more of these stats fails to generate and crashes the game on startup
# requires further debugging
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
onready var stats = get_node('Stats')
func set_stats():
	get_node('Top/Level').set_text(str(stats._level())+" |")
	get_node('Value').parse_bbcode(
	str(age)+", "+ethnicity+", "+gender+"\n"+
	stats._intelligence()+"\n"+
	stats._devotion()+", "+stats._trust()+"\n"+
	"\n"+
	stats._face()+"\n"+
	stats._figure()+"\n"+
	voice+"\n"+
	"\n"+
	stats._libido()+"\n"+
	stats._male_attraction()+"\n"+
	stats._female_attraction()+"\n"+
	"#Fetishes"+"\n"+
	"\n"+
	stats._sexual_skill()+"\n"+
	stats._prostitution_skill()+"\n"+
	stats._entertainment_skill()+"\n"+
	stats._combat_skill()+"\n"+
	"\n"+
	"#Behavioral trait"+"\n"+
	"#Sexual trait"+"\n"+
	"#Relationships")

func _action_ended():
	get_node('Assignments/'+assignment).next_action()
	get_node('Activity/Time').set_text("Done")
	get_node('Activity/Action').set_text("")

func quick_save():
	var path
	var file = File.new()
	var location = get_node('../../../').name
	if location == "Slaves":
		path = 'user://Data/Slot %s/Slaves/Owned/'%game.data_slot
	elif location == "Kidnappers Market":
		path = "user://Data/Slot %s/Slaves/Available/Kidnappers' Market/"%game.data_slot
	elif location == "Neighboring Arcologies":
		path = 'user://Data/Slot %s/Slaves/Available/Neighboring Arcologies/'%game.data_slot
	file.open(path+name+'.json',File.WRITE)
	file.store_line(to_json(_save()))
	file.close()

func _save():
	return {
		core = {
			name = name,
			ethnicity = ethnicity,
			skin_color = skin_color,
			tissue_color = tissue_color,
			gender = gender,
			age = age,
			height = height,
			weight = weight,
			genitals = genitals,
			penis_size = penis_size,
			testicles_size = testicles_size,
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
			time = get_node('Actions/'+action).time,
			total_time = get_node('Actions/'+action).total_time},
		nested = {}}
#			breasts = _get_properties(breasts),
#			penis = _get_properties(penis)}}

func _load(data):
	for setting in data['core']:
		set(setting, data['core'][setting])
	for _class in data['nested']:
		for setting in data['nested'][_class]:
			get(_class).set(setting, data['nested'][_class][setting])
	get_node('Actions/'+action).time = data['core']['time']
	get_node('Actions/'+action).total_time = data['core']['total_time']
	if get_node('Actions/'+action).total_time:
		get_node('Activity/ProgressBar').max_value = get_node('Actions/'+action).total_time
		get_node('Activity/ProgressBar').value = get_node('Actions/'+action).time

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


var breasts = Breasts.new()
class Breasts:
	var flesh
	var nipples
	var implant
	enum shape {normal, saggy, perky, torpedo_shaped, downward_facing, wide_set}
	enum implant_type {normal, string, gatling_laser}
	enum nipples_piercing {none, ring, stud, gatling, chain, pasties}
	var areolae
	enum areolae_shape {circle, star, heart}
	enum areolae_piercing {}
	var lactation
	var tattoo
	var skill
	var count
	func _init():
		flesh = "normal"
		nipples = floor(rand_range(-1,11))
		areolae = game.gaussian(4,1)
	func volume():
		return self.flesh+self.implant

var penis = Penis.new()
class Penis:
	var length
	var girth
	var size = game.gaussian(5.5,1)
	var foreskin = 3
	enum shape {normal, curved, horse, canine}
	enum head_piercing {none, stud, ring, smart}
	enum shaft_percing {none, studs, rings}
	enum accessory {none, chastity, perm_chastity}
	var tattoo

func _on_Top_mouse_entered():
	get_node('Panel').show()

func _on_Top_mouse_exited():
	get_node('Panel').hide()

func _on_Assignment_item_selected(ID):
	var assignments = {0:"Rest",1:"Prostitute"}
	assignment = assignments[ID]

onready var root = get_tree().get_root()
func _on_Buy_pressed():
	for_sale = false
	get_node('Panel').hide()
	get_node('Panel/Buttons').show()
	get_node('Panel/Selling Buttons').hide()
	get_parent().remove_child(self)
	root.get_node('Game/Slaves/Slider/HBoxContainer').add_child(self,true)
	