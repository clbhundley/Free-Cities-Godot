extends Control

onready var _slave = owner

onready var chest = _slave.chest['cup']

func chest():
	print(_slave.name," ",chest)
	get_node('Breasts/'+str(chest)).show()
	if _slave.tissue_color == "pink":
		get_node('Breasts/'+str(chest)+'/areola').set_self_modulate('fc6060')
	elif _slave.tissue_color == "dark":
		get_node('Breasts/'+str(chest)+'/areola').set_self_modulate('8b5037')

func _display():
###	get_node('torso').texture = load('res://Slaves/Textures/Body/Torso/'+s['torso']+'.png')
	
	#print("www", _slave['hair_color'])
	
	chest()
#	var chest = _slave.chest['cup']
#	if chest != null:
#		get_node('Breasts/'+str(chest)).show()
#		if _slave.tissue_color == "pink":
#			get_node('Breasts/'+str(chest)+'/areola').set_self_modulate('fc6060')
#		elif _slave.tissue_color == "dark":
#			get_node('Breasts/'+str(chest)+'/areola').set_self_modulate('8b5037')
	
	var legs = _slave.hips
	if legs == true:
		get_node(legs).show()
		get_node(legs).set_modulate(_slave.skin_color)
	
	var gender = _slave.gender
	var genitals = _slave.genitals
	var size = _slave.penis_size
	
	if _slave.vagina == true:
		get_node('vagina').show()
		if _slave.tissue_color == "pink":
			get_node('vagina').set_self_modulate('fc6060')
		elif _slave.tissue_color == "dark":
			get_node('vagina').set_self_modulate('8b5037')
	
	if _slave.penis_size >= 1:
		get_node('Penis/'+str(_slave.penis_size)).show()
	
	if _slave.testicles_size >= 1:
		get_node('Testicles/'+str(_slave.testicles_size)).show()
	
	#print("111111www ", _slave['hair_color'])
	var hair = [get_node('hair aft neat'),get_node('hair fore neat')]
	#var feminine = ["female","intersex","trans female"]
	#if finimine.has(_slave.gender):
	print("GRERGRG!!!!! ",_slave.gender)
	
	#if _slave.gender == "Female" or _slave.gender == "Intersex" or _slave.gender == "Trans female":
#	for parts in hair:
#		parts.show()
#		parts.set_modulate(_slave.hair_color)
#		print("111111www ", _slave.hair_color)
#	else:
#		for parts in hair:
#			parts.hide()
	
	var tissue = [
	get_node('vagina'),
	get_node('Breasts/'+str(chest)+'/areola')]
	
	if _slave.vagina and _slave.penis:
		if _slave.tissue_color == "pink":
			for parts in tissue:
				parts.set_self_modulate('fc6060')
		elif _slave.tissue_color == "dark":
			for parts in tissue:
				parts.set_self_modulate('8b5037')
	
	var skin = [
	get_node('Arms/Right/low'),
	get_node('Arms/Left/low'),
	get_node('Torso/normal'),
	get_node('head'),
	get_node('Legs/normal'),
	get_node('Butt/0'),
	get_node('Feet/feet'),
	get_node('Breasts/'+str(chest)),
	get_node('Penis/'+str(_slave.penis_size)),
	get_node('Testicles/'+str(_slave.testicles_size))]
	for parts in skin:
		parts.set_self_modulate(_slave.skin_color)
