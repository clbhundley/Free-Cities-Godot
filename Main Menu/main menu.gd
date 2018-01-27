extends Control

func _ready():
	gui.hide()
	
func _on_new_game_pressed():
	gui.show()
	game.week = 0
	game.end_week()
	get_tree().change_scene("res://game.tscn")

func _on_quit_pressed():
	get_tree().quit()
