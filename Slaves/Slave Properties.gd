extends Spatial

var age

var ethnicity

var skin_color
var tissue_color

var hair_color_natural
var hair_color
var hair_style

var gender
var genitals #use model?



#use model
var penis_size
var testicles_size
var vagina 
var chest

var fertility
var pregnancy
var pregnancy_history



var height
var weight

var health = 1 setget set_health
var fatigue
var is_awake # check if action == "Sleeping" instead?
var hunger
var bathroom
var arousal

var libido
var male_attraction
var female_attraction

var intelligence

var devotion = 0 setget set_devotion
var trust = 0 setget set_trust
var happiness = 0 setget set_happiness

var social #in use?

var face

var figure#add to flags?
var hips #use model

var voice

var sexual_skill
var oral_skill
var anal_skill
var vaginal_skill
var penis_skill

var prostitution_skill
var entertainment_skill

var combat_skill

var acquired

var diet
var diet_base
var regimen = []

var rules = []

var wardrobe = {}

var assignment
var action
var queued_action

var for_sale = false

var flags = {}

var quarters = "P5"
var location
var destination
var travel_mode

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
