extends Control

func _ready():
	get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'tick')
	for i in range(abs(game.gaussian(3,1))):
		var preset = "kidnappers market"
		get_node('Slider/HBoxContainer').add_child(get_node('New Slave').new(preset),true)
	tick()

func tick():
	get_node('Header/HBoxContainer/Number').set_text(str(get_node('Slider/HBoxContainer').get_child_count())+" Slaves Owned")

func _on_Buy_Slaves_pressed():
	get_node('Header').hide()
	get_node('Slider').hide()
	get_node('Availability').show()

func reset_scene():
	for nodes in get_children():
		nodes.hide()
	get_node('Header').show()
	get_node('Slider').show()
	get_tree().get_root().get_node('Game/Background').color_filter('82000000')
