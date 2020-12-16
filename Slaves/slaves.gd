extends Spatial

var cam_pos

var active_collection

func _ready():
	cam_pos = 7.0
	$Camera.current = true
	$Camera.set_translation(Vector3(cam_pos, 3.2, 5))
	for i in range(abs(math.gaussian(6,1))):
		var preset = "kidnappers market"
		get_node("Collections/Owned").add_child(get_node('New Slave').new(preset),true)
	set_active_collection("Owned")
	update_collection(active_collection)
	update_header()

func slave_count(collection):
	return get_node("Collections/"+collection).get_child_count()

func update_header():
	var header = get_tree().get_root().get_node("Game/GUI/Header/Slaves/Title")
	if active_collection.name == "Owned":
		var count = str(slave_count("Owned"))
		if slave_count("Owned") == 1:
			header.set_text(count+" Slave Owned")
		else:
			header.set_text(count+" Slaves Owned")
	elif active_collection.name == "Kidnappers Market":
		var count = str(slave_count("Kidnappers Market"))
		if slave_count("Kidnappers Market") == 1:
			header.set_text("%s Slave available"%count)
		else:
			header.set_text("%s Slaves available"%count)
	elif active_collection.name == "Neighboring Arcologies":
		var count = str(slave_count("Neighboring Arcologies"))
		if slave_count("Neighboring Arcologies") == 1:
			header.set_text("%s Slave available"%count)
		else:
			header.set_text("%s Slaves available"%count)

func _input(event):
	if not is_visible_in_tree():
		return
	var calendar = get_tree().get_root().get_node("Game/GUI//Navigation/Time/Calendar")
	if calendar.is_visible():
		return
	var min_camera_pos = 7
	var max_camera_pos = slave_count(active_collection.name) * 5.4
	if slave_count(active_collection.name) == 1:
		max_camera_pos *= 1.3
	if event.is_class("InputEventMouseMotion"): # add android swipe here?
		if event.button_mask&(BUTTON_MASK_LEFT):
			cam_pos -= event.relative.x * 0.015
	elif event.is_action_pressed('ui_page_up'):
			cam_pos -= 2
	elif event.is_action_pressed('ui_page_down'):
			cam_pos += 2
	else:
		return
	if cam_pos < min_camera_pos:
		cam_pos = min_camera_pos
	elif cam_pos > max_camera_pos:
		cam_pos = max_camera_pos
	$Tween.interpolate_method(
		$Camera,'set_translation',
		$Camera.get_translation(),
		Vector3(cam_pos, 3.2, 5),
		0.8,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT)
	$Tween.start()

func set_active_collection(collection):
	active_collection = $Collections.get_node(collection)
	for _collection in $Collections.get_children():
		_collection.hide()
		for _slave in _collection.get_children():
			_slave.ui.hide()
	for _slave in active_collection.get_children():
		_slave.ui.show()
		_slave.ui.resize()
		_slave.ui.tracking()
	update_collection(active_collection)
	active_collection.show()
	update_header()
	var min_camera_pos = 7
	var max_camera_pos = slave_count(active_collection.name) * 5.4
	if cam_pos < min_camera_pos:
		cam_pos = min_camera_pos
	elif cam_pos > max_camera_pos:
		cam_pos = max_camera_pos

const offset_x = 2.37
const offset_y = -4.62
const vertical_pos = 5.9
const horizontal_spacing = 5
func update_collection(collection):
	var horizontal_pos = 0
	collection.translation.x = offset_x
	collection.translation.y = offset_y
	for _slave in collection.get_children():
		horizontal_pos += horizontal_spacing
		_slave.translation.x = horizontal_pos
		_slave.translation.y = vertical_pos
		_slave.ui.tracking()

func _on_Tween_tween_step(object, key, elapsed, value):
	for _slave in active_collection.get_children():
		_slave.ui.tracking()
