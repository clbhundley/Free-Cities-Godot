extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#get_parent().get_parent().get_node('Camera').current = true
	#get_tree().get_root().get_camera().translation = Vector3(0,0,7)
	#print(get_tree().get_root().get_camera().translation)
	
	#update_display()


func update_display():
	var i = 0
	translation.x = 2.37
	translation.y = -4.62
	for node in get_children():
		i += 5
		node.translation.x = i
		node.translation.y = 5.9
		node.tracking()
