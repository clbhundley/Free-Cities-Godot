extends Control



func _ready():
	pass

func _on_Quit_pressed():
	get_tree().change_scene("res://Main Menu/main menu.tscn")


func _on_Arcology_pressed():
	get_tree().change_scene("res://Arcology/spatial.tscn")


func _on_Slaves_pressed():
	get_tree().change_scene("res://Slaves/display slaves.tscn")
