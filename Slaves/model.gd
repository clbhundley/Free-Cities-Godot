extends Control

func display(s):
#	get_node('torso').texture = load('res://Slaves/Textures/Body/Torso/'+s['torso']+'.png')
	
	var chest = s.chest['cup']
	if chest != null:
		get_node('Breasts/'+str(chest)).show()
		if s.tissue_color == "pink":
			get_node('Breasts/'+str(chest)+'/areola').set_self_modulate('fc6060')
		elif s.tissue_color == "dark":
			get_node('Breasts/'+str(chest)+'/areola').set_self_modulate('8b5037')
	
	var legs = s.hips
	if legs == true:
		get_node(legs).show()
		get_node(legs).set_modulate(s.skin_color)
	
	var gender = s.gender
	var genitals = s.genitals
	var size = s.penis_size
	
	if s.vagina == true:
		get_node('vagina').show()
		if s.tissue_color == "pink":
			get_node('vagina').set_self_modulate('fc6060')
		elif s.tissue_color == "dark":
			get_node('vagina').set_self_modulate('8b5037')
	
	if s.penis_size >= 1:
		get_node('Penis/'+str(s.penis_size)).show()
	
	if s.testicles_size >= 1:
		get_node('Testicles/'+str(s.testicles_size)).show()
	
	var hair = [get_node('hair aft neat'),get_node('hair fore neat')]
	if gender == "female" or gender == "intersex" or gender == "trans female":
		for parts in hair:
			parts.show()
			parts.set_self_modulate(s['hair_color'])
	
	var tissue = [
	get_node('vagina'),
	get_node('Breasts/'+str(chest)+'/areola')]
	
	if s.vagina == true and s.penis == true:
		if s.tissue_color == "pink":
			for parts in tissue:
				parts.set_self_modulate('fc6060')
		elif s.tissue_color == "dark":
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
	get_node('Penis/'+str(s.penis_size)),
	get_node('Testicles/'+str(s.testicles_size))]
	for parts in skin:
		parts.set_self_modulate(s.skin_color)