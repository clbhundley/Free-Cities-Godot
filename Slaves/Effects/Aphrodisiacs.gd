extends Node

func _ready():
	pass

func activate():
	if not time.is_connected("minute",self,"minute"):
		time.connect("minute",self,"minute")

func deactivate():
	if time.is_connected("minute",self,"minute"):
		time.disconnect("minute",self,"minute")

func minute():
	pass
