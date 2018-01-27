extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("Week").set_text("Week: " + str(game.week))


func _on_End_Week_pressed():
	game.end_week()
	