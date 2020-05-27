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
var current_time # needed?
var for_sale = false

onready var stats = get_node('Stats') # needed?

func _ready():
	get_tree().get_root().connect('size_changed',self,'resize')
	get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'tick')
#	connect('pressed',get_tree().get_root().get_node('Game/Slaves'),'buy',[self,get_parent()])
	if not action:
		action = "Idle"
	if not assignment:
		assignment = "Rest"
	get_node('Top/Name').set_text(name)
	get_node('Top/Status').set_text("Resting") # TEMP
	get_node('Activity/Action').set_text(action)
	get_node('Model')._display(self)
	set_level()
	for text in get_node("Stats Display").get_children():
		text.set_stats()
	if for_sale:
		get_node('Panel/Buttons').hide()
		get_node('Panel/Selling Buttons').show()
	resize()

func resize():
	#resize on scene switch, resize on market switch
	
	#if not is_visible_in_tree():
		#return
	
	#formalize
	var scale = display.scale
	var scale_adjusted = display.scale*20
	
	game.default_font.size = max(scale_adjusted,12)
	
	#adjust line separation in hbox container with scaling?
	#get_parent().set('custom_constants/separation',scale_adjusted*10)
	#print(get_parent().get('custom_constants/separation'))
	
	var baseline = Vector2(450,700)
	rect_min_size = Vector2(max(baseline.x*scale,270),max(baseline.y*scale,420))
	#print("SLAVE CARD SIZE: ",rect_size)
	
	#individual scaling on each image instead of scaling entire container?
	$Model.rect_scale = Vector2(max(scale,0.6),max(scale,0.6))
	
	#line and level using same custom font, only one resize needed
	get_node("Top/Level").get('custom_fonts/font').size = max(scale_adjusted*2,24)
	get_node("Top/Line").get('custom_fonts/font').size = max(scale_adjusted*2,24)
	
	get_node("Top/Name").get('custom_fonts/font').size = max(scale_adjusted*1.5,18)
	
	get_node("Top/Status").get('custom_fonts/font').size = max(scale_adjusted,12)
	
	get_node("Stats Display/Basic").get('custom_fonts/normal_font').size = clamp(scale_adjusted,12,20)
	
	get_node("Gauges/Upper/Health/Value").get('custom_fonts/font').size = scale_adjusted*1.2

func tick():
	if not for_sale:
		get_node('Assignments/'+assignment).tick()
		get_node('Actions/'+action).tick()
		for status in get_node('Effects').get_children():
			if status.active:
				status.tick()
		get_node('Model')._display(self) # do not display every tick, dont pass self into function
		quick_save()

func set_level():
	get_node('Top/Level').set_text(str(get_node('Stats')._level()))

func _action_ended():
	get_node('Assignments/'+assignment).next_action()
	get_node('Activity/Time').set_text("Done")
	get_node('Activity/Action').set_text("")

func quick_save():
	var path
	var file = File.new()
	var location = get_node('../../../').name
	if location == "Slaves":
		path = 'user://Data/Slot %s/Slaves/Owned/'%data.save_slot
	elif location == "Kidnappers Market":
		path = "user://Data/Slot %s/Slaves/Available/Kidnappers' Market/"%data.save_slot
	elif location == "Neighboring Arcologies":
		path = 'user://Data/Slot %s/Slaves/Available/Neighboring Arcologies/'%data.save_slot
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
			current_time = get_node('Actions/'+action).current_time,
			total_time = get_node('Actions/'+action).total_time},
		nested = {}}
#			breasts = _get_properties(breasts),
#			penis = _get_properties(penis)}}

func _load(_data):
	for setting in _data['core']:
		set(setting, _data['core'][setting])
	for _class in _data['nested']:
		for setting in _data['nested'][_class]:
			get(_class).set(setting, _data['nested'][_class][setting])
	get_node('Actions/'+action).current_time = _data['core']['current_time']
	get_node('Actions/'+action).total_time = _data['core']['total_time']
	if get_node('Actions/'+action).total_time:
		get_node('Activity/ProgressBar').max_value = get_node('Actions/'+action).total_time
		get_node('Activity/ProgressBar').value = get_node('Actions/'+action).current_time

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
		areolae = math.gaussian(4,1)
	func volume():
		return self.flesh+self.implant

var penis = Penis.new()
class Penis:
	var length
	var girth
	var size = math.gaussian(5.5,1)
	var foreskin = 3
	enum shape {normal, curved, horse, canine}
	enum head_piercing {none, stud, ring, smart}
	enum shaft_percing {none, studs, rings}
	enum accessory {none, chastity, perm_chastity}
	var tattoo

func _on_Assignment_item_selected(ID):
	var assignments = {0:"Rest",1:"Prostitute"}
	assignment = assignments[ID]

onready var root = get_tree().get_root()
func _on_Buy_pressed():
	var path
	var dir = Directory.new()
	var location = get_node('../../../').name
	if location == "Slaves":
		path = 'user://Data/Slot %s/Slaves/Owned/'%data.save_slot
	elif location == "Kidnappers Market":
		path = "user://Data/Slot %s/Slaves/Available/Kidnappers' Market/"%data.save_slot
	elif location == "Neighboring Arcologies":
		path = 'user://Data/Slot %s/Slaves/Available/Neighboring Arcologies/'%data.save_slot
	path += name+'.json'
	dir.remove(path)
	for_sale = false
	get_node('Panel').hide()
	get_node('Panel/Buttons').show()
	get_node('Panel/Selling Buttons').hide()
	get_parent().remove_child(self)
	root.get_node('Game/Slaves/Slider/HBoxContainer').add_child(self,true)

func _on_Top_pressed():
	$Panel.show()

func _on_Top_mouse_entered():
	$Top.set_modulate('ff7200')

func _on_Top_mouse_exited():
	$Top.set_modulate('ffffff')

func _input(event):
	if event.is_action_pressed('ui_back'):
		$Panel.hide()
	if is_visible_in_tree():
		if event is InputEventMouseButton:
			var x = get_local_mouse_position().x
			var y = get_local_mouse_position().y
			if x < 0 or y < 0:
				$Panel.hide()
			if x > rect_size.x or y > rect_size.y:
				$Panel.hide()

func _on_Examine_pressed():
	pass # Replace with function body.

func _on_Summon_pressed():
	pass # Replace with function body.

func _on_Sell_pressed():
	pass # Replace with function body.
