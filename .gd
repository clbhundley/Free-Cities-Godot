extends Node




var slaves = {
	Alice = {
		name = "Alice",
		nickname = null,
		age = 22,
		haircolor = "red"
	},
	Alixe2 = {
		name = "Alixe2",
		nickname = null,
		age = 23,
		haircolor = "red"
	}
}


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	
	randomize()
	var ROLL = rand_range(0,1)
	if ROLL >= 0 and ROLL < 0.3: # 30%
		var rand_color = "brown"
	elif ROLL >= 0.3 and ROLL < 0.4: # 10%
		var rand_color = "black"
	elif ROLL >= 0.4 and ROLL <= 1: # 60%
		var rand_color = "red"
	
	slaves.Mike = {
		name = "Mike",
		nickname = null,
		age = 53,
		haircolor = rand_color
	}
	
	pass
