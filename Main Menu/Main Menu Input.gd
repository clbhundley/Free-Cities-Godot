extends Node

onready var saves = get_node('../Saves')
onready var options = get_node('../Options')
onready var new_game = get_node('../New Game')

func _input(event):
	if event.is_action_pressed('ui_back') or event.is_action_pressed('ui_cancel'):
		for node in [saves, options, new_game]:
			if node.is_visible_in_tree():
				node.hide()

func _on_New_Game_pressed():
	new_game.show()

func _on_Load_Game_pressed():
	saves.show()

func _on_Options_pressed():
	options.show()

func _on_Exit_pressed():
	get_tree().quit()

func _on_New_Game_Back_pressed():
	new_game.hide()
