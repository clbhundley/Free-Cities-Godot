extends Camera

onready var default_position = global_transform
onready var light = get_parent().get_node("OmniLight")
onready var slave_scene = SlaveUtils.get_slave_scene()
onready var slaves_camera = slave_scene.get_node("Camera")

func activate():
	var transform_start = get_viewport().get_camera().global_transform
	var transform_end = global_transform
	slave_scene.get_node("Examine Slave").activate(get_parent())
	current = true
	slaves_camera.hide()
	light.show()
	$Tween.interpolate_property(
		self,
		'global_transform',
		transform_start,
		transform_end,
		0.8,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT)
	$Tween.start()

func deactivate(reset_dock_mode=true):
	var transform_start = global_transform
	var transform_end = slaves_camera.global_transform
	slave_scene.get_node("Examine Slave").deactivate(reset_dock_mode)
	for node in get_tree().get_nodes_in_group("Active Slaves"):
		node.remove_from_group("Active Slaves")
		node.show()
	slaves_camera.current = true
	slaves_camera.show()
	light.hide()
	slave_scene.slide_camera()
#	$Tween.interpolate_property(
#		slaves_camera,
#		'global_transform',
#		transform_start,
#		transform_end,
#		0.8,
#		Tween.TRANS_CUBIC,
#		Tween.EASE_OUT)
#	$Tween.start()
	#game.get_gui().get_node("Dock").set_mode("ManageSlaves")
	#global_transform = default_position
