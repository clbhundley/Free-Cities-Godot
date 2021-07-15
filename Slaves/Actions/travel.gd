extends Node

onready var _slave = get_parent().get_parent()

var current_time = 0
var total_time

const TRAVEL_SPEED = 30

enum {WAITING, ELEVATOR, LATERAL, RADIAL}

func display_action():
	owner.get_node('UI/Activity/Action').set_text("Traveling")

func location(section):
	return ArcUtils.parse_address(_slave.location)[section]

func destination(section):
	return ArcUtils.parse_address(_slave.destination)[section]

func tick():
	if not _slave.travel_mode:
		update_travel_mode()
	if _slave.travel_mode == WAITING:
		waiting()
	elif _slave.travel_mode == ELEVATOR:
		elevator()
	elif _slave.travel_mode == LATERAL:
		lateral()
	elif _slave.travel_mode == RADIAL:
		radial()
	_slave.get_node("UI").display_location() #every tick?

func update_travel_mode():
	if location("address") == destination("address"):
		arrival()
	elif location("terra") != destination("terra"):
		if location("ring") == 1:
			_slave.travel_mode = LATERAL
		else:
			_slave.travel_mode = WAITING
	elif location("ring") != destination("ring"):
		_slave.travel_mode = LATERAL
	else:
		_slave.travel_mode = RADIAL

func waiting():
	if not total_time:
		total_time = math.gaussian(45,6)
		#_slave.get_node('UI/Activity/ProgressBar').max_value = total_time
	if current_time < total_time:
		step("Waiting on Elevator")
	else:
		_slave.travel_mode = ELEVATOR
		total_time = null
		current_time = 0

func elevator():
	if not total_time:
		var distance = abs(location("terra") - destination("terra"))
		total_time = distance * TRAVEL_SPEED
		#_slave.get_node('UI/Activity/ProgressBar').max_value = total_time
	elif current_time < total_time:
		step("Using Elevator")
	else:
		_slave.location = ArcUtils.to_address(destination("terra"),0,location("sector"))
		total_time = null
		current_time = 0
		update_travel_mode()

func lateral():
	var new_address = ArcUtils.to_address(location("terra"),abs(location("ring")-1),location("sector"))
	if not total_time:
		total_time = TRAVEL_SPEED
		#_slave.get_node('UI/Activity/ProgressBar').max_value = total_time
	if current_time < total_time:
		step("Traveling")
	else:
		_slave.location = new_address
		total_time = null
		current_time = 0
		update_travel_mode()

func radial():
	var new_address = ArcUtils.to_address(location("terra"),location("ring"),destination("sector"))
	if not total_time:
		var distance = 6-abs(6-abs(location("sector")-destination("sector")))
		total_time = distance * TRAVEL_SPEED
		#_slave.get_node('UI/Activity/ProgressBar').max_value = total_time
	if current_time < total_time:
		step("Traveling")
	else:
		_slave.location = new_address
		total_time = null
		current_time = 0
		update_travel_mode()

func arrival():
	_slave.travel_mode = null
	_slave.destination = null
	_slave.get_node('UI/Activity/Time').set_text("")
	_slave.get_node('UI/Activity/Action').set_text("Arriving at destination")
	_slave.get_node('Assignments/'+_slave.assignment).next_action()

func step(action_text):
	current_time += 1 * time.scale
	if action_text:
		_slave.get_node('UI/Activity/Action').set_text(action_text)
	#_slave.get_node('UI/Activity/ProgressBar').set("value",current_time)
	#_slave.get_node('UI/Activity/Time').set_text(math.time_remaining(current_time,total_time))
