extends Node

onready var player = get_node("/root/Game/Control/Player")
onready var slaves_ui = get_node("/root/Game/Control/UI/slaves_ui")

onready var slaves = player.slaves
onready var slavelist = player.slavelist

var rand_color = null
var wew1 = null
var age_gen = null
var haircolor_gen = null
var rand_haircolor = null
var randfirst_name = null
var randlast_name = null
var rand_name = null

func _ready():
	for i in slaves.keys():
		print()
		print()
		print(i)
		print()
		for k in slaves[i]:
			print(k + " : " + str(slaves[i][k]))
	
	pass