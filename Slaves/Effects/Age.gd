extends Node

onready var _slave = get_parent().get_parent()

func _ready():
	activate()

func activate():
	if not time.is_connected("day",self,"day"):
		time.connect("day",self,"day")

func deactivate():
	if time.is_connected("day",self,"day"):
		time.disconnect("day",self,"day")

func day():
	birthday()

func birthday():
	if time.quarter == _slave.birthday["quarter"]:
		if time.week == _slave.birthday["week"]:
			if time.day == _slave.birthday["day"]:
				_slave.age += 1
				fertility_age_adjustment()
				if not _slave.for_sale:
					NAVI.say("It's "+_slave.name+"'s birthday!")

export(Curve) var fertility_decline
func fertility_age_adjustment():
	if _slave.age >= 30:
		var age_factor = (_slave.age-30)*0.05
		var prev_age_factor = (_slave.age-31)*0.05
		var interpolation = fertility_decline.interpolate(age_factor)
		var prev_interpolation = fertility_decline.interpolate(prev_age_factor)
		var orig_fertility = (1/prev_interpolation)*_slave.fertility
		_slave.fertility = orig_fertility*interpolation
