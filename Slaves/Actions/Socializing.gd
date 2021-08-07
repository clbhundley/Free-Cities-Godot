extends Node

onready var _slave = get_parent().get_parent()

var current_time = 0
var total_time

var interacting_with

func display_action():
	owner.get_node('UI/Activity/Action').set_text("Socializing")

func tick():
	if current_time == 0:
		start()
	elif current_time < total_time:
		step()
	else:
		finish()

func start():
	total_time = abs(math.gaussian(160,10))
	display_action()
	step()

func step():
	current_time += 1 * time.scale

func finish():
	current_time = 0
	_slave.activity.action_end()
