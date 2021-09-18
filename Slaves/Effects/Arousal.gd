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
	if _slave.arousal < 100:
		if _slave.libido < 25:
			_slave.arousal += 0.0004 * time.scale
		elif _slave.libido < 50:
			_slave.arousal += 0.0005 * time.scale
		elif _slave.libido < 75:
			_slave.arousal += 0.0006 * time.scale
		elif _slave.libido < 125:
			_slave.arousal += 0.0007 * time.scale
		elif _slave.libido < 150:
			_slave.arousal += 0.0008 * time.scale
		elif _slave.libido < 175:
			_slave.arousal += 0.0009 * time.scale
		elif _slave.libido >= 175:
			_slave.arousal += 0.001 * time.scale
