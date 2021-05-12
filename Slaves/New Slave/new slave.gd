extends Node

var region = "Asia"


func new(preset=null,for_sale=false):
	randomize()
	
	var _slave = load('res://Slaves/Slave.tscn').instance()
	
	if not _slave.ethnicity:
		_slave.ethnicity = _ethnicity(region)
	var presets = load('res://Slaves/New Slave/Presets/%s.gd'%preset).presets()
	
	_slave.for_sale = for_sale
	
	if preset:
		for setting in presets.keys():
			_slave.set(setting, presets[setting])
	
	if not _slave.gender:
		_slave.gender = _gender()
	
	var path = 'res://Slaves/New Slave/Ethnicities/%s/%s.gd'
	var ethnicity = _slave.ethnicity.to_lower()
	var traits = load(path%[region,ethnicity]).traits(_slave.gender)
	for trait in traits.keys():
		_slave.set(trait, traits[trait])
	
	_slave.is_awake = true
	
	_slave.location = _slave.quarters
	
	if not _slave.age:
		_slave.age = randi() %41+18

	if _slave.gender == "Male" or _slave.gender == "Trans female":
		_slave.vagina = false
		#_slave.penis = true
		_slave.penis_size = traits['penis_size']
		_slave.testicles_size = 1
	elif _slave.gender == "Female" or _slave.gender == "Trans male":
		_slave.vagina = true
		#_slave.penis = false
		_slave.penis_size = 0
		_slave.testicles_size = 0
	elif _slave.gender == "Intersex":
		_slave.vagina = true
		#_slave.penis = true
		_slave.penis_size = traits['penis_size']
		_slave.testicles_size = 1
	if not _slave.fertility:
		if dice.roll(12) == 0 and dice.roll(6) == 0:
			_slave.fertility = 0
		else:
			_slave.fertility = randf()
	_pregnancy(_slave)
	if not _slave.skin_color:
		_slave.skin_color = skin_color(traits)
#	if not _slave.hair_color:
#		_slave.hair_color = hair_color(traits,_slave)
	hair_color(_slave)
	if not _slave.hair_style:
		_slave.hair_style = hair_style()
	if not _slave.chest:
		_slave.chest = null
	if not _slave.voice:
		_slave.voice = _voice(_slave.gender)
	if not _slave.health:
		_slave.health = math.gaussian(50,12)
	if not _slave.fatigue:
		_slave.fatigue = math.gaussian(40,12)
	if not _slave.hunger:
		_slave.hunger = math.gaussian(85,5)
	if not _slave.bathroom:
		_slave.bathroom = math.gaussian(90,5)
	if not _slave.intelligence:
		_slave.intelligence = math.gaussian(100,25)
	if not _slave.libido:
		_slave.libido = math.gaussian(100,25)
	if not _slave.male_attraction:
		_slave.male_attraction = math.gaussian(0,25)
	if not _slave.female_attraction:
		_slave.female_attraction = math.gaussian(0,25)
	if not _slave.devotion:
		_slave.devotion = math.gaussian(-50,25)
	if not _slave.trust:
		_slave.trust = math.gaussian(-50,25)
	if not _slave.happiness:
		_slave.happiness = abs(math.gaussian(40,10))
	if not _slave.social:
		_slave.social = math.gaussian(5,10)
	if not _slave.face:
		_slave.face = math.gaussian(5,3)
	if not _slave.figure:
		_slave.figure = null
	if not _slave.arousal:
		_slave.arousal = abs(math.gaussian(10,5))
	if not _slave.sexual_skill:
		_slave.sexual_skill = abs(math.gaussian(10,25))
	if not _slave.oral_skill:
		_slave.oral_skill = abs(math.gaussian(10,25))
	if not _slave.anal_skill:
		_slave.anal_skill = abs(math.gaussian(10,25))
	if not _slave.vaginal_skill:
		_slave.vaginal_skill = abs(math.gaussian(10,25))
	if not _slave.penis_skill:
		_slave.penis_skill = abs(math.gaussian(10,25))
	if not _slave.prostitution_skill:
		_slave.prostitution_skill = abs(math.gaussian(10,25))
	if not _slave.entertainment_skill:
		_slave.entertainment_skill = abs(math.gaussian(10,25))
	if not _slave.combat_skill:
		_slave.combat_skill = abs(math.gaussian(10,25))
	
	if _slave.gender == "Female" or _slave.gender == "Trans male":
		_slave.regimen.append("Contraception")
	_slave.diet = "Healthy"
	_slave.diet_base = "Normal"
	
	_slave.wardrobe["choosing"] = "none"
	_slave.wardrobe["clothing"] = {}
	for i in ["outfit","shirt","pants","shoes"]:
		_slave.wardrobe["clothing"][i] = null
	_slave.wardrobe["clothing"]["outfit"] = "Nude"
	_slave.wardrobe["accessories"] = {}
	for i in ["head","face","neck","arms","torso","genitals","legs"]:
		_slave.wardrobe["accessories"][i] = "None"
	
	#force gauged values to below 100. should not be needed if slave is generated properly
	var gauges = ['happiness','arousal','fatigue','hunger','bathroom']
	for value in gauges:
		if _slave.get(value) > 100:
			_slave.set(value,100)
	return _slave

func _ethnicity(region):
	var ethnicities = {
		"Africa": ["Arabic", "Ethiopian", "Egyptian"],
		"Asia": ["Korean", "Japanese", "Chinese", "Indian"],
		"Australia": ["British", "Italian", "Vietnamese"],
		"Europe": ["British", "French", "German", "Italian", "Spanish", "Russian", "Turkish"],
		"Middle East": ["Egyptian", "Iranian", "Saudi", "Turkish"],
		"North America": ["British", "French", "German", "Italian", "Spanish", "Korean", "Japanese", "Chinese", "Indian", "Mexican"],
		"South America": ["Brazilian", "Colombian", "Mexican", "Latina"]}
	return ethnicities[region][randi()%ethnicities[region].size()]

func skin_color(traits):
	var colors = {
	'tanned':['e0ac69','ffcd94','ffad60'],
	'brown':['9b6b39','805d38','6e4c25'],
	'dark_brown':['522500','7c501a','9c7248'],
	'black':['2d241c','221c17','1c1712']}
	return ['ffe39f','dec676','ceb563'][randi()%3+0]

func areola_labia_color(traits): # change to flesh color?
	var colors = {
	'pink':'d76b93',
	'dark':'7a3d00'}
	return colors[traits.areola_labia_color()]

func hair_color(_slave):
	var colors = load('res://Slaves/New Slave/colors.gd')
	var natural_colors = colors.hair_natural
	var dyed_colors = colors.hair_dyed
	if _slave.age >= 54:
		var selection = natural_colors['grey']
		_slave.hair_color_natural = selection[dice.roll(selection.size())]
		_slave.hair_color = _slave.hair_color_natural
	elif not _slave.hair_color_natural:
		_slave.hair_color_natural = '100C07'
		_slave.hair_color = _slave.hair_color_natural
	elif dice.roll(12) <= 2:
		var selection = dyed_colors[dyed_colors.keys()[dice.roll(dyed_colors.size())]]
		_slave.hair_color = selection[dice.roll(selection.size())]
	else:
		_slave.hair_color = _slave.hair_color_natural

func hair_style():
	var styles = ["straight", "wavy", "curly", "none"]
	return(styles[dice.roll(4)])

func _gender():
	var roll = math.gaussian(100,25)
	var roll2 = randi()%3+0
	if roll <= 55:
		return "Trans female"
	elif roll < 100:
		return "Female"
	elif roll >= 145:
		return "Trans male"
	elif roll > 100:
		return "Male"
	if roll == 100:
		if roll2 == 0:
			return "Female"
		elif roll2 == 2:
			return "Male"
		else:
			return "Intersex"

#aiming for 37 to 42 weeks
func _pregnancy(_slave):
	if _slave.gender != "Female" and _slave.gender != "Trans male":
		return
	if _slave.gender == "Female":
		if dice.roll(8) != 0:
			return
	if _slave.gender == "Trans male":
		if dice.roll(9) != 0 and dice.roll(3) != 0:
			return
	if randi()%100 < _slave.fertility * 100:
		return
	var weeks_pregnant = randi()%int(math.gaussian(39,1))
	var conceived = time.get_reversed_time(
		randi()%60,
		randi()%60,
		randi()%24,
		randi()%7,
		weeks_pregnant)
	var weeks_forward = max(int(math.gaussian(39,1)),weeks_pregnant)-weeks_pregnant
	var due = time.get_forward_time(
		randi()%60,
		randi()%60,
		randi()%24,
		randi()%7,
		weeks_forward)
	var babies = 1
	if randi()%1000 == 0:
		babies = 5
	elif randi()%120 == 0:
		babies = 4
	elif randi()%60 == 0:
		babies = 3
	elif randi()%30 == 0:
		babies = 2
	_slave.pregnancy = {
		"conceived":conceived,
		"due":due,
		"babies":babies}
	#print(_slave.name," ",_slave.gender," ",JSON.print(_slave.pregnancy," "))

func _voice(gender):
	var accents = ["Ugly", "Cute", "Pretty", "Exotic"]
	var voice = ""
	var roll
	roll = randi()%100
	if roll == 51:
		return "mute"
	elif gender == "Male":
		roll = dice.roll(12)
		if roll <= 2:
			voice += "deep "
		elif roll >= 10:
			voice += "high "
		if dice.roll(12) == 11:
			voice += "feminine "
	elif gender == "Female":
		roll = dice.roll(12)
		if roll <= 1:
			voice += "deep "
		elif roll >= 9:
			voice += "high "
		if dice.roll(12) == 0:
			voice += "masculine "
	if gender == "Trans male":
		roll = dice.roll(12)
		if roll <= 1:
			voice += "deep "
		elif roll >= 9:
			voice += "high "
		roll = dice.roll(12)
		if roll <= 1:
			voice += "masculine "
		elif roll >= 8:
			voice += "feminine "
	elif gender == "Trans female":
		roll = dice.roll(12)
		if roll <= 2:
			voice += "deep "
		elif roll >= 10:
			voice += "high "
		roll = dice.roll(12)
		if roll <= 3:
			voice += "masculine "
		elif roll >= 10:
			voice += "feminine "
	elif gender == "Intersex":
		roll = dice.roll(12)
		if roll <= 2:
			voice += "deep "
		elif roll >= 9:
			voice += "high "
		roll = dice.roll(12)
		if roll <= 2:
			voice += "masculine "
		elif roll >= 9:
			voice += "feminine "
	return voice

#func figure():
#	var roll = math.gaussian(0,62)
#	if roll < -95:
#		return "Emaciated"
#	elif roll < -50:
#		return "Skinny"
#	elif roll < -20:
#		return "Average weight"
#	elif roll < 20:
#		return "Muscular"
#	elif roll < 50:
#		return "Plush"
#	elif roll < 95:
#		return "Fat"
#	else:
#		return "Overweight"

#func chest(traits,_slave): # http://www.averageheight.co/breast-cup-size-by-country
#	var cup_sizes = ["AA","A","B","C","D","DD","E","F","FF","G","GG","H","HH","J","JJ","K"]
#	var band_size = int(traits.breast_size['chest_size'])
#	var bust_size = math.gaussian(band_size+traits.breast_size['breast_size'],traits.breast_size['breast_variation'])
#	if bust_size < band_size:
#		bust_size = band_size
#	var cup = bust_size - band_size
#	if cup > 10:
#		cup = 10
#	if band_size % 2 == 0:
#		band_size += 4
#	else:
#		band_size += 5
#	if _slave.gender == "male" or _slave.gender == "trans male":
#		return {'band':band_size,'cup':"flat"}
#	return {'band':band_size,'cup':cup_sizes[cup]}

#func genitals(traits,_slave):
#	if _slave.gender == "male" or _slave.gender == "trans female":
#		_slave.vagina = false
#		_slave.penis = true
#		_slave.penis_size = traits.penis_size()
#		_slave.testicles = true
#	elif _slave.gender == "female" or _slave.gender == "trans male":
#		_slave.vagina = true
#		_slave.penis = false
#		_slave.penis_size = 0
#		_slave.testicles = false
#	elif _slave.gender == "intersex":
#		_slave.vagina = true
#		_slave.penis = true
#		_slave.penis_size = traits.penis_size()
#		_slave.testicles = true

#func torso(_slave):
#	var types = ["normal", "hourglass"] # "unnatural" not in use
#	if _slave.gender == "male" or _slave.gender == "trans man":
#		return "normal"
#	return types[randi()%types.size()+0]
#
#func hips(_slave):
#	var types = ["normal", "thin", "wide"]
#	if _slave.gender == "male" or _slave.gender == "trans man":
#		return "thin"
#	return types[randi()%types.size()+0]
#
#func butt():
#	var types = ["small", "normal", "large", "very large"]
#	return types[randi()%types.size()+0]

#func genitals():
#	var vagina
#	var penis
#	var penis_size
#	var testicles
#	if gender == "male" or gender == "trans female":
#		vagina = false
#		penis = true
#		penis_size = traits.penis_size()
#		testicles = true
#	elif gender == "female" or gender == "trans male":
#		vagina = true
#		penis = false
#		penis_size = 0
#		testicles = false
#	elif gender == "intersex":
#		vagina = true
#		penis = true
#		penis_size = traits.penis_size()
#		testicles = true
#	return {'vagina':vagina, 'penis':penis, 'penis_size':penis_size, 'testicles':testicles}
#	var methods = {
#		text = _slave.get_node('Label').set_text(pset.traits['text']),
#		scale = _slave.get_node('Label').set_scale(Vector2(pset.traits['scale']['x'],pset.traits['scale']['y'])),
#		gender = _slave.gender,
#		ethnicity = _slave.ethnicity,
#		age = _slave.age,
#		traits = _slave.traits,
#		name = _slave.name,
#		height = _slave.height,
#		weight = _slave.weight,
#		torso = torso(),
#		hips = hips(),
#		butt = butt(),
#		skin_color = skin_color(),
#		tissue_color = areola_labia_color(),
#		hair_color = hair_color(),
#		eye_color = traits.eye_color(),
#		chest = chest(),
#		genitals = genitals(),
#		intelligence = math.gaussian(100,25),
#		devotion = math.gaussian(-50,25),
#		trust = math.gaussian(-50,25),
#		health = math.gaussian(40,12),
#		face = math.gaussian(5,3),
#		sexuality = math.gaussian(10,10),
#		social = math.gaussian(5,10),
#		education = math.gaussian(0,10),
#		domestic = math.gaussian(-2,10),
#		combat = math.gaussian(-5,10)}
