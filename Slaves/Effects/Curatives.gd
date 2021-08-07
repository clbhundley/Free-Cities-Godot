extends Node

onready var _slave = owner

func _ready():
	if not _slave.for_sale:
		if _slave.regimen.has("Curatives"):
			activate()

func activate():
	if not time.is_connected("minute",self,"minute"):
		time.connect("minute",self,"minute")

func deactivate():
	if time.is_connected("minute",self,"minute"):
		time.disconnect("minute",self,"minute")

func minute():
	if _slave.assignment == "Resting":
		_slave.health += 0.001
	else:
		_slave.health += 0.0005
