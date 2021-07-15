extends Node

onready var _slave = owner

func _ready():
	if not _slave.for_sale:
		time.connect("minute",self,"minute")

func deactivate():
	if time.is_connected("tick",self,"tick"):
		time.disconnect("tick",self,"tick")

func minute():
	if _slave.health > 100:
		if not _slave.regimen.has("Preventatives"):
			_slave.health -= 0.0002
	
	
	
#	if s.health < 200:
#		s.health += 1
	
#	if s.is_awake:
#		if s.health <= 0: #Deceased
#			pass
#
#		elif s.health < 10: #Near death
#			s.happiness -= 0.005
#			if s.fatigue > 10:
#				s.fatigue -= 0.005
#
#		elif s.health < 20: #Extremely unhealthy
#			s.happiness -= 0.004
#			if s.fatigue > 20:
#				s.fatigue -= 0.004
#
#		elif s.health < 30: #Very unhealthy
#			s.happiness -= 0.003
#			if s.fatigue > 30:
#				s.fatigue -= 0.003
#
#		elif s.health < 40: #Unhealthy
#			s.happiness -= 0.002
#			if s.fatigue > 40:
#				s.fatigue -= 0.002
#
#		elif s.health < 50: #Somewhat unhealthy
#			s.happiness -= 0.001
#			if s.fatigue > 50:
#				s.fatigue -= 0.001
#
#		elif s.health < 60: #Healthy
#			s.happiness += 0.001
#
#		elif s.health < 80: #Very healthy
#			s.happiness += 0.002
##			if s.fatigue < 50:
##				s.fatigue += 0.001
#
#		elif s.health < 100: #Extremely healthy
#			s.happiness += 0.003
##			if s.fatigue < 60:
##				s.fatigue += 0.003
#
#		elif s.health < 110: #Perfectly healthy
#			s.happiness += 0.004
##			if s.fatigue < 80:
##				s.fatigue += 0.004
#
#		elif s.health >= 110: #Unnaturally healthy
#			s.happiness += 0.005
##			if s.fatigue < 100:
##				s.fatigue += 0.005
