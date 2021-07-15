extends Node

onready var _slave = get_parent().get_parent()

var current_time = 0
var total_time

var interacting_with

var role
var type

func display_action():
	if not interacting_with:
		return
	var display_text
	match role:
		'giving':
			match type:
				'oral':
					display_text = "Giving oral to " + interacting_with
				'anal':
					display_text = "Anally fucking " + interacting_with
				'vaginal':
					display_text = "Fucking " + interacting_with
				'hands':
					display_text = "Using hands on " + interacting_with
				'feet':
					display_text = "Using feet on " + interacting_with
		'recieving':
			match type:
				'oral':
					display_text = "Getting oral from " + interacting_with
				'anal':
					display_text = "Getting anally fucked by "+interacting_with
				'vaginal':
					display_text = "Getting fucked by " + interacting_with
				'hands':
					display_text = "Getting off with "+interacting_with+"'s hands"
				'feet':
					display_text = "Getting off with "+interacting_with+"'s feet"
	_slave.get_node('UI/Activity/Action').set_text(display_text)

func reset():
	current_time = 0
	total_time = null
	if get('interacting_with'):
		interacting_with = null

func tick():
	if current_time == 0:
		start()
	elif current_time < total_time:
		step()
	else:
		current_time = 0
		finish()

func start():
	#total_time = int(max(abs(math.gaussian(1,1)),1)*_slave.arousal)
	display_action()
	step()

func step():
	current_time += 1 * time.scale
	_slave.arousal = min(_slave.arousal + 0.1*time.scale,100)

func finish():
	_slave.arousal = max(abs(math.gaussian(1,1)),1)
	_slave._action_ended()
