extends Control

var region = "Asia"

func new(preset=null,selling=false):
	randomize()
	
	var _slave = load('res://Slaves/Slave.tscn').instance()
	
	if not _slave.ethnicity:
		_slave.ethnicity = _ethnicity(region)
	var traits = load('res://Slaves/Ethnicities/%s.gd'%_slave.ethnicity.to_lower()).traits()
	var presets = load('res://Slaves/Presets/%s.gd'%preset).presets()
	
	_slave.for_sale = selling
	
	if preset:
		for setting in presets.keys():
			_slave.set(setting, presets[setting])
	
	for trait in traits.keys():
		_slave.set(trait, traits[trait])
	
	_slave.is_awake = true
	
	if not _slave.age:
		_slave.age = randi() %41+18
	if not _slave.gender:
		_slave.gender = _gender()
	if _slave.gender == "Male" or _slave.gender == "Trans female":
		_slave.vagina = false
		_slave.penis = true
		_slave.penis_size = traits['penis_size']
		_slave.testicles_size = 1
	elif _slave.gender == "Female" or _slave.gender == "Trans male":
		_slave.vagina = true
		_slave.penis = false
		_slave.penis_size = 0
		_slave.testicles_size = 0
	elif _slave.gender == "Intersex":
		_slave.vagina = true
		_slave.penis = true
		_slave.penis_size = traits['penis_size']
		_slave.testicles_size = 1
	
	if not _slave.skin_color:
		_slave.skin_color = skin_color(traits)
	if not _slave.chest:
		_slave.chest = chest(traits,_slave)
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
		_slave.figure = math.gaussian(0,62)
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

func chest(traits,_slave): # http://www.averageheight.co/breast-cup-size-by-country
	var cup_sizes = ["AA","A","B","C","D","DD","E","F","FF","G","GG","H","HH","J","JJ","K"]
	var band_size = int(traits.breast_size['chest_size'])
	var bust_size = math.gaussian(band_size+traits.breast_size['breast_size'],traits.breast_size['breast_variation'])
	if bust_size < band_size:
		bust_size = band_size
	var cup = bust_size - band_size
	if cup > 10:
		cup = 10
	if band_size % 2 == 0:
		band_size += 4
	else:
		band_size += 5
	if _slave.gender == "male" or _slave.gender == "trans male":
		return {'band':band_size,'cup':"flat"}
	return {'band':band_size,'cup':cup_sizes[cup]}

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

func torso(_slave):
	var types = ["normal", "hourglass"] # "unnatural" not in use
	if _slave.gender == "male" or _slave.gender == "trans man":
		return "normal"
	return types[randi()%types.size()+0]

func hips(_slave):
	var types = ["normal", "thin", "wide"]
	if _slave.gender == "male" or _slave.gender == "trans man":
		return "thin"
	return types[randi()%types.size()+0]

func butt():
	var types = ["small", "normal", "large", "very large"]
	return types[randi()%types.size()+0]

func skin_color(traits):
	var colors = {
	'tanned':['e0ac69','ffcd94','ffad60'],
	'brown':['9b6b39','805d38','6e4c25'],
	'dark_brown':['522500','7c501a','9c7248'],
	'black':['2d241c','221c17','1c1712']}
	return ['ffe39f','dec676','ceb563'][randi()%3+0]

func areola_labia_color(traits):
	var colors = {
	'pink':'d76b93',
	'dark':'7a3d00'}
	return colors[traits.areola_labia_color()]

func hair_color(traits,_slave):
	var colors = {
	'black':'000000',
	'brown':'905424',
	'red':'5e0808',
	'blonde':'fde968',
	'grey':'8e8e8e',
	'dyed':null}
	var dyes = [
	'fcf3c1', # platinum blonde
	'e62c2c', # red
	'e6da2c', # yellow
	'37e62c', # green
	'2ce6e1', # ice
	'2c75e6', # blue
	'512ce6', # purple
	'a32ce6', # violet 
	'e62c9d',] # pink
	var is_dyed = randi()%50+0
	if _slave.age >= 50:
		return colors['grey']
	elif is_dyed < 10:
		return dyes[randi()%dyes.size()+0]
	else:
		return colors[traits.hair_color()]

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

func _voice(gender):
	var voice = ["Deep voice", "Male voice", "Female voice", "High voice", "Mute"]
	var accent = ["Ugly", "Cute", "Pretty", "Exotic"]
	var roll
	roll = randi()%100+0
	if roll == 51:
		return "Mute"
	if gender == "Male":
		roll = randi()%2+0
		return voice[roll]
	if gender == "Female":
		roll = randi()%3+2
		return voice[roll]
	if gender == "Trans male":
		roll = randi()%3+1
		return voice[roll]
	if gender == "Trans female":
		roll = randi()%3+0
		return voice[roll]
	if gender == "Intersex":
		roll = randi()%4+0
		return voice[roll]

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
