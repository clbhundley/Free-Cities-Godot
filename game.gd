extends Control

var week = 0
var km_limit = gaussian(10,2)
var km_list = {}

func gaussian(mean, deviation):
	randomize()
	var x1 = null
	var x2 = null
	var w = null
	while true:
		x1 = rand_range(0, 2) - 1
		x2 = rand_range(0, 2) - 1
		w = x1*x1 + x2*x2
		if 0 < w && w < 1:
			break
	w = sqrt(-2 * log(w)/w)
	return floor(mean + deviation * x1 * w)

func end_week():
	week += 1
	gui.get_node("Week").set_text("Week: " + str(game.week))
	km_limit = gaussian(10,2)
	km_list.clear()
	for i in range(km_limit):
		slaves.new_slave.default()
		slaves.new_slave.add_slave_to(km_list)


func _ready():
	pass

func _on_Quit_pressed():
	get_tree().change_scene("res://Main Menu/main menu.tscn")

func _on_Arcology_pressed():
	get_tree().change_scene("res://Arcology/spatial.tscn")

func _on_Slaves_pressed():
	get_tree().change_scene("res://Slaves/slaves.tscn")
