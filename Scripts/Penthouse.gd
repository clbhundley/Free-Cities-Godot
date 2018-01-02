extends Spatial

var camrot = 0.0
var previous = []


func _input(event):
	
	if (event.type == InputEvent.MOUSE_MOTION):
		if (event.button_mask & BUTTON_MASK_RIGHT):
			camrot += event.relative_x * 0.003
			get_node("cambase").set_rotation(Vector3(0, camrot, 0))
			print("camrot ", camrot)


func _ready():
	set_process_input(true)
