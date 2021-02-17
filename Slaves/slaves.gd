extends Spatial

var cam_pos = 7.0
var min_camera_pos = 7
var max_camera_pos = 0.0

var active_collection

func _ready():
	$Camera.current = true
	$Camera.set_translation(Vector3(cam_pos, 3.2, 5))
	for i in range(abs(math.gaussian(8,2))):
		var preset = "kidnappers market"
		var new_slave = get_node('New Slave').new(preset)
		new_slave.acquired =  time.get_timestamp()
		get_node("Collections/Owned").add_child(new_slave,true)
	set_active_collection("Owned")
	update_collection(active_collection)
	update_header()

func update_header():
	var header = get_tree().get_root().get_node("Game/GUI/Header/Slaves/Title")
	if active_collection.name == "Owned":
		var count = str(SlaveUtils.slave_count("Owned"))
		if SlaveUtils.slave_count("Owned") == 1:
			header.set_text(count+" Slave Owned")
		else:
			header.set_text(count+" Slaves Owned")
	elif active_collection.name == "Kidnappers Market":
		var count = str(SlaveUtils.slave_count("Kidnappers Market"))
		if SlaveUtils.slave_count("Kidnappers Market") == 1:
			header.set_text("%s Slave available"%count)
		else:
			header.set_text("%s Slaves available"%count)
	elif active_collection.name == "Neighboring Arcologies":
		var count = str(SlaveUtils.slave_count("Neighboring Arcologies"))
		if SlaveUtils.slave_count("Neighboring Arcologies") == 1:
			header.set_text("%s Slave available"%count)
		else:
			header.set_text("%s Slaves available"%count)

func set_active_collection(collection,reset_cam_pos=true):
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
	max_camera_pos = SlaveUtils.slave_count(active_collection.name)*5+0.7
	clamp_camera_position()
	if reset_cam_pos:
		cam_pos = min_camera_pos
		slide_camera()

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

func slide_camera():
	$Tween.interpolate_method(
		$Camera,'set_translation',
		$Camera.get_translation(),
		Vector3(cam_pos, 3.2, 5),
		0.8,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT)
	$Tween.start()

func clamp_camera_position():
	if cam_pos < min_camera_pos:
		cam_pos = min_camera_pos
	elif cam_pos > max_camera_pos:
		cam_pos = max_camera_pos

func _on_Tween_tween_step(object, key, elapsed, value):
	for _slave in active_collection.get_children():
		_slave.ui.tracking()
