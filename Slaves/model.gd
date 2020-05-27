extends Control

func _display(_slave):
#	get_node('torso').texture = load('res://Slaves/Textures/Body/Torso/'+s['torso']+'.png')
	
	var chest = _slave.chest['cup']
	if chest != null:
		get_node('Breasts/'+str(chest)).show()
		if _slave.tissue_color == "pink":
			get_node('Breasts/'+str(chest)+'/areola').set_self_modulate('fc6060')
		elif _slave.tissue_color == "dark":
			get_node('Breasts/'+str(chest)+'/areola').set_self_modulate('8b5037')
	
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
	
	var hair = [get_node('hair aft neat'),get_node('hair fore neat')]
	if gender == "female" or gender == "intersex" or gender == "trans female":
		for parts in hair:
			parts.show()
			parts.set_self_modulate(_slave['hair_color'])
#	else:
#		for parts in hair:
#			parts.hide()
	
	var tissue = [
	get_node('vagina'),
	get_node('Breasts/'+str(chest)+'/areola')]
	
	if _slave.vagina == true and _slave.penis == true:
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
