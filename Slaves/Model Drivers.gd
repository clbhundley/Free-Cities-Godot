extends Node

onready var model = get_node("../Salmacis")
onready var skeleton = get_node("../Salmacis/SalmacisSkeleton")
onready var body = get_node("../Salmacis/SalmacisSkeleton/Salmacis")
onready var male_genitals = get_node("../Salmacis/SalmacisSkeleton/MaleGenitals")
onready var female_genitals = get_node("../Salmacis/SalmacisSkeleton/FemaleGenitals")
onready var animation = get_node("../Salmacis/SalmacisSkeleton/AnimationPlayer")
onready var animation_tree = get_node("../Salmacis/SalmacisSkeleton/AnimationTree")

var morph_defaults = {
	#Weight = 0.75,
	WaistSize = 0.75,
	Penis_Length = 0.16,
	Penis_Thickness = 0.35,
	Testicles_Size = 0.25}

func set_default_values():
	for i in morph_defaults:
		var morph = i.replace("_"," ")
		var method_name = name.to_lower().replace(" ","_")
		if has_method(method_name):
			call(method_name,morph_defaults[i])
			return
		body.set("blend_shapes/"+morph, morph_defaults[i])
		male_genitals.set("blend_shapes/"+morph, morph_defaults[i])
		female_genitals.set("blend_shapes/"+morph, morph_defaults[i])

func morph(value,node):
	var name = node.get_parent().name
	var setting = value * 0.01
	print(name, ": ", value, "%")
	var method_name = name.to_lower().replace(" ","_")
	if has_method(method_name):
		call(method_name,setting)
		return
	body.set("blend_shapes/"+name, setting)
	male_genitals.set("blend_shapes/"+name, setting)
	female_genitals.set("blend_shapes/"+name, setting)

func armature_adjustment(value,morph,slope):
	var armature_value = animation_tree.get("parameters/Armature/blend_amount")
	var dif = value-get(morph)
	animation_tree.set("parameters/Armature/blend_amount", armature_value+(dif/slope))
	set(morph,value)
	#print("Armature: ",armature_value)

func genitals_selection(index):
	if index == 0:
		male_genitals.hide()
		female_genitals.show()
		body.set("blend_shapes/Genitals Male",0)
	else:
		male_genitals.show()
		female_genitals.hide()
		body.set("blend_shapes/Genitals Male",1)

func reset_weight(value):
	if value > 0:
		weight(1)
#		var weight_slider = $"../GUI/Morphs/Morphs 1/Vbox/Weight/Slider"
#		weight_slider.value = weight_slider.max_value

var weight_current = 0
func weight(value):
	if value < 1:
		weight_fat(0)
#		var fat_slider = $"../GUI/Morphs/Morphs 1/Vbox/Weight Fat/Slider"
#		fat_slider.value = fat_slider.min_value
		weight_pear(0)
#		var pear_slider = $"../GUI/Morphs/Morphs 1/Vbox/Weight Pear/Slider"
#		pear_slider.value = pear_slider.min_value
		weight_round(0)
#		var round_slider = $"../GUI/Morphs/Morphs 1/Vbox/Weight Round/Slider"
#		round_slider.value = round_slider.min_value
	armature_adjustment(value,"weight_current",4.2)
	body.set("blend_shapes/Weight",clamp((value-0.6)/0.4,0,1))
	body.set("blend_shapes/Weight Skinny",clamp((value-0.6)/-0.3,0,1))
	body.set("blend_shapes/Weight Emaciated",clamp((value-0.3)/-0.3,0,1))
	male_genitals.set("blend_shapes/Weight",clamp((value-0.6)/0.4,0,1))
	male_genitals.set("blend_shapes/Weight Skinny",clamp((value-0.6)/-0.3,0,1))
	male_genitals.set("blend_shapes/Weight Emaciated",clamp((value-0.3)/-0.3,0,1))
	female_genitals.set("blend_shapes/Weight",clamp((value-0.6)/0.4,0,1))
	female_genitals.set("blend_shapes/Weight Skinny",clamp((value-0.6)/-0.3,0,1))
	female_genitals.set("blend_shapes/Weight Emaciated",clamp((value-0.3)/-0.3,0,1))

var weight_fat_current = 0
func weight_fat(value):
	reset_weight(value)
	var male_amount = body.get("blend_shapes/Gender Male")
	var female_amount = 1-male_amount
	body.set("blend_shapes/Weight Fat",female_amount*value)
	body.set("blend_shapes/Weight Fat Male",male_amount*value)
	male_genitals.set("blend_shapes/Weight Fat",value)
	female_genitals.set("blend_shapes/Weight Fat",value)
	armature_adjustment(value,"weight_fat_current",1.3)

var round_current = 0
func weight_round(value):
	reset_weight(value)
	body.set("blend_shapes/Weight Round",value)
	male_genitals.set("blend_shapes/Weight Round",value)
	female_genitals.set("blend_shapes/Weight Round",value)
	armature_adjustment(value,"round_current",7.2)

var pear_current = 0
func weight_pear(value):
	reset_weight(value)
	body.set("blend_shapes/Weight Pear",value)
	male_genitals.set("blend_shapes/Weight Pear",value)
	female_genitals.set("blend_shapes/Weight Pear",value)
	armature_adjustment(value,"pear_current",1.8)

var body_size_current = 0
func body_size(value):
	body.set("blend_shapes/BodySize",value)
	male_genitals.set("blend_shapes/BodySize",value)
	female_genitals.set("blend_shapes/BodySize",value)
	armature_adjustment(value,"body_size_current",3.9)
	var male = body.get("blend_shapes/Gender Male")
	var breasts_small = $"../GUI/Morphs/Morphs 2/Vbox/Breasts Small/Slider"
	if male > 0:
		breasts_small.value = male*100

var bodybuilder_current = 0
func bodybuilder(value):
	body.set("blend_shapes/Bodybuilder",value)
	male_genitals.set("blend_shapes/Bodybuilder",value)
	female_genitals.set("blend_shapes/Bodybuilder",value)
	armature_adjustment(value,"bodybuilder_current",6.3)

var voluptious_current = 0
func voluptuous(value):
	body.set("blend_shapes/Voluptuous",value)
	male_genitals.set("blend_shapes/Voluptuous",value)
	female_genitals.set("blend_shapes/Voluptuous",value)
	armature_adjustment(value,"voluptious_current",1.7)

var pregnant_current = 0
func pregnant(value):
	body.set("blend_shapes/Pregnant",value)
	male_genitals.set("blend_shapes/Pregnant",value)
	female_genitals.set("blend_shapes/Pregnant",value)
	armature_adjustment(value,"pregnant_current",10)

func breasts_growth(value):
	body.set("blend_shapes/Breasts Growth1",clamp((value-0.0)/0.5,0,1))
	body.set("blend_shapes/Breasts Growth2",clamp((value-0.3)/0.5,0,1))
	body.set("blend_shapes/Breasts Growth3",clamp((value-0.5)/0.5,0,1))

func gender_male(value):
	bodybuilder(bodybuilder_current)
	weight_fat(weight_fat_current)
	body.set("blend_shapes/Gender Male", value)
	male_genitals.set("blend_shapes/Gender Male", value)
	female_genitals.set("blend_shapes/Gender Male", value)
