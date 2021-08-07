extends Node

onready var _slave = owner

func _ready():
	if not _slave.for_sale:
		activate()

func activate():
	if not time.is_connected("tick",self,"tick"):
		time.connect("tick",self,"tick")

func deactivate():
	if time.is_connected("tick",self,"tick"):
		time.disconnect("tick",self,"tick")

func tick():
	if _slave.hunger < 100:
		if _slave.is_awake:
			_slave.hunger += 0.0018 * time.scale
		else:
			_slave.hunger += 0.0014 * time.scale
