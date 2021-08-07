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
	if _slave.bathroom < 100:
		if _slave.is_awake:
			_slave.bathroom += 0.0036 * time.scale
		else:
			_slave.bathroom += 0.0026 * time.scale
