extends Node

onready var _slave = owner

var selected:int

enum {
	NONE,
	FEMALE,
	INTENSIVE_FEMALE,
	MALE,
	INTENSIVE_MALE}

func _ready():
	load_hormones()

func load_hormones():
	if _slave.regimen.has("HormonesFemale"):
		selected = FEMALE
	if _slave.regimen.has("HormonesFemaleIntensive"):
		selected = INTENSIVE_FEMALE
	if _slave.regimen.has("HormonesMale"):
		selected = MALE
	if _slave.regimen.has("HormonesMaleIntensive"):
		selected = INTENSIVE_MALE
	else:
		selected = NONE
	var effects = get_node("../../")
	effects.activate(self,"hour")

func hour():
	var masculinity_change := 0.0
	match selected:
		NONE:
			pass
		FEMALE:
			masculinity_change = -0.00002
		INTENSIVE_FEMALE:
			_slave.health -= 0.00004
			masculinity_change = -0.00005
		MALE:
			masculinity_change = 0.00002
		INTENSIVE_MALE:
			_slave.health -= 0.00004
			masculinity_change = 0.00005
	if masculinity_change == 0:
		return
	if _slave.regimen.has("HormoneEnhancers"):
		masculinity_change *= 2
	_slave.model.masculinity += masculinity_change
