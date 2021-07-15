extends Node

onready var _slave = owner

func _ready():
	time.connect("day",self,"day")

func day():
	if time.quarter == _slave.birthday["quarter"]:
		if time.week == _slave.birthday["week"]:
			if time.day == _slave.birthday["day"]:
				_slave.age += 1
