extends Node

onready var _slave = owner

var signals = ['minute','hour','day','week','quarter','year']

export(Curve) var belly_size

func _ready():
	if _slave.health > 0 and not _slave.for_sale and _slave.pregnancy:
		yield(_slave,"ready")
		update_belly_size()
		advance_pregnancy()

func activate():
	time.connect('day',self,'day')

func deactivate():
	disconnect_all()

func disconnect_all():
	for _signal in signals:
		if time.is_connected(_signal,self,_signal):
			time.disconnect(_signal,self,_signal)

func update_belly_size():
	var baby_weight = _slave.pregnancy['babies'] * 25
	var body_weight = 0.0
	var total_weight = [
		_slave.model.weight,
		_slave.model.weight_round,
		_slave.model.weight_pear,
		_slave.model.weight_fat]
	for weight in total_weight:
		body_weight += weight
	var progress = (float(get_days_pregnant()+baby_weight)/body_weight) / 425
	_slave.model.pregnant = belly_size.interpolate(progress)

func advance_pregnancy():
	var due = _slave.pregnancy['due']
	var current = time.get_timestamp()
	var total_time = time.get_total_time(current,due)
	for i in total_time:
		if sign(total_time[i]) == -1:
			delivery()
			return
	var time_remaining
	for _time in signals:
		if current[_time] < due[_time]:
			time_remaining = _time
	if ['week','quarter','year'].has(time_remaining):
		time_remaining = 'day'
	if get_days_till_due() < 2 and get_hours_till_due() < 42:
		time_remaining = 'hour'
	if time_remaining:
		disconnect_all()
		time.connect(time_remaining,self,time_remaining)

func day():
	update_belly_size()
	if _slave.model.weight < 1:
		_slave.model.weight += 0.0002
	else:
		_slave.model.weight_fat += 0.0002
	_slave.model.breasts_growth += 0.00001
	_slave.model.waist_size += 0.000005
	if get_days_till_due() < 2 and get_hours_till_due() < 42:
		disconnect_all()
		time.connect('hour',self,'hour')

func hour():
	if get_hours_till_due() < 18:
		pass #time.connect('minute',self,'minute')
	if get_hours_till_due() < 1:
		delivery()

func minute():
	return

func delivery():
	var babies:String
	match int(_slave.pregnancy['babies']):
		1:
			babies = "a baby"
		2:
			babies = "twins"
		3:
			babies = "triplets"
		4:
			babies = "quadruplets"
		5:
			babies = "quintuplets"
	NAVI.say(
		_slave.name+" delivered "+babies+
		"\n"+" @ "+str(time.get_timestamp()))
	_slave.model.pregnant = 0
	_slave.pregnancy = null
	_slave.get_node("UI/StatsDisplay").refresh()
	disconnect_all()

func get_days_pregnant():
	var conceived = _slave.pregnancy['conceived']
	var current_time = time.get_timestamp()
	var time_pregnant = time.get_total_time(conceived,current_time)
	var days_pregnant = time_pregnant['days']
	days_pregnant += time_pregnant['weeks']*7
	days_pregnant += time_pregnant['quarters']*13*7
	return days_pregnant

func get_days_till_due():
	var current = time.get_timestamp()
	var due = _slave.pregnancy['due']
	var time_till_due = time.get_total_time(current,due)
	var days_till_due = time_till_due['days']
	days_till_due += time_till_due['weeks']*7
	days_till_due += time_till_due['quarters']*13*7
	return days_till_due

func get_hours_till_due():
	var current = time.get_timestamp()
	var due = _slave.pregnancy['due']
	var time_till_due = time.get_total_time(current,due)
	var days_till_due = time_till_due['days']
	var hours_till_due = time_till_due['hours']
	return hours_till_due + (days_till_due*24)
