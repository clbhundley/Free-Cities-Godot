extends "res://Slaves/Slaves Input.gd"

func _init():
	game.slaves = self

func _ready():
	retrieve_index()
	update_index()
	generate_price_history()
	$Camera.current = true
	$Camera.set_translation(Vector3(cam_pos, 3.2, 5))
	time.connect("day",self,"price_fluctuation")
	for _slave in abs(math.gaussian(8,2)):
		var preset = "kidnappers market"
		var new_slave = get_node('New Slave').new(preset)
		new_slave.acquired = time.get_timestamp()
		get_node("Collections/Owned").add_child(new_slave,true)
	set_active_collection("Owned")

var active_collection:Node
func set_active_collection(collection_name,reset_cam_pos=true):
	if not collection_name:
		game.gui.get_node("Header/Slaves/Title").hide()
		for collection in $Collections.get_children():
			collection.hide()
			for _slave in collection.get_children():
				_slave.ui.hide()
		return
	active_collection = $Collections.get_node(collection_name)
	unload_collection('Kidnappers Market')
	unload_collection('Neighboring Arcologies')
	match collection_name:
		'Kidnappers Market','Neighboring Arcologies':
			load_collection(collection_name)
	for collection in $Collections.get_children():
		collection.hide()
		for _slave in collection.get_children():
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

func load_collection(collection):
	var collection_node = $Collections.get_node(collection)
	var available_slaves = "user://Data/Slot %s/Slaves/Markets/%s"
	var files = data.list_contents(available_slaves%[data.save_slot,collection])
	for file in files:
		var path = available_slaves+"/%s"
		var slave_file = path%[data.save_slot,collection,file]
		var slave_data = data.json_parse(slave_file)
		var _slave = load('res://Slaves/Slave.tscn').instance()
		_slave.name = file.get_basename()
		_slave._load(slave_data)
		collection_node.add_child(_slave,true)
	update_collection(collection_node)
	var renamed_collection = collection.replace(" ","")
	game.gui.get_node("SidePanel").get_node(renamed_collection).refresh()

func unload_collection(collection):
	var collection_node = $Collections.get_node(collection)
	for _slave in collection_node.get_children():
		collection_node.remove_child(_slave)
		_slave.queue_free()

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

func update_header():
	var header = game.gui.get_node("Header/Slaves/Title")
	header.show()
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

var price := 1.3
var median_price := 1.0
var minimum_price := 0.2
var trend := 0.0
var trend_strength := 0.05
var volatility := 0.025
func price_fluctuation():
	if randi()%3 != 0:
		store_price()
		return
	var increment = clamp(trend,-trend_strength,trend_strength)
	var change = math.gaussian_float(increment,volatility)
	var deviation = -median_price + price
	if abs(deviation) > randf() and not trend:
		if randi()%3 != 0:
			change = abs(change) * -sign(deviation)
	if stepify(trend,0.1) == 0:
		trend = 0
	elif sign(trend) == -1:
		trend += 0.03
	else:
		trend -= 0.03
	price = max(price+change,minimum_price)
	store_price()
	update_index()

func store_price():
	var file = File.new()
	var price_data_path = "user://Data/Slot %s/Slaves/price history.a32"
	file.open(price_data_path%data.save_slot,file.READ_WRITE)
	file.seek_end()
	file.store_32(price*1000000)
	file.close()

func generate_price_history():
	var file = File.new()
	var price_data_path = "user://Data/Slot %s/Slaves/Price History.a32"
	if not file.file_exists(price_data_path%data.save_slot):
		file.open(price_data_path%data.save_slot,file.WRITE)
		file.close()
		price = 4
		trend = -65
		trend_strength = 0.0012
		for i in 10000:
			price_fluctuation()
		trend_strength = 0.05

func retrieve_index():
	var index:String = "user://Data/Slot %s/Slaves/Index.json"%data.save_slot
	var index_data = data.json_parse(index)
	if index_data is Dictionary and index_data.has('slaves price'):
		var slaves_price = index_data['slaves price']
		if slaves_price.has('price'):
			price = slaves_price['price']
		if slaves_price.has('median price'):
			median_price = slaves_price['median price']
		if slaves_price.has('minimum price'):
			minimum_price = slaves_price['minimum price']
		if slaves_price.has('trend'):
			trend = slaves_price['trend']
		if slaves_price.has('trend strength'):
			trend_strength = slaves_price['trend strength']
		if slaves_price.has('volatility'):
			volatility = slaves_price['volatility']

func update_index():
	var index:String = "user://Data/Slot %s/Slaves/Index.json"%data.save_slot
	var index_data = data.json_parse(index)
	if not index_data is Dictionary:
		index_data = {}
	if not index_data.has('slaves price'):
		index_data['slaves price'] = {}
	var slaves_price = index_data['slaves price']
	slaves_price['price'] = price
	slaves_price['median price'] = median_price
	slaves_price['minimum price'] = minimum_price
	slaves_price['trend'] = trend
	slaves_price['trend strength'] = trend_strength
	slaves_price['volatility'] = volatility
	var file = File.new()
	file.open(index,File.WRITE)
	file.store_line(JSON.print(index_data," "))
	file.close()

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
