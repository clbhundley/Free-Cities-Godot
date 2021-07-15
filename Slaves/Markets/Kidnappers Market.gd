extends Spatial

var active_phase
var total_time
var current_time

func _ready():
	get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'tick')
	delivery()

func tick():
	call(active_phase)

func tba():
	if current_time == 0:
		total_time = 3600*abs(math.gaussian(2,2))
		current_time += 1
		#get_node('Header/Delivery').set_text("Delivery: TBA")
	elif current_time < total_time:
		current_time += 1
		#get_node('Header/Delivery').set_text("Delivery: TBA")
	else:
		active_phase = "timer"
		current_time = 0

func timer():
	if current_time == 0:
		total_time = 3600*abs(math.gaussian(32,4))
		current_time += 1
		#get_node('Header/Delivery').set_text("Delivery: "+math.time_remaining(current_time,total_time))
	elif current_time < total_time:
		current_time += 1
		#get_node('Header/Delivery').set_text("Delivery: "+math.time_remaining(current_time,total_time))
	else:
		active_phase = "delivery"
		current_time = 0

func delivery():
	for n in range(abs(math.gaussian(7,3))):
		add_child(get_node('../../New Slave').new("kidnappers market",true),true)
	get_node('../../').update_collection(self)
	active_phase = "tba"
	current_time = 0
