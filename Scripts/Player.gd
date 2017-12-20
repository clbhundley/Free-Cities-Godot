extends Control

# Everything here should probably go in a GLOBALS script.

var money = 0
var slaves = {}
var slavelist = []
var week = 0

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func next_week():
	for slave in slaves.values():
		assignment_report(slave)
	week += 1

func assignment_report(slave):
	# do slave stuff
	print(str(slave))
