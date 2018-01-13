extends RigidBody

var gray_mat = FixedMaterial.new()
onready var previous = get_node("/root/Game/Control/Arcology/Penthouse").previous


func _input_event(camera, event, pos, normal, shape):
	
	if (event.button_mask & BUTTON_LEFT and event.is_pressed()):
		
		for i in previous:
			get_node(i).set_material_override(null)
		
		print(str(get_name()))
		get_node("/root/Game/Control/Arcology/Label 2").set_text(get_name())
		
		get_node("mesh").set_material_override(gray_mat)
		previous.clear()
		previous.append(str(get_path()) + "/mesh")


func _mouse_enter():
	get_node("mesh").set_scale(Vector3(1.1, 1.1, 1.1))


func _mouse_exit():
	get_node("mesh").set_scale(Vector3(1, 1, 1))
