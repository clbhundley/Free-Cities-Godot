extends Node

onready var _slave = get_parent().get_parent()

var current_time = 0
var total_time

var interacting_with

func display_action():
	_slave.get_node('UI/Activity/Action').set_text("Seeking sex")

func tick():
	if current_time == 0:
		start()
	elif current_time < total_time:
		step()
	else:
		finish()

func start():
	var slaves_in_proximity = SlaveUtils.slaves_in_proximity(_slave).size()
	total_time = int(max(abs(math.gaussian(1,1)),1)*slaves_in_proximity)
	interacting_with = null
	find_sex_partner()
	if interacting_with:
		seize_target_slave(interacting_with)
	display_action()
	step()

func step():
	current_time += 1 * time.scale
	_slave.arousal = min(_slave.arousal + 0.2*time.scale,100)

func finish():
	current_time = 0
	if interacting_with:
		initiate_sex(interacting_with)
	else:
		_slave.action = _slave.get_node('Actions/Masturbation')

func reset():
	current_time = 0
	total_time = null
	if get('interacting_with'):
		interacting_with = null

func find_sex_partner():
	var ranked_slaves = SlaveUtils.proximity_affinity(_slave)
	#remove negative values here
	for target_slave in ranked_slaves:
		var target_slave_name = target_slave.keys()[0]
		target_slave = SlaveUtils.get_slave(target_slave_name)
		var desire = SlaveUtils.desire(target_slave,_slave)
		var having_sex
		if target_slave.action.name == "Sex":
			having_sex = true
		var sleeping
		if target_slave.action.name == "Sleeping":
			sleeping = true
		var roll = randi()%100
		if not having_sex:
			if desire >= 20 and not sleeping:
				interacting_with = target_slave_name
			elif desire >= 10:
				if roll <= 75:
					interacting_with = target_slave_name
			elif desire > -10:
				if roll <= 50:
					interacting_with = target_slave_name
			elif desire > -20:
				if roll <= 25:
					interacting_with = target_slave_name

func seize_target_slave(target_slave_name):
	var target_slave = SlaveUtils.get_slave(target_slave_name)
	target_slave.action = target_slave.get_node("Actions/Idle")
	target_slave.action.total_time = total_time + 1
	target_slave.is_awake = true

func initiate_sex(target_slave_name):
	var target_slave = SlaveUtils.get_slave(target_slave_name)
	var interaction = SlaveUtils.dominance_interaction(_slave,target_slave)
	var dominant_slave = [_slave,target_slave][interaction]
	var submissive_slave = [_slave,target_slave][abs(interaction-1)]
	var dominant_slave_choice = dominant_slave.sexual_preferences.slave_choice
	var duration = max(math.gaussian(300,50),120)
	if dominant_slave_choice['role'] == "giving":
		if dominant_slave_choice['type'] == 'vaginal':
			if ["Male","Trans female"].has(submissive_slave.gender): #intersex?
				dominant_slave_choice['type'] = "anal"
	for __slave in [dominant_slave,submissive_slave]:
		__slave.action = __slave.get_node('Actions/Sex')
		__slave.action.reset()
		__slave.action.type = dominant_slave_choice['type']
		__slave.action.total_time = duration
	dominant_slave.action.interacting_with = submissive_slave.name
	dominant_slave.action.role = dominant_slave_choice['role']
	submissive_slave.action.interacting_with = dominant_slave.name
	if dominant_slave_choice['role'] == "giving":
		submissive_slave.action.role = "receiving"
	else:
		submissive_slave.action.role = "giving"
