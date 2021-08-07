extends Spatial

var age

var birthday

var ethnicity

var skin_color
var tissue_color

var hair_color_natural
var hair_color
var hair_style

var gender

###use model for these
#var genitals
var penis_size
var testicles_size
var vagina 
var chest

var fertility

var pregnancy
var pregnancy_history

var height
var weight

var health = 1 setget set_health #redesign to keep null value
func set_health(value):
	if health == 0:
		return
	if value < health and regimen.has("Preventatives"):
		var difference = health - value
		difference/=3
		if health > 0.01 and difference <= 3:
			health = clamp(health-difference,0.01,200)
		else:
			health = clamp(health-difference,0,200)
	else:
		health = clamp(value,0,200)
	if health == 0:
		NAVI.say(name+" DIED"+"\n"+str(time.get_timestamp()))
		call("die")

var fatigue

var hunger

var bathroom

var arousal

var personality
var dominance
var submission

var sexual_preferences = SexualPreferences.new()
class SexualPreferences:
	var giving = Giving.new()
	class Giving:
		var oral
		var anal
		var vaginal
		var hands
		var feet
	var receiving = Receiving.new()
	class Receiving:
		var oral
		var anal
		var vaginal
		var hands
		var feet
	var slave_choice setget ,get_slave_choice
	func get_slave_choice():
		var ranked_choices = []
		for role in ['giving','receiving']:
			for type in ['oral','anal','vaginal','hands','feet']:
				var pair = {role+"/"+type:get(role).get(type)}
				ranked_choices.append(pair)
		ranked_choices.sort_custom(SlaveUtils.SortByValue,"sort_descending")
		var roll = clamp(math.gaussian(0,1),0,ranked_choices.size())
		var choice = ranked_choices[roll].keys()[0].split("/")
		return {'role':choice[0],'type':choice[1]}

var libido
var male_attraction
var female_attraction

var intelligence

var devotion = 0 setget set_devotion
func set_devotion(value):
	if regimen.has("Psychosuppressants"):
		if value < devotion:
			var difference = devotion - value
			difference/=3
			devotion = clamp(devotion-difference,-100,100)
		else:
			var difference = value - devotion
			difference/=2
			devotion = clamp(devotion+difference,-100,100)
	else:
		devotion = clamp(value,-100,100)

var trust = 0 setget set_trust
func set_trust(value):
	if regimen.has("Psychosuppressants"):
		if value < trust:
			var difference = trust - value
			difference/=3
			trust = clamp(trust-difference,-100,100)
		else:
			var difference = value - trust
			difference/=2
			trust = clamp(trust+difference,-100,100)
	else:
		trust = clamp(value,-100,100)

var happiness = 0 setget set_happiness
func set_happiness(value):
	if regimen.has("Psychosuppressants"):
		if value < happiness:
			var difference = happiness - value
			difference/=3
			happiness = clamp(happiness-difference,0,100)
		else:
			var difference = value - happiness
			difference/=2
			happiness = clamp(happiness+difference,0,100)
	else:
		happiness = clamp(value,0,100)

var face
var voice

var skills = Skills.new()
class Skills:
	var oral
	var anal
	var hands
	var feet
	var vaginal
	var penetration
	var prostitution
	var entertainment
	var seduction
	var cleaning
	var cooking
	var medical
	var combat
	var music
	var sexual_total setget ,get_sexual_total
	func get_sexual_total():
		var sexual_skill = 0
		for skill in ['oral','anal','hands','feet','vaginal','penetration']:
			sexual_skill += get(skill)
		return sexual_skill

var acquired

var diet
var diet_base
var regimen = []

var rules = {}

var wardrobe = {}

var assignment
var action
var queued_action

var for_sale = false

var is_awake

var flags = {}

var quarters = "P5"
var location
var destination
var travel_mode
