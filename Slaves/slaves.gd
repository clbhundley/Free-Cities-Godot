extends Spatial

var cam_pos

#func _ready():
#	get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'tick')
#	for i in range(abs(math.gaussian(3,1))):
#		var preset = "kidnappers market"
#		get_node('Slider/HBoxContainer').add_child(get_node('New Slave').new(preset),true)
#	tick()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect('size_changed',self,'resize')
	$Camera.current = true
	cam_pos = 7.0
	#$SpotLight2.set_translation(Vector3(cam_pos, 1.6, 8))
	#$SpotLight3.set_translation(Vector3(cam_pos, 16, -10))
	$Camera.set_translation(Vector3(cam_pos, 3.2, 5))
	#$OmniLight.set_translation(Vector3(-1*cam_pos, 4, 6))
	#$Owned.set_translation(Vector3(3, -4, 0))
	
	#get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'tick')
	for i in range(abs(math.gaussian(6,1))):
		var preset = "kidnappers market"
		get_node('Owned').add_child(get_node('New Slave').new(preset),true)
	get_node('Owned').update_display()
	#tick()
	resize()

func resize():
	for node in $Owned.get_children():
		node.tracking()

var tweening = false
func _input(event):
	if not is_visible_in_tree():
		return
	var calendar = get_tree().get_root().get_node("Game/GUI//Navigation/Time/Calendar")
	if calendar.is_visible():
		return
	
	var count = $Owned.get_child_count()
	
	var min_camera_pos = 7
	var max_camera_pos = count * 5.4
	if count == 1:
		max_camera_pos *= 1.3
	
	if event.is_class("InputEventMouseMotion"): # add android swipe here?
		if event.button_mask&(BUTTON_MASK_LEFT):
			cam_pos -= event.relative.x * 0.015
	elif event.is_action_pressed('ui_page_up'):
		#if cam_pos < min_length:
			cam_pos -= 2
	elif event.is_action_pressed('ui_page_down'):
		#if cam_pos > max_length:
			cam_pos += 2
	else:
		return
	
	#var siblings = 
	if cam_pos < min_camera_pos:
		cam_pos = min_camera_pos
	elif cam_pos > max_camera_pos:
		cam_pos = max_camera_pos
	
	#print("CAMERA POSITION: ",cam_pos)
	
	$Tween.interpolate_method(
		$Camera,'set_translation',
		$Camera.get_translation(),
		Vector3(cam_pos, 3.2, 5),
		0.8,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT)
	$Tween.start()
	

func _on_Tween_tween_step(object, key, elapsed, value):
	for node in $Owned.get_children():
		node.tracking()
