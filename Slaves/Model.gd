extends Spatial

onready var _slave = get_parent()
onready var body = get_node("Salmacis/SalmacisSkeleton/Salmacis")
onready var genitals_male = get_node("Salmacis/SalmacisSkeleton/MaleGenitals")
onready var genitals_female = get_node("Salmacis/SalmacisSkeleton/FemaleGenitals")

var masculinity = 0 setget set_masculinity
var genitals_male_adjustment = 0 setget set_genitals_male_adjustment
var weight = 0 setget set_weight
var weight_round = 0 setget set_weight_round
var weight_pear = 0 setget set_weight_pear
var weight_fat = 0 setget set_weight_fat
var waist_size = 0 setget set_waist_size
var butt_size = 0 setget set_butt_size
var body_size = 0 setget set_body_size
var bodybuilder = 0 setget set_bodybuilder
var voluptuous = 0 setget set_voluptuous
var pregnant = 0 setget set_pregnant
var breasts_growth = 0 setget set_breasts_growth
var breasts_implants = 0 setget set_breasts_implants
var breasts_small = 0 setget set_breasts_small
var breasts_gone = 0 setget set_breasts_gone
var testicles_size = 0 setget set_testicles_size
var penis_length = 0 setget set_penis_length
var penis_thickness = 0 setget set_penis_thickness
var penis_micro = 0 setget set_penis_micro

var model_data
func _ready():
	make_resources_unique()
	set_skin_color()
	set_hairstyle()
	set_hair_color()
	set_genitals()
	if model_data:
		for setting in model_data:
			set(setting,model_data[setting])
		model_data = null
	else:
		set_default_values()

func set_default_values():
	self.weight = clamp(math.gaussian(75,28),20,100)/100
	if weight == 1:
		distribute_fat()
	self.waist_size = clamp(math.gaussian(75,8),50,100)/100
	if dice.roll(3) == 0:
		self.butt_size = clamp(math.gaussian(0,5),0,20)/100
	if dice.roll(4) == 0:
		distribute_body_size()
	if dice.roll(4) == 0:
		distribute_muscles()
	if _slave.gender == "Male":
		self.masculinity = clamp(math.gaussian(97,4),90,100)/100
	elif _slave.gender == "Trans male":
		self.masculinity = clamp(math.gaussian(80,10),70,100)/100
	elif _slave.gender == "Female":
		distribute_breast_growth()
		if dice.roll(4) == 0:
			self.breasts_implants = clamp(math.gaussian(12,12),0,55)/100
		if dice.roll(4) == 0:
			self.voluptuous = clamp(math.gaussian(20,15),0,55)/100
	elif _slave.gender == "Trans female":
		self.masculinity = clamp(math.gaussian(50,24),30,90)/100
		distribute_trans_breasts()
		if dice.roll(4) == 0:
			self.breasts_implants = clamp(math.gaussian(12,12),0,45)/100
		if dice.roll(6) == 0:
			self.voluptuous = clamp(math.gaussian(15,10),0,35)/100
	self.penis_length = clamp(math.gaussian(16,9),10,50)/100
	self.penis_thickness = clamp(math.gaussian(35,5),20,60)/100
	self.testicles_size = clamp(math.gaussian(25,7),10,50)/100

func distribute_breast_growth():
	if dice.roll(12) <= 4:
		self.breasts_growth = clamp(math.gaussian(10,12),0,35)/100
	elif dice.roll(12) <= 8:
		self.breasts_growth = clamp(math.gaussian(30,12),10,60)/100
	elif dice.roll(12) <= 11:
		if dice.roll(2) == 0:
			self.breasts_small = clamp(math.gaussian(60,12),30,90)/100
		else:
			self.breasts_growth = clamp(math.gaussian(60,12),30,90)/100

func distribute_trans_breasts():
	if dice.roll(12) <= 4:
		self.breasts_small = clamp(math.gaussian(50,22),0,100)/100
	elif dice.roll(12) <= 8:
		self.breasts_gone = clamp(math.gaussian(70,12),50,100)/100
	elif dice.roll(12) <= 11:
		self.breasts_growth = clamp(math.gaussian(10,12),0,35)/100

func distribute_fat():
	var average_fat = clamp(math.gaussian(35,25),0,80)/100
	var fat_type = ["weight_round","weight_fat","weight_pear"]
	fat_type.shuffle()
	var fat_combination = dice.roll(3)
	if fat_combination == 0:
		set(fat_type[0],average_fat)
	elif fat_combination == 1:
		var split = math.random_split_2(average_fat)
		set(fat_type[0],split[0])
		set(fat_type[1],split[1])
	elif fat_combination == 2:
		var split = math.random_split_3(average_fat)
		set(fat_type[0],split[0])
		set(fat_type[1],split[1])
		set(fat_type[2],split[2])

func distribute_body_size():
	if dice.roll(12) <= 5:
		self.body_size = clamp(math.gaussian(10,12),0,30)/100
	elif dice.roll(12) <= 9:
		self.body_size = clamp(math.gaussian(30,12),10,60)/100
	elif dice.roll(12) <= 11:
		self.body_size = clamp(math.gaussian(60,12),30,90)/100

func distribute_muscles():
	if dice.roll(12) <= 5:
		self.bodybuilder = clamp(math.gaussian(10,12),0,30)/100
	elif dice.roll(12) <= 9:
		self.bodybuilder = clamp(math.gaussian(30,12),10,60)/100
	elif dice.roll(12) <= 11:
		self.bodybuilder = clamp(math.gaussian(60,12),30,90)/100

func set_skin_color():
	var skin_material = SpatialMaterial.new()
	skin_material.albedo_color = _slave.skin_color
	body.set_surface_material(0,skin_material)
	genitals_male.set_surface_material(0,skin_material)
	genitals_female.set_surface_material(0,skin_material)

func set_hair_color():
	var hair_material = SpatialMaterial.new()
	hair_material.albedo_color = _slave.hair_color
	if not _slave.hair_style == "none":
		$Hair.set_surface_material(0, hair_material)

func set_hairstyle():
	var gender = _slave.gender.trim_prefix("Trans").capitalize()
	if gender == "Intersex":
		gender = ["Male","Female"][dice.roll(2)]
	if _slave.hair_style == "none":
		$Hair.mesh = null
		return
	var styles = ["straight", "wavy", "curly"]
	var str2 = 'res://Slaves/Models/%s/Hair/hair %s %s.obj'
	var load_str2 = str2%[gender,gender.to_lower(),str(styles.find(_slave.hair_style)+1)]
	var hair_mesh = load(load_str2)
	$Hair.mesh = hair_mesh

func set_genitals():
	if _slave.gender == "Female" or _slave.gender == "Trans male":
		genitals_male.hide()
		genitals_female.show()
		self.genitals_male_adjustment = 0
	else:
		genitals_male.show()
		genitals_female.hide()
		self.genitals_male_adjustment = 1

func armature_adjustment(value,morph,slope):
	var animation_tree = get_node("Salmacis/SalmacisSkeleton/AnimationTree")
	var armature_value = animation_tree.get("parameters/Armature/blend_amount")
	var difference = value - morph
	animation_tree.set("parameters/Armature/blend_amount",armature_value+(difference/slope))
	armature_value = animation_tree.get("parameters/Armature/blend_amount")

func make_resources_unique():
	body.mesh = body.mesh.duplicate()
	genitals_male.mesh = genitals_male.mesh.duplicate()
	genitals_female.mesh = genitals_female.mesh.duplicate()

func set_masculinity(value):
	set_bodybuilder(bodybuilder)
	set_weight_fat(weight_fat)
	body.set("blend_shapes/Gender Male", value)
	genitals_male.set("blend_shapes/Gender Male", value)
	genitals_female.set("blend_shapes/Gender Male", value)
	masculinity = value
	if _slave.gender == "Female" or _slave.gender == "Trans female":
		if masculinity >= 0.7:
			_slave.flags["gender"] = "[color=#ffa500]Very masculine body[/color]" 
		elif masculinity >= 0.5:
			_slave.flags["gender"] = "[color=#ffd100]Masculine body[/color]" 
		elif masculinity >= 0.3:
			_slave.flags["gender"] = "Slightly masculine body"
		else:
			_slave.flags.erase("gender")
	elif _slave.gender == "Male" or _slave.gender == "Trans male":
		if masculinity <= 0.3:
			_slave.flags["gender"] = "[color=#ffa500]Very feminine body[/color]"
		elif masculinity <= 0.5:
			_slave.flags["gender"] = "[color=#ffd100]Feminine body[/color]"
		elif masculinity <= 0.7:
			_slave.flags["gender"] = "Slightly feminine body"
		else:
			_slave.flags.erase("gender")

func set_genitals_male_adjustment(value):
	body.set("blend_shapes/Genitals Male",value)
	genitals_male.set("blend_shapes/Genitals Male",value)
	genitals_female.set("blend_shapes/Genitals Male",value)
	genitals_male_adjustment = value

func reset_weight(value):
	if value > 0:
		set_weight(1)

func set_weight(value):
	if value < 1:
		set_weight_fat(0)
		set_weight_pear(0)
		set_weight_round(0)
	armature_adjustment(value,weight,5.2)
	body.set("blend_shapes/Weight",clamp((value-0.6)/0.4,0,1))
	body.set("blend_shapes/Weight Skinny",clamp((value-0.6)/-0.3,0,1))
	body.set("blend_shapes/Weight Emaciated",clamp((value-0.3)/-0.3,0,1))
	genitals_male.set("blend_shapes/Weight",clamp((value-0.6)/0.4,0,1))
	genitals_male.set("blend_shapes/Weight Skinny",clamp((value-0.6)/-0.3,0,1))
	genitals_male.set("blend_shapes/Weight Emaciated",clamp((value-0.3)/-0.3,0,1))
	genitals_female.set("blend_shapes/Weight",clamp((value-0.6)/0.4,0,1))
	genitals_female.set("blend_shapes/Weight Skinny",clamp((value-0.6)/-0.3,0,1))
	genitals_female.set("blend_shapes/Weight Emaciated",clamp((value-0.3)/-0.3,0,1))
	weight = clamp(value,0,1)
	if weight <= 0.3:
		_slave.flags["weight"] = "[color=#ffa500]Emaciated[/color]"
	elif weight <= 0.5:
		_slave.flags["weight"] = "[color=#ffd100]Skinny[/color]"
	elif weight <= 0.7:
		_slave.flags["weight"] = "[color=white]Thin[/color]"
	else:
		_slave.flags.erase("weight")

func set_overweight_flags():
	if weight < 1:
		return
	var weight_total = weight + weight_fat + weight_pear + weight_round/2
	if weight_total >= 1.5:
		_slave.flags["weight"] = "[color=#ffa500]Obese[/color]"
	elif weight_total >= 1.3:
		_slave.flags["weight"] = "[color=#ffd100]Fat[/color]"
	elif weight_total >= 1.1:
		_slave.flags["weight"] = "[color=white]Chubby[/color]"
	else:
		_slave.flags.erase("weight")

func set_weight_round(value):
	reset_weight(value)
	body.set("blend_shapes/Weight Round",value)
	genitals_male.set("blend_shapes/Weight Round",value)
	genitals_female.set("blend_shapes/Weight Round",value)
	armature_adjustment(value,weight_round,7.2)
	weight_round = clamp(value,0,1)
	set_overweight_flags()

func set_weight_pear(value):
	reset_weight(value)
	body.set("blend_shapes/Weight Pear",value)
	genitals_male.set("blend_shapes/Weight Pear",value)
	genitals_female.set("blend_shapes/Weight Pear",value)
	armature_adjustment(value,weight_pear,1.8)
	weight_pear = clamp(value,0,1)
	set_overweight_flags()

func set_weight_fat(value):
	reset_weight(value)
	var male_amount = body.get("blend_shapes/Gender Male")
	var female_amount = 1-male_amount
	body.set("blend_shapes/Weight Fat",female_amount*value)
	body.set("blend_shapes/Weight Fat Male",male_amount*value)
	genitals_male.set("blend_shapes/Weight Fat",value)
	genitals_female.set("blend_shapes/Weight Fat",value)
	armature_adjustment(value,weight_fat,1.3)
	weight_fat = clamp(value,0,1)
	set_overweight_flags()

func set_waist_size(value):
	body.set("blend_shapes/WaistSize",value)
	#Absurd 
	#Hourglass
	#Feminine
	#Average
	#Masculine
	waist_size = clamp(value,0,1)

func set_butt_size(value):
	body.set("blend_shapes/ButtSize",value)
	genitals_male.set("blend_shapes/ButtSize",value)
	genitals_female.set("blend_shapes/ButtSize",value)
	#Flat
	#Small
	#Plump
	#Healthy
	#Huge
	#Enormous
	#Gigantic
	#Massive
	butt_size = clamp(value,0,1)

func set_bodybuilder(value):
	body.set("blend_shapes/Bodybuilder",value)
	genitals_male.set("blend_shapes/Bodybuilder",value)
	genitals_female.set("blend_shapes/Bodybuilder",value)
	armature_adjustment(value,bodybuilder,6.3)
	bodybuilder = clamp(value,0,1)
	if bodybuilder >= 0.7:
		_slave.flags["physique"] = "[color=#00aa0a]Ripped[/color]"
	elif bodybuilder >= 0.5:
		_slave.flags["physique"] = "[color=#00aa0a]Buff[/color]"
	elif bodybuilder >= 0.3:
		_slave.flags["physique"] = "[color=#00aa0a]Tone[/color]"
	else:
		_slave.flags.erase("physique")

func set_body_size(value):
	body.set("blend_shapes/BodySize",value)
	genitals_male.set("blend_shapes/BodySize",value)
	genitals_female.set("blend_shapes/BodySize",value)
	armature_adjustment(value,body_size,3.9)
	if masculinity > 0:
		breasts_small = masculinity
	body_size = clamp(value,0,1)
	set_body_flags()

func set_voluptuous(value):
	body.set("blend_shapes/Voluptuous",value)
	genitals_male.set("blend_shapes/Voluptuous",value)
	genitals_female.set("blend_shapes/Voluptuous",value)
	armature_adjustment(value,voluptuous,1.7)
	voluptuous = clamp(value,0,1)
	set_body_flags()

func set_body_flags(): #replace with separate body_size flag
	_slave.flags.erase("body")
	if voluptuous >= 0.5:
		_slave.flags["body"] = "[color=#00aa0a]Voluptuous[/color]"
	elif voluptuous >= 0.35:
		_slave.flags["body"] = "[color=#00aa0a]Curvy[/color]"
	elif voluptuous >= 0.2:
		_slave.flags["body"] = "[color=#00aa0a]Plush[/color]"
	if body_size >= 0.7 and voluptuous < 0.5:
		_slave.flags["body"] = "Huge"
	elif body_size >= 0.5 and voluptuous < 0.35:
		_slave.flags["body"] = "Heavily built"
	elif body_size >= 0.3 and voluptuous < 0.2:
		_slave.flags["body"] = "Stocky"

# 37 to 42 weeks
# math.gaussian(39,2)
func set_pregnant(value):
	body.set("blend_shapes/Pregnant",value)
	genitals_male.set("blend_shapes/Pregnant",value)
	genitals_female.set("blend_shapes/Pregnant",value)
	armature_adjustment(value,pregnant,10)
	pregnant = clamp(value,0,1)

func set_breasts_growth(value):
	body.set("blend_shapes/Breasts Growth1",clamp((value-0.0)/0.5,0,1))
	body.set("blend_shapes/Breasts Growth2",clamp((value-0.3)/0.5,0,1))
	body.set("blend_shapes/Breasts Growth3",clamp((value-0.5)/0.5,0,1))
	breasts_growth = clamp(value,0,1)

func set_breasts_implants(value):
	body.set("blend_shapes/Breasts Implants",value)
	breasts_implants = clamp(value,0,1)

func set_breasts_small(value):
	body.set("blend_shapes/Breasts Small",value)
	breasts_small = clamp(value,0,1)

func set_breasts_gone(value):
	body.set("blend_shapes/Breasts Gone",value)
	breasts_gone = clamp(value,0,1)

func set_testicles_size(value):
	genitals_male.set("blend_shapes/Testicles Size",value)
	testicles_size = clamp(value,0,1)

func set_penis_length(value):
	genitals_male.set("blend_shapes/Penis Length",value)
	penis_length = clamp(value,0,1)

func set_penis_thickness(value):
	genitals_male.set("blend_shapes/Penis Thickness",value)
	penis_thickness = clamp(value,0,1)

func set_penis_micro(value):
	genitals_male.set("blend_shapes/Penis Micro",value)
	penis_micro = clamp(value,0,1)
