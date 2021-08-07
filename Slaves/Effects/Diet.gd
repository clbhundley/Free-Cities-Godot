extends Node

onready var _slave = owner

var selected:int

enum {
	HEALTHY,
	LOSE_WEIGHT,
	GAIN_WEIGHT,
	BUILD_MUSCLE}

func _ready():
	if not _slave.for_sale:
		load_diet()
		activate()

func activate():
	if not time.is_connected("hour",self,"hour"):
		time.connect("hour",self,"hour")

func deactivate():
	if time.is_connected("hour",self,"hour"):
		time.disconnect("hour",self,"hour")

func load_diet():
	match _slave.diet:
		"Healthy":
			selected = HEALTHY
		"Lose Weight":
			selected = LOSE_WEIGHT
		"Gain Weight":
			selected = GAIN_WEIGHT
		"Build Muscle":
			selected = BUILD_MUSCLE

func hour():
	var weight_change := 0.0
	match selected:
		HEALTHY:
			_slave.health += 0.00002
		LOSE_WEIGHT:
			_slave.health += 0.00001
			weight_change = -0.00008
		GAIN_WEIGHT:
			_slave.health += 0.00003
			weight_change = 0.00008
		BUILD_MUSCLE:
			_slave.health += 0.00004
			_slave.bodybuilder += 0.00004
			_slave.body_size += 0.00004
	if weight_change == 0:
		return
	elif _slave.model.weight < 1:
		_slave.model.weight += weight_change
	else:
		var body_fat_types = [
			_slave.model.weight_round,
			_slave.model.weight_pear,
			_slave.model.weight_fat]
		var weight_total = 0.0
		for body_fat in body_fat_types:
			weight_total += body_fat
		var round_total = _slave.model.weight_round / weight_total
		var pear_total = _slave.model.weight_pear / weight_total
		var fat_total = _slave.model.weight_fat / weight_total
		#print("round_total ",weight_change * round_total)
		_slave.model.weight_round += weight_change * round_total
		#print("pear_total ",weight_change * pear_total)
		_slave.model.weight_pear += weight_change * pear_total
		#print("fat_total ",weight_change * fat_total)
		_slave.model.weight_fat += weight_change * fat_total
