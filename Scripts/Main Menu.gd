extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _on_NEW_GAME_pressed():
	get_tree().change_scene("res://Scenes/GAME.tscn")

func _on_QUIT_pressed():
	get_tree().quit()
