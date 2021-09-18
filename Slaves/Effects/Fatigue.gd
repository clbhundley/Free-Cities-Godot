extends Node

onready var _slave = owner

func _ready():
	if not _slave.for_sale:
		activate()

func activate():
	if not time.is_connected("second",self,"tick"):
		time.connect("second",self,"tick")

func deactivate():
	if time.is_connected("second",self,"tick"):
		time.disconnect("second",self,"tick")

func tick():
	if _slave.is_awake:
		if _slave.fatigue < 80:
			_slave.fatigue += 0.0014 * time.scale
		elif _slave.fatigue < 100:
			_slave.fatigue += 0.0007 * time.scale